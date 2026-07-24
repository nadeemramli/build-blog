---
title: ATT-4 — Windows packaging, signing pipeline, side-channels
description: Durable, privacy-safe learnings from the per-user NSIS + offline-WebView2 build, the self-signed signing proof, and the Windows side-channel baseline.
created: 2026-07-15
updated: 2026-07-15
status: build-log
linear_issue: ATT-4
review_date: 2026-08-10
tags: [attributeos, build-log, phase-0, windows, packaging, nsis, signing, side-channel]
---

# ATT-4 — Windows packaging, signing, side-channels

Branch `mnadeemramli/att-4-windows-packaging` off `c31d200` (PR #10, not merged).
Verified natively on **Windows 11 Pro build 26200, x86_64-pc-windows-msvc,
cargo 1.97.0**.

## Packaging (built)

- **Per-user NSIS + offline WebView2.** `tauri.conf.json` bundle: `active=true`,
  `targets=[nsis]`, `windows.nsis.installMode=currentUser`,
  `windows.webviewInstallMode.type=offlineInstaller`. `pnpm tauri build`
  produced `AttributeOS_0.0.1_x64-setup.exe` (**208 MB** — the offline WebView2
  runtime installer is embedded, so a clean offline machine needs no download)
  plus an 8.5 MB app exe. The Tauri bundler auto-downloaded NSIS and the
  WebView2 offline bootstrapper. Installer artifacts live in gitignored
  `target/` and are never committed.
- **Icons.** Generated a real multi-size set (32/128/256 PNG + multi-res
  `icon.ico` 16→256) to replace the placeholder. Tauri needs `icons/icon.ico`
  present on Windows even for a plain `cargo build` (the resource step).
- **Toolchain:** `@tauri-apps/cli` added as a dev dep; the app crate does **not**
  pull `attribute-store`/SQLCipher, so the shell builds without the OpenSSL
  toolchain (unlike the store crate).

## Signing pipeline (proof only — never distributed)

`scripts/sign-windows.ps1` signs an artifact with a **self-signed** dev cert in
`CurrentUser\My` (never Trusted Root) via `signtool`. Ran it on the exe and the
installer: both `Successfully signed`; `Get-AuthenticodeSignature` returns
`status=UnknownError` (untrusted self-signed root — the expected proof) with the
signer present. This proves the pipeline can sign; **trusted signing stays a
separate distribution gate** (per `Decisions/decisions.md`). Do not distribute
the self-signed artifact. Run the script inline / with the default execution
policy — do not use `-ExecutionPolicy Bypass`.

## Side-channel checklist (Technical Design §7.5)

| Surface | Status |
| --- | --- |
| Search index | **Control implemented + tested.** `attribute_store::side_channel::mark_non_indexable` sets `FILE_ATTRIBUTE_NOT_CONTENT_INDEXED` on the vault dir (via `attrib +I`, no unsafe); `is_non_indexable` reads it back. |
| Temp / parser-viewer files | Posture documented (app-owned encrypted/restricted, swept at startup); not yet enforced in code (no viewer/temp path exists pre-Phase-1). |
| Thumbnails / previews | Posture documented (generate inside encrypted cache; strip EXIF); no media pipeline yet. |
| Clipboard | Posture documented (clear on lock); no sensitive-copy surface yet. |
| Logs / crash reports | Structural allowlist only; enforced by the privacy-safe error types across keystore/store/import. |
| Code signing | Self-signed pipeline proven; trusted signing deferred. |

Recorded in the repo at `docs/architecture.md` (structural threat-model note),
which also refreshed the now-stale "encryption not implemented" / "bundling
disabled" lines (ATT-1/2/3 shipped; ATT-4 enables bundling).

## Honest gap (not claimed)

Built + signed the installer but did **not** run it to install and boot the
installed app (interactive install). The web-mode frontend boot is covered by
the Playwright smoke; the native installed-app boot from the NSIS package is the
one remaining manual verification for ATT-4's "boots to the shell" clause.

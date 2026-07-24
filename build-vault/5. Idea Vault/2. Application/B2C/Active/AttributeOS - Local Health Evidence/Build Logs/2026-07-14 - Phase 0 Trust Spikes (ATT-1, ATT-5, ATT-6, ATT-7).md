---
title: Phase 0 Trust Spikes — ATT-1, ATT-5, ATT-6, ATT-7
description: Durable, privacy-safe learnings from implementing the identity/license, Windows key-store, Hevy schema-lock and APEX-24 seed spikes.
created: 2026-07-14
updated: 2026-07-14
status: build-log
linear_issues: [ATT-1, ATT-5, ATT-6, ATT-7]
review_date: 2026-08-10
tags: [attributeos, build-log, phase-0, windows, keystore, hevy, apex]
---

# Phase 0 Trust Spikes — ATT-1, ATT-5, ATT-6, ATT-7

Four issue-scoped branches, each verified and pushed to `nadeemramli/attributeOS`
(none merged to `main`). Verification environment for every Windows-only claim:
**Windows 11 Pro build 26200, x86_64-pc-windows-msvc, rustc/cargo 1.97.0**,
frontend Node 24 / pnpm 10.34.5 (Corepack). CI-equivalent `scripts/verify.sh`
passes; it excludes the Tauri shell on non-WebKitGTK hosts, but the shell was
separately proven to compile natively on Windows.

## What shipped

- **ATT-7 — identity & license.** Final identifier `com.nadeemramli.attributeos`
  (verified it propagates into Tauri codegen). Root proprietary `LICENSE`;
  `[workspace.package]` now carries `authors` + `license-file` + `repository`,
  inherited by all 9 packages; `publish = false` everywhere. Bundling, updater
  and network capability stay disabled.
- **ATT-1 — Windows key-store.** `attribute-store::keystore`: 256-bit master key
  (OS CSPRNG), HKDF-SHA256 subkeys (db/blob/export) with versioned labels
  namespaced to the app id, `ZeroizeOnDrop` + redacted `Debug`, explicit lock
  boundary. Windows Credential Manager wrapper (store/retrieve/re-wrap/delete)
  proven against the real store. Key **management** only — no DB/blob encryption
  claimed, no recovery wrapper yet.
- **ATT-6 — Hevy schema lock.** `attribute-import::hevy`: header detection,
  RFC 4180 parsing into review candidates (never accepted records), local-naive
  timestamps with explicit required timezone, source fingerprints + raw-record
  hashes, exact-duplicate idempotency, optional-field and unknown-value review
  handling. Synthetic golden + adversarial fixtures only. No screenshot OCR.
- **ATT-5 — APEX-24 seed.** `attribute-apex`: immutable `apex-24/v1` (24 keys,
  locked content hash), six derived compound views, mapping/coverage vocabulary
  (candidates only), named progress policies, and the benchmark admission
  validator. No benchmark pack activated.

## Durable technical learnings

- **Crate choices (ATT-1):** `keyring` v3 (`windows-native`, default features
  off) for the OS wrapper — keep it behind `[target.'cfg(windows)'.dependencies]`
  and `#[cfg(windows)]` so Linux CI never pulls a secret-service/dbus backend;
  `hkdf`+`sha2`, `zeroize`, `getrandom`. Windows Credential Manager generic
  credentials are inherently current-user, so "never machine scope" is satisfied
  by not calling machine-scope DPAPI at all.
- **`keyring` v4 exists but reorganized its API** (store-suffixed features);
  v3's `Entry`/`set_secret`/`get_secret`/`delete_credential`/`Error::NoEntry`
  surface is simpler and was pinned deliberately.
- **Hevy shape (ATT-6):** timestamps parse as `D Mon YYYY, H:MM AM/PM`; the
  comma inside the timestamp means those cells are quoted in the CSV, so a real
  RFC 4180 parser (the `csv` crate) is mandatory. Session = consecutive rows
  sharing `(title,start,end)`; exercise occurrence = a maximal run of one
  `exercise_title`. Exact-duplicate collapse keys on the full raw-record hash
  within an occurrence; a repeated `set_index` with *different* content is a
  flagged conflict, not a collapse.
- **APEX governance (ATT-5):** locking `apex-24/v1` with a committed SHA-256
  content hash + a test turns any accidental edit of `v1` into a red build,
  which is the cheapest possible "new version, not silent edit" enforcement.

## Environment gotchas (Windows checkout at `C:\code\attributeOS`)

- **`.gitignore` `vault/` also matches source dirs.** A module placed at
  `.../src/vault/` was silently untracked by `git add -A` (the ignore protects
  local vault *data*). Named the module `keystore` instead; kept the broad
  ignore. Watch for this with any future `vault/`-named source path.
- **`core.autocrlf=true` with no `.gitattributes`** checked files out CRLF, so
  `pnpm format:check` failed on untouched files while committed blobs stayed LF
  (CI green). Added a repo `.gitattributes` (`* text=auto eol=lf` + binary asset
  rules) so local verification matches CI on both Windows and WSL checkouts.
- **Tauri build needs `icons/icon.ico` on Windows.** The scaffold shipped only
  `icon.png`, so the shell had never compiled on Windows. A placeholder `.ico`
  (wrapping the png) unblocks native compilation; a real icon set is ATT-4.
- **`pkg-config` on PATH is Strawberry Perl's**, which errors, so `verify.sh`'s
  WebKitGTK probe marks the Tauri shell `BLOCKED` and verifies the domain
  workspace — same behavior as CI. Verify the shell separately with
  `cargo check -p attributeos-app` on Windows.
- **`pnpm` isn't on PATH in Git Bash**; use `corepack pnpm`, and Playwright's
  `webServer` needs a `pnpm` shim on PATH (or a pre-started `vite preview`).

## Remaining blockers (do not invent)

- **Hevy screenshots are descoped (2026-07-14):** native CSV export is the sole
  Hevy source; no screenshot/OCR contract is needed or built. The real export's
  header was confirmed (header-only, no rows) to match the locked 14-column
  schema exactly, so the ATT-6 adapter detects/parses the actual file. Not a
  blocker.
- **Admissible benchmark pack** — the ATT-5 validator is ready, but no pack can
  activate until entries carry complete source/equipment/rep/cohort/licensing/
  confidence metadata.
- **Encryption / recovery / packaging remain unproven:** ATT-2 (SQLCipher +
  blob crypto), ATT-3 (recovery wrapper + backup/clean-machine restore) and
  ATT-4 (NSIS/WebView2 + signing + side channels) are untouched. No encryption,
  recovery or Windows-packaging claim is made.

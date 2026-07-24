---
title: 2026-07-13 - WSL Project Scaffold
description: Phase 0 scaffold of the AttributeOS repository from WSL — foundation, verification loop and CI; no product features.
created: 2026-07-13
updated: 2026-07-13
product: AttributeOS
type: build-log
tags: [attributeos, build-log, phase-0, scaffold, wsl]
---

# 2026-07-13 - WSL Project Scaffold

Phase 0 scaffold executed by Claude Code from WSL under the Project Bootstrap
Protocol. Scope was foundation-only: no health data, no medical logic, no
encryption claims, no Phase 1 features.

## Repository

- Path (WSL): `~/workspace/github.com/nadeemramli/attributeOS` — pre-existing
  repo adopted (had one `Initial commit` with README only). Canonical alias
  `~/workspace/attributeos` created as a symlink to it. Everything on the
  Linux filesystem; nothing under `/mnt/c`.
- Commits: `b49bffb` initial (pre-existing) → `505c5e6` baseline (.gitignore)
  → `840a38a` scaffold (63 files). Working tree left clean.
- No remote, no push, no PR (not authorized; nothing external created).

## Tool versions

Ubuntu 22.04.5 (WSL2, kernel 6.18.33.2) · Rust/Cargo 1.97.0 stable (rustup,
`rust-toolchain.toml` pins stable + rustfmt + clippy) · Node 22.17.0 (nvm) ·
Corepack 0.33.0 · **pnpm 10.34.5** pinned via `packageManager` in
`app/package.json` · Tauri v2 · Svelte 5 + TypeScript 5.8 + Vite 6 ·
Tailwind CSS 4 (local tokens) · Vitest 3 · Playwright 1.53+ (Chromium).

## Architecture created

Cargo workspace with 8 domain crates (`attribute-core/store/import/apex/
physique/health/report/agent`) + `app/src-tauri`. Dependency direction:
core ← domain ← Tauri shell; domain crates have no Tauri dependency.
Frontend reaches Rust only via a typed adapter (`app/src/lib/backend/`)
with a deterministic web-mode mock; frontend never owns accepted state.
Tauri capability = `core:default` only; bundling disabled; single command
`shell_status`. Storage/encryption are interface spikes only. Repo `docs/`
limited to setup/architecture/verification. Synthetic fixture + fixture-path
test in `fixtures/sanitized/`. `.env.example` records that Phase 0 needs no
environment variables.

## Verification run (all passing in WSL)

`./scripts/verify.sh` (CI runs the same script; `.github/workflows/ci.yml`):
prettier check · eslint · svelte-check (0 errors) · vitest (2 tests) ·
production vite build · `cargo fmt --check` · `cargo clippy --workspace
--all-targets -- -D warnings` · `cargo check --workspace --all-targets`
(incl. Tauri shell — WebKitGTK 4.1 dev libs were present in WSL) ·
`cargo test --workspace` (10 tests) · Playwright web-mode smoke test
(shell boots, Phase 0 home state renders: title, "Phase 0 scaffold" badge,
vault "Not configured", 6 source + 11 module placeholders).

## Blocked / pending (honest status)

- **Windows Phase 0 spikes — pending, not attempted from WSL:** Windows
  packaging (WiX/NSIS) + WebView2, Windows Credential Manager key store,
  SQLCipher/DB+blob encryption packaging, encrypted backup + clean-machine
  restore, Windows side-channel tests. No encryption is implemented or claimed.
- **Linear — blocked:** no AttributeOS project exists in the workspace
  (checked read-only); creation awaits user authorization. Repo context files
  mark it "not linked".
- **GitHub remote/PR — blocked:** not authorized; repo is local-only.

## Deviations

- Repo lives at `~/workspace/github.com/nadeemramli/attributeOS` (pre-existing,
  adopted per protocol) rather than a new `~/workspace/attributeos`; a symlink
  provides the canonical path.
- App identifier set provisionally to `com.attributeos.desktop` (PRD §19 lists
  identifier/license/signing as open decisions — revisit before packaging).
- Bootstrap protocol asks for format + type-check hooks; only the deterministic
  format-on-edit hook was added. Type-check-after-edit was omitted because a
  full `cargo check`/`svelte-check` per edit is slow enough to degrade agent
  loops; the gate remains `scripts/verify.sh`/CI.
- A 32×32 placeholder icon was generated because Tauri's `generate_context!`
  requires one even with bundling disabled.

## Durable learnings

1. `tauri::generate_context!` embeds `app/dist` and an icon at **compile
   time** — frontend build must precede full-workspace cargo checks; the
   verify script encodes this ordering.
2. pnpm 10 blocks dependency build scripts by default; `esbuild` must be
   allowlisted via `pnpm.onlyBuiltDependencies` or Vite fails at runtime.
3. A stale global Corepack shim (`/usr/local/bin/pnpm`) with old signing keys
   breaks bare `pnpm` invocations; `corepack enable` from the nvm Node fixed
   PATH resolution. Watch for this on future machine setups.
4. WSL Ubuntu 22.04 already had WebKitGTK 4.1/GTK3 dev libraries, so the
   Linux Tauri shell check runs fully — CI installs the same packages, keeping
   local and CI verification identical.

## Post-scaffold authorization (same day, user-approved)

- GitHub remote already existed and was **public**; flipped to **private**
  (verified via API) before pushing `main` (`b49bffb..840a38a`).
- Linear project created: https://linear.app/canvasm/project/attributeos-9e5f64d4996b
  under the existing AttributeOS team (key ATT), lead Nadeem.
- Seeded ATT-1..ATT-4 (Windows trust/packaging spikes) and ATT-5..ATT-7
  (APEX-24 framework input, Hevy export inspection, identifier/license decision).
- Repo and vault context files updated with the Linear/GitHub links.

## Next smallest actions

1. User decision: authorize Linear project + GitHub remote (or defer).
2. Start Windows Phase 0 trust spikes (key store → SQLCipher → backup/restore)
   from a Windows checkout of this repo.
3. Provide the real APEX-24 framework + a representative (never committed)
   Hevy export to begin schema inspection per PRD §8.

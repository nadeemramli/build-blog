---
title: ATT-2 — SQLCipher packaging + encrypted DB/blob store
description: Durable, privacy-safe learnings from proving SQLCipher + XChaCha20 blob encryption on native Windows and locking the storage crate decision.
created: 2026-07-15
updated: 2026-07-15
status: build-log
linear_issue: ATT-2
review_date: 2026-08-10
tags: [attributeos, build-log, phase-0, windows, sqlcipher, encryption, storage]
---

# ATT-2 — SQLCipher packaging + encrypted DB/blob store

Branch `mnadeemramli/att-2-sqlcipher-store` off `main` (which now contains
ATT-1's key hierarchy). Verified natively on **Windows 11 Pro build 26200,
x86_64-pc-windows-msvc, cargo 1.97.0**. Not merged.

## Crate decision (accepted)

**`rusqlite` with `bundled-sqlcipher-vendored-openssl`.** It packages SQLCipher
and compiles OpenSSL from source, so there is no system-library dependency to
install or ship. Chosen over `sqlx` because rusqlite exposes first-class
SQLCipher bundling and the synchronous `PRAGMA key` flow the vault needs.

Blob crypto: **XChaCha20-Poly1305** (`chacha20poly1305` crate) with a random
192-bit nonce, per-file authenticated encryption — matches Technical Design §4.

## What is proven on real Windows (24 passing tests)

- **DB encryption at rest.** SQLCipher keyed with the ATT-1 `db` subkey as a
  raw 256-bit key (`PRAGMA key = "x'…'"`, no KDF — the subkey is already a
  strong HKDF output). `PRAGMA cipher_version` confirms SQLCipher is active
  (not plain SQLite); a wrong key cannot open the DB; the inserted plaintext
  marker does not appear anywhere in the `.db` file; `user_version` migrations
  are monotonic and idempotent.
- **Blob encryption at rest.** Content-addressed `blobs/ab/cd/<sha256>.blob`
  holding `nonce‖ciphertext+tag`, keyed with the `blob` subkey. Put/get round
  trips; the same bytes map to the same address (idempotent); the plaintext is
  absent from the on-disk object; a one-byte tamper and a wrong key both fail
  authentication.

## Windows packaging cost (the real finding)

Building the vendored OpenSSL from source needs a specific toolchain that a
bare Git Bash shell does **not** provide:

- **MSVC dev environment.** `cl.exe`/`nmake` must be on PATH — activate
  `…\VS\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat` (located via
  `vswhere.exe`). Without it, OpenSSL's `Configure`/build cannot run.
- **A Perl with OpenSSL's Configure modules.** The failure mode is subtle: Git
  Bash's msys `/usr/bin/perl` shadows Strawberry Perl and is missing
  `Locale::Maketext::Simple`, so `Configure` aborts. Under `vcvars64` the
  Windows PATH resolves `perl` to **Strawberry Perl**, which has the modules.
- **NASM** for the OpenSSL asm routines — present via `C:\Strawberry\c\bin`.

Consequences to remember:

- **Every `cargo` command that touches `attribute-store` must run inside the
  same `vcvars64` environment.** Cargo fingerprints the OpenSSL build script by
  environment; switching between Git Bash and the VS env invalidates it and
  forces a ~12-minute rebuild (or fails under Git Bash). Run builds/tests/clippy
  for this crate from one consistent VS-dev shell.
- **`| tail` hides cargo's exit code.** A backgrounded `cargo build … | tail`
  reported exit 0 while the build had actually failed. Never pipe cargo through
  `tail` when the exit status matters.
- **CI implication (not yet actioned).** Once ATT-2 lands, Linux CI and the WSL
  checkout will also compile OpenSSL+SQLCipher from source (perl + make needed;
  present on ubuntu-latest and typical WSL). This lengthens CI and is worth a
  follow-up decision: keep vendored, or switch to a system/`vcpkg` OpenSSL for
  faster iteration. First cold build here was ~12m31s.

## OpenSSL packaging decision — SYSTEM OpenSSL (updated 2026-07-15)

The initial spike used `bundled-sqlcipher-vendored-openssl` (OpenSSL compiled
from source). Switched to **`bundled-sqlcipher` over a system OpenSSL** to drop
the ~12-min from-source build and the msys-perl trap from the normal loop.

- **Linux CI / WSL:** `apt-get install libssl-dev pkg-config`. SQLCipher's
  bundled C compiles against the system OpenSSL; no perl/NASM/from-source
  build. `ci.yml` updated.
- **Windows:** an MSVC OpenSSL via **vcpkg** — `vcpkg install
  openssl:x64-windows-static-md` (vcpkg ships its own Perl/NASM, so the msys
  issue never arises). Point `openssl-sys` at it with
  `OPENSSL_DIR=C:\vcpkg\installed\x64-windows-static-md` and `OPENSSL_STATIC=1`
  (or set `VCPKG_ROOT`). No machine path is committed — this is an env contract,
  not repo config.
- **Verified on Windows** (under `vcvars64` + `OPENSSL_DIR`): `cargo test -p
  attribute-store` = 31 passed, **no vendored `openssl-src` build**
  (`libsqlite3-sys` links the vcpkg OpenSSL); test build ~11.5s vs the earlier
  ~12-min cold OpenSSL compile. The Linux CI line is standard but unverified
  from the Windows checkout.

## Not proven / out of scope (do not claim)

- **Recovery** (portable Argon2id passphrase wrapper) and **backup +
  clean-machine restore** remain ATT-3. Production import stays blocked until
  those pass.
- **Packaged installer** round-trip (SQLCipher inside an NSIS/WebView2 build) is
  ATT-4; ATT-2 proves the library packages and encrypts, not that it ships in a
  bundle.
- No recovery, backup, or installer claim is made from this spike.

## Carry-over hardening from the ATT-1 review (low severity)

1. Transient stack copies of key bytes in `MasterKey::generate` /
   `derive_subkey` are not explicitly zeroized (moved-from locals).
2. `MasterKey: Clone` allows silent secret proliferation.
3. `OsKeyStore::for_vault` interpolates `vault_id` into the credential
   namespace unsanitized (fine for UUID ids).

Fold these into ATT-3 when the recovery wrapper touches the same code.

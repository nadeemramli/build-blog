---
title: AttributeOS - WSL Scaffold Prompt
description: Executable prompt for scaffolding the AttributeOS repository on WSL while preserving Obsidian as product memory and following the Development Operating System.
created: 2026-07-13
updated: 2026-07-13
status: ready
product: AttributeOS
tags: [attributeos, scaffold, wsl, tauri, rust, svelte, development-operating-system]
---

# AttributeOS - WSL Scaffold Prompt

## Recommended WSL launch

Keep source code on the Linux filesystem. Grant only the product knowledge, development operating system and PA Control directories needed for this bootstrap.

```bash
mkdir -p "$HOME/workspace/attributeos"
cd "$HOME/workspace/attributeos"

CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1 claude \
  --add-dir "/mnt/c/Users/Nadeem/Desktop/Obsidian/build-blog/build-vault/5. Idea Vault/Application/B2C/Active/AttributeOS - Local Health Evidence" \
  --add-dir "/mnt/c/Users/Nadeem/Desktop/Obsidian/build-blog/build-vault/3. Operation/Development Operating System" \
  --add-dir "/mnt/c/Users/Nadeem/Desktop/Obsidian/pa-control"
```

Paste the prompt below into that session. If using another coding agent, start it from `~/workspace/attributeos`, grant the same three directories read/write access as appropriate, and paste the same prompt.

## Prompt

```text
Scaffold AttributeOS as a new Windows-first, local-first desktop system, working from WSL. Complete the scaffold and verification loop; do not implement the full product yet.

ENVIRONMENT AND CANONICAL PATHS

- Repository path in WSL: ~/workspace/attributeos
- Do not place the repository or build output under /mnt/c. The Linux filesystem is the implementation workspace.
- AttributeOS product vault, WSL:
  /mnt/c/Users/Nadeem/Desktop/Obsidian/build-blog/build-vault/5. Idea Vault/Application/B2C/Active/AttributeOS - Local Health Evidence
- AttributeOS product vault, Windows:
  C:\Users\Nadeem\Desktop\Obsidian\build-blog\build-vault\5. Idea Vault\Application\B2C\Active\AttributeOS - Local Health Evidence
- Development Operating System, WSL:
  /mnt/c/Users/Nadeem/Desktop/Obsidian/build-blog/build-vault/3. Operation/Development Operating System
- PA Control, WSL:
  /mnt/c/Users/Nadeem/Desktop/Obsidian/pa-control

AUTHORITY AND MANDATORY READ ORDER

Before changing files, read these completely in order:

1. /mnt/c/Users/Nadeem/Desktop/Obsidian/pa-control/AGENTS.md
2. Every governance/current-state file that PA Control AGENTS.md marks as mandatory for this health/product task.
3. /mnt/c/Users/Nadeem/Desktop/Obsidian/build-blog/build-vault/3. Operation/Development Operating System/1. Development Operating System.md
4. /mnt/c/Users/Nadeem/Desktop/Obsidian/build-blog/build-vault/3. Operation/Development Operating System/6. Project Bootstrap Protocol.md
5. /mnt/c/Users/Nadeem/Desktop/Obsidian/build-blog/build-vault/3. Operation/Development Operating System/3.a Workflow Architecture - Linear Obsidian Agents Product Surfaces CI-CD.md
6. /mnt/c/Users/Nadeem/Desktop/Obsidian/build-blog/build-vault/3. Operation/Development Operating System/3.b Claude Code Obsidian Knowledge Setup.md
7. <AttributeOS product vault>/AttributeOS - Discovery Brief.md
8. <AttributeOS product vault>/PRD.md
9. <AttributeOS product vault>/Technical Design.md

Use the current user request and accepted PA Control decisions as highest authority. The AttributeOS PRD defines product behavior. The Technical Design defines the intended architecture. The Development Operating System defines how work, code, verification and product learning must be separated.

OPERATING PRINCIPLES TO ENFORCE

- Obsidian is the product knowledge and learning source of truth.
- The repository is implementation truth.
- Linear owns work status only when an authorized/existing project is available.
- CI and automated tests are verification gates, not product memory.
- Do not duplicate the PRD, product principles or point-in-time build narrative into repo docs.
- Repo docs are limited to infrastructure and structural technical documentation that must version with code.
- Agentic work starts from explicit context and ends with verifiable output.
- Durable learning goes back to the AttributeOS product vault.
- No raw health exports, laboratory PDFs, progress photos, credentials, tokens or production vault data may enter the repo, fixtures, logs or Obsidian Build Vault.
- Use sanitized or synthetic fixtures only.
- Do not create directory copies for variants. Use Git branches or worktrees.
- Never modify global shell configuration, append installer commands to shell rc files, or store secrets there.
- Do not change global Git identity. If commits are blocked by missing identity, report the blocker.
- Do not silently skip a bootstrap requirement. Mark it blocked with the exact reason.

SCOPE OF THIS RUN

This run is Phase 0 scaffolding only. Produce a trustworthy empty foundation that can later implement the PRD. Do not ingest real health data, implement medical interpretation, add cloud services, add an LLM dependency, create a composite health score, or start Phase 1 feature work.

Use this stack unless a preflight finding proves it infeasible:

- Tauri v2 desktop shell
- Rust stable core and Cargo workspace
- Svelte 5 + TypeScript + Vite frontend
- Tailwind CSS with local design tokens
- SQLite/SQLCipher and encrypted blob storage represented by interfaces/spikes only; do not falsely claim encryption is complete
- pnpm through Corepack for frontend dependencies, with the chosen version recorded
- Vitest or the Svelte-compatible unit-test default
- Playwright for an initial web-mode smoke test
- GitHub Actions or an equivalent checked-in CI workflow for deterministic Linux-safe checks

WSL/WINDOWS BOUNDARY

AttributeOS is Windows-first, but this repository is being scaffolded from WSL. Do not claim that a packaged Windows Tauri build has passed from WSL. The baseline must verify:

- Rust workspace formatting, linting, checking and tests in WSL
- Svelte formatting/linting/type checking, unit tests and production web build in WSL
- Playwright smoke test against the Vite/web-mode UI in WSL
- Tauri Rust shell checking in WSL only when required Linux system packages are available

If Linux Tauri/WebKit packages are missing, either install only the documented distro packages with normal approval or mark the shell check blocked. Record Windows packaging, WebView2, key-store, SQLCipher packaging and clean-machine restore as explicit Phase 0 Windows spikes, not completed facts.

EXECUTION PLAN

Use a written plan before building because this changes more than three files and creates architecture. Then execute the following.

1. Preflight and preservation

- Confirm the current directory resolves inside ~/workspace/attributeos and not /mnt/c.
- Inspect the directory before writing. Preserve any existing user work; do not overwrite or delete it.
- Report installed WSL distribution/version, Rust, Cargo, Node, Corepack, pnpm, Git and relevant Tauri prerequisites.
- If the directory already contains a project, adopt it through the same protocol rather than regenerating destructively.

2. Version-control baseline

- Initialize Git if absent.
- Create a comprehensive .gitignore before the first commit. Include at least target/, node_modules/, dist/, Playwright artifacts, coverage, .env*, local vault/database/blob directories, temporary decrypted material, IDE files and OS artifacts. Keep .env.example tracked.
- Create the protocol-required baseline commit before substantial scaffold work.
- After scaffolding and verification, create a separate intentional scaffold commit and leave a clean working tree.
- If commits are blocked by local Git identity, do not edit global config; report the precise commands the user must run.

3. Repository structure

Create the Technical Design's initial structure:

attributeos/
  Cargo.toml
  rust-toolchain.toml
  crates/
    attribute-core/
    attribute-store/
    attribute-import/
    attribute-apex/
    attribute-physique/
    attribute-health/
    attribute-report/
    attribute-agent/
  app/
    src/
    src-tauri/
  fixtures/
    sanitized/
  schemas/
    agent/
    export/
  scripts/
  docs/
  .claude/
  .github/workflows/

Requirements:

- Each Rust crate compiles with a minimal public module boundary and no invented domain behavior.
- Domain crates must not depend on Tauri.
- The Tauri layer may depend on narrow domain interfaces.
- Establish dependency direction without adding database/encryption crates that the Technical Design says require a spike.
- Add synthetic fixture guidance and a harmless fixture proving the test path; never copy real exports.
- Keep docs/ limited to setup, architecture boundaries and verification commands.

4. Minimal vertical shell

- Scaffold a Svelte 5/TypeScript/Tauri app that renders a restrained AttributeOS shell.
- The home screen should show only a product title, local-vault status as “Not configured,” source/module placeholders and a visible “Phase 0 scaffold” state.
- Add no health recommendations, benchmarks, sample personal values or fake production data.
- Put Tauri command access behind a typed frontend adapter so the web-mode test can use a deterministic mock without making accepted app state a client-side source of truth.
- Do not add runtime network, shell or broad filesystem plugins. Keep Tauri capabilities narrow and document any generated default capability that remains.

5. Agent context files

Create repository CLAUDE.md and AGENTS.md with byte-identical content, under approximately 100 lines. Include:

- exact install/dev/build/format/lint/type-check/test/E2E commands
- concise architecture and dependency direction
- WSL Linux-filesystem rule
- environment and secret rules from the bootstrap protocol
- plan-before-building rule for 3+ files or any schema/API change
- prohibition on raw health data and production vault files in the repo
- prohibition on diagnosis, prescribing, PED optimization and opaque health scoring
- repository docs versus Obsidian product-memory split
- both Windows and WSL AttributeOS product-vault paths
- read-first links to PRD.md and Technical Design.md
- rule that durable build learning is written to the product vault, not scattered into repo notes
- Linear project field marked “not linked” unless an existing authorized project/link is supplied

Also create `.claude/settings.json` with the narrowest practical allowlist for the exact safe verification commands. Add format-on-edit and type-check/check-after-edit hooks only if they can be configured deterministically without creating approval loops. Never use a broad shell wildcard permission.

6. Environment contract

- Add a committed .env.example listing every environment variable. If Phase 0 requires none, state that explicitly in comments rather than inventing secrets.
- Confirm .env.local and all other real env files are ignored.
- Record that machine secrets, if later needed, belong in ~/.config/secrets/env with chmod 600 and are never copied into Obsidian or agent context files.
- Do not add telemetry, remote endpoints or cloud accounts.

7. Verification from day one

Wire deterministic commands for:

- Rust format check
- Rust clippy with warnings denied
- Rust workspace check
- Rust workspace tests
- Svelte format/lint
- Svelte type check
- frontend unit tests
- production web build
- Playwright smoke test proving the shell boots and the Phase 0 home state renders
- one root aggregate verification command that runs all WSL-safe checks

Add a CI workflow that runs the same WSL-safe checks. Do not add a deployment workflow. Do not mark Windows packaging/security spikes as passed in Linux CI.

Run every wired command and fix failures. If one cannot run because of an external prerequisite, keep the configuration honest and mark that item blocked with reproduction details.

8. Product-vault knowledge wiring

Do not rewrite PRD.md, Technical Design.md or the Discovery Brief during scaffolding unless implementation proves a real contradiction. If a contradiction is found, stage a clearly labelled proposed decision instead of silently changing product truth.

Within the AttributeOS product vault:

- Create CLAUDE.md and AGENTS.md with identical, concise product-knowledge instructions if they do not exist.
- Make their read-first sequence PRD.md, Technical Design.md and the Discovery Brief.
- State that production/raw health evidence never belongs in this Build Vault folder.
- Create Build Logs/ only if absent.
- Write `Build Logs/2026-07-13 - WSL Project Scaffold.md` containing repository path, commit hashes, chosen tool versions, architecture created, commands/tests run, blocked Windows spikes, deviations and durable learnings.
- Do not turn the build log into a task board or duplicate the PRD.

9. Linear and external services

- If an existing authorized AttributeOS Linear project/link is available in the supplied context, link it in repo context files.
- Otherwise do not create a Linear project, GitHub repository, remote, cloud service or deployment implicitly. Mark the Linear/remote items blocked awaiting user authorization.
- Do not push or open a pull request unless explicitly authorized.

10. Final audit

Before finishing:

- Prove CLAUDE.md and AGENTS.md are identical.
- Prove the working tree is clean or explain every remaining file.
- Search the repo for Obsidian absolute paths and confirm they appear only in allowed context/setup documentation.
- Search for likely secrets, raw-health filenames and accidental production data.
- Confirm no code/build artifacts were written under /mnt/c.
- Confirm the app works without an LLM and without network access.
- Confirm product requirements were linked, not copied into repo narrative docs.
- Run the aggregate verification command once more.

DEFINITION OF DONE

The scaffold is complete only when:

- Git baseline and scaffold commits exist, or commit creation is explicitly blocked without changing global Git config.
- Cargo workspace and Svelte/Tauri shell exist at ~/workspace/attributeos.
- Repository CLAUDE.md and AGENTS.md are identical.
- WSL-safe lint, type-check, unit tests, production web build and E2E smoke test pass.
- CI runs the same safe checks.
- No real health data or secrets exist in the repo.
- AttributeOS Obsidian paths and read-first documents are wired into agent context.
- A durable scaffold build log exists in the AttributeOS product vault.
- Windows-only security/packaging spikes and unauthorized external-service steps are honestly reported as blocked/pending.

FINAL RESPONSE FORMAT

Lead with whether the scaffold is usable. Then return:

[ ]/[x] WSL repository created at ~/workspace/attributeos
[ ]/[x] Git baseline commit <hash>
[ ]/[x] Scaffold commit <hash>
[ ]/[x] CLAUDE.md + AGENTS.md identical
[ ]/[x] Stack and workspace created
[ ]/[x] Rust checks passing
[ ]/[x] Svelte lint/type-check/unit/build passing
[ ]/[x] Playwright smoke test passing
[ ]/[x] CI workflow created
[ ]/[x] Product vault linked
[ ]/[x] Obsidian scaffold build log written
[ ]/[x] Secret/raw-health-data audit clean
[ ]/[x] Linear linked or BLOCKED: <reason>
[ ]/[x] Windows packaging/security spikes completed or PENDING: <exact list>

Also include:

- repository tree summary
- exact verification commands and results
- commits created
- files written to the AttributeOS product vault
- deviations from PRD/Technical Design/Bootstrap Protocol
- unresolved blockers and the smallest next action

Do not continue into Phase 1 implementation after the scaffold report.
```

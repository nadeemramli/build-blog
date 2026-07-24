---
title: Canvasm Vault Audit
date: 2026-07-04
---

# Canvasm - Easy Workflow — Vault Audit

45 files checked against the live repo (`github.com/nadeemramli/metrimap`) and its current docs (`AGENTS.md`, `docs/prd/prd.md`, `docs/adr/*`, `docs/backlog/*`, `BACKLOG.md`).

## TL;DR

Almost the entire vault (34 of 45 files) is dated 2025-06 to 2025-08 — brainstorm-stage material from before most of the current product existed. One file (`Tasks/Development Backlog by Intake Group.md`) is dated today and is accurate. The product's name settled on **Metrimap**; "Canvasm" survives only as the org/domain identity (canvasm.app, Linear team name) — but the vault calls the *product* "Canvasm" almost everywhere, which is now backwards from reality. About a quarter of the vault (11 files + 3 folders) is empty stubs that were never filled in. Meanwhile several real, shipped features have zero documentation anywhere in this vault.

## Naming

- Vault's own history: `Early - PRD.md` (2025-07-30) calls the product "Metrimap" → `Medium - PRD 1.0.md` (same day) rebrands to "Canvasm" (but still has a leftover header `# The Metrimap: User Stories` — an incomplete find/replace).
- Reality today: the repo, `docs/prd/prd.md`, `AGENTS.md`, and the logo/branding doc all call the product **Metrimap**. "Canvasm" now only labels infrastructure — `canvasm.app` domain, `clerk.canvasm.app`, and the Linear team is literally named "Canvasm" while its issues are about "Metrimap."
- Net effect: any vault doc that refers to the product as "Canvasm" in prose is using the name that lost.

## Safe to archive or delete (superseded by repo docs)

These describe a version of the product/stack that's been fully superseded, or record decisions since made differently:

- `Archive or References/*` (3 files) — earliest ideation (Jun 2025), including a Django-as-backend note that's long dead. Already filed as "archive," no action needed unless you want it gone entirely.
- `PRD/Early - PRD.md`, `Medium - PRD 1.0.md`, `Medium - PRD 2.0.md` — superseded by `docs/prd/prd.md` in the repo. 1.0 has the richest node-taxonomy detail of the three if you want to keep one for history.
- `PRD/Tech Stack.md` — superseded by the repo's real `package.json` + `docs/adr/*`. Also already drifted at the time: assumes Excalidraw (repo uses `perfect-freehand` instead), HashiCorp Vault/Temporal (no evidence either shipped), Snyk/Dependabot/PostHog/BetterStack (per today's Development Backlog doc, still not integrated).
- `PRD/Source.md` — a competitor-research dump (count.co's config format, DB-tier wishlist). Superseded by `docs/backlog/data-source-architecture.md` and `data-source-caveats.md`, which reflect what was actually built (DuckDB WASM, not the tiered DB list here).
- `Tasks/1. Main Task Lists.md`, `1. UI Task.md`, `Codebase cleaning.md`, `Features Pipeline.md`, `Optimization.md` — Aug 2025 bug/build logs (many bugs described as fully broken — drag, connect, open-sheet — are long fixed). Superseded by `BACKLOG.md` + `docs/backlog/*` (17 active docs) in the repo.

## Empty stubs (never written)

11 files are 100% empty (frontmatter only or literally 0 bytes): `1.a New User Flows`, `1.b.i Walkthrough Style`, `1.b.ii Quest Style`, `1.c Retention Effort`, `2.a Current Active User`, `2.b Reactivated User`, `2.c Resurrected Users` (all under Onboarding), plus `1.b Settings`, `2.a/2.b Canvas (Project Level)[-Setting]`, and `2.c–2.g` (Canvas/Dashboard/Assets/Evidence/Source) under Product. Also 3 dead empty folders: `PRD/4. Product/1. Home`, `2. Canvas`, `Untitled` — leftovers from a renumbering.

Minor naming bugs worth a pass regardless of what you decide above: `2.b Reactivated User.md`'s internal title says "2.a" (collides with the real 2.a file); `1.b Settings.md`'s internal title says "1.a"; the architecture canvas groups the "Product" folder under a group labeled "Management."

## Real gaps — shipped features with no doc anywhere in this vault

The repo's recent commits and `docs/backlog/handoff-2026-06-28.md` show the object model and feature set moved well past what any vault file describes:

- **Workspace → Space → Canvas** hierarchy (Workspace = Clerk org) replacing the flat "Canvas Project Level" concept the vault's PRDs describe
- **Tracked-Metric catalog** with a promotion flow and cross-canvas propagation
- **Strategy** feature — Kanban/table views for Action/Hypothesis cards
- **Permissions** — Viewer/Commenter/Editor/Admin roles with RLS + client-side gating
- **Canvas value time-travel** (view metric values as of a past period)
- **Alerting** — scheduled pg_cron monitored/breached checks
- System-health crash→Linear pipeline — this one *is* already covered in `Tasks/Development Backlog by Intake Group.md`, so no action needed there

Side note, not a vault problem but worth knowing: the repo's own `AGENTS.md` feature list is also stale — it doesn't mention `catalog`, `data`, `notifications`, `settings`, or `strategy`, all of which exist under `src/features/`.

## Actions taken (2026-07-04)

- Archived the 10 superseded 2025 planning docs into `Archive or References/Superseded 2025 Planning/` (Early/Medium PRDs, Tech Stack, Source, and 5 old Tasks bug logs), each with a note on what supersedes it.
- Deleted the 15 empty stub files and 3 dead empty folders.
- Added `PRD/5. Current State (2026-07)/` with 5 new docs covering the previously-undocumented shipped features: Object Model (Workspace/Space/Catalog), Strategy kanban, Permissions & Roles, Alerting & Monitoring, and Canvas Value Time-Travel — each sourced from the repo's `docs/backlog/*` and `docs/tests/manual-test-plan.md`.
- Left `PRD in Architecture.canvas` untouched — it still references some now-archived/deleted files, so treat its layout as stale until redrawn.

## Worth keeping as-is

- `Tasks/Development Backlog by Intake Group.md` — dated today, accurate, cites verifiable facts (CVS-19, prod dates). This is the one doc in the vault that's actually current.
- `PRD in Architecture.canvas` — useful as an information-architecture map if updated to reflect Workspace/Space and the newer feature areas.
- `PRD/4. Product/1.a Homepage.md` — the most fleshed-out speculative spec (Organizations/Teams, Figma-style file browser). Worth a decision on whether it still applies now that Workspace→Space→Canvas is locked in, since it may be either superseded or the actual source of that idea.
- The Distribution/Proposition stubs (GTM, Marketing, Economics, website/docs/community placeholders) are thin but not "wrong" — they're pre-launch marketing planning that may just not have happened yet. Flagging as low-content rather than stale.

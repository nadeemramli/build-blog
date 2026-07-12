# Bookie / ProperBooky Knowledge Vault

This folder is the product knowledge base for **Bookie** (repo name: `properbooky`, github.com/nadeemramli/properbooky). Claude Code uses this vault to understand product context and preserve learning from implementation work. This one file consolidates agent instructions, current state, and the decision log.

## What Bookie is

A unified private reading experience — Readwise (highlight sync + export) + Reader (library/EPUB/PDF reading + highlighting) + Storygraph (organization, status, challenges, stats) — minus the community, plus what none of them give:

- **Context & prioritization**: not all books are equal; recommendations carry weight (Nassim Taleb ≠ random YouTube comment). Priority scores drive a "next queue"; tag-level progress (e.g. "learning" shelf 50% read).
- **Availability context**: ~1,300 local PDFs/EPUBs; the library must show wishlist vs downloaded vs uploaded, so nothing gets lost between lists.
- **Obsidian as the second brain**: highlights live in the app first, then sync to Obsidian (plugin/export). No spaced repetition — Obsidian handles that.
- **Personal knowledge library** (PVP-2, 2026-07-12): books are the first source of truth per domain/niche; articles/blogs are scraped and saved as markdown so they can't disappear from the web; finished books form knowledge groups that power conversational AI and agent search over the whole library. Goal: the user can shut down their brain and go to Bookie for the knowledge.

Read for yourself, not socially. Full product thinking: `1. PD/1. PRD/1. PVP.md`, `3. PVP - 2 (Personal Knowledge Library).md`, and the PRD notes beside them.

## Direction (2026-07)

Build a **private, local-first version that runs entirely on Nadeem's machine**, with **remote sync for mobile use**, and **Tauri for the desktop app** (best native reading experience). Supabase remains the auth/sync backend that can be enabled later; local usage must not depend on the cloud. On top of the library sits a **knowledge layer**: local embeddings index, group-scoped conversational AI, and agent access (likely an MCP server over the library).

Next step: deep-dive into the reference architecture of Readwise and Reader, then design the local-first + Tauri + sync + knowledge-layer architecture against it (Linear: PBK-10; open questions in `TRD - 2 (2026 Restart)`).

## Ecosystem boundary (2026-07-13)

Obsidian is the brain; Properbooky/Bookie is the reading, capture and library instrument.

- Original books, EPUB/PDF files, scraped article snapshots, reading positions and app highlights live in the local Properbooky library and rebuildable index.
- Durable interpretations, learning notes and accepted highlights export to Career Path or Second Brain according to subject; the whole corpus is not duplicated into Obsidian.
- Product learning and architecture stay in Build Vault.
- Codex and Claude Code may process the library through local files, CLI and optional MCP. A public API or in-app cloud AI is not required for the initial agentic workflow.
- Deterministic ingestion, deduplication, indexing, reading and export must work without an LLM.
- The legacy `curation-blog` vault is a migration source for unique reading principles, not a competing current source of truth.

## Current state (updated 2026-07-12 — development restart)

- Codebase: Next.js 13 + Supabase web app, restarted after a pause since early 2025. Working baseline: dev-mode auth bypass, default books, EPUB/PDF reader, tags.
- Remote Supabase (`weyclyuthdbqyjdeelzb`) stays **paused**; development runs against a **local Supabase stack** (`supabase start`, all 14 migrations applied). Blocked-restore reason: free plan allows 2 active projects (used by metrimap-v2, indexalabs).
- Playwright E2E in place (`npm run test:e2e`, smoke suite green on desktop + mobile Chrome, works with the cloud paused).
- Work tracking: Linear team **Properbooky** (key `PBK`), project *Development Restart & Foundation*. Repo has `CLAUDE.md` (map) + `AGENTS.md` (workflow: small commits, batched pushes of ≤5–10, manual-test loop).
- PR #1 landed the pre-pause WIP in 9 commits.

## Decision log

- **2026-07-12 — Local Supabase for development; remote stays paused.** Local-first by design; restore the cloud project only when login/sync work resumes. Consequence: `supabase:types` and the live-DB Jest test target the remote and fail until repointed.
- **2026-07-12 — Tauri for desktop.** The desktop experience will be a Tauri app; web stack remains for development and as the sync/mobile surface. Architecture to be designed after the Readwise/Reader reference deep-dive.
- **2026-07-12 — Desktop = fresh Tauri 2 app (`desktop/` in the repo, Vite + React TS), not a wrapper around the Next.js app.** Next.js has server pieces that fight Tauri's static frontend; reader components port over incrementally. Next.js app stays as the web/mobile-sync surface.
- **2026-07-12 — Files as truth, SQLite as index (desktop).** The library folder (original EPUB/PDF + scraped markdown + metadata) is the source of truth; the desktop app keeps a rebuildable SQLite index (FTS5, sqlite-vec later) via Rust. No local Supabase inside the desktop app; Supabase returns later purely as the mobile sync relay.
- **2026-07-12 — Dev in WSL (WSLg window), Windows installer built by CI** (GitHub Actions), not by hand on Windows.
- **2026-07-13 — Obsidian brain / Properbooky instrument boundary.** Local library owns raw reading assets and app state; Obsidian receives durable learning outputs. External local agents via CLI/MCP can provide the intelligence layer, so public API and cloud AI are not initial requirements.

## Reading map (for agents)

| Need | Read |
|---|---|
| Product vision, pain points, UX flow | `1. PD/1. PRD/1. PVP.md`, `2. PRD - 1.md`, `PRD - 2.md`, `PRD - 3.md` |
| Original backend architecture (Feb 2025, bolt.new era) | `2. TD/1. TRD/TRD - 1.md` |
| Current architecture & dev setup | `2. TD/1. TRD/TRD - 2 (2026 Restart).md` |
| Data model | `2. TD/2. TDD/ERD.md` |
| Feature-level thinking | `1. PD/2. PDD/Features + Component Docs/`, `Build Journal/` |
| Known pre-pause bugs/backlog | `Build Journal/4. To-do Lst.md` (superseded by Linear where duplicated) |
| Legacy curation vault handoff | `Reference/Legacy Curation Vault Handoff.md` |

## Write learning here

- Build logs and feature thinking: `Build Journal/`
- Product docs: `1. PD/` — technical docs: `2. TD/`
- Decisions: append to the decision log in this file (one line + date); expand into a note only if the reasoning is long

## Rules

- Linear (team Properbooky) owns tasks and status — this vault is not a task board.
- No secrets, tokens, or credentials here.
- Link learning to the relevant Linear issue/PR when available.
- Prefer updating existing notes over creating new ones; ask before broad reorganizations.

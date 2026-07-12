---
draft: false
title: "TRD - 2 (2026 Restart)"
date: "2026-07-12"
tags:
  - bookie
  - properbooky
  - technical-requirements
---

# TRD - 2 — Development restart setup and target architecture

Supersedes the deployment/CI portions of [[TRD - 1]] (Feb 2025, bolt.new era: Vercel + remote Supabase free tier). The database architecture and RLS thinking in TRD-1 still stand; the repo's `supabase/migrations/` is the schema source of truth (14 migrations as of the restart — books, highlights, tags, wishlist, storage buckets, missions/challenges, default books).

## What changed at the restart (2026-07-12)

| Layer | TRD-1 (2025) | Now |
|---|---|---|
| Backend | Remote Supabase free tier | **Local Supabase stack** (`supabase start`); remote `weyclyuthdbqyjdeelzb` paused until sync work resumes |
| Frontend hosting | Vercel | Not deployed — local/personal use first |
| Auth in dev | Supabase Auth | Dev-mode bypass with fixed dev user (`NEXT_PUBLIC_DEVELOPMENT=true`), local auth behind it |
| Testing | none | Jest (minimal) + **Playwright E2E** smoke suite, desktop + mobile Chrome, runs with cloud paused |
| CI/CD | GitHub Actions → Vercel + `supabase db push` | To be rebuilt as PR gate: tsc, lint, jest, build, Playwright (Linear PBK-4) |
| Work tracking | none | Linear team Properbooky (PBK), Development OS (`CLAUDE.md`/`AGENTS.md` in repo) |

Dev environment: WSL2, Docker, Supabase CLI. Local connection values in `.env.development.local` (gitignored). Studio at `127.0.0.1:54323`.

## Target architecture (to be designed)

Goal: a **private, local-first Bookie that runs entirely on the local machine**, with **remote sync enabling mobile use**, and **Tauri as the desktop shell** for the best reading experience.

Open questions for the Readwise/Reader reference deep-dive (next research task):

1. How Reader structures its reading pipeline (document ingestion, positions, highlights) and what of it applies to a single-user local app
2. How Readwise models highlight sync/export (source of truth, idempotency, dedupe) — informs the Obsidian sync design
3. Local-first data layer: keep Postgres (local Supabase) vs embedded (SQLite + CRDT e.g. Yjs/Electric/PowerSync) inside Tauri; what the sync protocol to the remote Supabase looks like
4. How the existing Next.js app maps into Tauri (webview reuse vs progressive rewrite) and what stays web-only for mobile
5. Where the ~1,300-book library lives locally (filesystem as truth vs imported store) and how availability status is derived

Added by the Personal Knowledge Library expansion ([[3. PVP - 2 (Personal Knowledge Library)|PVP - 2]]):

6. **Article/blog ingestion**: how Reader parses and cleans web content (readability extraction), and what a scrape-to-markdown-with-assets pipeline looks like locally (permanence against link rot is the goal, not read-later)
7. **Canonical storage**: files (markdown + original EPUB/PDF) as source of truth with the DB as index, vs DB as truth — AI/agent access, Obsidian compatibility, and user ownership all pull toward file-first; what breaks (search, relations, sync) if we go that way
8. **Knowledge index**: text extraction quality per format → chunking → local embeddings; vector store choice (sqlite-vec / LanceDB vs pgvector in local Supabase); groups as scoped RAG corpora
9. **Agent interface**: exposing the library to agents/LLMs — an MCP server over the library (prior art collected in [[Integrated MCP]]: ebook-mcp, docsmcp), plus in-app conversational AI over a knowledge group

Constraints carried over from the PRD: manual progress tracking, priority scoring with weighted recommendations, tag-level progress, wishlist/availability distinction, Obsidian as the export target. New constraint from PVP-2: every asset type (book, article, highlight) must end up queryable in the same knowledge layer.

## Links

- Repo: `github.com/nadeemramli/properbooky` (see `CLAUDE.md`, `AGENTS.md`)
- Linear: PBK-1 (local stack), PBK-4 (CI), PBK-5 (architecture cleanup), PBK-6 (Obsidian sync), PBK-7 (mobile/local-first)
- Current state summary: [[CLAUDE|vault CLAUDE.md]]

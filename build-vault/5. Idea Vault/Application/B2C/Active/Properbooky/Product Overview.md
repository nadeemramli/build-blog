---
draft: false
title: "Properbooky Product Overview"
date: "2026-07-12"
tags:
  - properbooky
  - product-overview
---

# Properbooky Product Overview

## What it is

ProperBooky is a personal reading system, being evolved into two complementary jobs:

1. **Reader (like Reader by Readwise)** — a library + reading experience for EPUB/PDF (later: articles, web content) with highlights, progress, and tags.
2. **Readwise-like sync layer** — highlights and reading data flow out to personal knowledge tools, starting with local Obsidian sync.

Primary use is **local/personal + mobile**. Supabase provides auth and storage so cloud login and sync can be enabled later; the app should degrade gracefully to local-first usage.

## Current state (2026-07-12, development restart)

- Stale Next.js 13 + Supabase codebase being restarted after a pause since early 2025.
- Supabase project (`weyclyuthdbqyjdeelzb`, free plan) was paused; restore blocked by the 2-active-project free-plan limit.
- Working tree has uncommitted WIP: dev-mode auth bypass, default-books seeding, reader fixes.
- Linear team **Properbooky** created 2026-07-11; work tracking moves there.
- Repo `CLAUDE.md` + `AGENTS.md` created from the Development Operating System.

## Direction

- Restart development: restore Supabase, get dev server + E2E (Playwright) running, clean up WIP.
- Then improve architecture (dual-auth remnants, type duplication, offline/local-first story) before building Reader/sync features.

## Links

- Repo: `github.com/nadeemramli/properbooky`
- Linear: team Properbooky
- Operating system: [[1. Development Operating System]]

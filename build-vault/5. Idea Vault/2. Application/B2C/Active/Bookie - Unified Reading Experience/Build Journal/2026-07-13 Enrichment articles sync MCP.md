---
draft: false
title: "Enrichment, articles, Obsidian sync, MCP, notes"
date: "2026-07-13"
tags:
  - bookie
  - properbooky
  - build-log
---

# 2026-07-13 (later) — Five slices in one arc

Stacked PR chain #4→#8, each CI-green, awaiting merge.

## Shipped

- **PBK-22 Enrichment**: Open Library lookups (resumable, 1 req/s, conservative match floor so garbled titles never attach wrong metadata); covers cached in `.properbooky/covers/`; grid shows cover thumbnails + year. Full 2,100-entry run in progress.
- **PBK-11 Articles**: Save URL → readability-extracted permanent markdown in `Articles/` (dedupe by source URL); article reader (serif column, scroll positions, quote-anchored highlights); `save_article` CLI. First capture: PG's "How to Do Great Work".
- **PBK-6 Obsidian sync**: export module + vault setting + one-click "Sync highlights now" → regenerates `<vault>/Properbooky/`.
- **PBK-13 MCP server**: `mcp/server.mjs` — search_library / get_asset / get_highlights / search_highlights over the index + sidecars; `.mcp.json` wires it into Claude Code. Bookie is now an agent knowledge source (PVP-2's promise, v1).
- **PBK-16 + notes**: legacy formats (mobi/azw3/chm/djvu) indexed for availability; notes on highlights (panel editor → sidecar → Obsidian export).

## Learnings

- **Alphabetical resumability made enrichment self-auditing**: the first 30 entries were all garbage-titled adoptees, which immediately exposed two spurious single-token matches → minimum-signal floor (≥2 tokens, ≥3 authorless).
- **ureq 3 and pdfjs 5/6 both rewrote their APIs** — pin majors deliberately (ureq@2) or read the installed source before writing against memory.
- **Background jobs must run from built artifacts, not the build tree**: the first enrichment run compiled lazily mid-edit and died on a half-added dependency.
- The `source_url` frontmatter key cleanly splits articles from catalog entries in one scanner pass — one field as a type discriminator beats a parallel folder convention.

## Open

- Enrichment run finishing (~2,100 entries); reseed + cover report after.
- PR chain #4–#8 needs merging in order (Nadeem's click or explicit go).
- Next big rocks: PBK-12 knowledge layer (extraction→embeddings→group chat), PBK-15 multi-library, review-queue triage UI.

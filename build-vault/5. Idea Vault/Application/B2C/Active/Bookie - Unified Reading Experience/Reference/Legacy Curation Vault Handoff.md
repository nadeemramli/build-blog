---
title: Legacy Curation Vault Handoff
description: Unique product and reading principles to preserve before archiving the standalone curation-blog vault.
created: 2026-07-13
updated: 2026-07-13
status: migration-summary-source-archived
source_vault: C:/Users/Nadeem/Desktop/Obsidian/_archive-vaults/curation-blog
tags: [bookie, properbooky, migration, curation, reading]
---

# Legacy Curation Vault Handoff

The standalone `curation-blog` vault predates Properbooky and should not remain a competing active product brain. Its original files were moved intact to `_archive-vaults/curation-blog` on 2026-07-13. This note captures the unique ideas that should inform Properbooky.

## Reading system concepts to preserve

- Reading is a keystone identity and long-horizon practice, not merely a completion metric.
- A reading session should be a protected environment that helps the user resume context across books and sessions.
- The system should distinguish inspectional reading, analytical reading and syntopical work across multiple books.
- Progress tracking matters partly because the user may move between books; resumption context is as important as percent complete.
- The library needs structured book identity, authors/recommenders, tags, status/shelves, availability and reading state.
- The earlier component model separated:
  - Library: book inventory, availability, metadata and skimming.
  - Reading/highlight source: reading state and captured passages.
  - Analytical layer: one-book/chapter/argument understanding.
  - Syntopical layer: cross-book synthesis inside a domain.
- A low-friction daily practice should not force every session into superficial reading; the tool should allow a small session to accumulate into deeper analysis over time.
- Learning should remain open to revision rather than hardening every early model into identity.

## Mapping into Properbooky

| Legacy concept | Properbooky home |
| --- | --- |
| Library inventory and availability | Book/library model and local asset store |
| Reading session/resumption context | Reader position, session notes and recent-context UI |
| Inspectional/analytical/syntopical modes | Reading intent, annotation type and knowledge-group workflows |
| Analytical book work | Book/chapter notes and highlight exports |
| Syntopical work | Knowledge groups and cross-source agent queries |
| Habit/progress identity | Private progress and challenges without social pressure |
| Durable learning | Reviewed export to Career Path or Second Brain |

## Archive gate

Before moving `curation-blog` to `_archive-vaults`:

- [x] Unique principles summarized here.
- [ ] Review the two Excalidraw files for any unique architecture not represented here.
- [x] Confirm no known inbound links or scripts depend on the old path.
- [ ] Generate and verify the vault manifest.
- [x] Move the whole vault intact; do not delete during cutover.

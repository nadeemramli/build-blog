---
draft: false
title: "Catalog system: import, matcher, adoption"
date: "2026-07-13"
tags:
  - bookie
  - properbooky
  - build-log
---

# 2026-07-13 — Catalog system (PBK-19/20/23)

The Catalog-vs-Library model went from decision to working system in one day. All in the Tauri desktop app (PR #2).

## Shipped

- **Import** (PBK-19): Library-of-Books sheet → 1,702 `Catalog/*.md` book profiles (frontmatter + latticework bodies). Idempotent, deduped (37 sheet dupes).
- **Matcher** (PBK-20): 189 auto matches applied — 187 files renamed `Author - Title.ext`, 180 entries → `available`, sha256 + original_filename recorded. 305-row review queue in `Catalog/.match-plan.tsv`.
- **Adoption** (PBK-23): 405 owned-but-uncataloged files got entries (322 renamed from their own metadata). Catalog now 2,106 entries: 584 available / 1,519 wishlist / 3 queued.

## Learnings

- **The sheet and the disk barely overlapped.** Only ~190 of 925 files were in the wishlist sheet; ~430 owned books were never cataloged. "Match" and "adopt" are two different operations — assuming one universe (the sheet) hides half the library.
- **Authorless filenames are the norm.** The single biggest matcher win was the full-title rule (100% title coverage on a ≥4-token title → auto), which more than doubled auto matches; author-in-filename is the exception in real collections.
- **Asymmetric scoring is the right shape for dirty filenames**: score = how much of the catalog identity the filename covers; junk tokens can't hurt.
- **Reversibility made bulk renaming safe to automate**: original_filename in frontmatter + never-clobber + hash meant 500+ renames with no anxiety.
- `sha2` 0.11 broke the io::Write hashing idiom — pin 0.10.

## Open

- 315 review rows to triage; 26 filename collisions (likely duplicate copies) to inspect.
- Next slices: acquisition queue + Drop watcher (PBK-21), enrichment (PBK-22), reading view.

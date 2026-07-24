---
draft: false
title: "Reader, highlights, acquisition loop, CI"
date: "2026-07-13"
tags:
  - bookie
  - properbooky
  - build-log
---

# 2026-07-13 — Reader, highlights, acquisition loop, CI

Second big build day on the Tauri desktop app (all on PR #2).

## Shipped

- **Reading view** (PBK-24): EPUB (epub.js, CFI positions) + PDF (pdf.js, text layer, fit-page/fit-width) in index-card tabs with bookmark-ribbon progress; positions persist as `.properbooky/state/` sidecars.
- **Highlights** (PBK-26): select → pill → anchored highlight (CFI / page+TextQuote per TRD-3), UUID + tombstones in sidecars, highlights side panel (jump/remove), `export_highlights` → Obsidian-ready markdown with `^pb-id` markers.
- **Acquisition loop** (PBK-21): ranked daily queue with z-library search links, `Drop/` folder processing (match → rename → `Library/00 Inbox` → link+hash+available), `relink_library` repairs links by content hash.
- **CI** (PBK-4): web + web-e2e + desktop jobs green; stale Vercel/cron workflows removed.

## Learnings

- **The reorganization test came early and files-as-truth passed.** Nadeem restructured everything into `Library/<12 numbered shelves>` mid-development; all 583 file links were recovered by sha256 (0 lost). Content hash is the identity; paths are just where things happen to be.
- **Never put destructive actions under a click that overlaps reading.** Click-to-delete on highlights (with `window.confirm`, which wry doesn't reliably support) silently tombstoned highlights the moment the user touched the text again. Destructive actions live in management UI (panel) only. Tombstones made the lost data recoverable.
- **React callback identity in effect deps re-loaded whole books** (freeze bug): stable callbacks + refs inside readers; effects depend only on the document identity.
- **CI caught two real bugs on day one**: Jest matching Playwright's `*.spec.ts`, and a parallel-test race on a shared temp dir. Also: jest CLI `--testPathIgnorePatterns` replaces (not merges) the config list.
- WebKitWebDriver quirks: rejects `browserName` capability and synthetic key input — drive React inputs via native value setter in E2E.

## Next

- Merge PR #1 → #2 (checks green, Nadeem's click), branch protection
- PBK-22 enrichment (fixes mangled adopted titles), PBK-11 article ingestion, notes-on-highlights UI, PBK-6 scheduled Obsidian sync

---
draft: false
title: "Prioritization Algorithm v2 (implemented)"
date: "2026-07-13"
tags:
  - bookie
  - properbooky
  - prioritization
---

# Prioritization Algorithm v2

Formalizes the original notes (see [[Prioritization Algorithm]]) into the shipped implementation (PBK-29). Drives the acquisition queue ("today's 10").

## The score

```
priority = 0.35 · lindy + 0.25 · recommendation + 0.25 · rating + 0.15 · spectrum
```

| Component | Source | Normalization |
|---|---|---|
| **Lindy** (older is better) | `year` frontmatter — first-publish year from Open Library enrichment | `min(current_year − year, 120) / 120`; unknown year → 0.3 |
| **Recommendation** | `recommendation` frontmatter (from the sheet / manual) | present = 1, absent = 0 (source weighting is a future refinement: Taleb ≠ YouTube comment) |
| **Rating** | manual 1–5 | `rating / 5`; unrated → 0.6 (neutral 3/5) |
| **Knowledge spectrum** | `spectrum` frontmatter: `original` / `novel` / `collection` | 1.0 / 0.6 / 0.3; unset → 0.5. Manual classification; AI-assisted later |

Queued items always outrank the score (an explicit "read now" beats the formula).

## Weights rationale

Midpoints of the original ranges: Lindy 30–40% → 0.35 (the strongest conviction: survival is evidence), recommendation and manual judgment 20–30% → 0.25 each, spectrum 10–20% → 0.15. Weights live in one place in `acquisition_queue` (desktop/src-tauri/src/lib.rs) — tune there.

## The second system: divide and conquer

Grouping same-context books to read together = **knowledge groups** (PBK-12). Topics from the sheet + shelf folders are the seed grouping; the corpus/embedding layer makes it real. Not duplicated here.

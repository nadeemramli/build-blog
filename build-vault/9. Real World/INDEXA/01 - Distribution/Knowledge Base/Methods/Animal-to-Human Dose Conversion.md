---
type: kb-method
id: Animal-to-Human Dose Conversion
title: "Animal-to-Human Dose Conversion"
applies_to: dosing
peptides:
- '[[BPC-157]]'
- '[[MOTS-C]]'
- '[[TB-500]]'
- '[[SS-31]]'
- '[[Selank]]'
- '[[GHK-Cu]]'
concepts:
- '[[Dosing & Titration]]'
sources:
- '[[TRANSCRIPT-bpc157-deep-dive]]'
- '[[TRANSCRIPT-mots-c-deep-dive]]'
- '[[TRANSCRIPT-tb4-tb500-deep-dive]]'
- '[[TRANSCRIPT-ss31-deep-dive]]'
- '[[TRANSCRIPT-selank-deep-dive]]'
- '[[TRANSCRIPT-ghk-cu-deep-dive]]'
research_use_only: true
tags:
- kb-method
---

# Animal-to-Human Dose Conversion

> [!warning] Educational method, not a prescription
> Almost all peptide efficacy data in this base is **animal (rat/mouse)**. A human-equivalent dose (HED) is a **starting estimate** for understanding the literature — *not* a dosing recommendation. Species differ in metabolism/half-life, anecdotal human ranges often differ, and animal "no-toxicity" ≠ human safety. Research/educational only; always with a physician.

## Why you can't use the animal mg/kg directly
Metabolic rate scales with **body surface area**, not body weight — so a small animal needs a *higher* mg/kg dose than a human to reach the same exposure. Converting requires allometric scaling, then a route adjustment, then per-person scaling.

## Step 1 — Allometric scaling (FDA Kₘ method)
**HED (mg/kg) = Animal dose (mg/kg) × (Kₘ animal ÷ Kₘ human)**

| Species | Kₘ | Shortcut ×factor → human |
| --- | --- | --- |
| Mouse | 3 | **×0.081** |
| Rat | 6 | **×0.162** |
| Rabbit | 12 | ×0.324 |
| Dog | 20 | ×0.541 |
| Human (60 kg) | 37 | — |

(This is the source of the "×0.162" you'll see for rat studies in the transcripts.)

## Step 2 — Route / bioavailability adjustment
Most animal studies inject **intraperitoneally (IP)**, which is ~**40% more bioavailable than subcutaneous** → to match exposure, **SubQ dose ≈ HED × 1.4**. Other routes: **IV = 100%**; **SubQ ≈ 70% of IV**; **oral varies** (e.g. acid-resistant BPC-157 oral ≈ half of SubQ; most other peptides far lower).

## Step 3 — Per-kg → per-person
Multiply the adjusted mg/kg by body weight (typically 70–80 kg).

## Step 4 — Sanity-check + safety factor
Drug development often **÷10** as a safety margin for a first human dose. Compare the result to **anecdotal human ranges** (which frequently run higher) and **start low, titrate slow**. See [[Dosing & Titration]].

## Worked examples (already derived in our transcripts)

| Peptide | Animal dose | Conversion | Human-equivalent | Anecdotal human range | Source |
| --- | --- | --- | --- | --- | --- |
| [[BPC-157]] | 10 mcg/kg rat IP | ×0.162 → 1.62, ×1.4 (IP→SubQ) → 2.27 mcg/kg | ~**181 mcg/day** (80 kg) | 250–500 mcg/day SubQ | [[TRANSCRIPT-bpc157-deep-dive]] |
| [[MOTS-C]] | 0.5 mg/kg/day IP | → ~0.048 mg/kg SubQ | ~**3.33 mg/day** → ~23 mg/week | ~5 mg 3×/week | [[TRANSCRIPT-mots-c-deep-dive]] |
| [[TB-500]] / TB4 | 6 mg/kg rat IP | ×0.162 → 0.49, ×1.4 → ~0.69 mg/kg → ~48 mg/day (**impractically high**) → re-anchored to human IV-safety 5 mcg/kg | ~**500 mcg/day** SubQ | 250–500 mcg/day | [[TRANSCRIPT-tb4-tb500-deep-dive]] |
| [[SS-31]] | 3 mg/kg mouse (anti-aging) | allometric HED | ~**17 mg/day**; a 1 mg/kg study → ~6 mg/day | start 5–10 mg/day (studies used 40 mg/day in extreme-dysfunction populations) | [[TRANSCRIPT-ss31-deep-dive]] |
| [[Selank]] | 100 mcg/kg/day | →16.2 mcg/kg → ~1 mg/day; **÷10 safety → ~100 mcg/day** start | 250–900 mcg intranasal (human studies) | [[TRANSCRIPT-selank-deep-dive]] |
| [[GHK-Cu]] | 0.5 mg/kg EOD IP | allometric + IP→SubQ | ~**0.6–1 mg/day** SubQ | 0.5–2 mg/day | [[TRANSCRIPT-ghk-cu-deep-dive]] |

## Posting convention for animal-study notes
When a `kb-paper` or peptide note records an **animal dose**, also record the **HED breakdown** (animal dose → Kₘ scaling → route adjustment → per-person), with the anecdotal human range and a "start-low" caveat — so the jump from animal protocol to human protocol is always explicit and traceable, never a bare number.

## Caveats
HED is a *modeling estimate*, not a target. Half-life, receptor desensitization, and bioavailability differ by species and route. Anecdotal human doses are not validated. None of this is medical advice.

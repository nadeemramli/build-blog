---
title: "Policy — Platform Restricted Terms (IG/TikTok Safe-Words)"
type: policy
date: 2026-06-03
tags: [indexa, distribution, policy, compliance, content]
---

# Policy — Platform Restricted Terms

**Purpose:** keep Indexa's Instagram and TikTok accounts alive. Certain words get content suppressed (shadowban) or get the whole account banned — especially named pharma drugs, injection/dosing language, and medical claims. This policy defines what we never say on-platform, what we say carefully, and how the automation enforces it so a bad post can't go out by accident.

**This is enforced in code.** The publisher (`Automation/Zernio/publish.mjs`) runs a lint gate before uploading anything. A **block** term aborts the whole run. The word lists live in `Automation/Zernio/restricted-terms.json` — edit that file to change the rules (single source of truth). The standalone checker is `node lint.mjs`.

> Sits under the existing guardrail in [[SOP — Zernio Publishing]] and [[Distribution — Strategy]] (research-use framing, no medical claims). This policy is the *platform-survival* layer on top of the *legal* layer.

## Two tiers

**BLOCK — never on-platform (automation refuses to publish).**
- **Named pharma drugs:** Retatrutide, Tirzepatide, Semaglutide, Liraglutide, Cagrilintide, Ozempic, Wegovy, Mounjaro, Zepbound, Saxenda. Use a code name or "the compound" instead.
- **Administration / dosing:** inject, injection, needle, syringe, subcutaneous, intramuscular, dosage, dose, dosing, mcg, reconstitute, reconstitution.
- **Medical claims:** cure, cures, treats, treatment for, heal disease, prevents disease.
- **Consumption framing:** "for human use", "human consumption", "safe to take", "take this".

**CAUTION — allowed, but flagged every time (use sparingly, swap in hashtags where you can).**
- peptide(s), vial(s), research chemical(s), weight loss, fat loss, muscle growth, anti-aging, SARMs, steroid, hormone, clinical, mg, ml, protocol, stack.

> "Peptide" is unavoidable in our niche — it stays **caution**, not block. The play is to reduce its density in *captions and hashtags* (the parts platforms scan hardest), not to purge it from educational copy. On-image text is lower-risk but still counts.

## Approved swaps (say this instead)

| Don't say | Say |
| --- | --- |
| Retatrutide / Semaglutide / Tirzepatide | Reta / a code name / "the compound" |
| peptide(s) | research compound(s) / "the compound" |
| weight loss / fat loss | metabolic research / body-composition research |
| injection / inject | research handling / preparation (route detail off-platform) |
| dosage / dose | research protocol amount |
| reconstitution | preparation steps (link off-platform) |
| buy / for sale | enquire / DM to order |

## Where this applies
Captions, hashtags, first comments, bio, **and on-image text** (platforms OCR images/video frames). The linter scans `caption`, `onImageText`, and `note` for every post in `posts.json` — so keep `onImageText` in the post entry accurate to what the creative actually shows.

## How to use it
- **Before scheduling:** `node lint.mjs` (or it runs automatically inside `node publish.mjs`). Fix every BLOCK; review every CAUTION.
- **Override (rare):** `node publish.mjs --force` publishes despite block findings — only for a deliberate, reviewed exception.
- **Tuning:** add/remove terms in `restricted-terms.json`. Promote a caution word to block if a platform starts penalising it; demote if proven safe.

## Operating rules
1. Lead generation happens **off-platform.** On IG/TikTok we educate and build trust; product names, prices, and ordering move to WhatsApp/link-in-bio. This keeps the riskiest words out of public posts entirely.
2. Never put a price or "buy now" in a caption — route to DM.
3. Keep the research-use disclaimer on every post (legal layer) *and* keep block words out (platform layer). Both, always.
4. Threads uses disposable alias accounts (separate playbook) — assume even stricter and rotate.

## Related
[[SOP — Zernio Publishing]] · [[Workflow — Content Production Pipeline]] · [[Style Guide — TikTok Braindead Poster]] · [[Style Guide — Instagram Beautiful]] · `Automation/Zernio/restricted-terms.json`

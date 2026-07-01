---
title: "Style Guide — TikTok Braindead Poster"
type: style-guide
date: 2026-06-03
tags: [indexa, distribution, content, tiktok, style-guide]
---

# Style Guide — TikTok "Braindead Poster"

The TikTok top-of-funnel look: **loud, ugly-on-purpose, screenshot energy.** It should look like it took 90 seconds to make — because that's the native dialect of the feed and it out-reaches polished content. Reference: [[POST-20260603-002]] (`_assets/POST-20260603-002-tiktok.png`).

## Why this style
TikTok rewards a hard hook and an instant payoff, not production value. "Too clean" reads as an ad and gets scrolled. The braindead poster is a pattern-interrupt: a dumb-simple claim, one circled object, one punchline you want to send to a friend.

## The formula
1. **POV / setup tag** (small black box, top-left): `POV: it's 2026`.
2. **HOOK** (huge, 2–4 lines, ALL CAPS, one phrase highlighted): the spicy/relatable claim. ≤ 8 words per line.
3. **One dumb visual** (a doodle vial, a circle, a red arrow) — never a polished render.
4. **PAYOFF** (mid-size): the answer, in plain lowercase. End with a meta line: *"that's it. that's the whole post."*
5. **Footer:** `full breakdown → @indexalabs` + the research-use disclaimer (small).

## Visual rules
- **Canvas:** 1080 × 1920.
- **Background:** flat off-white `#FBF9F2` (or a single loud colour — never gradients).
- **Type:** one bold sans (Arial/Helvetica/Liberation Sans, **bold**). No font pairing. Oversized on purpose; mild clipping/overlap is fine and on-brand.
- **Colour kit:** ink `#111111` · highlighter `#FFE53B` · alert red `#FF2D2D` (circles/arrows) · accent `#4B3FCF` (one payoff line only).
- **Marks:** one yellow highlighter bar behind a key word; one red hand-drawn circle + arrow at the visual. Max one of each — restraint is what keeps "messy" from becoming "noise".
- **Safe zones:** keep the hook in the upper-center. Right ~120px and bottom ~420px are covered by TikTok UI (icons + caption) — nothing important there.

## Copy rules
- First line is the hook and must work with zero context.
- Lowercase payoff = casual, human. Caps = the claim.
- Punchline beats explanation. If the post can end on "that's the whole post," it should.
- Caption: relatable one-liner + a follow reason ("follow for how to read a COA") + disclaimer. 5–8 hashtags (`#peptidetok #peptides #fyp …`).

## Hard rules (guardrail)
- Research/educational framing only. **No dosing, no "treats/cures", no medical claims.** Disclaimer on-image **and** in caption.
- One idea per post. If you're explaining, you've lost.
- Block/limit off-topic spam comments early.

## Reusable template (SVG)
Duplicate `_assets/POST-20260603-002-tiktok.svg` and swap the hook/payoff text. Re-export to PNG:
```bash
convert -density 96 -background none POST-YYYYMMDD-NNN-tiktok.svg POST-YYYYMMDD-NNN-tiktok.png
```

## Hook bank (steal these)
- "EVERYONE SAYS 'PEPTIDES' AND HAS NO CLUE WHAT THEY ARE"
- "YOUR BODY MAKES THESE EVERY DAY AND YOU CAN'T NAME ONE"
- "POV: you bought a peptide and never checked the COA 💀"
- "'RESEARCH GRADE' MEANS NOTHING WITHOUT THIS ONE PDF"
- "PROTEIN vs PEPTIDE in 4 seconds (so you stop guessing)"

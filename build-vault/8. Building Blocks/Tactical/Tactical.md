---
title: Tactical
type: layer
created: 2026-06-05
tags: [tactical, theoretical, practical, market, capital, operation]
---

# Tactical

> [!summary]
> The execution layer beneath [[Three Entities|Strategy]]. Where Strategy says *what & why*, Tactical records the *how* — the concrete moves, plays, and mechanics across the same three entities ([[Market]] · [[Capital]] · [[Operation]]). Tactics are split by **maturity**, not topic: **[[Practical]]** (built, executed, documented) and **[[Theoretical]]** (observed, collected, unproven).

## Why split by maturity, not just by entity

Strategy is governed by stable principles. Tactics are messy: most ideas are unproven and most of what you read or observe never gets built. Folding unvalidated ideas into the same shelf as battle-tested playbooks rots the knowledge base — you stop trusting any of it. So the first cut is **proven vs not-yet-proven**:

```
                         TACTICAL  (the how)
            ┌──────────────────────┴──────────────────────┐
      [[Practical]]                                 [[Theoretical]]
   built & executed                              observed & collected
   → documented, trusted                         → brainstormed fast, untrusted
            │                                              │
   ┌────────┼────────┐                          ┌──────────┼──────────┐
 Market  Capital  Operation                   Market    Capital   Operation
```

## The two tiers

| Tier | What lives here | Trust level | How it's written |
|---|---|---|---|
| **[[Practical]]** | Tactics we've built and shipped | High — proven by execution | Documented carefully: what we did, the result, the learning |
| **[[Theoretical]]** | Tactics we've observed or collected | Low — unproven until built | Brainstormed fast; cheap to add, cheap to discard |

> [!note] The promotion rule
> A tactic earns its way from **Theoretical → Practical** only by being *built and executed*. Until then it stays an idea, no matter how good it sounds. When something graduates, move the note across and rewrite it as documentation (what happened), not speculation (what might). See [[Theoretical#The promotion path]].

## Static vs dynamic prioritization

Before brainstorming tactics, classify the function as [[Static and Dynamic Functions|static, dynamic, or hybrid]].

- **Static tactics** are stable across businesses: accounting, tracking, website plumbing, inventory logs, schemas, guardrails. These usually become the first build queue because they are easier to document and automate.
- **Dynamic tactics** depend on market context: positioning, creative strategy, content hooks, offers, channel testing, product roadmap calls. These usually start in [[Theoretical]] and need evidence before promotion.
- **Hybrid areas** must be decomposed. For example, digital marketing contains static work (website setup, tracking, link-in-bio, scheduling infrastructure) and dynamic work (content angles, CRO interpretation, channel strategy).

This lens does not replace Practical vs Theoretical. Static/dynamic asks *how stable is the function?* Practical/Theoretical asks *has it been proven?*

## Mirrors the three entities

Both tiers carry the same three domains as [[Strategy]], so a tactic always has a home that maps back to its governing entity:

- **Market** → tactics for branding, product, and distribution/growth → governed by [[Market]]
- **Capital** → tactics for raising, allocating, and wielding cash → governed by [[Capital]]
- **Operation** → tactics for costing, supply chain, inventory, fulfilment → governed by [[Operation]]

## Related
- [[Static and Dynamic Functions]] - how to prioritize tactical build order
- [[Three Entities]] — the strategic layer Tactical executes against
- [[Practical]] · [[Theoretical]] — the two maturity tiers
- [[decision-log.template|Decision / Experiment Log]] — how a tactic earns promotion

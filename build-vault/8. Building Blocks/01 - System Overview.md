---
title: System Overview
type: overview
created: 2026-06-05
tags: [system, first-principles, business-model]
---

# 01 — System Overview

> [!summary]
> The business is run as three top-level entities — **Market**, **Capital**, **Operation** — that form a *closed loop*, not a one-way chain. Market itself contains three pillars: Branding, Product, and Distribution (Growth). A layer of **Governing Artifacts** (brand, intel, driver tree, knowledge base) sits underneath all three and feeds the agents that execute the work. What gets automated vs kept human is decided by the **BAU vs Pilot** lens.

## First principles

The whole system rests on a few core ideas:

1. **A business is a value loop, not a pipeline.** Demand is created and grown ([[Market]]), money is raised/allocated/wielded ([[Capital]]), and things get made and delivered ([[Operation]]) — and the demand signal flows *back* into Operation (what to make) and Capital (cash timing), while Capital can be *wielded* back into Market. Documenting it as a chain is fine for *understanding*; running it that way is a mistake. See [[Three Entities]].

2. **Distribution is the constraint for most early businesses — but only once Branding and Product deserve growth.** Making the thing is rarely the bottleneck; getting a *deserving* offer in front of the right people repeatedly is. So [[Distribution]] gets the most structure here — sitting under [[Market]] alongside [[Branding]] and [[Product]], which define what deserves to grow.

3. **Artifacts are the ground truth.** Brand guidelines, market intel, raw footage, and the driver tree aren't decoration — they're the *context layer*. Whatever the agents don't have in context, they hallucinate or do badly. See [[Governing Artifacts]].

4. **Automate the repeatable, gate the important.** "Pilot vs BAU" is really a question of *how much human oversight* a task needs, not a binary of automate/don't. See [[Part B2 - BAU vs Pilot Framework]].

5. **Measurement is the spine that connects strategy to execution.** Every moving part decomposes through a [[Governing Artifacts#4. Driver tree / value architecture|driver tree]] down to a controllable lever with a leading proxy metric. Without it, automation optimizes nothing.

> [!important] Static before dynamic
> Use [[Static and Dynamic Functions]] as a build-order lens. Static functions like accounting, tracking, website plumbing, schemas, and operating files are stable and reusable, so they should usually be built before dynamic functions like positioning, hooks, offers, and creative strategy. This gives dynamic experiments cleaner data and better context.

## The shape of the system

```
   ┌──────────────────────── GOVERNING ARTIFACTS (context layer) ───────────────────────┐
   │  Brand & design system · Raw footage/mockups · Market & competitor intel ·          │
   │  Driver tree / KPIs · Knowledge base (RAG) · Decision & Experiment Log               │
   └───────────────┬───────────────────────┬────────────────────────┬───────────────────┘
                   │                        │                        │
          ┌────────▼───────┐      ┌─────────▼────────┐      ┌────────▼─────────┐
          │     MARKET     │ ◄──► │     CAPITAL      │ ◄──► │    OPERATION     │
          │ Branding       │      │ raise            │      │ costing          │
          │ Product        │      │ allocate         │      │ supply chain     │
          │ Distribution   │      │ wield            │      │ inventory        │
          └────────┬───────┘      └──────────────────┘      └────────┬─────────┘
                   │                                                  │
                   └──────── demand signal → what to make/stock ──────┘

   Executed by:  AGENTS  ← governed by → policies.md · skills.md · guardrail.md
   Decided by:   BAU vs Pilot  →  Automation Decision Matrix
```

## How to read this vault

- If you're thinking about **the business**, start with [[Three Entities]] → [[Market]] → [[Distribution]].
- If you're thinking about **what to build first**, read [[Static and Dynamic Functions]] before brainstorming tactics.
- If you're thinking about **building agents**, start with [[Part B2 - BAU vs Pilot Framework]] then [[Part A2 - Multi-Agent Orchestration]].
- If you want the **worked example**, read [[Part C1 - Case Study - Peptide TikTok Network]].
- If you want my **pushback and corrections**, read [[Critique and Best Practices]].

## Status legend (use across notes)
- 🟢 **Working** — tested, in production
- 🟡 **Piloting** — being tested, not yet trusted
- 🔴 **Idea** — captured, not yet tested
- ⚫ **Deprecated** — tried, didn't work (keep the note — that's the point)

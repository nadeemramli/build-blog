---
title: Three Entities — Market, Capital, Operation
type: framework
created: 2026-06-05
updated: 2026-06-05
tags: [strategy, structure, mental-model]
---

# Three Entities: Market · Capital · Operation

> [!summary]
> The business is organized into three top-level entities, mapping onto the Commoncog "three sisters" of business power: **[[Market]]** (own the demand), **[[Capital]]** (fund and wield the money), **[[Operation]]** (make and deliver). They form a *closed loop*, not a one-way chain. An AI assistant — or a human team — should be structured the same way, because clean boundaries make both delegation and automation possible.

> [!note] Model upgrade (2026-06-05)
> An earlier version used **Capital · Operation · Distribution** and folded product into Operation. The corrected model promotes the triad to **Market · Capital · Operation**: *Distribution* is now the **Growth** pillar inside [[Market]], sitting alongside [[Branding]] and [[Product]]. See [[Market#Why Market is the umbrella]].

## The three entities

| Entity | Owns | Core question it answers |
|---|---|---|
| **[[Market]]** | Branding, Product, Distribution (Growth) | *Do we deserve demand, and can we grow it?* |
| **[[Capital]]** | Bookkeeping, accounting, finance — raise · allocate · wield | *Where is the money, is it healthy, and how do we deploy it?* |
| **[[Operation]]** | Costing, supply chain, inventory, fulfilment | *Can we make and deliver it profitably?* |

[[Market]] decomposes into three pillars — [[Branding]] (moats, advantage, power), [[Product]] (value architecture, JTBD, value proposition, demand), and [[Distribution]] (acquisition → conversion → retention).

## How they connect — a loop, not a chain

The original mental model described a chain: Capital → Operation → Distribution. That's correct as a **data-flow** description (cost and inventory data must reach the website before the offer can sell accurately). But running the business as a strict one-directional chain hides the most important arrows: the **feedback**.

```
   ┌──────────────────── GOVERNING ARTIFACTS (context layer) ────────────────────┐
   └──────────┬───────────────────────┬────────────────────────┬─────────────────┘
              │                        │                        │
        ┌─────▼──────┐         ┌───────▼──────┐         ┌───────▼──────┐
        │   MARKET   │ ◄─────► │   CAPITAL    │ ◄─────► │  OPERATION   │
        │ Branding   │ demand  │ raise        │  cash   │ costing      │
        │ Product    │ & GTM   │ allocate     │ timing  │ supply chain │
        │ Distribution│        │ wield        │         │ inventory    │
        └─────┬──────┘         └──────────────┘         └──────┬───────┘
              │                                                │
              └──────── demand signal → what to make/stock ────┘
```

- Market produces a **demand signal** → Operation forecasts what to make/stock; Capital plans cash.
- Capital produces **constraints** (budget, runway) → Market sizes its growth spend; and can be **wielded** offensively (see [[Capital#Capital expertise: raise, allocate, wield]]).
- Operation produces **unit economics & availability** → Market sells only what's real and profitable.

Model it as a closed loop. Each entity's agents should publish their state where the others can read it — see [[Part A2 - Multi-Agent Orchestration#Shared state is the backbone]].

## Why split this way at all

- **Clean interfaces.** Each entity exposes a small, well-defined output the others consume (Market → demand + value prop; Capital → unit economics + budget; Operation → inventory + costs). Clean interfaces are what make a task *delegatable* — to a person or an agent.
- **Independent automation.** You can automate Market's content production without touching the books.
- **Separation of measurement.** Each entity has its own KPIs that roll up into the [[Governing Artifacts#4. Driver tree / value architecture|driver tree]].

## Related
- [[Market]] · [[Capital]] · [[Operation]]
- [[Branding]] · [[Product]] · [[Distribution]] — the three Market pillars
- [[Governing Artifacts]] — the shared context layer beneath all three

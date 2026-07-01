---
title: Operation
type: entity
created: 2026-06-05
tags: [strategy, operation, supply-chain, inventory]
---

# Operation

> [!summary]
> The product spine. Operation takes Capital's cost data and turns it into a working supply chain: what things cost, how stock moves, what's in inventory now, and what's coming next. Its outputs auto-update the website — the bridge into Distribution.

## Scope

- **Costing** — landing cost per unit, building on Capital's fixed/variable split.
- **Supply chain management** — sourcing, lead times, suppliers, fulfilment.
- **Stock movement logs** — every in/out movement, the operational ledger of physical goods.
- **Inventory** — the live product list, plus the roadmap of future products.

## The bridge into [[Distribution]]

This is a key insight in the original model: **inventory auto-updates the website**, which is the bridge into Distribution.

```
Operation (inventory, price, stock level)
        │  sync / API
        ▼
Website (product pages, availability, price)
        │
        ▼
Distribution (sells what's actually in stock)
```

If this sync is manual, Distribution will eventually sell something that's out of stock or mispriced. **Make the inventory → website sync a system, not a chore** — this is one of the cleanest early automation wins (BAU, see [[Part B2 - BAU vs Pilot Framework]]).

## What Operation produces for the rest of the system

| Output | Consumed by | Why it matters |
|---|---|---|
| Live inventory + price | [[Distribution]] / website | Can't sell accurately without it |
| Stock movement log | [[Capital]] | Feeds COGS and valuation |
| Product roadmap | [[Distribution]] | What to build campaigns around next |

## Automation notes

Mostly **BAU**: stock logs, reorder alerts, inventory→website sync, supplier reminders. These are deterministic and benefit from plain scripts more than LLM agents (see [[Critique and Best Practices#5. Don't reach for an LLM when a script will do]]).

**Pilot-grade** decisions inside Operation: choosing *which future product to build*, supplier selection, big purchase commitments — keep these human (agent can prepare the analysis).

## KPIs
- Inventory turnover, days of inventory on hand
- Stockout rate, sell-through rate
- Fulfilment lead time, landed cost per unit

## Related
- [[Capital]] — feeds costing in
- [[Distribution]] — receives inventory/price out
- [[Conversion and Engagement#Website]] — the surface inventory updates

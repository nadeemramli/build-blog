---
title: Capital
type: entity
created: 2026-06-05
tags: [strategy, capital, finance, accounting]
---

# Capital

> [!summary]
> The cash engine. Capital records every transaction (bookkeeping), turns those records into statements (accounting), and uses them to plan (finance). It is the source of truth for unit economics that every other entity depends on.

## Scope

- **Bookkeeping** — recording every transaction as it happens. The raw ledger.
- **Accounting** — structuring the ledger into statements (P&L, balance sheet, cash flow) and applying rules (revenue recognition, accruals).
- **Finance** — forward-looking: budgeting, cash-flow forecasting, deciding how much capital to deploy into ads, inventory, or product.

## Capital expertise: raise · allocate · wield

> [!note] Capital isn't just record-keeping — it's a source of business power
> Bookkeeping/accounting/finance are the *machinery*. The strategic edge in Capital (per the Commoncog framing) shows up in three forms — and these are the inherent "flows" of the entity, not just data passing through it:
>
> 1. **The ability to raise it.** Three broad routes: sell equity, raise debt, or reinvest retained earnings. Each demands expertise, and each has a creative palette of instruments. For a bootstrapped operator, retained earnings + disciplined reinvestment is usually the engine.
> 2. **The ability to spend it well — *capital allocation*.** Only five options exist for the cash a business generates: reinvest in the business, M&A, pay down debt, buy back shares, or issue a dividend. How well these calls are made determines long-term enterprise value. For an early business this collapses mostly to *reinvest vs. hold* — but the discipline is the same.
> 3. **The ability to wield it** in service of moves in [[Operation]] or against competitors in the [[Market]]. Capital is an *enabling weapon*: used to shore up operations, out-invest a rival in [[Distribution]], or buy a [[Branding|moat]]. This is the arrow from Capital *back into* Market and Operation — part of why the [[Three Entities|triad is a loop, not a chain]].

This is why Capital sits as a top-level entity beside [[Market]] and [[Operation]], rather than a back-office function: *allocation and wielding decisions are strategy*, not bookkeeping.

## The bridge into [[Operation]]

Capital feeds Operation the numbers Operation can't function without:
- **Costing** — what each unit actually costs to produce and deliver.
- **Fixed vs variable costs** — the split that determines breakeven and contribution margin.

These then flow on into supply-chain and inventory decisions. This is the "Capital → Operation" arrow from [[Three Entities]].

## What Capital produces for the rest of the system

| Output | Consumed by | Why it matters |
|---|---|---|
| Unit economics (COGS, margin) | [[Operation]], [[Distribution]] | Sets the ceiling on CAC and ad spend |
| Cash-flow forecast | Whole business | Determines pace of growth |
| Budget / runway | [[Distribution#Paid|Paid acquisition]] | Caps performance-marketing spend |

## Automation notes (see [[Part B2 - BAU vs Pilot Framework]])

Most of Capital is **BAU** — high-frequency, rule-bound, low-creativity. Strong automation candidates:
- Transaction categorization and reconciliation (bookkeeping).
- Statement generation on a schedule.
- Cash-flow forecast refresh.

> [!caution] Keep a human gate on anything that *moves money or files with authorities*
> Automate the *recording and reporting*; never let an agent execute payments, transfers, or tax filings autonomously. These are **Pilot-grade** approval gates even though the surrounding work is BAU. See [[Part B1 - Automation Decision Matrix#The approval-gate rule]].

## KPIs (roll up into the driver tree)
- Gross margin %, contribution margin per unit
- Cash conversion cycle, runway (months)
- Operating expense ratio

## Related
- [[Operation]] — the entity Capital bridges into
- [[Governing Artifacts#4. Driver tree / value architecture]] — where these KPIs decompose

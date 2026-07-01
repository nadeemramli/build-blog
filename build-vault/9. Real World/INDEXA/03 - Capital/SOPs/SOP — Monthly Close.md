---
title: "SOP — Monthly Close"
type: sop
date: 2026-06-01
tags: [indexa, capital, sop]
---

# SOP — Monthly Close

**Cadence:** first few days of the new month, for the month just ended.

## Steps
1. **Completeness** — every `#sales-order` that was `paid` has a matching `#transaction`; every `#transaction` is `reconciled: true`.
2. **Total the buckets** from the Transactions Ledger + Expenses bases:
   - Revenue = sum of `sales-revenue` in.
   - COGS = stock shipped this month (from `cogs` transactions / costing).
   - Opex = `software + marketing + shipping + payment-fees + domain + phone + misc`.
3. **Compute** net = revenue − COGS − opex; record ending cash.
4. **Create** the `#month-close` note `YYYY-MM` with revenue / cogs / opex / net / cash_end.
5. **Refresh margins** — reconcile `#costing` sell prices vs latest landed costs from POs received this month.
6. **Review & plan** — 5 lines: what grew, what leaked, margin trend, and how much to reinvest into ads vs inventory next month.

## Output
A clean `#month-close` row in [[Cashflow Monthly.base|Cashflow Monthly]] and a short written review in the note body.

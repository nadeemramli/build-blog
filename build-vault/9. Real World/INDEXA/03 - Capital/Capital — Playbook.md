---
title: "Capital — Playbook"
type: pillar
date: 2026-06-01
tags: [indexa, capital]
---

# 🟢 Capital

**Mandate:** make sure every cycle ends with more usable cash than it started, the books are clean, and there's enough runway to fund the next restock and the next campaign. Capital is the scoreboard for Distribution and Operation.

## Objective & guardrail

Stay cash-positive and fund growth from margin, not borrowing. Every ringgit in or out is logged as a `#transaction`; nothing is "off the books". Reconcile to the bank weekly — the vault must match reality.

## What Capital tracks

### 1. Bookkeeping (the ledger)
Every payment in or out → a `#transaction` (`direction: in|out`, a `category`, an `amount`, and a `ref` to the order/PO it relates to). Sales revenue, refunds, COGS, opex, owner draws, capital in — all flow through one ledger.

### 2. Expenses
Recurring and one-off costs → `#expense`. Known fixed costs today: Lovable (RM105/mo), Cursor, domain (indexalabs.com), business phone + top-ups, payment fees, shipping, ad spend. Recurring flag makes monthly burn easy to total.

### 3. Product costing & margin
Each SKU has a `#costing` note: `landed_cost + pack_cost` vs `sell_price`. The Base computes margin and margin %. This is the link between Operation (what stock costs) and pricing — if landed cost rises on a PO, update costing so you don't quietly sell at a loss.

### 4. Cashflow & planning
Monthly `#month-close` rolls up revenue, COGS, opex, net, and ending cash. That series is the runway and growth picture — and the basis for deciding how much to reinvest into ads and inventory.

## The money rules

- **Revenue is recognised when paid**, not when ordered.
- **COGS books when stock ships** (matched to the order).
- **Separate business cash** from personal — owner draws are an explicit category, never a silent withdrawal.
- **Reserve for restock.** Keep enough cash to refill top-sellers before they stock out.
- **Escalate** any single movement over RM1,000 or anything that won't reconcile.

## Weekly / monthly rhythm

- **Weekly:** record every transaction, reconcile against the bank (`reconciled: true`), list upcoming recurring expenses, check cash on hand.
- **Monthly close:** match orders↔transactions, total the three buckets, write the `#month-close`, refresh margins, and review reinvestment.

## Bases

- **[[Transactions Ledger.base|Transactions Ledger]]** — all money in/out, reconciled flag.
- **[[Expenses.base|Expenses]]** — recurring + one-off burn.
- **[[Product Costing.base|Product Costing]]** — margin & margin % per SKU.
- **[[Cashflow Monthly.base|Cashflow Monthly]]** — revenue → net → ending cash by month.

## SOPs

- [[SOP — Bookkeeping & Reconciliation]]
- [[SOP — Monthly Close]]

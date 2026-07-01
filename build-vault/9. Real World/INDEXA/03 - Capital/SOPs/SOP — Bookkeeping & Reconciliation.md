---
title: "SOP — Bookkeeping & Reconciliation"
type: sop
date: 2026-06-01
tags: [indexa, capital, sop]
---

# SOP — Bookkeeping & Reconciliation

**Goal:** a ledger that always matches the bank.

## Record (as it happens)
1. Money in (a paid order) → `#transaction` (`direction: in`, `category: sales-revenue`, `ref` to the order). Set `reconciled: false`.
2. Money out (supplier, software, ads, shipping) → `#transaction` (`direction: out`) **and** a `#expense` note if it's an operating cost. COGS books when stock ships.
3. Always set `account` (which bank/card) and `method`.

## Reconcile (weekly)
4. Pull the bank/payment-gateway statement.
5. Match each line to a `#transaction`. When matched, set `reconciled: true`.
6. **Unmatched bank line** → create the missing transaction. **Unmatched vault line** → investigate; never delete to "fix" a mismatch.
7. Confirm the running cash balance equals the bank balance.

## Red flags → escalate
Any movement > RM1,000, a duplicate charge, a gateway fee that looks off, or a transaction that can't be matched after one cycle.

## Definition of done
Every transaction for the period `reconciled: true`; vault cash == bank cash.

---
title: "SOP — Buying from Amo"
type: sop
date: 2026-06-01
tags: [indexa, operation, sop]
---

# SOP — Buying from Amo (Crypto Payment)

Supplier: [[SUP-BFF|BFF / Amo]]. Payment rail: **USDT (TRC-20)**. Sends are **irreversible** — accuracy beats speed.

## Funding flow (fiat → USDT)
1. **Swapped** — use [swapped.com](https://swapped.com) to convert fiat (MYR) → **USDT-TRC20**.
2. **Push to Ledger** (hardware wallet) for custody.
3. **Store / spend from Trust Wallet**.
4. **Hold TRX** in the wallet for network gas fees (TRC-20 transactions need TRX).
5. **Buy directly** — send USDT to Amo's wallet, then place/confirm the order.

> If routing via Wise fails/cancels, expect a fee loss (≈ RM27 last time) when rerouting through Binance/crypto. Prefer Swapped → Ledger → Trust Wallet to avoid this.

## Wallet check (do not skip)
- Confirm Amo's wallet address character-by-character: `TA24DNkfYCh57wWKQPGUKFyGxVjwqxviY7`
- After sending, save the **Tronscan transaction link** into the purchase order note.

## Log the purchase
1. Create a `#purchase-order` note (`PO-<order#>`): supplier, vials, `total_cost`, ETA, tronscan link.
2. Create `#transaction` notes for each payment leg: USDT amount, TRX, and any Wise/convert fees.
3. Add consumables (BAC water, syringes, swabs) as `#expense` notes.
4. On arrival + COA check → `#stock-move` (in) and update `#inventory`.

## Cost legs to capture (from last order)
- USDT (peptides): the main cost in RM
- TRX (gas): small, ~RM50
- Wise / convert fees: ~RM15–27
- Consumables: BAC water, insulin syringes, alcohol swabs

## Escalate
Any wallet-address uncertainty, a failed/stuck transaction, or a price change from Amo.

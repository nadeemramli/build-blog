---
title: "SOP — Restock & QC"
type: sop
date: 2026-06-01
tags: [indexa, operation, sop]
---

# SOP — Restock & QC

**Trigger:** an `#inventory` item hits `available ≤ reorder_point`, or a planned buy.

## Order
1. Create `#purchase-order` (`PO-YYYYMMDD-NNN`): supplier, lines, `total_cost`, `eta`. Status `ordered`.
2. Track shipment: status `in-transit` until it lands.

## Receive & QC
3. On arrival, inspect: packaging intact, cold-chain held, quantities match.
4. **COA check** — confirm a third-party COA exists for the batch (identity + purity). File it. **No COA → no shelf.**
5. Pass → create `#stock-move` (`direction: in`, `reason: restock`, link `ref` to the PO) and update `#inventory` `on_hand`, `unit_cost`, `status`. PO → `received`.
6. Fail → `#stock-move` (`reason: qc-fail`), quarantine, escalate to supplier.

## Costing sync
7. If landed cost changed, update the matching `#costing` note so margins stay accurate (see Capital).

## Escalate
Supplier delay on a top-seller, price change, or any QC fail.

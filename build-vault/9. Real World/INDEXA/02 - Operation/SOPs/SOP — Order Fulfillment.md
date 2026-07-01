---
title: "SOP — Order Fulfillment"
type: sop
date: 2026-06-01
tags: [indexa, operation, sop]
---

# SOP — Order Fulfillment

**Trigger:** a `#sales-order` reaches status `paid`.

## Steps
1. **Create fulfilment** — copy `_Template — Fulfillment`, name `FUL-YYYYMMDD-NNN`, link `order`.
2. **Reserve stock** — create a `#stock-move` (`direction: out`, `reason: sale`, link `ref` to the order). Increment `reserved` on each `#inventory` item, or decrement `on_hand` at pack time. Pick FIFO (oldest batch first).
3. **Pack** — verify SKUs, doses, and that the batch has a COA on file. Status → `packed`.
4. **Ship** — book courier (J&T / Pos Laju / etc.), enter `courier` + `tracking`, set `ship_date`. Status → `shipped`.
5. **Notify** — tracking flows to the customer via the site's track-order → WhatsApp function.
6. **Close** — on delivery, set fulfilment `delivered` and the order `delivered`.

## Exceptions
- Out of stock at pack time → hold, raise/await a `#purchase-order`, tell the customer, **escalate** if it's a top-seller.
- Damaged in transit / wrong item → status `issue`, open a `#support-ticket`, escalate refund/replacement.

## Definition of done
Order `delivered`, stock decremented, no open issue.

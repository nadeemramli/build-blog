---
title: "Operation — Playbook"
type: pillar
date: 2026-06-01
tags: [indexa, operation]
---

# 🟠 Operation

**Mandate:** turn every paid order into a delivered order — accurately, in spec, on time — while keeping stock available and customers informed. Operation sits between Distribution (orders in) and Capital (COGS out).

## Objective & guardrail

Ship 100% of paid orders on time, never sell what isn't in stock, and keep cold-chain / storage integrity for every vial. Quality and traceability beat speed — a wrong or degraded product is worse than a late one.

## Core workflows

### 1. Order fulfilment
`paid` order → reserve stock → pack → ship → tracking → `delivered`. Each step is a status on the `#fulfillment` note; tracking links back to the order and feeds the website's track-order function (→ WhatsApp).

### 2. Stock & inventory
Every physical move is a `#stock-move` (in / out / adjust). The `#inventory` note holds the live picture: `on_hand`, `reserved`, and computed `available`. When `available ≤ reorder_point`, raise a purchase order.

### 3. Restock & QC
Supplier delivery → `#purchase-order` received → QC check (COA on file, packaging intact) → `#stock-move` in → update `#inventory`. No stock goes live without a COA logged for the batch.

### 4. Customer support
WhatsApp/IG enquiries → `#support-ticket`. Most are tracking, verify, or product questions. Resolve fast, stay in research-use framing, escalate refunds.

## Storage & handling (non-negotiables)

Follow the vault's *Peptide Storage and Handling Guidelines* and *Reconstitution* docs. Lyophilised vials kept cold/dry, minimal light/heat exposure, FIFO on stock so oldest batches ship first. Log any damage/QC fail as a `#stock-move` (`reason: qc-fail` / `damage`).

## Daily / weekly rhythm

- **Daily:** clear the fulfilment queue (every `paid` order gets shipped), log stock-out movements, answer support.
- **Weekly:** physical stock count vs. `#inventory`; raise POs for anything below reorder point; review open tickets and any fulfilment `issue`.

## Bases

- **[[Inventory.base|Inventory]]** — live on-hand, reserved, available, status.
- **[[Stock Movements.base|Stock Movements]]** — every in/out/adjust.
- **[[Purchase Orders.base|Purchase Orders]]** — incoming restocks & ETAs.
- **[[Fulfillment Queue.base|Fulfilment Queue]]** — what needs packing/shipping now.
- **[[Support Tickets.base|Support Tickets]]** — open enquiries by topic.

## SOPs

- [[SOP — Order Fulfillment]]
- [[SOP — Restock & QC]]
- [[SOP — Customer Support]]

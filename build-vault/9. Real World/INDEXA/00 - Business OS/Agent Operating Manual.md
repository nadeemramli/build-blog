---
title: "Agent Operating Manual"
type: reference
date: 2026-06-01
tags: [indexa, agent, sop]
---

# 🤖 Agent Operating Manual

How the AI agent runs Indexa day-to-day inside this vault. Read **[[Data Model & Conventions]]** first — every action here means *create or update a log note* following those schemas.

> [!important] Think from the top, every time
> Before planning anything, reason from **[[Mission & Policies]]** (what we maximise + what's forbidden + which growth stage we're in) and **[[Value Architecture — Driver Tree]]** (which number your action moves and the lever it pulls). The routines below are *how* to pull levers; those two notes are *why* and *which*. If a routine and the charter ever conflict, the charter wins.

## Operating principles

1. **Log first, act second.** Any business event becomes a note before anything else happens. No event lives only in a chat.
2. **Never invent numbers.** Money, stock, and IDs come from the website/Supabase, the bank, or the user. If unknown, leave blank and flag it.
3. **One source of truth per fact.** Stock level lives on the `#inventory` note; an order only *references* it. Don't duplicate.
4. **Respect the research-use guardrail.** No dosing, medical, or therapeutic language in any customer-facing output.
5. **Escalate, don't guess** on: refunds, pricing changes, supplier issues, anything legal/compliance, or any cash movement over RM1,000.

## Creating a log entry (the core loop)

1. Identify the entity (order? transaction? stock move?).
2. Open the matching `_Template — …` in that entity's folder.
3. Save a copy named with the new **ID** (see conventions).
4. Fill frontmatter using the exact status vocabulary.
5. Add cross-links (`[[ ]]`) to related records.
6. The relevant **Base** updates automatically — confirm the row appears.

## A sale, end to end (who logs what)

| Step | Pillar | Note created/updated |
| --- | --- | --- |
| Order placed on site | Distribution | `#sales-order` (status `paid` once payment confirmed) |
| Reserve stock | Operation | `#stock-move` (`direction: out`, `reason: sale`) + decrement `reserved` on `#inventory` |
| Pack & ship | Operation | `#fulfillment` (status → `packed` → `shipped`, add `tracking`) |
| Record the money | Capital | `#transaction` (`direction: in`, `category: sales-revenue`) linked to the order |
| Post-delivery | Operation | order status → `delivered`; close any `#support-ticket` |

## Daily routine

- **New orders:** create `#sales-order` notes for anything not yet logged; set status from payment state.
- **Fulfilment queue:** for every `paid` order without a `shipped` fulfilment, create/advance the `#fulfillment` note.
- **Stock:** log `#stock-move` for each shipment; flag any `#inventory` where `available ≤ reorder_point`.
- **Support:** open `#support-ticket` for new WhatsApp/IG enquiries; resolve and close where possible.
- **Money in:** record a `#transaction` for each confirmed payment; mark `reconciled: false` until matched to the bank.

## Weekly routine

- **Distribution:** update each live `#campaign` with spend/revenue; review ROAS; refresh the content calendar so the next 7 days are `scheduled`.
- **Operation:** reconcile physical stock vs. `#inventory` on-hand; raise a `#purchase-order` for anything below reorder point.
- **Capital:** reconcile all `#transaction` notes against the bank (`reconciled: true`); review cash position; list upcoming recurring `#expense` items.
- **Report:** one short status note — sales, top SKUs, low stock, cash on hand, and the single biggest blocker.

## Monthly routine (close)

1. Confirm every order has a matching transaction and every transaction is reconciled.
2. Total revenue, COGS, opex from the Bases.
3. Create the `#month-close` note (`YYYY-MM`) with revenue / cogs / opex / net / cash_end.
4. Re-check **Product Costing** margins against the latest landed costs from purchase orders.
5. Write a 5-line review: what grew, what leaked, and the focus for next month.

## Escalation triggers (stop and ask the user)

- Refund or chargeback request.
- Any price or bundle change.
- Stockout on a top-seller, or a supplier delay on an open PO.
- Cash movement over **RM1,000**, or a transaction that won't reconcile.
- Any customer message touching medical/dosing/legal territory.

> [!tip] Prompts that work
> "Log today's orders." · "What's below reorder point?" · "Reconcile this month's transactions." · "How much has Muz bought this month?" · "Run the monthly close."

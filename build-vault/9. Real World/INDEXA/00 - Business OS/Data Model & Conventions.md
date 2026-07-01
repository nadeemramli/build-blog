---
title: "Data Model & Conventions"
type: reference
date: 2026-06-01
tags: [indexa, reference, schema]
---

# 🗂️ Data Model & Conventions

The single source of truth for **how every log note is structured** so Bases, templates, and the agent stay consistent. If you add a property here, update the relevant template and `.base` file too.

## Golden rules

1. **One thing = one note.** One order, one transaction, one stock movement per file.
2. **The frontmatter is the data.** The note body is for context/notes only.
3. **Filename = ID.** The file is named exactly as its `id` (e.g. `ORD-20260525-001.md`).
4. **Tag drives the Base.** Every log carries a type tag (e.g. `#sales-order`). Bases filter on that tag and exclude any file whose name contains `Template`.
5. **Money is a number, currency is a field.** Store `total: 320`, `currency: RM` — never `"RM320"`. Numbers must stay numeric so formulas work.
6. **Dates are ISO.** `2026-05-25`. Use Obsidian *Date* property type.
7. **Cross-links use wikilinks.** An order points to its transaction with `txn: "[[TXN-20260525-001]]"`.

## ID conventions

| Entity | Pattern | Example |
| --- | --- | --- |
| Sales order | `ORD-YYYYMMDD-NNN` | `ORD-20260525-001` |
| Lead | `LEAD-NNNN` | `LEAD-0001` |
| Campaign | `CMP-NNN` | `CMP-001` |
| Content post | `POST-YYYYMMDD-NNN` | `POST-20260525-001` |
| Inventory SKU | `SKU-<PEPTIDE>-<DOSE>` | `SKU-BPC157-5MG` |
| Stock movement | `STK-YYYYMMDD-NNN` | `STK-20260525-001` |
| Purchase order | `PO-YYYYMMDD-NNN` | `PO-20260520-001` |
| Fulfilment | `FUL-YYYYMMDD-NNN` | `FUL-20260525-001` |
| Support ticket | `TKT-YYYYMMDD-NNN` | `TKT-20260525-001` |
| Transaction | `TXN-YYYYMMDD-NNN` | `TXN-20260525-001` |
| Expense | `EXP-YYYYMMDD-NNN` | `EXP-20260501-001` |
| Product cost | `COST-<PEPTIDE>-<DOSE>` | `COST-BPC157-5MG` |
| Month close | `YYYY-MM` | `2026-05` |

## Status vocabularies (use these exact values)

- **Sales order** → `cart` · `pending-payment` · `paid` · `fulfilling` · `shipped` · `delivered` · `cancelled` · `refunded`
- **Lead** → `new` · `contacted` · `qualified` · `nurturing` · `won` · `lost`
- **Campaign** → `planned` · `live` · `paused` · `done`
- **Content** → `idea` · `drafting` · `scheduled` · `published`
- **Purchase order** → `draft` · `ordered` · `in-transit` · `received` · `cancelled`
- **Fulfilment** → `queued` · `packed` · `shipped` · `delivered` · `issue`
- **Support** → `open` · `waiting` · `resolved`
- **Inventory** → `in-stock` · `low` · `out` · `discontinued`

## Channels & categories

- **Channels:** `website` · `whatsapp` · `instagram` · `tiktok` · `telegram` · `x` · `email`
- **Expense categories:** `inventory-cogs` · `software` · `marketing` · `shipping` · `payment-fees` · `domain` · `phone` · `misc`
- **Transaction categories:** `sales-revenue` · `refund` · `cogs` · `opex` · `owner-draw` · `capital-in`

## Frontmatter schemas

### Sales order — `#sales-order`
```yaml
type: sales-order
id: ORD-20260525-001
status: paid
channel: website
customer: "handle or name"
order_date: 2026-05-25
items: 2
subtotal: 320
shipping: 0
discount: 0
total: 320
currency: RM
payment_method: bank-transfer
txn: "[[TXN-20260525-001]]"
fulfillment: "[[FUL-20260525-001]]"
tags: [sales-order]
```

### Lead — `#lead`
```yaml
type: lead
id: LEAD-0001
status: qualified
source: tiktok
handle: "@user"
interest: "Retatrutide 60mg"
value_est: 300
currency: RM
first_contact: 2026-05-20
last_touch: 2026-05-24
tags: [lead]
```

### Campaign — `#campaign`  (formula: `roas = revenue / spend`)
```yaml
type: campaign
id: CMP-001
status: live
channel: tiktok
objective: conversion
start: 2026-05-15
end: 2026-06-15
budget: 500
spend: 180
revenue: 640
currency: RM
tags: [campaign]
```

### Content post — `#content-post`
```yaml
type: content
id: POST-20260525-001
status: scheduled
channel: tiktok
format: video
pillar: education
publish_date: 2026-05-25
hook: "Why third-party COA matters"
link: ""
tags: [content-post]
```

### Inventory item — `#inventory`  (formula: `available = on_hand - reserved`)
```yaml
type: inventory
id: SKU-BPC157-5MG
product: "BPC-157"
dose: "5mg"
category: "Tissue Regeneration Research"
on_hand: 42
reserved: 6
reorder_point: 20
unit_cost: 18
price_dropship: 89
supplier: "Supplier A"
status: in-stock
tags: [inventory]
```

### Stock movement — `#stock-move`
```yaml
type: stock-move
id: STK-20260525-001
sku: "[[SKU-BPC157-5MG]]"
direction: out
qty: 2
reason: sale
ref: "[[ORD-20260525-001]]"
date: 2026-05-25
tags: [stock-move]
```

### Purchase order — `#purchase-order`
```yaml
type: purchase-order
id: PO-20260520-001
supplier: "Supplier A"
status: received
order_date: 2026-05-10
eta: 2026-05-20
lines: 5
total_cost: 4200
currency: RM
tags: [purchase-order]
```

### Fulfilment — `#fulfillment`
```yaml
type: fulfillment
id: FUL-20260525-001
order: "[[ORD-20260525-001]]"
status: shipped
courier: "J&T"
tracking: "JT0000001"
ship_date: 2026-05-26
tags: [fulfillment]
```

### Support ticket — `#support-ticket`
```yaml
type: support
id: TKT-20260525-001
channel: whatsapp
status: open
topic: tracking
customer: "handle or name"
opened: 2026-05-25
tags: [support-ticket]
```

### Transaction — `#transaction`
```yaml
type: transaction
id: TXN-20260525-001
direction: in
category: sales-revenue
amount: 320
currency: RM
method: bank-transfer
account: "Maybank Business"
ref: "[[ORD-20260525-001]]"
date: 2026-05-25
reconciled: false
tags: [transaction]
```

### Expense — `#expense`
```yaml
type: expense
id: EXP-20260501-001
category: software
vendor: "Lovable"
amount: 105
currency: RM
recurring: monthly
date: 2026-05-01
account: "Card"
tags: [expense]
```

### Product cost — `#costing`  (formulas: `ds_margin`, `pub_margin`, `pub_pct`)
**Two price tiers** — see [[Pricing Model]]. `price_dropship` = wholesale to resellers; `price_public` = direct retail (`0` = not yet set).
```yaml
type: costing
id: COST-BPC157-5MG
sku: "[[SKU-BPC157-5MG]]"
product: "BPC-157 5mg"
landed_cost: 18
pack_cost: 2
price_dropship: 89
price_public: 0
currency: RM
tags: [costing]
```

### Month close — `#month-close`
```yaml
# illustrative shape only — fill with real reconciled figures
type: month-close
id: 2026-06
month: 2026-06
revenue: 0
cogs: 0
opex: 0
net: 0
cash_end: 0
currency: RM
tags: [month-close]
```

> [!tip] Adding a new record fast
> Copy the matching `_Template — …` note inside the entity folder, rename the file to the new ID, fill the frontmatter. The Base picks it up automatically — no other step.

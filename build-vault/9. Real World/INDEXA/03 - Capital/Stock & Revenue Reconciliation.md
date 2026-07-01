---
title: "Stock & Revenue Reconciliation"
type: reconciliation
date: 2026-06-01
status: open
tags: [indexa, capital, operation, reconciliation]
---

# 🔍 Stock & Revenue Reconciliation (v1 — open)

> [!abstract] What this is
> A from-the-logs reconstruction of **how much stock we *should* have** (every purchase in, every documented unit out) so that when you fill the **Your physical count** column, the **gap = units that left without a clean record** — off-log sales, personal use, friend trials, price variances. It also surfaces the **revenue ledger gap** so we can finalise *how much the business actually earned* and, from there, the founder ↔ company balance.

---

## ✅ Ground truth corrections (founder-confirmed, 2026-06-01) — do not re-ask

> [!important] These override any conflicting record in the vault. The agent treats them as fact.
> 1. **`SKU-BPC157-5MG` is NOT real** — it's seeded template/example data (it matches the Data Model sample record exactly: 42/6/20/18/89). **The only BPC-157 we stock is 10mg.** → remove the phantom SKU + cost card.
> 2. **`SKU-GHKCU-50MG` is NOT real** — same story. **The only GHK-Cu we stock is 100mg.** → remove the phantom SKU + cost card.
> 3. **First BFF batch (`PO-20251218-001`, US$336) = ONE box / ONE vial. That's it.** It is *not* the source of any bulk stock. (Which single product/dose → confirm once; immaterial to totals.)
> 4. **Wolverine Blend is self-made, not purchased.** Founder combines **1× BPC-157 10mg + 1× TB500 5mg** per blend. Landed cost RM79 = 40 (BPC10) + 39 (TB500) — the arithmetic confirms 1:1. Every Wolverine made/sold *consumes one of each component vial* from stock.

## Part A — Stock reconciled to physical count (2026-06-01) ✅

**Inputs:** physical counts founder-supplied; **W = 2 Wolverine blends made** (1 sold, 1 given free) → −2 BPC-157 10mg & −2 TB500 5mg; first BFF batch = **Retatrutide** (BFF only ever sources Reta). R&D corrected 9→7 (see below).

| Real SKU | Bought | R&D | →Wolverine | Should-have | **Physical** | **Gap = sold/used off-log** |
| --- | ---: | ---: | ---: | ---: | :--: | :--: |
| Retatrutide 60mg | 40* | — | — | 26 | **4** | **22** 🔴 |
| GHK-Cu 100mg | 10 | — | — | 8 | **0** | **8** 🔴 |
| BPC-157 10mg | 10 | — | 2 | 8 | **5** | **3** |
| TB500 5mg | 10 | — | 2 | 8 | **6** | **2** |
| CJC-1295 5mg | 10 | — | — | 10 | **9** | **1** |
| SS-31 10mg | 10 | 7 | — | 3 | **3** | **0** ✅ |
| MOTS-C 10mg | 10 | 7 | — | 3 | **3** | **0** ✅ |
| Wolverine Blend | (2 made) | — | — | 0 | **0** | 1 sold + 1 free ✅ |

*\*Reta bought = 30 (PO-37066) + **10** (first BFF batch = 1 box of 10, founder-confirmed). 36 disposed of 40; gap 22 = disposed beyond the 14 documented.*

### What the gaps mean
- **Reta 60mg — 22 vials gone off-log** (on top of the 14 in the batch P&L; total disposed ≈ 36 of 40). This is the bulk of your unrecorded revenue.
- **GHK-Cu 100mg — all 10 gone**, only 2 ever recorded. Shelf is empty.
- **BPC-157 10mg (3) · TB500 5mg (2) · CJC-1295 (1)** — small off-log disposals.
- **SS-31 & MOTS-C reconcile exactly** once R&D is corrected: logs said 9 consumed, but 10 bought − 3 on hand = only **7** could have gone. Corrected `STK-20260201-001/002` to **qty 7**. (If 2 were actually *sold* not R&D, tell me.)

> [!success] Stock side is now real
> Inventory `on_hand` updated to your physical counts; GHK-Cu 100mg flagged `out`, Reta/BPC/SS-31/MOTS-C `low`. The Bases now show reality. The *variances* above get booked as proper stock-moves + revenue once we price them (Part C).

---

## Part B — Resolved / remaining
- ✅ **W = 2** (1 sold, 1 free). ✅ **First batch = 1 box of 10 Reta.** ✅ **R&D corrected** 9→7. ✅ **Reta price RM350→RM400.**
- ✅ **Money in = RM12,030** (personal account; total only, not a per-unit ledger).
- ✅ **`ORD-20260525-001` / `TXN-20260525-001` (RM320, @ironpeak):** confirmed fake seed data — **deleted** (see Part C3).

---

## Part C — Rebuild true revenue from the units that left 🔴

The stock gaps tell us **how many units left**; you tell me **the price each went for**, and that *is* true revenue. The money ledger is effectively empty (only a suspected-fake RM320 entry), so we're rebuilding it from physical reality. Here are the units to price:

| Units gone (need price) | Qty | Price buckets to split into |
| --- | ---: | --- |
| **Retatrutide 60mg** | **22** | mostly @ RM400 (a few early @ RM350) · personal-use · free trial (RM0) · still-owed by Muz |
| **GHK-Cu 100mg** | **10** | @ RM90 / RM100 · personal · free |
| **BPC-157 10mg** (standalone) | **3** | price each · or free/personal |
| **TB500 5mg** (standalone) | **2** | price each · or free/personal |
| **CJC-1295 5mg** | **1** | price · or R&D/personal |
| **Wolverine Blend** | **2** | 1 sold (RM350?) + 1 free (RM0) |

> [!tip] Easiest way to answer
> Don't itemise every sale. Just give me **counts per price bucket** per SKU — e.g. *"Reta: 12 @ 400, 4 @ 1000, 3 personal, 3 free."* I'll total it into real revenue, real COGS (units × landed cost), and real profit, then book it.

Once priced, you also get the real margin per channel (dropship vs public) — which feeds the [[Pricing Model]] and the [[Value Architecture — Driver Tree|driver tree]].

---

## Part C2 — Sales ledger: who bought what (real, 2026-06-01)

**Total money in to date = RM12,950**, across four buyers. Muz = the entire bank statement (all credits are his, instalments now fully paid — **no outstanding balance**). The other three paid separately.

| Buyer | Money in (RM) | Stock received | Paid vs free |
| --- | ---: | --- | --- |
| **Muz** (main dropshipper) | **12,030** | ~29–30× Reta 60mg + 1× Wolverine | all paid, settled |
| **Kio** (reseller, trial) | **370** | 2× GHK-Cu · 2× BPC-157 10mg · 1× Reta · 1× MOTS-C · 1× TB500 | paid only for **1 Reta + 1 GHK = RM370** (pre-pricing rate); **rest free to test** |
| **Haikhal** (reseller) | **150** | 1× GHK-Cu | paid |
| **Najiha** (direct customer) | **400** | 1× Reta 60mg | paid |
| **TOTAL** | **12,950** | | |

> [!note] Why we don't split Muz's RM12,030 by line
> It's a personal account and Muz paid in instalments, so the per-vial split isn't bankable. What we know: **Muz = RM12,030 for Reta (bulk, mostly RM400, a few early at RM350) + 1 Wolverine (RM350).** That implies **~29–30 Reta vials.**

### Stock disposition — does it tie to the 40-Reta / full shelf? Mostly.

| SKU | Disposed | Explained (paid + free + R&D) | **Unaccounted** |
| --- | ---: | --- | ---: |
| Reta 60mg | 36 | Muz ~30 + Najiha 1 + Kio 1 | **~4** |
| GHK-Cu 100mg | 10 | Kio 2 + Haikhal 1 | **7** 🔴 |
| BPC-157 10mg | 5 | Wolverine 2 + Kio 2 | **1** |
| TB500 5mg | 4 | Wolverine 2 + Kio 1 | **1** |
| MOTS-C 10mg | 7 | R&D 6 + Kio 1 | **0** ✅ |
| SS-31 10mg | 7 | R&D 7 | **0** ✅ |
| CJC-1295 5mg | 1 | — | **1** |
| Wolverine | 2 | Muz 1 (sold) + 1 free | **0** ✅ |

**The big one: 7 GHK-Cu still unaccounted** (only 3 of 10 went to named buyers). Plus small bits: ~4 Reta, 1 BPC, 1 TB500, 1 CJC. These left the shelf but aren't in the RM12,950 — almost certainly **personal use + free trials**. Confirm and they get booked as owner-draw (personal) or marketing (free samples).

### Real revenue — finally a number
- **Revenue received to date = RM12,950** (Muz 12,030 + Kio 370 + Haikhal 150 + Najiha 400). No receivables outstanding.
- vs the **RM320** the vault had booked — the books were under-recording by **~40×**.
- COGS of *paid* units = **RM4,387** → **gross profit ≈ RM8,563.**
- Separately, **~RM1,078 of stock at cost was given free or used personally** (Kio's free items RM180 + 1 free Wolverine RM79 + ~RM819 unaccounted/personal). That sits *below* gross profit — booked as marketing (free trials) or owner-draw (personal use) once you confirm the split.

---

## Part C3 — Logs created & ledger tied out ✅ *(2026-06-01)*

Real records now exist in the vault and the **full stock ledger nets exactly to your physical shelf for all 7 SKUs** (verified):

| SKU | Ledger (in−out) | Shelf | |
| --- | :--: | :--: | :--: |
| Reta 60mg · GHK-Cu 100mg · BPC-157 10mg · TB500 5mg · CJC-1295 · SS-31 · MOTS-C | = | = | ✅ all tie |

**Created:**
- **4 sales orders** — `ORD-20260303-001` (Muz), `ORD-20260410-001` (Kio), `ORD-20260415-001` (Najiha), `ORD-20260515-001` (Haikhal).
- **12 revenue transactions** — Muz's 9 bank instalments + Kio + Najiha + Haikhal → **money in = RM12,950** (reconciled).
- **13 stock-moves** — first-batch intake (10 Reta) + per-customer outflows + Wolverine blend consumption + 5 `adjustment` moves for the untrailed/personal units.

**Purged (deleted 2026-06-01) — all fabricated seed data, no longer in the vault:**

| Removed | Why it was fake |
| --- | --- |
| `SKU-BPC157-5MG`, `SKU-GHKCU-50MG` | products that don't exist (matched template sample) |
| `COST-BPC157-5MG`, `COST-GHKCU-50MG` | cost cards for those non-existent SKUs |
| `STK-20260120-000` | phantom 10-Reta "intake from TCI" (TCI never supplies Reta) |
| `ORD-20260525-001`, `TXN-20260525-001`, `FUL-20260525-001` | the fake RM320 @ironpeak order + payment + shipment |
| `TKT-20260526-001` | support ticket for that fake order |
| `LEAD-0001`, `CMP-001`, `POST-20260525-001`, `EXP-20260515-001` | the made-up "Shred / TikTok campaign" narrative (lead, campaign, content, RM180 ad spend) |
| `2026-05` month-close | fabricated numbers (rev 5,200 / net 2,500 / cash 7,400) — contradicted by the real reconciliation |

**Kept (real):** 7 SKUs + 8 cost cards, the 3 real POs, real expenses (Lovable, Reta consumables), the Olymp competitor research, and the 4 customer orders / 12 transactions / stock-moves created today.

> [!success] Analytics docs rebuilt from real figures (2026-06-01)
> **[[Mission & Policies]]**, **[[Value Architecture — Driver Tree]]** (+ its interactive HTML) and **[[KPI Dashboard]]** have been **rebuilt** with the reconciled actuals: revenue **RM12,950**, gross profit **RM8,563** (66%), inventory-at-cost **RM1,437**, resellers **97% of revenue** (Muz 93%), TikTok/Threads **RM0**, cash **commingled — pending founder↔company**. The old fabricated figures (cash 7,400, rev 5,200, net-worth 12,289, ROAS 3.6) are gone.

---

## Part D — Founder ↔ Company (after the above)

### Cash-flow reconstruction (how much cash *should* be in hand)

Founder-confirmed model: **the only money ever poured in was the first 2 batches** (founder-funded). Selling that stock funded the 3rd batch (Reta 30) and everything since — the business has been **self-funding from margin** since the first batch sold.

**Capital in (founder, one-time):**

| Source | RM |
| --- | ---: |
| Batch 1 — Reta 10 vials (US$336 @ ~4.5) | 1,512 |
| Batch 2 — TCI group order (60 vials) | 2,112 |
| **Total capital in** | **3,624** |

**Cash flow since (with all real costs, founder-supplied 2026-06-01):**

| | RM |
| --- | ---: |
| **+ Revenue collected** | **12,950** |
| − Batch 3 — Reta 30 peptides + consumables | 4,285 |
| − Janoshik COA testing (batch 3): 3.75 USDC + 50.14 USD | 243 |
| − Lovable website (Jan $25 + RM61.10 + Feb–May $5×4) | 264 |
| − Domain (RM124.04, 2-yr, renews 28 Jan 2028) | 124 |
| − Shipping/fulfilment (~12 × RM15 — *estimate, confirm count*) | 180 |
| **= Cash generated (capital not yet returned)** | **≈ 7,855** |

> [!success] The real number: **≈ RM7,855 cash generated** + **RM1,437 inventory** = **RM9,292 business value** (on RM3,624 in → **2.56×**)
> Splitting it the way you framed it: **your RM3,624 capital — already paid back to you ✅** · **retained profit = RM4,230** *(not RM4,935 — the missing ~RM705 is exactly the Janoshik/Lovable/domain/shipping costs that weren't in the rough estimate).*

> [!warning] Founder ↔ company — the actual answer
> - **Company owes founder: RM0 extra.** Every cost above was paid from the same (personal) account that holds the revenue, and your RM3,624 capital is already returned. Nothing outstanding to you.
> - **Founder owes company: whatever you've drawn from the RM4,230 for emergencies.** That retained profit is *business money* — meant to fund the next restock. To the extent it's been spent personally, it's a loan from the company to you.
> - **So "actual business money" = RM4,230 cash (physically there, or owed back by you) + RM1,437 inventory = RM5,667.**
>
> **One number to close it:** how much of the RM4,230 have you taken for personal emergencies? `business cash still in the account = 4,230 − that`. I'll book the rest as an `owner-draw` (founder loan) so the books are clean.

### Monthly cost of the business (now known) — strikingly low

| Cost | RM/month | Type |
| --- | ---: | --- |
| Lovable (website) | ~22.50 | fixed (current $5/mo plan) |
| Domain (amortised) | ~5.17 | fixed |
| **Fixed total** | **≈ RM28/mo** | |
| Shipping | RM15 × orders | variable |
| Janoshik COA | ~RM243 per new batch tested | variable |
| *Cursor / phone* | *not given* | *add if real* |

**The business runs on ≈ RM28/month of fixed cost.** That's the real edge — it's almost pure margin; the only meaningful costs are per-batch (stock + COA) and per-order (shipping).

---

## What I need from you — checklist (v3)

- [x] Physical counts · [x] W=2 · [x] first batch = 10-box Reta · [x] R&D fixed · [x] Reta RM350→400
- [x] **Money in = RM12,950** (Muz 12,030 settled + Kio 370 + Haikhal 150 + Najiha 400) · [x] no receivables
- [ ] **The 7 GHK-Cu** (and ~4 Reta, 1 BPC, 1 TB500, 1 CJC) not in any sale — personal use, or free samples? (Splits owner-draw vs marketing.)
- [ ] **Muz exact Reta count** (if you know it) — to nail the ~4 Reta personal gap.
- [ ] **Company-paid-by-founder list**: item · RM · date (for the founder ↔ company balance).
- [x] **Phantom records deleted** (SKUs, cost cards, fake order/txn/ful, fake lead/campaign/content/ad, fake month-close) — vault now holds only real data.
- [x] **Analytics docs rebuilt** with real figures (Mission, Driver Tree, KPI Dashboard).

Give me these and I produce v4: true revenue, real COGS & profit, the corrected net-worth figure, and the net founder ↔ company balance booked to a loan account.

---

## Open items carried from existing notes
- **Reta USDT overpay (~RM1,400):** USD order line ($629 ≈ RM2,526) vs USDT leg paid (RM3,922.55) don't tie — confirm what the extra covered before treating RM4,001 as final landed cost. (from [[PO-37066]] / [[Batch P&L — Reta 60mg]])
- **GHK COGS booked against Reta batch:** the 2 GHK-Cu sales sit inside the Reta batch P&L — book GHK's own COGS separately for clean per-SKU margin.
- **CJC-1295 DAC vs no-DAC:** confirm which was shipped (price/retail depends on it). (from [[PO-20260120-001]])

## Related
- [[Capital — Playbook]] · [[SOP — Bookkeeping & Reconciliation]] · [[SOP — Monthly Close]]
- [[Mission & Policies]] (net-worth snapshot updates once this closes) · [[Value Architecture — Driver Tree]]

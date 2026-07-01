---
title: "Pricing Model"
type: policy
date: 2026-06-01
tags: [indexa, distribution, pricing]
---

# 💵 Pricing Model — Two Tiers

Indexa sells at **two price levels**. Every product has both. Never quote the wrong one to the wrong buyer.

| Tier | Who pays it | Level | Notes |
| --- | --- | --- | --- |
| **Public** | End customers buying direct (storefront / WhatsApp) | Higher | Our true retail. |
| **Dropshipper** | Resellers who re-sell to *their own* customers | Lower (≈ wholesale) | They add their own commission/markup on top. |

> [!important] Read this before trusting any old price
> The prices captured historically in this vault — **Reta 60mg RM400, GHK-Cu RM100, Wolverine Blend RM350** — are **dropshipper prices**, not public. Treat any "price I sent in the past" as dropship unless labelled otherwise. Per-SKU figures now carry both as `price_dropship` and `price_public` in [[Product Costing.base|Product Costing]].

## Retatrutide price ladder (draft)

| Dose | Public | Dropship | Landed (RM, @4.0) |
| --- | --- | --- | --- |
| R10 (10mg) | RM200 | _TBD_ | ~RM40 |
| **R20 (20mg)** | **RM400** ✅ | **RM200** ✅ | ~RM58 |
| R30 (30mg) | RM600 | _TBD_ | ~RM72 |
| R60 (60mg) | **RM1,000** | **RM400** | ~RM115 |

Rule of thumb (founder-confirmed): **public ≈ RM20/mg** off the 10mg base (10mg = RM200, 20mg = RM400), tapering at high dose (60mg = RM1,000, not 1,200). **Dropship ≈ half of public.**

**Volume math:** ~10 vials/month across the ladder ≈ **RM3,000–4,000 profit/month** average.

## Where we sit vs competitor (public-to-public)

| | Indexa public | Olymp public |
| --- | --- | --- |
| Reta 60mg | RM1,000 | RM1,300 |

Still ~23% below Olymp on public price — headroom remains, backed by our COA/Verify trust edge. See [[Olymp Peptides]].

## Rules
1. **Two prices per SKU, always** — keep `price_public` and `price_dropship` current in costing.
2. **Public on the storefront**, dropship only to vetted resellers.
3. **Don't undercut your own dropshippers' public margin** — set public high enough that a dropshipper buying at dropship price can still mark up and sell.
4. Dropship R10/R20/R30 still **to define** (only R60 dropship = RM400 is known).

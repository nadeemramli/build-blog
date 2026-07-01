---
title: "Supplier Sourcing Policy"
type: policy
date: 2026-06-01
tags: [indexa, operation, sourcing]
---

# 🧭 Supplier Sourcing Policy

The rule for **where to buy each product**. Follow it in order — it keeps cost and quality predictable.

## The waterfall

```
1. Retatrutide?  ───────────────► BFF        (always, any dose)
2. Available at TCI?  ──────────► TCI         (default for everything else)
3. Not at TCI?  ───────────────► Uther        (fallback only)
```

1. **Retatrutide → [[SUP-BFF|BFF]]** for every dose. BFF is the GLP-1 specialist (unnamed T/S/R/C list); R60 60mg = $287/box.
2. **Everything else → [[SUP-TCI|TCI]] first.** If TCI carries the product + dose, buy it there. TCI also stocks **KPV 10mg = $70** (not on the printed list).
3. **Only if TCI doesn't have it → [[SUP-UTHER|Uther]].** Uther has the widest catalog (rare doses, blends, bioregulators, tablets, GMP) — use it to fill gaps TCI can't.

## Price-tier note
- **TCI** prices have two tiers: **<10 kits** and **≥10 kits** (cheaper). Hit ≥10 kits where demand justifies it.
- All supplier prices are **per box of 10 vials**, in **USD**. Convert to RM at the live rate on purchase day and log the RM in the PO.

## Exceptions to flag (don't auto-decide)
When a product is at **both** TCI and Uther and **Uther is cheaper** (e.g. Thymosin Alpha-1: TCI $170 vs Uther $145; TB500 10mg: TCI $160 vs Uther $120), the policy says **TCI first** — but surface the price gap to Nadeem before ordering so he can choose cost vs. consolidation.

## Price lists (reference)
- [[BFF Price List]] · [[TCI Price List]] · [[Uther Price List]]

---
title: Shared Operating Budget
description: Portfolio-level budget for shared infrastructure, builder tooling, and non-project-specific operating spend.
created: 2026-07-08
updated: 2026-07-21
status: active-partially-reconciled
scope: shared-operating-costs
tags: [real-world, shared-ops, budget, tooling]
---

# Shared Operating Budget

This is the portfolio budget for recurring tools and infrastructure used across projects. Product-specific costs remain in the owning project ledger.

## Current forward run-rate

- Shared builder/platform subscriptions: **USD252/month** — Claude 200 + Codex 20 + Linear 12 + Supabase 20.
- Shared infrastructure: **EUR26.49/month** — Hetzner.
- INDEXA-specific Lovable: **USD5/month**, tracked outside shared overhead.
- Total founder-paid software view, if Lovable is included: **USD257/month + EUR26.49/month**.
- No MYR total is calculated until actual card FX or a deliberate planning FX rate is chosen.

| Item | Amount | Billing anchor | Beneficiary/allocation | Evidence and treatment |
| --- | ---: | --- | --- | --- |
| Claude Max 20x | USD200/month | 7th | Shared builder workflow | Receipt-supported plan rate; July cash charge was USD41.16 after credits/account balance |
| Codex | USD20/month | Unknown | Shared builder workflow | Owner-reported; card line and billing date pending |
| Linear Basic | USD12/month | 7th | Portfolio project management | Receipt-supported; July cash charge was RM50.68 |
| Supabase Pro | USD20/month | 17th | Current product platform; allocation review required | Pro activation email dated 2026-07-17; amount owner-reported, receipt/card line pending |
| Hetzner CPX22 `metrimap-mcp` | EUR26.49/month | Unknown | Shared infrastructure | Owner-reported; invoice/date pending |
| Vercel | USD0 | Monthly | Current app platform | Free; upgrade only when production limits or paying users justify it |
| Clerk | USD0 | Monthly | Auth | Free; upgrade only when an evidenced requirement exists |
| Resend | USD0 | Monthly | Email | Free; upgrade only when an evidenced requirement exists |

**Stack decision:** Cursor is excluded at RM0 by owner decision on 2026-07-21 and must not reappear in the active budget or development stack.

## July 2026 cash evidence

| Item | Actual July cash evidence | Forward budget treatment |
| --- | ---: | --- |
| Claude | USD41.16 charged 2026-07-07 | Keep USD200/month until plan change is evidenced |
| Linear | RM50.68 charged 2026-07-07 | Keep USD12/month native plan rate |
| Lovable | USD5 charged 2026-07-20 | INDEXA-specific; review while INDEXA is paused |
| Supabase | Charge not located | USD20 owner-reported; obtain card line |
| Codex | Charge not located | USD20 owner-reported; obtain card line |
| Hetzner | Charge/invoice not located | EUR26.49 owner-reported; obtain first invoice |

Source details: [2026-07 Billing Evidence](<../../../../operating-system/6. Records/Finance/2026-07 Billing Evidence.md>).

## Allocation policy

| Cost type | Default treatment | Decision rule |
| --- | --- | --- |
| Shared infrastructure | Portfolio ledger with project allocation view | Allocate by actual active use when a burdened project P&L is needed |
| Claude and Codex | Shared builder overhead | Keep out of product gross margin; include in fully burdened founder ROI |
| Linear | Shared operating overhead | Allocate only for a burdened view |
| Supabase | Product/platform cost pending use review | Retain paid tier only if current usage, production reliability or paid-customer path justifies it |
| Project-only website/domain costs | Owning project capital ledger | INDEXA Lovable/domain stay in INDEXA Capital |

## ROI control

Each paid tool must have:

1. a named active workflow or product dependency;
2. one observable output for the billing month;
3. a keep, downgrade or cancel review before the next charge if the output is absent.

Claude usage pressure should be translated into high-value deliverables, not activity for its own sake. Supabase and Hetzner remain justified only by a working product/infrastructure requirement and a credible route to operational or customer value.

## Next evidence

- Match Codex, Supabase and Hetzner to card/bank lines and record billing anchors.
- Decide whether Lovable remains necessary while INDEXA is paused.
- Assign Supabase to the product(s) actually consuming the paid tier.
- Choose an FX policy: actual card rate per transaction for closes; optionally a conservative planning rate for forecasts.
- Add monthly output/ROI evidence before each renewal review.

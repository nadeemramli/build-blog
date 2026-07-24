---
title: Pricing and Break Even Model
description: Canvasm/Metrimap pricing model for stack cost, break-even MRR, and monthly subscription targets.
created: 2026-07-08
updated: 2026-07-21
status: draft
tags: [canvasm, metrimap, pricing, economics, budget]
---

# Pricing And Break Even Model

This note answers the practical pricing question: if Canvasm/Metrimap runs on a proper paid SaaS stack, how much monthly revenue does the app need, and what monthly price makes sense?

Source references:

- [Shared Infrastructure Budget](<../../../../../../../9. Real World/Shared Infrastructure/Shared Infrastructure Budget.md>)
- [Shared Operating Budget](<../../../../../../../9. Real World/Shared Operating Costs/Shared Operating Budget.md>)
- [2026-07-08 - SaaS Pricing Benchmarks and Plan Sources](<../../../../../../../9. Real World/Shared Operating Costs/Sources/2026-07-08 - SaaS Pricing Benchmarks and Plan Sources.md>)

## Why We Break Costs Apart

There are three different questions:

| Question | Cost lens | Why it matters |
| --- | --- | --- |
| What does the app need to earn to cover production infrastructure? | App infra only | Sets minimum MRR and pricing floor. |
| What does the founder need to cover monthly while building? | App infra plus shared tooling | Sets runway pressure, but should not automatically become product COGS. |
| What price can Malaysia B2B customers accept? | Market benchmark | Prevents underpricing the app just because the early stack is cheap. |

## Stack Scenarios

Working FX assumptions for quick planning: 1 USD = 4.2511 MYR from the Lovable receipt; 1 EUR = 5.00 MYR as a scenario assumption until the Hetzner card statement is checked.

| Scenario | Monthly stack | Planning monthly cost | Treatment |
| --- | --- | --- | --- |
| Current lean infra | Hetzner 26.49 EUR + owner-reported Supabase 20 USD; Vercel, Clerk, and Resend free | About 217 MYR/month at the working FX assumptions | Supabase invoice/plan and necessity still require verification. |
| Paid production stack | Hetzner 26.49 EUR + Vercel Pro 20 USD + Supabase Pro 25 USD + Clerk Pro 25 USD + Resend Pro 20 USD | About 515 MYR/month | Pricing floor for a serious paid-stack assumption. |
| Paid production stack, Clerk still free | Hetzner + Vercel Pro + Supabase Pro + Resend Pro | About 409 MYR/month | Likely if we do not need Clerk Pro features and stay inside free allowance. |
| Fully burdened builder view | Paid production stack + Linear 12 USD + Claude 200 USD + Codex 20 USD | About 1,501 MYR/month before Cursor | Runway lens, not default app COGS. |

## Break-Even Paid Accounts

Use the paid production stack scenario of about 515 MYR/month as the app-level break-even target.

| Monthly price | MRR from 5 accounts | Accounts to cover 515 MYR | Accounts to cover 1,030 MYR | Accounts to cover 1,501 MYR |
| --- | --- | --- | --- | --- |
| 39 MYR | 195 MYR | 14 | 27 | 39 |
| 79 MYR | 395 MYR | 7 | 14 | 19 |
| 99 MYR | 495 MYR | 6 | 11 | 16 |
| 179 MYR | 895 MYR | 3 | 6 | 9 |
| 349 MYR | 1,745 MYR | 2 | 3 | 5 |
| 599 MYR | 2,995 MYR | 1 | 2 | 3 |

## Pricing Implication

If we upgrade the stack around 4-5 paid customers, the average account needs to be around 179 MYR/month or higher. A 39 MYR starter can exist later, but it should not be the main first monetization target because 4-5 customers at that price do not cover the paid production stack.

## Bouncer Benchmark

Bouncer is not a competitor, but it is useful Malaysia SaaS pricing evidence. The benchmark ladder from the owner screenshot is:

| Benchmark tier | Monthly price |
| --- | --- |
| Starter | 39 MYR |
| Growth | 179 MYR |
| Business | 349 MYR |
| Pro | 599 MYR |

This suggests Malaysia customers can accept 179-599 MYR/month when the product solves an operational problem. For Canvasm/Metrimap, the safer early move is to target the Growth/Business band rather than anchor on the 39 MYR starter band.

## Draft Pricing Ladder

| Tier | Monthly price | Role | Notes |
| --- | --- | --- | --- |
| Starter | 79-99 MYR | Solo builder / lightweight use | Useful later as self-serve acquisition. Do not rely on this tier to justify paid infrastructure at 4-5 customers. |
| Growth | 179 MYR | Core early paid plan | Best first pricing anchor. At 4-5 customers, this can cover the paid production stack. |
| Team / Business | 349 MYR | Team/workspace plan | Should include stronger collaboration, exports, integrations, or decision cadence features. |
| Pro | 599 MYR | Advanced operating system plan | Should include higher-touch workflows, priority support, templates, or multi-team operating views. |

## Seat And Team Pricing Direction

The recommended first implementation is workspace-level plans with included seats, plus an extra-seat add-on field in the entitlement model.

| Plan | Monthly price | Included seats | Extra seat posture | Why |
| --- | --- | --- | --- | --- |
| Starter | 79-99 MYR | 1 | No extra seats; upgrade to Growth | Keeps solo tier simple. |
| Growth | 179 MYR | 3 | Optional later at about 29-39 MYR/seat/month | Best early founder/customer plan. |
| Team / Business | 349 MYR | 8 | Optional later at about 29-39 MYR/seat/month | Clear team plan without forcing per-seat sales conversation. |
| Pro | 599 MYR | 15 | Optional later at about 29-39 MYR/seat/month | Captures advanced teams without custom pricing yet. |

Avoid pure per-seat pricing as the first public model. It makes billing, support, and customer buying decisions more complex before we know which role inside the customer account actually drives usage. Use included-seat tiers now; implement the data model so per-seat billing can be activated later.

Implementation note: Stripe supports subscription item quantities for per-seat licensing, but the first app pass can store `seatLimit`, `includedSeats`, and `extraSeatPrice` without enabling automatic add-on billing yet. Source: [2026-07-08 - SaaS Pricing Benchmarks and Plan Sources](<../../../../../../../9. Real World/Shared Operating Costs/Sources/2026-07-08 - SaaS Pricing Benchmarks and Plan Sources.md>).

## Upgrade Rule

Upgrade Vercel, Supabase, Clerk, or Resend when either:

- limits or production risk require it, or
- 4-5 paid accounts produce at least 700-900 MYR MRR, meaning the stack upgrade is already funded.

Supabase is now an owner-reported paid exception at 20 USD/month. Verify which limit or production requirement caused the upgrade; if no current requirement or paid-customer path supports it, review downgrade rather than manufacturing usage. If the first 4-5 accounts are below 99 MYR/month, keep the rest of the stack lean unless a product limit forces an upgrade.

## Next Inputs Needed

- Confirm whether Clerk Pro features are needed in production or whether free Clerk is enough.
- Confirm actual Supabase paid-plan requirement and whether Supabase Auth could replace Clerk if auth costs become material.
- Confirm payment processor fee assumptions.
- Confirm support load per customer, especially if charging 349-599 MYR/month.
- Decide whether the first launch offer should be a single 179 MYR founder plan or the full tier ladder.

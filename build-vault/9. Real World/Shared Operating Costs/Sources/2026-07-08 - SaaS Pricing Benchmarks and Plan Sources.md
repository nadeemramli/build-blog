---
title: 2026-07-08 - SaaS Pricing Benchmarks and Plan Sources
description: External and owner-provided pricing references for Canvasm/Metrimap stack and benchmark pricing.
created: 2026-07-08
updated: 2026-07-08
source_type: external-pricing-and-owner-screenshot
tags: [real-world, budget, source, pricing, canvasm]
---

# 2026-07-08 - SaaS Pricing Benchmarks And Plan Sources

This is a source note for the Canvasm/Metrimap pricing and break-even model. It captures the reference prices used on 2026-07-08. Re-check official pages before committing to a paid plan.

## Benchmark SaaS Pricing

| Source | Captured pricing | Evidence | Notes |
| --- | --- | --- | --- |
| Bouncer pricing | Starter 39 MYR/month; Growth 179 MYR/month; Business 349 MYR/month; Pro 599 MYR/month | Owner screenshot and https://bouncer.my/pricing | Not a direct competitor; useful as Malaysia SaaS willingness-to-pay benchmark. |

## Stack Plan References

| Service | Free/current planning value | Paid planning value | Source | Notes |
| --- | --- | --- | --- | --- |
| Vercel | 0 USD/month | Pro 20 USD/month | https://vercel.com/pricing | Official pricing page captured Pro at 20 USD/month with included usage credit. |
| Supabase | 0 USD/month | Pro planning assumption: 25 USD/month | https://supabase.com/pricing | Verify from official page before upgrade; page is dynamic in the browser capture. |
| Clerk | 0 USD/month while inside free allowance | Pro 25 USD/month if billed monthly, or 20 USD/month billed annually | https://clerk.com/pricing | Clerk prices by monthly retained users. Free allowance shown as first 50,000 monthly retained users and 100 monthly retained orgs. |
| Resend | 0 USD/month for free plan | Pro 20 USD/month | https://resend.com/pricing | Free plan captured at 3,000 emails/month; Pro captured at 50,000 emails/month. |
| Hetzner CPX22 `metrimap-mcp` | Not free | 26.49 EUR/month | [2026-07-08 - Owner Cost Inputs](<./2026-07-08 - Owner Cost Inputs.md>) | Owner screenshot. Use actual card/bank exchange rate for cash reconciliation. |

## Billing Implementation References

| Source | Captured point | Notes |
| --- | --- | --- |
| Stripe subscription quantities | Stripe supports subscription item quantities for per-seat licensing, and can also combine multiple products/prices into one invoice. | https://docs.stripe.com/billing/subscriptions/quantities |

## Working FX

| Currency | Working treatment | Source | Notes |
| --- | --- | --- | --- |
| USD to MYR | 1 USD = 4.2511 MYR | [2026-07-08 - Owner Cost Inputs](<./2026-07-08 - Owner Cost Inputs.md>) | Based on actual Lovable receipt screenshot. Use only as planning FX unless the card statement confirms it for other transactions. |
| EUR to MYR | Scenario assumption: 1 EUR = 5.00 MYR | Planning assumption | Replace with actual Hetzner card/bank statement rate during reconciliation. |

## Source Handling

- Bouncer is a benchmark for price tolerance, not a competitor feature model.
- Vercel, Supabase, Clerk, and Resend pricing can change; re-check before upgrading.
- FX assumptions are for planning only and should not be treated as reconciled accounting.

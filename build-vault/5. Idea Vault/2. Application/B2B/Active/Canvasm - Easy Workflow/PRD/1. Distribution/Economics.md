---
draft: true
title: "Economics"
date: "2025-08-11"
tags: 
---

# Economics

This note is the Canvasm/Metrimap budget view. It should answer what the app costs to run, market, and sell without duplicating shared infrastructure expenses.

## Budgeting Rule

Canvasm has two cost layers:

- **Canvasm-specific costs** belong in this note or future Canvasm budget docs.
- **Reusable infrastructure costs** belong in [Shared Infrastructure Budget](<../../../../../../../9. Real World/Shared Infrastructure/Shared Infrastructure Budget.md>), then Canvasm can reference an allocation.

Do not record reusable infrastructure as a Canvasm-only expense if another project can realistically reuse it.

## Cost Questions

| Question | Budget layer | Source of truth |
| --- | --- | --- |
| How much does it cost to maintain the app? | Canvasm + shared allocation | This note and [Shared Infrastructure Budget](<../../../../../../../9. Real World/Shared Infrastructure/Shared Infrastructure Budget.md>) |
| How much does it cost to market the app? | Canvasm-specific | Canvasm GTM / distribution notes |
| How much does it cost others to use the app? | Pricing and gross margin | Pricing model, usage assumptions, support costs |
| What is our margin? | Project economics | Revenue model minus direct and allocated costs |

## Canvasm-Specific Cost Buckets

| Bucket | Examples | Amount | Notes |
| --- | --- | --- | --- |
| Acquisition | paid ads, sponsorships, launch campaigns | TODO | Keep separate from shared infra. |
| Product-specific SaaS | tools used only for Canvasm | TODO | Confirm invoices before filling. |
| Domain/brand assets | Canvasm-only domains, brand assets | TODO | Shared domains/tools go to shared infra. |
| Support/success | customer support tooling or labor | TODO | Separate founder time from cash spend. |

## Shared Infrastructure Allocation

Use [Shared Infrastructure Budget](<../../../../../../../9. Real World/Shared Infrastructure/Shared Infrastructure Budget.md>) for the actual shared ledger. Canvasm can carry a planning allocation here once we choose an allocation rule.

| Shared item | Allocation method | Canvasm allocation | Notes |
| --- | --- | --- | --- |
| Hetzner CPX22 `metrimap-mcp` | Conservative planning allocation until another project uses it | Up to 26.49 EUR/month | Shared workers and serverless-hostile workloads. Actual ledger is in [Shared Infrastructure Budget](<../../../../../../../9. Real World/Shared Infrastructure/Shared Infrastructure Budget.md>). |
| Redis / queues | TODO | TODO | Shared job infrastructure if reused. |
| Worker services | TODO | TODO | Compute, notifications, ingest, rendering. |
| Supabase | Free until traction/limits | 0 USD/month | Revisit paid plan around 4-5 paid users or when limits require it. |
| Vercel | Free until traction/limits | 0 USD/month | Revisit paid plan around 4-5 paid users or when limits require it. |
| Clerk | Free until feature/usage limits | 0 USD/month | Used for sign-in and user management. Include Clerk Pro in the paid-stack scenario, but keep free while production needs allow it. |
| Resend | Free until traction/limits | 0 USD/month | Revisit paid plan around 4-5 paid users or when email volume/deliverability requires it. |

## Shared Builder Tooling Note

Claude, Codex, Linear, and Cursor are shared builder/operating overhead, not Canvasm product COGS by default. Track them in [Shared Operating Budget](<../../../../../../../9. Real World/Shared Operating Costs/Shared Operating Budget.md>) unless building a fully burdened profitability view.

## Pricing / Monetization References

- Pricing reference to analyze: https://count.co/pricing
- [Pricing and Break Even Model](<Pricing and Break Even Model.md>)
- Benchmark to use for Malaysia SaaS willingness-to-pay: Bouncer pricing ladder, captured in [2026-07-08 - SaaS Pricing Benchmarks and Plan Sources](<../../../../../../../9. Real World/Shared Operating Costs/Sources/2026-07-08 - SaaS Pricing Benchmarks and Plan Sources.md>).
- Current pricing direction: do not rely on a 39 MYR tier to fund the paid stack. Target 179 MYR/month average revenue per account or higher before upgrading the full paid stack.

## Next Inputs Needed

- Confirm current paid services and invoices.
- Decide allocation rule for shared infrastructure.
- Confirm current Cursor subscription amount if we want total builder-tooling burn.
- Confirm whether the first launch offer should be a single 179 MYR founder plan or a full tier ladder.

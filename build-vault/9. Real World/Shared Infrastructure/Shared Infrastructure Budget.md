---
title: Shared Infrastructure Budget
description: Shared operating budget for reusable infrastructure used across active projects.
created: 2026-07-08
updated: 2026-07-08
status: active
scope: shared-infrastructure
tags: [real-world, shared-infra, budget, capital]
---

# Shared Infrastructure Budget

This is the canonical budget home for infrastructure that can serve more than one project. Canvasm/Metrimap can reference or receive an allocation from this budget, but reusable infrastructure should not be recorded as a Canvasm-only expense.

## Decision

Track shared infrastructure once, at the portfolio/platform layer.

- Actual shared infrastructure spend lives here.
- Project notes can show an allocation view, but should not duplicate the real expense.
- If a cost becomes dedicated to a single project, move it into that project's budget view or mark it as fully allocated to that project.

## Why This Exists

Canvasm's current infrastructure plan includes shared workers and services that can support more than the Canvasm app: MCP/API hosting, background jobs, render/export workloads, notification workers, CRDT collaboration, connected-account sync, ingest workers, and webhook receivers. Source: [Project Memory - Metrimap](<Project Memory - Metrimap.md>) and [Shared Infra (Hetzner VPS)](<7. Shared Infra (Hetzner VPS).md>).

## Classification Rule

| Cost type | Where it belongs | Rule |
| --- | --- | --- |
| Dedicated app cost | Project budget | Only one project benefits from it. |
| Shared infrastructure | This budget | Two or more projects can reuse it now or realistically later. |
| Experimental/pilot cost | This budget or project budget | Put it where the learning primarily compounds. |
| Personal/dev tool | Shared infrastructure if broadly used | Track once, then allocate if needed. |
| Customer acquisition spend | Project budget | CAC and GTM spend belong to the project using it. |

## Current Shared Infrastructure Candidates

Amounts below are filled only when confirmed from invoices, dashboards, bank records, or user-provided figures. Current owner-provided source snapshot: [2026-07-08 - Owner Cost Inputs](<../Shared Operating Costs/Sources/2026-07-08 - Owner Cost Inputs.md>).

| Item | Role | Primary current beneficiary | Shareable? | Billing cycle | Amount | Status | Source |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Hetzner CPX22 `metrimap-mcp` | Always-on Docker host for serverless-hostile workloads | Canvasm/Metrimap | Yes | Monthly | 26.49 EUR/month | active | [2026-07-08 - Owner Cost Inputs](<../Shared Operating Costs/Sources/2026-07-08 - Owner Cost Inputs.md>) and [Shared Infra (Hetzner VPS)](<7. Shared Infra (Hetzner VPS).md>) |
| Redis / job queue | Queues, rate limits, background jobs | Canvasm/Metrimap | Yes | TODO | TODO | planned | [Project Memory - Metrimap](<Project Memory - Metrimap.md>) |
| Worker services | Compute, RCA/drift, notifications, exports, sync, ingest | Canvasm/Metrimap | Yes | TODO | TODO | planned | [Project Memory - Metrimap](<Project Memory - Metrimap.md>) |
| Vercel project | Static SPA hosting | Canvasm/Metrimap | Maybe | Monthly | 0 USD/month | free for now | [2026-07-08 - Owner Cost Inputs](<../Shared Operating Costs/Sources/2026-07-08 - Owner Cost Inputs.md>) and [Project Memory - Metrimap](<Project Memory - Metrimap.md>) |
| Supabase | Managed DB/auth/edge | Canvasm/Metrimap | Maybe | Monthly | 0 USD/month | free for now | [2026-07-08 - Owner Cost Inputs](<../Shared Operating Costs/Sources/2026-07-08 - Owner Cost Inputs.md>) and [Project Memory - Metrimap](<Project Memory - Metrimap.md>) |
| Clerk | Sign-in and user management | Canvasm/Metrimap | Maybe | Monthly | 0 USD/month | free for now | [2026-07-08 - Owner Cost Inputs](<../Shared Operating Costs/Sources/2026-07-08 - Owner Cost Inputs.md>) and [2026-07-08 - SaaS Pricing Benchmarks and Plan Sources](<../Shared Operating Costs/Sources/2026-07-08 - SaaS Pricing Benchmarks and Plan Sources.md>) |
| Hosted PostHog | Analytics | Canvasm/Metrimap | Maybe | TODO | TODO | planned/hosted | [Shared Infra (Hetzner VPS)](<7. Shared Infra (Hetzner VPS).md>) |
| Resend | Notification/digest email | Canvasm/Metrimap | Maybe | Monthly | 0 USD/month | free for now | [2026-07-08 - Owner Cost Inputs](<../Shared Operating Costs/Sources/2026-07-08 - Owner Cost Inputs.md>) and [Project Memory - Metrimap](<Project Memory - Metrimap.md>) |

## Upgrade Trigger

Vercel, Supabase, Clerk, and Resend stay on free plans until traction, features, or limits justify an upgrade. The current planning trigger is around 4-5 paid users, unless technical limits force an earlier move. Source: [2026-07-08 - Owner Cost Inputs](<../Shared Operating Costs/Sources/2026-07-08 - Owner Cost Inputs.md>) and [Pricing and Break Even Model](<Pricing and Break Even Model.md>).

## Canvasm Allocation View

Canvasm should carry a budget view for planning, but not the actual shared-infra ledger.

| Layer | Treatment for Canvasm | Notes |
| --- | --- | --- |
| App-specific spend | Canvasm budget | CAC, marketing, domain/product-specific subscriptions, and costs that only serve Canvasm. |
| Shared infra spend | Allocation only | Show estimated burden for runway/pricing, but source of truth remains this shared budget. For now, Hetzner can be treated as a conservative Canvasm planning burden while actual ledger remains shared. |
| One-off setup | Decide case by case | If setup creates reusable platform capability, keep here. If it is Canvasm-only, classify under Canvasm. |

## Review Cadence

- Weekly: capture new invoices or dashboard spend and classify them.
- Monthly: update project allocation views and runway assumptions.
- Before scaling: confirm which costs are fixed, variable, project-specific, or shared.

## Open Questions

- Which services already have paid plans active?
- Which costs are paid personally vs. from a business account?
- Should shared infra use equal allocation, usage allocation, or primary-beneficiary allocation?
- Should this folder later get transaction/expense templates similar to INDEXA Capital?

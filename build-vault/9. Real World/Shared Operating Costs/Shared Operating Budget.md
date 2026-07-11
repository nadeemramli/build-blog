---
title: Shared Operating Budget
description: Portfolio-level budget for shared infrastructure, builder tooling, and non-project-specific operating spend.
created: 2026-07-08
updated: 2026-07-08
status: active
scope: shared-operating-costs
tags: [real-world, shared-ops, budget, tooling]
---

# Shared Operating Budget

This is the portfolio-level budget for recurring tools and operating costs that help multiple projects. It is separate from product-specific ledgers such as [INDEXA Capital](<../INDEXA/03 - Capital/>) and the technical [Shared Infrastructure Budget](<../Shared Infrastructure/Shared Infrastructure Budget.md>).

Primary source for the current snapshot: [2026-07-08 - Owner Cost Inputs](<./Sources/2026-07-08 - Owner Cost Inputs.md>).

## Current Recurring Costs

Known recurring spend currently confirmed by the owner:

- Shared builder tooling: 232 USD/month before Cursor.
- Shared infrastructure: 26.49 EUR/month for Hetzner.
- INDEXA-specific Lovable/domain spend is tracked in [INDEXA Software and Domain Budget](<../INDEXA/03 - Capital/Software and Domain Budget.md>), not treated as shared overhead unless we intentionally build a total founder-burn view.

| Item | Category | Beneficiary | Amount | Billing cycle | Status | Treatment |
| --- | --- | --- | --- | --- | --- | --- |
| Hetzner CPX22 `metrimap-mcp` | Shared infrastructure | Canvasm/Metrimap now, reusable later | 26.49 EUR | Monthly | Active | Keep actual ledger in [Shared Infrastructure Budget](<../Shared Infrastructure/Shared Infrastructure Budget.md>). Allocate to Canvasm only for planning. |
| Linear | Shared operating tool | Project management across builds | 12 USD | Monthly | Active | Shared builder tooling. |
| Claude | Shared AI development tool | Builder workflow across projects | 200 USD | Monthly | Active | Shared builder tooling, not Canvasm COGS. |
| Codex | Shared AI development tool | Builder workflow across projects | 20 USD | Monthly | Active | Shared builder tooling, not Canvasm COGS. |
| Cursor | Shared AI/editor tooling | Builder workflow across projects | TODO | TODO | To confirm | Track current recurring amount; historical backfill is optional. |
| Vercel | App platform | Canvasm/Metrimap now, maybe shared later | 0 USD | Monthly | Free | Upgrade only when paid-user traction or limits justify it. |
| Supabase | App platform | Canvasm/Metrimap now, maybe shared later | 0 USD | Monthly | Free | Upgrade only when paid-user traction or limits justify it. |
| Clerk | Auth and user management | Canvasm/Metrimap now, maybe shared later | 0 USD | Monthly | Free | Upgrade only when production features, retained-user limits, or org limits require it. |
| Resend | App platform | Canvasm/Metrimap now, maybe shared later | 0 USD | Monthly | Free | Upgrade only when paid-user traction or limits justify it. |

## Upgrade Triggers

| Service | Current treatment | Upgrade trigger |
| --- | --- | --- |
| Vercel | Stay free | Revisit around 4-5 paid users, or earlier if platform limits block the product. |
| Supabase | Stay free | Revisit around 4-5 paid users, or earlier if database/auth/storage limits block the product. |
| Clerk | Stay free | Revisit when production auth features, retained-user limits, or org limits require it. Include Pro in the paid-stack scenario even if current usage remains free. |
| Resend | Stay free | Revisit around 4-5 paid users, or earlier if email volume, deliverability, or sender-domain needs require it. |
| Hetzner | Paid now | Keep while it hosts reusable workers/MCP/API workloads that serverless platforms do not handle well. |

## Allocation Policy

| Cost type | Default treatment | Notes |
| --- | --- | --- |
| Shared infrastructure | Portfolio ledger, project allocation view | For Canvasm runway, use a conservative planning allocation for Hetzner until another project actively uses it. |
| Claude, Codex, Cursor | Shared builder overhead | Do not include in Canvasm gross margin unless building a fully burdened profitability view. |
| Linear | Shared operating overhead | Allocate by active project count only if we need a project-level burdened view. |
| INDEXA website/domain costs | INDEXA Capital | Keep product-specific website/domain spend in INDEXA records. |

## Cursor Tracking Decision

Cursor history is useful only if the goal is full cashflow reconstruction, reimbursement, tax/accounting prep, or comparing the AI/tool stack ROI. For immediate Canvasm budgeting, capture the current recurring Cursor amount and start tracking it going forward; backfilling every historical month is optional.

## Next Inputs Needed

- Confirm current Cursor plan amount and billing cadence.
- Confirm whether Lovable's current INDEXA hosting charge is still 5 USD/month and whether the latest charge has already cleared.
- Decide whether to maintain a total founder-burn view that includes shared tools plus project-specific spend.
- Decide an FX policy: actual card statement rate per transaction, monthly average, or no conversion until reconciliation.

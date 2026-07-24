---
title: Agent Prompts - Pricing Tier Implementation
description: Agent-ready prompts for implementing Canvasm/Metrimap pricing tiers in the app and marketing website.
created: 2026-07-08
updated: 2026-07-08
status: ready-to-send
tags: [canvasm, metrimap, pricing, agent-prompt, billing]
---

# Agent Prompts - Pricing Tier Implementation

Use this note when handing pricing work to the app agent and the marketing agent.

## Shared Product Context

- Canvasm is the brand, company, domain, and Linear organization.
- Metrimap is the product experience inside Canvasm.
- Use "Metrimap" when talking about the app/product workflow.
- Use "Canvasm" when talking about the company, public website, domain, deployment, or organization.
- App URL: `https://use.canvasm.app`.
- Repo name: `metric-mapping`.
- Implementation source of truth: WSL repo at `/home/nadeemramli/workspace/github.com/nadeemramli/metric-mapping`.
- Product learning source of truth: this Obsidian folder.

Metrimap is not generic workflow software and should not be described as a normal diagramming app, dashboard, project tracker, or data pipeline tool.

The product position:

> Canvasm/Metrimap is the operating workspace for metric trees, business architecture, evidence, experiments, and agent-ready growth work.

The core marketing line:

> Operationalize your driver tree. Connect metrics, evidence, experiments, and work in one living map.

Important product boundary:

- Metrimap maps and governs the business context around the customer's data stack.
- It should not become the customer's tracking tool, warehouse, CDP, reverse ETL tool, workflow engine, or automation runner.
- Customers can use GA4, PostHog, Segment, RudderStack, Amplitude, Mixpanel, Snowflake, BigQuery, Supabase, n8n, Zapier, Make, HubSpot, Intercom, Linear, and their own agents/workflows outside Canvasm.
- Metrimap should show what those systems need to prove, which metrics and relationships matter, which evidence supports them, and what work/actions are connected to the operating model.

## Current App Context

Stack:

- Vite React SPA.
- Clerk for auth and organization/workspace identity.
- Supabase/Postgres with RLS.
- React Flow for the canvas.
- EditorJS for evidence notebook content.
- Tailwind, Radix/shadcn-style components, Lucide icons, Recharts.

Current object model:

```text
Workspace = Clerk Organization
  Space / Folder
    Canvas
      Node / Metric Card
```

Important app model details:

- Workspace is the billing and collaboration boundary.
- Space is a lightweight folder layer.
- Canvas is the actual metric tree/business architecture workspace.
- Metric Catalog is promotion-based, not automatic.
- Evidence should become notebook-like and traceable to nodes, relationships, charts, snapshots, experiments, and decisions.
- Strategy board connects actions/hypotheses to the metric map.
- Guest permission roles already exist: Viewer, Commenter, Editor, Admin.
- Org members currently have full edit access; do not invent a complex internal org-role system inside this pricing work.
- Programmatic building via MCP/API is planned as a higher-value capability, but it must stay RLS-scoped and must not bypass workspace permissions.

## Pricing Decision

Use workspace-level plans with included seats. Do not implement pure per-seat-only pricing for the first public version.

| Tier | Monthly price | Included seats | Role |
| --- | ---: | ---: | --- |
| Starter | RM79-99 | 1 | Solo builder / lightweight use |
| Growth | RM179 | 3 | Core early paid plan |
| Team / Business | RM349 | 8 | Team workspace plan |
| Pro | RM599 | 15 | Advanced operating system plan |

Starter can display as RM99 by default unless the launch offer deliberately uses RM79. Keep this price in config so it is easy to change.

Extra seats can be represented in the entitlement model as a future add-on, roughly RM29-39 per seat per month, but automatic per-seat billing is not required in the first implementation.

Related source: [Pricing and Break Even Model](<Pricing and Break Even Model.md>).

## Shared Rules For Both Agents

- Make Growth the primary early paid plan.
- Do not anchor the experience around the lowest price.
- Make Team / Business feel like the natural plan for teams that review metrics together.
- Keep all plan data in one config object/module per codebase.
- Do not hardcode plan names, prices, or seat limits across scattered components.
- Do not build a full production billing system unless the app or website already has the primitives.
- Do not promise API/MCP, native integrations, advanced exports, history, or priority support as live features unless the implementation already supports them.
- Use "planned", "talk to us", or a gated placeholder where the value proposition is real but the feature is not production-ready.
- Avoid locking existing users out. Existing workspaces should get a safe default, founder, trial, or permissive fallback until billing is fully live.

## Prompt 1 - App Agent

```text
You are the app implementation agent for Metrimap, the product experience under the Canvasm brand.

Read first:
- AGENTS.md in the repo.
- Project Memory - Metrimap.
- PRD/1. Distribution/Pricing and Break Even Model.md.
- PRD/1. Distribution/Agent Prompts - Pricing Tier Implementation.md.
- PRD/5. Current State (2026-07)/1. Object Model - Workspace, Space, Catalog.md.
- PRD/5. Current State (2026-07)/3. Permissions and Roles.md.
- PRD/4. Product/3. MCP and Programmatic Building.md if touching API/MCP-related entitlements.

Goal:
Implement pricing-tier awareness inside the app so Metrimap can support workspace-level subscription plans with included seats and feature entitlements.

Important product decision:
Do not build pure per-seat-only pricing as the first model. Implement workspace/org-level plans with included seat limits. The data model may support extra-seat pricing later, but automatic extra-seat billing is out of scope unless the current repo already has a clean billing abstraction.

Product context to preserve:
- Canvasm is the brand/company/domain.
- Metrimap is the product/app.
- Workspace = Clerk organization.
- Workspace is the billing boundary.
- Metrimap is a visual operating workspace for metric trees, evidence, experiments, and agent-ready growth work.
- Do not turn this work into generic SaaS billing UI or generic project-management copy.
- Do not create a broad internal org-role model. Guest permission roles already exist, while org members currently have full edit access.
- Existing workspaces must not be accidentally locked out by the pricing layer.

Pricing tiers to model:
- Starter: RM79-99/month, 1 included seat. Use RM99 as the default public display unless a launch offer chooses RM79.
- Growth: RM179/month, 3 included seats. This is the recommended early paid plan.
- Team / Business: RM349/month, 8 included seats.
- Pro: RM599/month, 15 included seats.

Default implementation shape:

1. Create a central typed plan configuration module.

Suggested fields:
- planId: starter | growth | team | pro
- displayName
- monthlyPriceMyr
- includedSeats
- extraSeatPriceMyr nullable
- isRecommended
- publicDescription
- limits:
  - canvases
  - spaces
  - collaborators/seats
  - exports
  - data/source connections
  - evidence notebooks
  - history/versions
  - API/MCP access
  - support tier
- features / entitlements:
  - collaboration
  - comments
  - evidenceNotebook
  - strategyBoard
  - metricCatalog
  - sharedTemplates
  - advancedExports
  - integrations
  - apiMcp
  - prioritySupport

Keep these values in one place. UI components should read from this config instead of duplicating plan literals.

2. Resolve the active workspace plan.

- Metrimap workspaces map to Clerk organizations.
- Add or reuse a plan resolver at the workspace/org level.
- If no billing table exists, add a safe placeholder resolver.
- The safe default should not block existing users. Use a founder/internal/trial fallback if that pattern exists; otherwise default to a permissive starter/growth-style fallback with clear TODOs.
- Keep RLS/security assumptions intact.
- Do not use Supabase service-role access for normal product reads/writes.

3. Add entitlement helpers that are testable without React.

Suggested helpers:
- canInviteSeat(workspacePlan, currentSeatCount)
- canCreateCanvas(workspacePlan, currentCanvasCount)
- canUseFeature(workspacePlan, featureKey)
- getPlanLimit(workspacePlan, limitKey)
- getUpgradeMessage(featureKey, currentPlan)
- getRecommendedUpgrade(currentPlan, featureKey)

At minimum, enforce or visibly gate:
- seat limit in the invite/member flow, and
- one feature entitlement such as API/MCP, advanced export, history/versioning, or advanced integrations.

4. Add app UI surfaces.

- Workspace/account settings: current plan, included seats, seat usage, key limits, and upgrade CTA.
- Invite flow: show seat usage and included seat limit. Block or warn when the workspace is over the included seat limit.
- Feature gates: show gentle upgrade prompts for gated features, not broken states.
- Pricing/plan selection surface: use an existing billing/settings route if one exists. If no billing flow exists, add a simple internal settings view rather than inventing full checkout.
- If Pro includes API/MCP but MCP is not production-ready, show it as "available on Pro / talk to us" or keep the gate internal until ready.

5. Billing scope.

- If Stripe or another billing system already exists, map plans to price IDs using environment variables or a config layer.
- If billing does not exist, do not invent a full checkout system.
- Add clean placeholders and TODOs for checkout integration.
- Store plan metadata in a way that future Stripe subscription quantities can support extra seats.
- Extra-seat add-on billing is out of scope for this pass.

6. Suggested entitlement split.

Starter:
- 1 included seat.
- Solo map-building.
- Core canvases/spaces.
- Basic evidence notes.
- Basic export if export exists.
- No API/MCP.
- No advanced collaboration beyond what already exists.

Growth:
- 3 included seats.
- Recommended plan.
- Enough canvases/spaces for a small operating cadence.
- Comments/collaboration basics.
- Evidence notes and strategy board basics if available.
- Standard exports.

Team / Business:
- 8 included seats.
- Higher workspace limits.
- Team review cadence.
- Shared templates if available.
- Stronger exports if available.
- Integrations/source connections if already built or clearly planned.

Pro:
- 15 included seats.
- Highest self-serve limits.
- API/MCP access when production-ready.
- Advanced integrations/history/versioning if available.
- Priority support or onboarding support.
- Use "talk to us" for capabilities that need human setup.

7. Verification and tests.

- Add unit tests for plan config and entitlement helpers.
- Add at least one test for a gate.
- If touching RLS or permission behavior, run the repo's RLS tests if feasible.
- Run the repo checks from AGENTS.md. At minimum attempt type-check and lint. If there is pre-existing type/lint debt, capture the failure and run the narrow relevant tests for this change.

Acceptance criteria:
- Pricing tiers live in one typed config.
- Workspace plan resolution exists and has a safe default.
- Seat limit and at least one feature entitlement are enforced or visibly gated.
- Settings UI shows current plan and seat usage.
- Invite flow shows included seat limit and handles over-limit state.
- No existing workspace is locked out by default.
- Tests cover plan config, entitlement helpers, and at least one gate.
- The PR explains what is real now, what is placeholder, and what remains for checkout/billing.

Non-goals:
- Do not implement a full Stripe production billing flow unless the repo already has the primitives.
- Do not add usage-based pricing.
- Do not implement automatic extra-seat billing.
- Do not build a complex internal org-role system.
- Do not make pricing copy a marketing landing page concern inside the app.
- Do not hardcode prices in multiple components.

Deliverable:
A small, reviewable PR with plan config, workspace plan resolution, entitlement helpers, basic settings/upgrade UI, tests, and a clear note explaining what remains for real checkout/billing.
```

## Prompt 2 - Website Marketing Agent

```text
You are the website/marketing implementation agent for Canvasm.

Read first:
- Project Memory - Metrimap.
- PRD/1. Distribution/Pricing and Break Even Model.md.
- PRD/1. Distribution/Agent Prompts - Pricing Tier Implementation.md.
- PRD/1. Distribution/Content Pillars - Canvasm.app.md.
- PRD/1. Distribution/Marketing.md.
- PRD/2. Proposition/1. Main Website (Canvasm.app).md.

Goal:
Implement a clear pricing section/page for the Canvasm marketing website that explains Metrimap's subscription tiers and nudges serious early customers toward the Growth or Team / Business plan.

Naming rule:
- Canvasm is the public brand/company/domain.
- Metrimap is the product experience inside Canvasm.
- On the marketing site, it is fine to say "Canvasm" for the product family, but do not lose the product truth: the app experience is Metrimap.

Positioning:
Canvasm/Metrimap is the operating workspace for metric trees, business architecture, evidence, experiments, and agent-ready growth work. The pricing should sell operational clarity, traceability, and team alignment. Do not position it as a generic diagramming app, dashboard, or project tracker.

Core message:
- Dashboards show values. Metric maps show beliefs.
- Trust is not a vibe. Trust is traceability.
- Operationalize your driver tree. Connect metrics, evidence, experiments, and work in one living map.

Pricing tiers:
- Starter: RM79-99/month, 1 included seat. Use RM99 as the default public display unless a launch offer chooses RM79.
- Growth: RM179/month, 3 included seats. Mark as recommended for early customers.
- Team / Business: RM349/month, 8 included seats.
- Pro: RM599/month, 15 included seats.

Messaging rules:
- Do not anchor the page around the lowest price.
- Make Growth the recommended/default plan.
- Make Team / Business feel like the natural plan for companies where more than one person participates in metric reviews.
- Explain included seats simply.
- Mention extra seats as "talk to us" or "available later" if the product is not ready to bill them automatically.
- Avoid overpromising integrations, API/MCP, advanced exports, or priority support if the app does not yet deliver them.
- Do not publicly mention internal cost math, break-even targets, Vercel/Supabase/Clerk costs, or founder runway.

Suggested page structure:

1. Pricing hero.

Headline option:
"Choose the operating layer for your metrics."

Supporting copy:
Focus on mapping what drives the business, aligning the team around metric movement, and turning evidence into decisions.

Do not use a generic "simple pricing for every team" headline.
Monthly pricing by default. Add an annual toggle only if annual billing is actually supported.

2. Four pricing cards.

Starter:
- For solo builders mapping their first operating model.
- 1 seat.
- Core metric canvases.
- Basic evidence notes.
- Basic exports if available.
- CTA: Start mapping.

Growth:
- Recommended.
- For founders, operators, and small teams starting a real metric review cadence.
- 3 seats.
- Metric trees, evidence, comments/collaboration basics, strategy actions if available.
- Enough limits for the first operating cadence.
- CTA: Start Growth or Book onboarding.

Team / Business:
- For teams that review metrics together.
- 8 seats.
- Shared workspace, higher limits, team permissions where available, shared templates if available, stronger exports if available.
- CTA: Talk to us or Start Team.

Pro:
- For advanced operating systems and agent-ready workflows.
- 15 seats.
- API/MCP, advanced integrations, history/versioning, priority support, or onboarding support only if available or clearly marked as "talk to us".
- CTA: Contact us.

3. Break-even confidence.

Do not mention internal cost math publicly.
Instead communicate that paid plans are designed for serious business use, active team workflows, and the operational value of aligning metrics, evidence, and action.

4. FAQ.

Include:
- What counts as a seat?
- Can I add teammates?
- Can I change plans?
- Do you offer annual billing?
- Is this for individuals or teams?
- What happens if we need more seats?
- Is Canvasm a dashboard or data warehouse?

Answer the last question clearly:
Canvasm does not replace your analytics tools, warehouse, or workflow automation. It gives your team the operating map that connects metrics, sources, evidence, experiments, and actions.

Implementation requirements:
- Use the existing website design system and responsive layout.
- Pricing cards must look good on mobile and desktop.
- Keep feature lists readable. Do not create tiny dense lists that overflow cards.
- Use real buttons/links that route to the current signup, waitlist, onboarding, or contact flow.
- Keep plan data in one config object so marketing copy and displayed prices do not drift.
- If the app and website live in the same repo, align naming and prices with the app plan config where practical.
- Use B2B-serious copy that feels Malaysia-friendly, not enterprise-bloated.

Acceptance criteria:
- Pricing section/page shows all four tiers clearly.
- Growth is visually recommended.
- Seat counts are visible.
- The copy reflects Canvasm's metric-tree/evidence/operating-model thesis.
- The page does not claim unavailable features as live.
- Mobile layout is readable with no text overlap.
- CTA links work or are clearly wired to existing signup/contact routes.
- Plan data lives in one config object/module.

Non-goals:
- Do not implement app-side entitlement gates.
- Do not build checkout unless the website already owns checkout.
- Do not claim usage-based pricing.
- Do not mention internal cost, stack budget, break-even math, or runway.
- Do not position Canvasm as a generic workflow, BI, dashboard, or diagramming tool.

Deliverable:
A reviewable PR updating the marketing website pricing surface, with desktop and mobile screenshots or preview notes.
```

## Recommended Handoff Order

The app agent and marketing agent can work in parallel, but the app agent should define the canonical plan IDs and entitlement names first if both codebases share a repo.

If the marketing agent ships first, it should keep higher-risk claims flexible:

- API/MCP: "Talk to us" or "for advanced teams" until production-ready.
- Integrations/source connections: mention only if already available or clearly planned.
- Extra seats: "Talk to us" until automatic add-on billing exists.

The shared decision that should not change without founder approval:

> First public pricing uses workspace-level plans with included seats. Growth is the main early paid anchor. Pure per-seat billing and automatic extra-seat billing are later decisions.

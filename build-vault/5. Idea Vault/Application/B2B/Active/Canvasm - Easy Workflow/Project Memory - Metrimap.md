---
title: Project Memory - Metrimap
created: 2026-07-04
updated: 2026-07-08
status: active
product: Metrimap
brand: Canvasm
linear_team: CVS
---

# Project Memory - Metrimap

Last verified: 2026-07-04, Asia/Kuala_Lumpur.

This note is the working memory for future issue shaping and product/build work. It intentionally stores no secrets.

## Identity

- Product name: Metrimap.
- Brand, company, domain, and Linear organization name: Canvasm.
- Repo name: `metric-mapping`.
- App URL: `https://use.canvasm.app`.
- Linear source of truth: Canvasm team `CVS`.
- Product learning source of truth: this Obsidian folder.
- Implementation source of truth: WSL repo at `/home/nadeemramli/workspace/github.com/nadeemramli/metric-mapping`.

Use "Metrimap" when talking about the product experience. Use "Canvasm" when talking about the org, domain, deployment, brand, or Linear workspace.

## Source Map

Key vault sources:

- [[Docs Site & Auto-Update — Runbook]] — **public docs (docs.canvasm.app)**: how it was built, the weekly docs-drift agent, log locations, troubleshooting, and the prompts to push to auto-update docs. (added 2026-07-08)
- `Vault Audit - 2026-07-04.md`
- `Tasks/Development Backlog by Intake Group.md`
- `Tasks/Parallel Agent Build - Prompts and Orchestration.md`
- `Tasks/WSL Launch Runbook - Bootstrap then Parallel Build.md`
- `PRD/5. Current State (2026-07)/1. Object Model - Workspace, Space, Catalog.md`
- `PRD/5. Current State (2026-07)/2. Strategy (Kanban for Actions and Hypotheses).md`
- `PRD/5. Current State (2026-07)/3. Permissions and Roles.md`
- `PRD/5. Current State (2026-07)/4. Alerting and Monitoring.md`
- `PRD/5. Current State (2026-07)/5. Canvas Value Time-Travel.md`
- `PRD/4. Product/3. MCP and Programmatic Building.md`
- `PRD/4. Product/5. Canonical Schemas and Native Connectors.md`
- `PRD/4. Product/6. Strategy Impact and Dashboard Trace.md`
- `PRD/4. Product/7. Shared Infra (Hetzner VPS).md`

Key repo sources:

- `AGENTS.md`: agent/work protocol and Linear operating model.
- `CLAUDE.md`: points agents back to `AGENTS.md`.
- `README.md`: project overview and common commands.
- `package.json`: stack and scripts.
- `vite.config.ts`: Vite/React build config.
- `vercel.json`: deployment rewrites and security headers.
- `docs/features/linear-setup.md`: system health -> Linear runtime error intake.
- `docs/features/system-health-intake.md`: verified production error-intake flow.
- `docs/features/userback-customer-requests.md`: Userback -> Linear Customer Requests bridge, built but not fully live.
- `docs/features/linear-initiatives.md`: Linear Initiatives mapping to metric-tree objectives.

## Repo Snapshot

The WSL repo is reachable from Codex through:

`\\wsl$\Ubuntu\home\nadeemramli\workspace\github.com\nadeemramli\metric-mapping`

Current branch checked: `main`, clean against `origin/main` at the time of scan.

Stack:

- Vite React SPA, React 19, React Router 7.
- Clerk for auth and org/workspace identity.
- Supabase for Postgres, RLS, edge functions, realtime/storage-adjacent backend work.
- React Flow / `@xyflow/react` for canvas.
- EditorJS for evidence notebook content.
- Zustand, XState legacy, TanStack Query present.
- Tailwind, Radix/shadcn-style components, Lucide icons, Recharts.
- Userback for in-app feedback.

Common verification commands from repo guidance:

- `npm run type-check`
- `npm run lint`
- `npm run test`
- `npm run test:rls` when RLS/policy behavior changes

Important repo surfaces:

- Routes include home, auth, public embed, evidence, catalog, feed, workspace settings, and canvas subroutes for canvas/dashboard/strategy/assets/evidence/settings.
- `src/features/canvas` is the biggest and riskiest area.
- Core feature folders include canvas, data, strategy, assets, evidence, settings, projects, dashboard, auth, catalog, and notifications.
- Supabase client setup lives in `src/shared/lib/supabase/client.ts`.

Technical debt flags:

- There is broad type debt around canvas stores/services/components, including many `@ts-nocheck` files and `TODO(type-debt)` notes.
- Repo docs mention stale excluded XState integration tests.
- Open P0-ish product concerns from the vault/backlog: autosave, duplicate, version history, and evidence persistence.

## Product Model

Metrimap is a visual-first product for metric trees and business architecture maps.

Core objects:

- Workspace: backed by Clerk organization.
- Space: folder-like grouping inside a workspace.
- Canvas: the actual metric tree/business architecture workspace.
- Metric Card: node/card in the tree.
- Metric Catalog: promoted/shared definition layer for tracked metrics.
- Metric Values: time-series/snapshot values for tracked metrics.
- Relationships: typed edges and dependencies.
- Evidence: notebook/source material connected to nodes and decisions.
- Strategy board: action/hypothesis nodes presented as a Kanban/table workflow.

Important product distinction:

- Exploration mode: freeform, evolving, canvas-first thinking.
- Operationalization mode: tracked, catalogued, monitored, permissioned, and linked to outcomes.

Current product themes from the vault:

- Workspace -> Space -> Canvas organization.
- Metric Catalog promotion, propagation, detach/fork behavior, tracked metric candidates, stale/orphan source states.
- Strategy board for Actions and Hypotheses, including due dates, assignees, comments, and value-journey strip.
- Guest permission tiers: Viewer, Commenter, Editor, Admin.
- Alerting for thresholds, sharp changes, and out-of-range values.
- Canvas value time-travel: view as of / compare periods for tracked metric snapshots.
- Programmatic building via Metrimap API/MCP so agents and integrations can create/update trees and push values.

## Linear Snapshot

Live Linear scan source: Canvasm org, team `CVS`, run on 2026-07-04.

Team states:

- Triage
- Backlog
- Todo
- In Progress
- In Review
- Done
- Canceled
- Duplicate

Existing labels:

- Bug
- Feature
- Improvement
- Devin
- manual-test
- runtime-error
- from:error-boundary
- source:system-health
- type:bug

Projects observed:

- Access & visibility (node-level transparency)
- Growth - sites, onboarding & analytics (later)
- Draw mode (whiteboard)
- Programmatic building - Metrimap MCP + API
- Account & Settings
- System Health
- Manual Test
- Linear features & integrations
- Canvas engine - nodes & edges
- Evidence Notebook refactor
- Navigation & in-canvas UX

Issue counts from latest scan:

- 107 CVS issues fetched.
- 91 active issues.
- 16 completed or canceled.
- Active by state: 61 Triage, 12 Backlog, 11 Todo, 6 In Review, 1 In Progress.
- Active by project: 24 no project, 14 Manual Test, 8 Account & Settings, 8 Canvas engine, 8 Programmatic building, 6 Access & visibility, 6 Linear features, 5 Growth, 4 Navigation, 3 Evidence, 3 System Health, 2 Draw mode.
- Active by assignee: 63 unassigned, 17 Nadeem Ramli, 11 Checkpoint.
- Active by priority: 22 no priority, 1 urgent, 2 high, 56 medium, 10 low.

Linear hygiene findings:

- 24 active issues have no project.
- 63 active issues have no assignee.
- 91 active issues have no `area:*` label.
- 85 active issues have no `source:*` label.
- 88 active issues have no `type:*` label.

High-signal active issues and clusters:

- `CVS-127`: DB security posture, 96 Supabase advisor warnings. In Progress, System Health.
- `CVS-26`: Userback -> Customer Requests pipeline. In Review, Linear features.
- `CVS-86`: Account & Settings build-out. In Review.
- `CVS-29`: Canvases home redesign. In Review.
- `CVS-24`: Linear Initiatives -> metric-tree objective. In Review.
- `CVS-125`: Fix `AGENTS.md` manual-test protocol: Manual Test project, owner assignment, drop Checkpoint.
- `CVS-72`: Type-check debt, 34 `@ts-nocheck` files.
- `CVS-64`: ESLint debt, 37 pre-existing errors.
- `CVS-65`, `CVS-23`, `CVS-22`: active runtime-error issues from System Health intake.
- `CVS-83` through `CVS-75`: several no-project/no-label product or platform issues that need triage.

Manual-test issue pattern:

- Manual test issues are being created, which is good.
- Some are in the Manual Test project; many child manual-test issues have no project.
- Many are assigned to Checkpoint, which conflicts with the planned `CVS-125` cleanup.

## Linear Cleanup Applied - 2026-07-04

Direct Linear cleanup was applied on 2026-07-04 after the initial audit.

Changes applied:

- Created the missing issue label taxonomy for `area:*`, `source:*`, and `type:*`.
- Added area/source/type labels to active issues where the classification was obvious.
- Moved all active no-project issues into an appropriate project.
- Moved manual-test child issues into the Manual Test project.
- Reassigned manual-test issues from Checkpoint to Nadeem Ramli.
- Moved manual-test issues from Triage/Backlog into Todo when they were accepted verification work.

Final post-cleanup scorecard:

- 93 active issues.
- Active by state: 46 Triage, 31 Todo, 10 Backlog, 4 In Review, 2 In Progress.
- Active without project: 0.
- Active without `area:*` label: 0.
- Active without `source:*` label: 0.
- Active without `type:*` label: 0.
- Manual tests outside Manual Test project: 0.
- Manual tests assigned to Checkpoint: 0.
- Active unassigned issues: 57.

Remaining cleanup should focus on assignment, description quality, acceptance criteria, status correctness, and parent/child/dependency structure. The 57 unassigned issues were intentionally not auto-assigned because ownership needs product judgment.

## Linear Issue Improvement Rules

Every issue should have:

- Clear outcome-oriented title.
- Project.
- Assignee or explicit reason it is unassigned.
- State that reflects intent: Triage for unsorted intake only; Backlog for accepted later; Todo for accepted soon; In Progress/In Review only when actively moving.
- Labels:
  - `type:bug`, `type:feature`, `type:improvement`, `type:debt`, `type:spike`, or similar.
  - `area:canvas`, `area:evidence`, `area:settings`, `area:catalog`, `area:strategy`, `area:data`, `area:system-health`, `area:linear`, `area:auth`, `area:infra`, etc.
  - `source:system-health`, `source:userback`, `source:vault`, `source:repo`, `source:manual-qa`, `source:founder`, etc.
  - `manual-test` only for verification child issues.
- Description sections:
  - Problem / signal.
  - Expected outcome.
  - Scope.
  - Acceptance criteria.
  - Verification plan.
  - Dependencies or blocked-by notes.
  - Non-goals / locked decisions when relevant.

Manual-test child issue rule:

- Parent issue ships implementation.
- Child issue verifies behavior manually.
- Manual-test child should live in the Manual Test project, have a parent link, and be assigned to the actual verifier/owner.
- After verification, close the manual-test child and move/close the parent appropriately.

Runtime/System Health issue rule:

- Runtime issues should be in System Health unless they are immediately folded into a product project.
- Dedupe by fingerprint/group where possible.
- Keep `from:error-boundary`, `runtime-error`, `source:system-health`, and `type:bug`.
- Add area label based on affected route/module.

## Suggested Linear Cleanup Pass

1. Create or standardize missing label families:

- `area:*`
- `source:*`
- `type:*`
- optional `risk:*` or `confidence:*` later if useful

2. Triage the 24 active issues with no project:

- Product UX issues like command palette, cross-canvas search, orphan metric grouping, and notifications need project homes.
- Tech-debt issues like type-check and lint debt probably need System Health or a dedicated Engineering Health project.
- Runtime errors belong in System Health unless absorbed by a concrete fix issue.

3. Clean manual tests:

- Apply `CVS-125`.
- Move all manual-test child issues into Manual Test.
- Replace Checkpoint assignment with the responsible verifier.
- Close manual-test issues whose parent behavior has already been verified.

4. Reconcile vault status with live state:

- Initiatives are documented as live in repo docs, but related Linear issue `CVS-24` is still In Review.
- Userback bridge is code-built and `CVS-26` is In Review, but live Supabase schema suggests the Userback feedback migration is not applied yet.
- The backlog note has some stale "to build" items that are now at least partially built.

5. Turn current System Health gaps into crisp issues:

- Global JS error/unhandled rejection intake.
- API/network failure intake.
- Edge function/cron/background job failure intake.
- Vercel deploy failures -> Linear.
- Supabase advisor warnings and security/performance backlog.
- QA findings table -> Linear.
- Web Vitals / slow query capture.

## Vercel Snapshot

Live Vercel project:

- Project: `canvasm`.
- Production URL: `https://use.canvasm.app`.
- Latest inspected production deployment: Ready.
- Deployment created: 2026-07-04 06:59:21 MYT.
- Framework preset: Vite.
- Node.js: 22.x.
- Root directory: `.`.
- Build command: `npm run build` or `vite build`.

Local caveat:

- The repo does not appear locally linked to Vercel via `.vercel/project.json`, so `vercel env ls canvasm` failed from the repo context.

Deployment config:

- `vercel.json` rewrites SPA routes to `/index.html`.
- Security headers include CSP allowances for Supabase, Clerk, Userback, Google accounts, OpenAI API, blob workers, and related runtime needs.

## Supabase Snapshot

Live public tables observed:

- `alert_rules`
- `api_keys`
- `canvas_nodes`
- `changelog`
- `comment_mentions`
- `comment_threads`
- `comments`
- `dashboard_widgets`
- `error_report_groups`
- `error_reports`
- `event_definitions`
- `event_properties`
- `evidence_items`
- `feed_bookmarks`
- `groups`
- `metric_card_tags`
- `metric_cards`
- `metric_values`
- `notifications`
- `project_collaborators`
- `projects`
- `relationship_tags`
- `relationships`
- `source_connection_secrets`
- `source_connections`
- `spaces`
- `tags`
- `tracked_metrics`
- `users`

RLS:

- RLS is enabled on all observed live public tables.

Notable public functions:

- `can_comment_project`
- `can_view_project`
- `dispatch_error_report_sync`
- `emit_card_alert`
- `error_sync_config`
- `get_clerk_user_id`
- `get_current_user_id`
- `has_project_access`
- `is_project_owner`
- `my_project_permission`
- `requesting_org_id`
- `requesting_user_id`
- `rollup_error_report`
- `run_alert_sweep`
- `upsert_user`

Extensions:

- `pg_cron`
- `pg_graphql`
- `pg_net`
- `pg_stat_statements`
- `pgcrypto`
- `supabase_vault`
- `uuid-ossp`

Migration/live-state note:

- Live migration history observed through `20260703220735`.
- `userback_feedback` was not present in live public tables during the scan.
- Inference: the Userback Customer Requests bridge is code-built, but the live database/deploy path likely still needs the later Userback migration and final production verification.

System Health:

- Runtime crash intake is live: ErrorBoundary -> `error_reports` -> rollup/grouping -> sync edge function -> Linear issue.
- `error_reports` currently has insert-only policy for client reports.
- `error_report_groups` is backend-managed.

## Shared Infra / VPS - 2026-07-04

The runtime now includes a **shared Hetzner VPS** (Docker Compose), alongside Vercel (SPA) and Supabase (DB/auth/edge), to host the serverless-hostile workloads — long-lived / heavy / stateful / scheduled. Serverless (Vercel functions, Supabase Edge) is the wrong tool for these (SSE/duration/stateless limits).

Linear project: *Shared infra & workers (Hetzner VPS)* (under the Development Operating System initiative). `CVS-215` provisions the box first; everything else blocks on it.

Co-tenants:

- MCP server (Node, **Streamable HTTP**) — `CVS-100` deploys here (hosting locked; not Vercel serverless).
- Redis + job queue (BullMQ) — `CVS-216` (backs `CVS-104` rate limits).
- Server-side compute/simulation — `CVS-217`; RCA/drift engine — `CVS-218`.
- Canvas export/render (headless Chromium) — `CVS-219` (powers `CVS-29` thumbnails/PDF).
- Notifications/digest worker — `CVS-220` (Resend; ties `CVS-88`, `CVS-113`).
- CRDT collab server (yjs) — `CVS-221` (`CVS-40` phase 2).
- Agentic Loop-B runner + DevOS cron — `CVS-222`.
- Connected-accounts sync (`CVS-90`), MCP ingest (`CVS-102`), Stripe/Userback webhooks (`CVS-91`/`CVS-26`) also deploy here.

Not on the VPS: primary Supabase Postgres (managed), static sites (Cloudflare/Vercel Pages), analytics (**hosted** PostHog `CVS-115` — not self-hosted).

Guardrails: RLS-scoped path for anything touching metric data (no service-role bypass, per `CVS-118`); containerize each service; single point of failure + security surface → keep patched + backed up. MCP transport: Streamable HTTP (SSE deprecated).

Design: `PRD/4. Product/7. Shared Infra (Hetzner VPS).md`; MCP hosting locked in `PRD/4. Product/3. MCP and Programmatic Building.md`.

## Current Product/Delivery Risks

- Linear is the intended source of truth, but most active issues are still in Triage and many lack project/label/assignee metadata.
- The repo and vault disagree in a few places because some docs are ahead/behind live state.
- Userback Customer Requests bridge appears built but not fully deployed/live in database.
- System Health has runtime-error intake live, but other signal sources are not yet captured.
- Type/lint debt may slow future parallel agents unless isolated into dedicated cleanup work.
- Manual-test workflow exists but needs assignment/project cleanup to become reliable.

## Evidence Notebook Direction - 2026-07-04

Linear project updated: Evidence Notebook refactor.

Related issues updated:

- `CVS-34`: Refactor Evidence UI to a Notebook-style experience.
- `CVS-35`: Evidence canvas card shows "No content available" for populated evidence.
- `CVS-36`: Evidence "View Full" not wired properly.

Product direction:

- Evidence should become a first-class Metrimap Notebook, not a detached metadata form.
- Evidence should link deeply to metric cards/nodes, relationships, charts, snapshots, decisions, and other evidence.
- The reference model is an Amplitude-style analytics notebook: narrative analysis wrapped around live or snapshotted analytical objects.
- The editor should support slash-command insertion for Metrimap blocks such as `/node`, `/relationship`, `/chart`, `/snapshot`, `/metric`, `/hypothesis`, `/source`, and `/evidence`.
- Chart/node embeds should support both live reference mode and frozen screenshot/snapshot mode.
- Every preview, side sheet, and full page must open the same persisted evidence item and render the same rich notebook content.

Implementation findings:

- `EvidenceItem.content` already models EditorJS JSON, but live DB-backed `evidence_items` currently stores metadata only.
- `src/shared/lib/supabase/services/evidence.ts` and `relationships.ts` currently transform DB evidence rows into metadata-only `EvidenceItem` objects.
- `EvidenceRepositoryPage` merges local store evidence with relationship evidence from canvas edges.
- `/evidence/:id` currently reads from the local Zustand evidence store, which explains why evidence visible on a card can fail to open correctly in full-page or side-sheet form.

Likely build order:

1. Fix evidence identity/opening so View Full and side sheet resolve the same persisted item by ID.
2. Add rich content persistence to `evidence_items` and service transforms.
3. Unify card, relationship, and general evidence around one Evidence service.
4. Add custom EditorJS blocks for node references, relationship references, chart embeds, and snapshots.
5. Add slash-command aliases and read-only rendering for those blocks.

## Scope Clarification - Data Stack, Instrumentation, And External Workflows - 2026-07-04

Canvasm/Metrimap should not become the user's tracking tool, CDP, warehouse, reverse ETL tool, data pipeline builder, or workflow engine.

Correct product boundary:

- Instrumentation happens in the user's chosen event/tracking/analytics tools.
- Data unification happens in the user's chosen warehouse, CDP, ELT, reverse ETL, notebook, or data-agent stack.
- Applied AI and automations run in third-party tools or customer-owned systems such as Intercom, HubSpot, WhatsApp providers, n8n, Zapier, Make, internal scripts, or custom agents.
- Metrimap maps the business context around those systems: value-chain gaps, metric definitions, source expectations, relationships, evidence, owners, guardrails, and action status.
- MCP/API should let external agents/tools push maps, metric values, evidence, stack architecture summaries, and workflow status into Metrimap.

Issue-shaping implication:

- Do not create issues that make Metrimap responsible for building a full data stack or running external workflows.
- Create issues that let Metrimap reference, govern, and evaluate external systems.
- Action nodes can reference external agents, automations, scripts, and workflows, including runner, URL, owner, trigger, action performed, guardrails, target metric, evidence, and status.
- Instrumentation support should be framed as gap analysis and briefs: what event/source/app is missing, why it matters to the value chain, who owns it, and how the team verifies the gap is closed.

## MCP/API Auth Split - CVS-99A/B/C - 2026-07-04

`CVS-99` should not remain a single vague "OAuth + API key" issue. Treat it as an umbrella or split it into child issues:

- `CVS-99A`: Lock programmatic auth model and RLS strategy.
- `CVS-99B`: Implement programmatic auth resolver and scoped Supabase client.
- `CVS-99C`: Add auth tests, denial cases, and developer usage docs.

Key requirement:

- Programmatic MCP/API calls must authenticate as a real Metrimap user and run product reads/writes under RLS.
- OAuth/Clerk auth and personal API keys must resolve to the same normalized auth context.
- API keys must not imply service-role access.
- Multi-workspace access must be explicit when ambiguous.
- No raw keys/tokens/secrets should be logged.

Detailed requirements are in `PRD/4. Product/3. MCP and Programmatic Building.md`.

## Evidence And Provenance Gap Assessment - 2026-07-04

The Evidence Notebook project is directionally correct but still needs sharper issue coverage for the new product thesis: "trust is traceability."

Current known issues:

- `CVS-34`: Refactor Evidence UI to a Notebook-style experience.
- `CVS-35`: Evidence canvas card shows "No content available" for populated evidence.
- `CVS-36`: Evidence "View Full" not wired properly.

These issues are necessary, but not sufficient for the provenance thesis.

What they cover well:

- Evidence should become notebook-like rather than a metadata form.
- Evidence previews/full views should resolve the same persisted item.
- The editor and renderer should support rich content.

What is still missing or should be explicit in follow-up issues:

- A single persisted Evidence service that owns all evidence identity and content, not a mix of local Zustand evidence, relationship evidence transforms, and metadata-only DB rows.
- Relationship-linked evidence as a first-class path: evidence attached to a relationship should open, render, and persist the same way as evidence attached to a node or general repository.
- Provenance fields for generated or human-created artifacts: source, source type, source reference, related metric, related relationship, related experiment/test, created by, created from, and snapshot/live mode.
- Conviction model: relationship confidence should be backed by evidence history and prior tests, not only a static label.
- Embedded object blocks: `/node`, `/relationship`, `/chart`, `/snapshot`, `/experiment`, `/source`, `/decision`, `/artifact`, and `/conviction`.
- Read-only renderer parity: every embedded block must render consistently in cards, side sheets, full pages, and shared/read-only contexts.
- Evidence-to-decision loop: an evidence note should be able to change or explain confidence/conviction on the linked relationship or metric.

## Future Assistant Operating Notes

When helping on this project:

- Start from Linear issue `CVS-*` when implementation is requested.
- Read `AGENTS.md` before coding in the repo.
- Use a branch per Linear issue when making repo changes.
- Respect locked decisions and acceptance criteria in the issue.
- Add or update a manual-test child issue for feature work.
- Verify with the repo's commands before PR when feasible.
- Use Obsidian for durable product learning, not repo docs.
- Do not store or print API keys, Supabase service keys, Vercel tokens, or database URLs.

When shaping Linear issues:

- Prefer fewer, sharper issues over broad vague backlog items.
- Keep issue scope small enough for one agent/thread.
- Put build order in dependencies/parent-child links, not just prose.
- Tie product bets to metric-tree objectives or evidence when possible.
- Convert system/user signals into issues only after interpreting impact and desired outcome.

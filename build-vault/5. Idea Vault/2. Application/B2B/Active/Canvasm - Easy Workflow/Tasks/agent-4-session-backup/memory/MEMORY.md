# Memory Index

- [Agent 5 session](agent5-session.md) — "Agent 5" = THIS session (id 95edffa8-9ffc-42bc-ad18-77d211b47f91); Access & Visibility lane CVS-118→123 all shipped+merged+applied to prod; 5 manual tests (CVS-211/214/226/233/234) in owner Todo; resume: `claude --resume 95edffa8-9ffc-42bc-ad18-77d211b47f91`
- [Access & Visibility lane](access-visibility-lane.md) — Agent 5's lane; node-level transparency (groups × access-tags × RLS); COMPLETE
- [Agent 4 session handoff](agent-4-session-handoff.md) — "Agent 4" = Strategy impact lane (CVS-166→177) shipped to main; 11 manual tests in owner Todo; how to restore session after a computer reset
- [Manual tests → owner](manual-tests-assign-to-owner.md) — assign Linear manual-test issues to Nadeem (3f0b8049-…), NOT checkpoint.xyz; overrides AGENTS.md protocol
- [Multi-agent build workflow](multi-agent-build-workflow.md) — SUPERSEDES direct-to-main: Linear team CVS, branch-per-issue + PR → In Review + manual-test sub-issue; docs policy (product→vault, repo docs=infra); CVS-45+CVS-71 DONE; backlog gaps filed CVS-73..83; ⚠️ never run 2 agents in one working tree (use worktrees)
- [MCP server deployed](mcp-server-deployed.md) — LIVE at https://mcp.canvasm.app/mcp on Hetzner 5.223.49.175 (docker compose + Caddy TLS); rsync-the-worktree deploy one-liner; husky --ignore-scripts fix; sha256 key-hash auth chain

- [Evidence Notebook refactor](evidence-notebook-refactor.md) — CVS-34 epic; notebook `content` now persists to `evidence_items.content` jsonb (migration APPLIED to prod); slices 1-3 merged (service layer + EvidencePage + Repository all DB-backed); remaining = EvidencePage new-path/merge-dedup + slice 4 custom EditorJS blocks (/node /chart /snapshot)
- [Pages follow node-type spec](pages-node-type-spec.md) — Strategy page (kanban+journey) shipped; chart→widget import; Data folded into Assets; status/workflow on metric_cards; prisma:types is broken (hand-patch zod)

- [Group → dashboard restored](group-to-dashboard-restored.md) — grouping-becomes-a-dashboard rebuilt on current Recharts UI (buildGroupDashboard + GroupDashboard); DashboardPage pill selector, one dashboard per group + Custom
- [System Health → Linear intake](system-health-linear-intake.md) — server-side bridge: error_report_groups → deduped Linear issues (fingerprint, pg_cron, edge fn); code done + migrations applied, owner must deploy (Linear secrets + Vault)
- [Error reports sink](error-reports-sink.md) — ErrorBoundary reports crashes into insert-only Supabase error_reports table + shows details in-UI; read via dashboard (service_role), no admin UI yet
- [Canvas store split-brain](canvas-store-split-brain.md) — TWO useCanvasStore instances; @/lib/stores→canvasStore.ts is the REAL rendered one; orphan useCanvasStore.ts caused copy/delete + realtime bugs

- [Gap-list build 2026-06-30](gap-list-build-2026-06-30.md) — correctness slice DONE (cycle-validation, source-stale, perfect-freehand); pending decisions on collab substrate + paste semantics
- [Canvas pages restructure 2026-06-30](canvas-pages-restructure-2026-06-30.md) — unified headers (usePageHeader), Sources→Data hub (+events taxonomy), drag-drop dashboard builder (react-grid-layout), Realtime presence; 3 migrations APPLIED
- [Commit & merge always](commit-and-merge-preference.md) — user wants each step committed as it goes; type-check/lint first; branch-per-CVS-issue + merge-as-you-go, but DON'T self-merge prod DB-grant/security PRs
- [Integrations lane worktree 2026-07](integrations-lane-worktree-2026-07.md) — ../metrimap-integrations worktree; CVS-24/26 shipped (PR #17/#19), 25 parked (billing), 27/28 evals pending human setup, DB-hardening CVS-127 Phase-1 PR #24 open; app is pure PostgREST (GraphQL endpoint unused)
- [Supabase rebuild 2026](supabase-rebuild-2026.md) — old project deleted; new ref `iqrclwolhookzzmiedun`; Clerk pk_live now aligned + sign-in works
- [Metrimap handoff 2026-06](metrimap-handoff-2026-06.md) — current app state; operators/simulation DONE & verified (MRR→×1.1→851631); showcase+grouping done; gotchas (no parent_id, nodeIds)
- [Service-role key audit](service-role-key-audit.md) — live key never committed; rotation NOT urgent; dev client code path now deleted (Clerk-only)
- [Don't remove active vars](dont-remove-active-vars.md) — never delete env vars/code that are actively used; grep whole repo (incl. scripts) before removing
- [Product direction: value pipelines](product-direction-pipelines.md) — north star = build metric trees + govern business value chain; reframe backlog from auth/collab toward value pipelines
- [Vitest unit tests](vitest-unit-tests-dont-run.md) — OUTDATED: a `unit` vitest project now exists; `npm run test` DOES run src/**/*.test.ts alongside Storybook
- [Data source Phase 1 shipped](data-source-phase1.md) — sourceBinding.ts contract+engine (derive/generate/parse) wired into card Data tab; Phases 2-3 (file/warehouse) still draft
- [Collab consolidation 2026-06](collab-consolidation-2026-06.md) — Collaborate+Share merged into one right-side panel (people/comments/@mentions/activity); comment-refs uuid→text + source_connections migrations APPLIED to prod 2026-06-28
- [Object model LOCKED 2026-06-28](object-model-locked.md) — Workspace→Space→Canvas; Workspace=Clerk org; promotion-based Tracked-Metric catalog (Source+Card); two-tier values. Full doc: the Obsidian product vault
- [Tracked Metrics catalog](tracked-metrics-catalog.md) — Epic B.1 semantic layer SHIPPED 2026-06-29: tracked_metrics table + /catalog page (Tracked/Candidates, promote); next = card-promote, reference-resolution, then B.2 value store, B.3 hierarchy
- [Chart node + examples 2026-06](chart-node-and-examples-2026-06.md) — Visualization node reworked (Recharts, data-bound to cards); seed examples now wire all node types (source→operator→card→chart) but NOT yet re-run on prod
- [UI modernization 2026-06](ui-modernization-2026-06.md) — tokens were NOT wired to Tailwind v4 (dark mode inert) — fixed; Phases 0-4 done (zero native confirm/alert app-wide); deferred items (data-source linkage, canvas Inspector pending @ts-nocheck cleanup, Cmd+K) in the Obsidian product vault
- [UI/UX audit + backlog](ui-ux-audit-backlog.md) — full PRD vs codebase audit 2026-06-29; collaboration surfacing #7+#8 SHIPPED (notif inbox + /feed); next clusters: data-integrity/catalog, templates, workspace-settings
- [Alerting slice](alerting-slice.md) — threshold/change/band alert_rules on cards → emit_card_alert SECURITY DEFINER RPC → notifications (type=alert) in inbox/feed + card badge; client-side eval only (cron follow-up)
- [Strategy impact lane](strategy-impact-lane.md) — my lane = Strategy impact (CVS-166→177) in ../metrimap-strategy worktree; CVS-166 decision + CVS-167 data model shipped (PR #59, don't self-merge DB PR); next CVS-168 resolver
- [Permission tiers](permission-tiers.md) — Viewer/Commenter/Editor/Admin; org=collaborative (org members always write, roles gate guests); my_project_permission RPC + can_comment_project; UI gating + banner

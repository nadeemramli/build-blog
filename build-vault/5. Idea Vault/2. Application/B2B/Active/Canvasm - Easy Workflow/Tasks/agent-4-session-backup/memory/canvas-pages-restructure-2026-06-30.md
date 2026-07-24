---
name: canvas-pages-restructure-2026-06-30
description: "Canvas sub-pages restructure shipped 2026-06-30 — unified headers, Data hub, dashboard builder, presence"
metadata: 
  node_type: memory
  type: project
  originSessionId: c33a45dc-d047-4326-9520-bfd22e75dbca
---

Shipped 2026-06-30 (plan: ~/.claude/plans/harmonic-stirring-porcupine.md). Four phases, all type-check/lint/build/test green; a Stop hook auto-commits to main.

**Phase 0 — layout unification.** Canvas sub-pages no longer render their own `<h1>`. Shared pattern: `usePageHeader({title,description,actions})` (`src/shared/hooks/usePageHeader.ts`) pushes into the generalized `CanvasHeaderContext` (now has `actions`, `editableTitle`, optional `autoSaveStatus`/`canvasMode`). `useCanvasHeaderOptional()` no-ops outside the provider (Evidence is also mounted top-level at `/evidence` — keeps its in-page title there via `!isCanvasScoped`). Only `CanvasPage` sets `editableTitle:true`.

**Phase 1+2 — Data hub replaces Sources.** Deleted the whole mock `src/features/sources/` + `useSourceFiltering`. New `src/features/data/`: `DataHubPage` (route `/canvas/:id/data`, nav label "Data") with tabs Connections / Tracked Metrics / Events. `ConnectionsPanel` (reused in WorkspaceSettings too) wraps `sourceConnections.ts`. `TrackedMetricsPanel` is the extracted CatalogPage body; `/catalog` now renders it as a thin wrapper. Events taxonomy is GREENFIELD: `eventTaxonomy.ts` service + `event_definitions`/`event_properties` tables (owner-scoped like tracked_metrics) — migration `20260701120000_event_taxonomy.sql`, APPLIED to prod.

**Phase 3 — drag-and-drop dashboard builder.** Added `react-grid-layout` dep. `dashboard_widgets` table (canvas-scoped via `has_project_access`) — migration `20260702120000_dashboard_widgets.sql`, APPLIED to prod. Rewrote `DashboardPage` (view/edit toggle in header actions, RGL grid, debounced layout save). Widgets: kpi/line/area/bar/pie/table via `WidgetCard` + `WidgetConfigSheet` + `widgetData.ts` adapter (tracked-metric source synthesizes pseudo-cards → `resolveChartSeries`). Extracted shared `src/shared/components/charts/MetricChart.tsx` from chart-node (node is now a thin wrapper). Deleted `dashboardGenerator.ts` + `generateMockMetrics` (the old `Math.random` mock). **NOT yet runtime-smoke-tested in browser** (react-grid-layout × React 19 StrictMode) — flagged caveat.

**Phase 4 — presence + collab-aware comments.** `usePresence.ts` (Supabase Realtime presence channel `presence:project:{id}`, ephemeral, no table). `PresenceAvatars` stack in CanvasLayout top bar + "Online now" in CollaborationPanel People tab. CanvasLayout owns presence and derives the page label. Comments: `comment_threads.context` column ALREADY existed (no migration) — new top-level threads now stamp `context.page`; Comments tab has a "This page" filter.

Gotchas: `useClerkSupabase()` returns null until Clerk loads — guard every caller. New Supabase types were HAND-ADDED to `src/shared/lib/supabase/types.ts` (not via prisma:types). See [[object-model-locked]], [[tracked-metrics-catalog]], [[collab-consolidation-2026-06]].

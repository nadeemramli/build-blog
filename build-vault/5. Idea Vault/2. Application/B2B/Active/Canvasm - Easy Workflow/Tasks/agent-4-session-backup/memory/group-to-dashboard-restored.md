---
name: group-to-dashboard-restored
description: grouping → dashboard feature rebuilt on current Recharts UI (was deleted in the big UI refactor)
metadata: 
  node_type: memory
  type: project
  originSessionId: bb4291b1-f0d5-4f20-b5be-749bf47866b1
---

The "group nodes on canvas → that group becomes a dashboard" linkage was
deleted in the UI-modernization refactor (old `src/shared/utils/dashboardGenerator.ts`
gone; DashboardPage became a manual react-grid-layout widget builder).

Restored 2026-07-03 on the current Recharts/shadcn stack:
- `src/features/dashboard/utils/groupDashboard.ts` — pure `buildGroupDashboard(group, cards)` (members via `group.nodeIds`, KPI summaries, chart series capped to the 6-colour PALETTE).
- `src/features/dashboard/components/GroupDashboard.tsx` + `Sparkline.tsx` — read-only view: summary header (member count / category mix / trend health), KPI tiles w/ Recharts sparklines, MetricChart trend + composition charts.
- `DashboardPage.tsx` — now loads groups+cards via `getProjectById(canvasId)` (works even without visiting canvas first), shows a pill selector: one dashboard per group + a "Custom" pill for the existing widget grid. Prefers live store cards when `storeCanvas.id === canvasId`, else the loaded project.
- Tests: `groupDashboard.test.ts` (7).

Testable on seeded example projects — all seed groups are fully data-populated. SaaS example: `/canvas/c4fc7d38-8033-4e5e-8e8f-563e8a1a1374/dashboard` (4 groups). Related: [[chart-node-and-examples-2026-06]], [[canvas-pages-restructure-2026-06-30]].

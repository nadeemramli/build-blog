---
name: chart-node-and-examples-2026-06
description: "Chart/Visualization node reworked (Recharts, data-bound); seed examples now include all-node-type pipelines but NOT yet re-run on prod"
metadata: 
  node_type: memory
  type: project
  originSessionId: bab683fb-413a-43bc-a66a-62ea4d4fdfc9
---

**Visualization (chart) node — DONE 2026-06-28.** Rewrote `src/features/canvas/components/nodes/chart-node.tsx` to render real metric-card series via the theme-aware `ui/chart.tsx` wrapper (Line/Area/Bar/Pie, gradient areas, compact axes, legend/tooltip). Binds to cards by `data.seriesCardIds` (single source of truth), fed by BOTH a card→chart data-flow edge (`bindChartSeries` in CanvasPage, mirrors `bindOperatorInput`) AND a gear→right-side settings sheet (`chart-node-settings.tsx`). Pure helper `utils/chartData.ts` (`resolveChartSeries`/`formatCompact`) + `chartData.test.ts` (5 tests). Deleted orphaned `panels/chart-panel/`. `convertToCanvasNode` now also sets a `style` width/height for whiteboard nodes (they render at 100% and otherwise collapse).

**Example seeds — reworked to use ALL node types, NOT yet run on prod.** `scripts/seed/seed-example-trees.mjs` now appends a "showcase pipeline" to each of the 3 example projects (SaaS/E-commerce/Retail): a **sourceNode** (manual live-feed series) + **metricCard anchor** → **operatorNode** (`formula: a * 1.1 + b`) → **projection metricCard** (pre-baked so charts look good on load; Run Simulation recomputes) → **chartNode** (area, plots anchor + projection) → plus a **commentNode** + **whiteboardNode** label. Wired via `projects.settings.dataFlowEdges` (5 edges/project) + `canvas_nodes` inserts. Anchor picked by `pickAnchor` (revenue-like). Added a `--dry` flag (writes `example-metric-trees.sql` without DB writes) — validated: 15 canvas nodes across 3 projects, operator/chart/edges correct.

⚠️ **To activate:** run `node scripts/seed/seed-example-trees.mjs` (reads `.env` service-role key). It **DELETEs + recreates** the 3 example projects owned by `user_30uQARGezqSApAChPSGSwFyUy85` on prod `iqrclwolhookzzmiedun`. Not yet run — examples in prod are still the old (no-pipeline) versions. This regenerates card ids, orphaning the earlier MCP-seeded operator pipeline in the SaaS example (`ad1f3617…`). All gates green (type-check/lint/55 tests/build). See [[metrimap-handoff-2026-06]].

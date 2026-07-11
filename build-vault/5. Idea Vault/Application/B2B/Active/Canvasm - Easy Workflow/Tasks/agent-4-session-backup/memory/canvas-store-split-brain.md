---
name: canvas-store-split-brain
description: "Two useCanvasStore instances exist — canvasStore.ts (real, rendered) vs useCanvasStore.ts (orphan)"
metadata: 
  node_type: memory
  type: project
  originSessionId: 2cfc1040-2ad2-4fc3-8fa3-6ebb77a811c6
---

The canvas has TWO Zustand store implementations both exporting `useCanvasStore`, and imports are split — a major gotcha behind several bugs.

- **`src/features/canvas/stores/canvasStore.ts`** (legacy, ~55KB) is the REAL store: `@/lib/stores` re-exports it, and CanvasPage, MetricCard, useNewNodeTypesStore use it. It holds the rendered `canvas.nodes` + `selectedNodeIds`. It is a strict SUPERSET (57 keys ≥ 53) of the orphan.
- **`src/features/canvas/stores/useCanvasStore.ts`** (orphan, ~28KB) is a near-unused second instance. Imported by useCanvasActions, applyRemoteChange, TrackedMetricsPanel, runSimulation, feedDownstream, computePipeline, useBulkOperations, GroupControls, useVersionHistoryStore.

**Why it matters:** my realtime broadcast wiring (node/edge create/update/delete) and catalog value write-through (`syncCardValuesToCatalog`) were added to the ORPHAN, so in the real app (which mutates via legacy) they underfire — explains "relationship creation doesn't sync", card edits not syncing, and value-sharing not propagating. Copy/duplicate/delete were broken because useCanvasActions read the orphan's empty selection (fixed 2026-07-01, commit `976b6e3`, by pointing useCanvasActions at `@/lib/stores`). MetricCard delete used the local-only `deleteNode` (no DB row delete) → cards reappeared on refresh; fixed to `persistNodeDelete`.

**RESOLVED 2026-07-03 (commit `fc18fc4`):** consolidated to ONE store. `canvasStore.ts` is now the single source of truth — the realtime broadcast wiring (node/edge create/update/delete) + catalog write-through (`syncCardValuesToCatalog`) were moved INTO it, and the orphan `useCanvasStore.ts` is now just `export { useCanvasStore } from './canvasStore'`. All importers converge on one instance. This activated card/edge realtime sync + catalog value-sharing that previously underfired.

**How to apply:** import `useCanvasStore` from anywhere (`@/lib/stores`, `./canvasStore`, or the old `useCanvasStore.ts` path) — all resolve to the same instance now. Canvas node/edge mutations broadcast automatically. See [[gap-list-build-2026-06-30]], [[collab-consolidation-2026-06]].

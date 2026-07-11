---
name: tracked-metrics-catalog
description: Tracked Metrics catalog (semantic layer) — Epic B.1 foundation shipped 2026-06-29
metadata: 
  node_type: memory
  type: project
  originSessionId: 4acf6cca-ea6d-4342-91f6-be01eb6c413d
---

**Platform Epic B started with the semantic layer (Tracked Metrics catalog) — the moat.** Foundation shipped + deployed 2026-06-29 (owner approved building all of Epic B, applying schema to prod as we go). See design in `the Obsidian product vault` ([[object-model-locked]]).

**Live on prod (`iqrclwolhookzzmiedun`):**
- `tracked_metrics` table (owner-RLS, created_by; state candidate|tracked; name/unit/formula/owner_label/source_kind/origin_card_id/origin_project_id) + `metric_cards.tracked_metric_id` FK (ON DELETE SET NULL). A card = a "placement" of a catalog metric.
- `services/trackedMetrics.ts`: list, listCandidateCards (cards with non-empty `data` + null tracked_metric_id), promoteCardToTrackedMetric, linkCardToMetric (direct update — BYPASSES metric-cards zod which lacks tracked_metric_id), update, delete.
- `/catalog` page (`src/features/catalog/pages/CatalogPage.tsx`): Tracked + Candidates tabs; one-click "Catalog this metric"; linked from homepage header ("Metric Catalog").
- types.ts: surgically added `tracked_metrics` block + `metric_cards.tracked_metric_id`.

**Owner-scoped for now**; re-scope to Clerk-org workspace with the hierarchy epic.

**Card-level promote DONE 2026-06-29:** "Catalog this metric" in CardSettingsSheet + "Tracked" badge on the card; trackedMetricId threaded through MetricCard type + transforms. Also fixed P2-1 Rules-of-Hooks in CardSettingsSheet (removed the pre-hooks `if(!isOpen) return`).

**B.2 VALUE STORE SHIPPED 2026-06-29** (`metric_values` table on prod: owner-RLS, UNIQUE(tracked_metric_id,period)=current series, upsert, FK cascade). Service: getMetricValues / getMetricValuesByMetricIds / writeMetricValues / syncCardValuesToCatalog. Promote SEEDS the store from card.data. **Read-share:** CanvasPage loadCanvasData hydrates tracked cards from the store. **Write-through:** useCanvasStore.persistNodeUpdate syncs a tracked card's series to the store (ONE hook covers manual/generate/import + source feed + operator run — all persist card.data through it). So a catalogued metric reads the SAME series on every canvas. Versioning/time-travel = later (append-only history table).

**REFERENCE RESOLUTION SHIPPED 2026-06-29:** Add Node menu → "From Metric Catalog" → `CatalogMetricPicker` (src/features/catalog/components/) creates a card pre-linked to the tracked metric + seeded with its shared series (via `useNodeStore.createNode` → `linkCardToMetric` → `useCanvasStore.addNode`). Threaded onAddFromCatalog through TopCanvasToolbar→AddNodeButton. **So the full loop works: catalog a sourced card → add it to another canvas → both read ONE shared series.** Semantic layer (B.1 catalog + B.2 value store + reference resolution) is COMPLETE end-to-end.

**Remaining (minor):** inline catalog-metric edit on /catalog Tracked tab (updateTrackedMetric exists, no UI); versioning/time-travel (append-only history table — schema ready). **Next big epics: B.3** hierarchy (Workspace=Clerk org → Space → Canvas → unblocks homepage Folders/Spaces), **B.4** permissions. **Then B.2** value snapshot store (keyed by tracked_metric_id) → freshness/time-travel/scenarios; **B.3** hierarchy (Workspace=Clerk org → Space → Canvas, unblocks homepage Folders/Spaces); **B.4** permissions. Sequence in [[homepage-ascope-progress]] handoff doc.

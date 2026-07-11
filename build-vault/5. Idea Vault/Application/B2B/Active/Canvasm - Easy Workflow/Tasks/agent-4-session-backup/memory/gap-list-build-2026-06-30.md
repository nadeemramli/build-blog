---
name: gap-list-build-2026-06-30
description: Metrimap gap-task-list build — correctness slice DONE; remaining slices + pending decisions
metadata: 
  node_type: memory
  type: project
  originSessionId: 2cfc1040-2ad2-4fc3-8fa3-6ebb77a811c6
---

Working through the "Metrimap Gap Task List" (homepage/canvas/collab/node-edge walkthroughs). Agreed to do it **step by step**, correctness first.

**Correctness slice — DONE & committed (2026-06-30, on main):**
1. Committed an in-flight Sources→Data-hub restructure that was sitting uncommitted.
2. `wouldCreateCycle` was a silent no-op (ignored its target arg) — fixed to test the candidate edge; extended cycle guard to relationship+dataflow edges; added React Flow `isValidConnection` live block. (`5ab9624`)
3. Source nodes already keep last series on load (integrity safe); added `findOrphanedSourceBindings` + once-per-canvas reconcile so a removed warehouse connection shows the stale badge proactively. (`f05f5e6`)
4. Freehand: swapped hand-rolled polyline → `perfect-freehand` (variable-width filled outline), fixed ref-based live preview, removed debug logs, **persist** strokes as whiteboardNodes via createNode. (`45fe102`)

**Audit corrections to the gap list (it was partly wrong):**
- Realtime is NOT presence-based — `useCanvasRealtime.ts` is a stub (`setIsConnected(true)`). Live presence DOES exist separately via `usePresence.ts` (cursors/roster in CanvasLayout + CollaborationPanel).
- `@automerge/automerge` is an unused dependency (never imported).

**Collaboration slice — core DONE & committed (2026-06-30, on main):**
- Substrate DECIDED: presence-first on Supabase Realtime broadcast; `@automerge/automerge` removed.
- `useCanvasRealtime` implemented (was a stub): broadcast channel `canvas:project:${id}`, `self:false` (no echo). Local mutations broadcast from the STORES (`useCanvasStore`/`useCanvasNodesStore`) + handlers; remote changes apply via local-only store paths (`applyRemoteCanvasChange`) so no re-persist/re-broadcast.
- Split modules: `src/features/canvas/realtime/canvasSyncChannel.ts` (broadcast-only, no store imports — breaks cycle) + `applyRemoteChange.ts` (store-aware, used only by the hook).
- Synced: node create/move/update/delete (cards + canvas nodes), relationship edge create/delete, data-flow/reference edges create/delete (via `registerExtraEdgesApply` since they're React state). Commits `58dce06`, `3ecf874`, `6259c28`.
- Per-user undo is correct by construction: remote applies use local-only methods that never push to `useCanvasHistoryStore`.
- **NOT yet verified with two live browser sessions** (needs Clerk auth × 2; I couldn't automate it). Trade-offs: last-write-wins, no missed-message reconciliation until reload. Not synced: groups, evidence/PRD node families, live-drag streaming (moves sync on drag STOP only).

**Catalog / moat slice — in progress (2026-07-01, on main):**
- Semantic layer was already substantial: `tracked_metrics` (definition) + `metric_values` (shared series); cards link via `metric_cards.tracked_metric_id`; write-through on edit + value hydration on load already worked.
- SHIPPED: paste/duplicate now PRESERVES the catalog link (`createCopy`→`linkCardToMetric`) instead of forking a drifting copy; referenced cards hydrate DEFINITION (name+formula) from catalog on load via new `getTrackedMetricsByIds`; catalog-edit push-down updates open-canvas cards live. Commits `3f50c68`, `5b07765`.
- DECISION: catalog is **authoritative for referenced cards' title** (local rename overwritten on load) — user confirmed.
- SHIPPED 2026-07-03: reference/detach semantics — "Tracked" linked badge (existed) + Detach action in CardSettingsSheet (`linkCardToMetric(null)` + freezes displayed series onto the fork). Commit `bebecdc`.
- SHIPPED 2026-07-03: store consolidation (`fc18fc4`) — merged the two useCanvasStore instances; activated card/edge realtime sync + catalog write-through. See [[canvas-store-split-brain]].
- CATALOG MOAT COMPLETE 2026-07-03: live cross-canvas propagation shipped (`c5c1a20`) — `useCatalogRealtime` subscribes to metric_values/tracked_metrics postgres_changes, updates referencing cards on the canvas live (local-only updateNode, debounced). Required publishing metric_values+tracked_metrics+comments to supabase_realtime (migration `20260703170000`) — this ALSO fixed comment live-sync which silently never fired (comments wasn't published). Owner-scoped RLS ⇒ mainly one-user-many-canvases until workspace epic.
- Master manual test plan (all slices): docs/tests/manual-test-plan.md.

**Roadmap (user, 2026-07-03):** DONE alerting + catalog moat + object-hierarchy + value-time-travel. NEXT platform epic: (3) permission model depth (Viewer/Commenter/Editor/Admin + RLS+UI enforcement) — then canvas polish. Deferred bugs + debug-log cleanup done in tandem with manual test session later.

**Value time-travel — DONE 2026-07-03 (`5b599b8`,`ba52afd`):** per-period history already existed (metric_values + card.data), so PURELY CLIENT-SIDE, no migration. `useTimeTravelStore` (asOf/compare periods, display-only, separate from simulation-write globalPeriod) + `timeTravel.ts` util (seriesAsOf/valueAsOf/availablePeriods/deltaBetween, tested) + `TimeTravelControl` in canvas header actions slot (Live/As-of picker + compare + reset) + MetricCard renders series as-of + delta vs compare. Alerts still use live latest. Resets to live on canvas switch. Dashboard KPI parity NOT done (canvas-only) — optional follow-up. Structure version-history (canvas_snapshots) is orthogonal, untouched.

**Object-hierarchy epic — DONE 2026-07-03 (`5df39ce`):** was ~85% pre-built (Workspace=Clerk org via OrganizationSwitcher + workspace_id columns + org-scoped RLS all on prod since 2026-06-29; spaces table + service + store + basic UI too). Gap was space MANAGEMENT: added `SpacesBar` component (color-dotted chips + ⋯ menu rename/recolor/delete via shared dialog + confirm; create dialog with color) replacing the window.prompt; added `updateSpace` to service+store (color was never settable); fixed stale generated types (workspace_id on projects+spaces Rows). No new migration needed. NOTE: `project` table NOT renamed to Canvas (deferred per locked doc the Obsidian product vault). See [[object-model-locked]].

**Collaboration polish — DONE 2026-07-03:** comment-node threadId persistence (`d55d7a6`), @mention sources presence roster so teammates are mentionable (`d55d7a6`), live comment sync via postgres_changes on node+panel (`2f9e65e`), and last-edited-by attribution — migration `20260703130000_node_updated_by` (updated_by column + trigger stamping requesting_user_id, APPLIED to metrimap-v2) surfaced as "Edited <time> by <name>" on the card via getUsersByIds + useUserName hook (`3a39355`).
**Still-open collab:** panel↔node comment threads still independent (by design). Realtime "one step behind" → the Obsidian product vault. Public embed rendering → the Obsidian product vault.

**Templates + update feed — DONE 2026-07-03:**
- Feed board already existed (FeedPage All/Mentioned/Bookmarked). Made bookmarks a real DB primitive — migration `20260703140000_feed_bookmarks` (owner-scoped, keyed on feed item composite id c:/n:, APPLIED) + feedBookmarks service; FeedPage now DB-backed + live (subscribes to notification inserts). Commit `9b5c040`.
- Templates: authored 5 new trees (Web Analytics, Company KPIs, Marketing KPIs, Feature Launch, Lifecycle Cohort) in `scripts/seed/seed-example-trees.mjs`, generalized layout to per-tree `root`. SEEDED to prod (8 example trees total, public, tagged example+template) — appear automatically in TemplatePicker via getShowcaseProjects. Commit `0fa0e2f`. Seed workflow: edit DSL, `node scripts/seed/seed-example-trees.mjs` (reads SERVICE_ROLE_KEY from .env, idempotent delete-by-name).

**Still pending decisions / later slices:**
- Copy-paste: duplicate-as-new vs paste-as-catalog-reference (note: pasted nodes already sync since paste goes through createNode).
- Next candidate slices: Catalog/moat (reference resolution + paste-as-reference), Templates + Monday-style feed board, or finish collab (groups sync). See [[commit-and-merge-preference]], [[canvas-pages-restructure-2026-06-30]], [[product-direction-pipelines]].

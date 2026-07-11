---
name: data-source-phase1
description: "Data Source feature Phase 1 (Manual + Generate, zero backend) shipped 2026-06-28"
metadata: 
  node_type: memory
  type: project
  originSessionId: 4acf6cca-ea6d-4342-91f6-be01eb6c413d
---

Data Source architecture (the Obsidian product vault) **Phase 1 shipped 2026-06-28**:

- `src/features/canvas/utils/sourceBinding.ts` — the data contract + zero-backend engine. `SourceBinding` type; `deriveSeries` fills `change_percent`/`trend`; `generateSeries` is a seeded trend/seasonality/noise model (doubles as the seed→template engine); `parseSeries` parses CSV/JSON → `MetricValue[]`. Tested in `sourceBinding.test.ts` (15 tests, all pure).
- Wired into the card **Data tab** = `src/features/canvas/components/panels/relationship-panel/tabs/data-events-tab.tsx` (this IS the metric card's data editor, reached via the gear → CardSettingsSheet). Added Generate dialog, CSV/JSON Import, Clear All; manual edits now re-derive change/trend via `deriveSeries`.

**Phase 2 (file import) shipped 2026-06-28:** CSV/TSV/JSON file upload + paste in the Data tab Import dialog, reusing the contract (zero deps). Parquet/DuckDB-WASM deferred (bundle cost; project already has chunk-size warnings).

**Phase 3 (warehouse, Postgres) DEPLOYED to live `iqrclwolhookzzmiedun` 2026-06-28** via Supabase MCP: tables `source_connections` (owner-RLS) + `source_connection_secrets` (RLS no-policy + REVOKE ALL FROM anon,authenticated = service-role only); edge fn `warehouse-proxy` ACTIVE (verify_jwt=true, version 1). Smoke-tested: 401 unauth, CORS 200, security advisor no ERRORs. Code: `services/sourceConnections.ts`, `tabs/warehouse-source-dialog.tsx`, edge fn `supabase/functions/warehouse-proxy/index.ts`. Live migration version recorded as `20260628110840` (local file says `...120000` — MCP retimestamped). **Still local-only:** `npm run prisma:types` then drop `any` casts in sourceConnections.ts. **Untested at runtime:** the Clerk-JWT happy path through verify_jwt=true — if warehouse calls 401 at the gateway, flip verify_jwt to false (fn still enforces ownership via RLS). **All open caveats documented with root-cause + fix in `the Obsidian product vault`** (Clerk-JWT/verify_jwt 401, any-cast type regen, migration version mismatch, runtime-unverified DuckDB/warehouse) — read that doc first when resuming warehouse work. RCA/drift unblocked once data flows ([[product-direction-pipelines]] — RCA reads `card.data`).

**ARCH DECISION (2026-06-28): count.co Source Node (Architecture B) + DuckDB.** Owner wants the Source Node ON the canvas to be the query surface that FEEDS the cards it's wired to (data-flow edges), not data-input on the card. Built: `source-node.tsx` rebuilt + `source-config-sheet.tsx` (4 origin tabs Warehouse/File/Manual/Generate, result grid, Save&feed); `utils/sourceResolver.ts` (resolveSource → MetricValue[]); `utils/duckdbEngine.ts` (lazy DuckDB-WASM, file→`data` view); `utils/feedDownstream.ts` (series→wired cards); `computePipeline.ts` reads `node.data.series`. Source node `data` shape now `{title,config,series,refreshedAt}`. **v0 retired/deleted:** `data-transformation-node.tsx`, `pipeline-canvas.tsx`, all 6 `node-function/source-node/*` panels (the `sourceNode` type registration stays; only UI replaced; legacy nodes show "reconfigure"). File origin is transient (re-upload to re-run). The card Data tab (Phase 1/2) still exists as a parallel on-ramp.

# Evidence Notebook — Custom Blocks (CVS-34 slice 4): Design & Build Plan

**Linear:** CVS-34 (slice 4) · **Status:** design ready to build (no owner setup needed — this is a pure build task). Hand to a dedicated agent or pick up directly.
**Author:** Claude · 2026-07-04

---

## 1. Goal

Turn Evidence from a text notebook into an **Amplitude-style analytical notebook**: narrative wrapped around *live/snapshotted* analytical objects. Users type `/` to insert blocks that **cite the actual Metrimap objects** they're reasoning about — nodes, relationships, charts, metric values, snapshots.

**Foundation already shipped (slices 1–3):** the EditorJS notebook `content` now persists to `evidence_items.content` (jsonb) and is loaded/saved via the DB across card / relationship / repository / full-page surfaces. Custom blocks just add new block *types* into that already-persisted content — no new persistence work needed.

## 2. How EditorJS custom blocks plug into this repo

Everything routes through **`src/lib/editorjs-config.ts`**:
- **`createEditorJSTools()`** (line ~75) — the tool registry. Register each custom block here: `metricNode: { class: MetricNodeBlock, ... }`.
- **`VALID_BLOCK_TYPES`** (line ~44) — add each new block's `type` string, or `validateAndMigrateEditorData()` (line ~279) will strip it on save/load.
- **`createEditorJSInstance`** (editor) and **`createReadOnlyEditorJSInstance`** (preview/reader) both call `createEditorJSTools()` — so a block that respects `readOnly` **renders in the node preview + full view automatically**. This is why `EvidenceContentRenderer` needs no per-block code.

**A custom block = one class** implementing EditorJS `BlockTool`:
```ts
class MetricNodeBlock {
  static get toolbox() { return { title: 'Node', icon: '<svg…>' }; }  // "/" menu entry
  static get isReadOnlySupported() { return true; }
  constructor({ data, api, readOnly, config }) { this.data = data; this.readOnly = readOnly; }
  render() { /* return a DOM node — editable card in edit mode, static in readOnly */ }
  save(blockElement) { return this.data; }  // persisted JSON
  static get sanitize() { return { /* keep our fields */ }; }
}
```
Put block classes under **`src/features/evidence/blocks/`** (new dir): `MetricNodeBlock.tsx`, `RelationshipBlock.tsx`, `ChartBlock.tsx`, `SnapshotBlock.tsx`, `NoteBlock.tsx`, plus a shared `renderReactIntoBlock()` helper (mount a React component into the block's DOM node via `createRoot`, unmount on `destroy()`).

> React-in-EditorJS: EditorJS is DOM-based; render our shadcn/React UI by creating a container in `render()` and mounting with `createRoot(container).render(<Comp/>)`. Clean up in `destroy()`.

## 3. The blocks (spec)

Each block's `save()` stores **references (ids) + a display snapshot**, and a `mode: 'live' | 'snapshot'`. Live = resolve current data at render; snapshot = frozen values/image with a timestamp (audit/history).

| Block | `/` command | Saved data (jsonb) | Edit UI | Read-only render |
| --- | --- | --- | --- | --- |
| **Note / Callout** | `/note` | `{ variant: 'note'|'decision'|'callout', text }` | inline editable text + variant picker | styled callout |
| **Node ref** | `/node` | `{ cardId, mode, snapshot:{ title, category, value, status } }` | node picker (search cards in project) | card chip: title · category · current value/status · "focus on canvas" link |
| **Relationship ref** | `/relationship` | `{ relationshipId, mode, snapshot:{ source, target, type, confidence, weight } }` | relationship picker | source → target, type, confidence badge, evidence count |
| **Chart embed** | `/chart` | `{ widgetId \| chartConfig, mode }` | pick a dashboard widget / build inline | render the Recharts chart (reuse the chart node renderer) |
| **Snapshot** | `/snapshot` | `{ imageDataUrl, capturedAt, sourceRef }` | "capture" button (html-to-image of a node/chart/canvas region) | static `<img>` + timestamp |
| **Metric value** | `/metric` | `{ cardId, period, mode, snapshot:{ value, trend } }` | metric picker + period | value + trend sparkline |
| **Hypothesis** | `/hypothesis` | `{ statement, prediction, status }` | structured fields | formatted hypothesis card |
| **Source cite** | `/source` | `{ kind:'connection'|'url'|'doc'|'interview'|'dataset', ref, label }` | source picker / URL | citation chip |
| **Evidence link** | `/evidence` | `{ evidenceId }` | evidence picker | link chip → opens that evidence |

Data resolvers already exist: cards/relationships via the canvas store + `services/relationships.ts`; charts via the chart-node renderer; metric values via `metric_values`. Blocks should resolve **by id** at render (live mode) and fall back to the stored snapshot if the target was deleted.

## 4. Build slices (do in order — each is shippable)

- **4.1 Scaffolding + `/note` + `/node`** — the block dir, the React-mount helper, register in `createEditorJSTools` + `VALID_BLOCK_TYPES` + `validateAndMigrateEditorData`. `/note` (no refs, proves the pipeline) then `/node` (proves id-reference + resolve + read-only). *Ship.*
- **4.2 `/relationship` + `/metric`** — reuse the picker + resolver pattern from 4.1.
- **4.3 `/chart`** — embed a dashboard widget / chart-node config (live).
- **4.4 `/snapshot`** — html-to-image capture (add `html-to-image` dep) of a node/chart; frozen image + timestamp. Adds the live-vs-snapshot toggle to node/chart/metric blocks.
- **4.5 `/source` + `/evidence` + `/hypothesis`** — citations + cross-links; many-to-many evidence links (may want an `evidence_links` table — see §6).

## 5. Read-only / preview

`EvidenceContentRenderer` (node card) + the full page both use the shared read-only instance. Ensure every block sets `static get isReadOnlySupported() { return true; }` and renders a non-interactive view when `readOnly`. **Acceptance:** a notebook with a `/node` + `/chart` renders those as chips/charts on the canvas Evidence card — never "No content available".

## 6. Open questions / decisions (flag to owner before 4.5)

- **Many-to-many evidence↔target links:** blocks embed refs inside `content`, which is enough for display. A separate **`evidence_links` table** (evidence_id, target_type, target_id) is only needed if we want to *query* "what evidence cites this node?" from the node side. Recommend deferring until a node-side "evidence" affordance is requested.
- **Snapshot storage:** inline `data:` URI in jsonb (simple, bloats rows) vs Supabase Storage bucket (clean, adds a bucket + RLS). Recommend **Storage** once `/snapshot` lands; inline `data:` is fine for a first cut.
- **Chart embed source:** reuse existing dashboard widgets vs build charts inline in the notebook. Recommend **reuse widgets** first (pick an existing chart), inline-builder later.

## 7. Files to touch

- `src/lib/editorjs-config.ts` — register tools, `VALID_BLOCK_TYPES`, `validateAndMigrateEditorData`.
- `src/features/evidence/blocks/*` (new) — one class per block + React-mount helper.
- `src/features/evidence/components/EvidenceContentRenderer.tsx` — no change expected (shared tools) — verify.
- (4.4) `package.json` — add `html-to-image`.
- (4.5, optional) migration `evidence_links` + service.

## 8. Nothing needed from the owner

Pure build. The only owner touchpoints are the three **decisions in §6** (evidence_links table, snapshot storage, chart source) — all deferrable; sensible defaults chosen. Manual-test sub-issues per build slice (insert each block → renders live → renders read-only on the card → survives reload).

---

**Related:** [[evidence-notebook-refactor]] · CVS-34 research brief (on the Linear issue) · reference: Amplitude charts, Notion `/` commands, Editor.js Tools API.

---
name: evidence-notebook-refactor
description: "CVS-34 Evidence Notebook epic — content now persists to evidence_items.content (DB); slices 1-3 done, slice 4 (custom blocks) pending"
metadata: 
  node_type: memory
  type: project
  originSessionId: 013bc508-1cef-453e-8fd4-8a980115bb62
---

**CVS-34 (Evidence Notebook refactor) is an EPIC** — sliced it. The two "linked bugs" CVS-35 (card renders populated fields) + CVS-36 (View Full → nested `/canvas/:id/evidence/:eid` route) are DONE/merged.

**Root gap fixed:** `evidence_items` stored metadata only — the EditorJS notebook (`content`) was never persisted (lived in the Zustand store / localStorage, lost on reload).

**Done + merged (2026-07-04):**
- **Slice 1** (#55): added `evidence_items.content jsonb` (migration `20260708120000_evidence_content.sql`, **APPLIED to prod** ref `iqrclwolhookzzmiedun`). Threaded content through the whole service layer — `rowToEvidence`/`createCardEvidence` (evidence.ts) + `transformEvidenceItem`/`createEvidenceItem`/`updateEvidenceItem` (relationships.ts, @ts-nocheck). Content is set AFTER the generated **strict** Zod parse (`evidence_itemsUpdate/CreateInput.schema`) — adding it before throws. types.ts hand-patched (prisma:types generation broken).
- **Slice 2** (#57): `EvidencePage` saves+loads the notebook via DB — new `getEvidenceItemById(id, client)` (evidence.ts); load gated on `useClerkSupabase()` client so the editor hydrates with DB content; save via `updateEvidenceItem`. Survives reload / direct nav.
- **Slice 3** (#61): Evidence Repository "New Evidence" is DB-backed — new `createProjectEvidence(evidence, projectId, userId, client)` (project-scoped, no card/rel); `handleSaveEvidence` create→DB (uses DB uuid in store), edit→`updateEvidenceItem`. Only when canvas-scoped (canvasId=projectId); else store-only fallback.

**Slice 4 (custom EditorJS blocks) IN PROGRESS — 7/9 done, tracked as CVS-197.** Pattern: plain-DOM `BlockTool` classes in `src/features/evidence/blocks/`, registered in `editorjs-config.ts` → `createEditorJSTools()` + `VALID_BLOCK_TYPES` (else `validateAndMigrateEditorData` strips them); both editor + read-only instances share tools so blocks render on the canvas Evidence card too. Blocks read app data via Zustand `getState()` (no React): cards/edges from `useCanvasStore.getState().canvas.{nodes,edges}`, evidence from `useEvidenceStore.getState().evidence`. Reference blocks store `{id + snapshot}` (live-resolve, snapshot fallback). DONE: `/note` `/node` `/relationship` `/metric` (4.1 #65, 4.2 #67) + `/hypothesis` `/source` `/evidence` (4.5 #68). **REMAINING: 4.3 `/chart` (needs React-in-EditorJS to render Recharts, or do a widget-reference chip) + 4.4 `/snapshot` (needs `html-to-image` dep + capture)** — the complex tier; build plan doc: vault `Evidence Notebook Blocks (slice 4)/Design & Build Plan.md`. All blocks untestable by me (no runtime) — verified via `npm run build`; manual-tests CVS-199/201/202.

**Slice 3b remaining:** `EvidencePage` brand-new path (navigate to fresh `/evidence/:id`) still store-only + repository listing still merges store + relationship evidence (dedup by id). Slice 4 = custom EditorJS blocks `/node` `/relationship` `/chart` `/snapshot` + many-to-many evidence links (Amplitude-style analytical notebook — see the research brief comment on CVS-34). Manual-test sub-issues: CVS-190 (slice 2), CVS-195 (slice 3). Store note: evidence ids are `evidence_${Date.now()}` in the store vs DB uuids — the DB-returned item (uuid) is authoritative. See [[pages-node-type-spec]].

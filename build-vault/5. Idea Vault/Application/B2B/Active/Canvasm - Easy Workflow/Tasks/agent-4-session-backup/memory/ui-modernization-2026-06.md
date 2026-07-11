---
name: ui-modernization-2026-06
description: "UI/UX modernization effort (Phases 0-4) — what shipped, what's deferred and why; full status in the Obsidian product vault"
metadata: 
  node_type: memory
  type: project
  originSessionId: e1d8fed4-d9f6-473c-bf02-80341727a4c4
---

Foundation-first UI/UX modernization to a Linear/Notion aesthetic (started 2026-06-28). Full living status in **the Obsidian product vault** — read it before touching UI.

**Critical foundation fix:** the design tokens were NOT wired into Tailwind v4 (no `@config`/`@theme`), so `bg-muted`/`text-foreground`/etc. generated zero CSS and dark mode was inert. Fixed via `@theme inline` in `src/styles/index.css`. Also: `<Toaster>` was never mounted (every `toast.*` was a silent no-op) and there was no `ThemeProvider`/theme toggle — all now added.

**Shipped:** Phase 0 foundation (tokens, status tokens, ConfirmDialog/useConfirm, EmptyState, StatusBadge, Sparkline, formatDate, statusHelpers, theme switcher); Phases 1-3 modernized Settings, Evidence, Assets, Dashboard (real Recharts), Sources; Phase 4 eliminated ALL native `confirm`/`alert` app-wide (now zero).

**Deferred — DON'T just do these, coordinate first:**
- Data-source model consolidation (sourceId linkage canvas↔Sources↔Dashboard, fill 5 stub CRUD dialogs) — overlaps active data-source pipeline WIP. See [[data-source-phase1]].
- Canvas Inspector consolidation + floating toolbar + on-canvas mode toggle — BLOCKED on removing `@ts-nocheck` from CanvasPage.tsx first (no type safety = unsafe refactor).
- Command palette (Cmd+K) on canvas — next recommended additive feature, not yet built.
- AssetsPage line-count extraction (modernized in place; orphaned MetricsTable/RelationshipsTable are stale).

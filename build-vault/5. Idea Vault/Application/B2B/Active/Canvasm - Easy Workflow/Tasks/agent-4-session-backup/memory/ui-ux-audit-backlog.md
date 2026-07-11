---
name: ui-ux-audit-backlog
description: "Verified UI/UX audit + backlog (2026-06-29) of the full PRD vs codebase; what's done/partial/missing and build order"
metadata: 
  node_type: memory
  type: project
  originSessionId: 4acf6cca-ea6d-4342-91f6-be01eb6c413d
---

Full PRD vs codebase audit (6-way parallel) done 2026-06-29 → `the Obsidian product vault`. Foundations are SOLID (hierarchy, semantic layer/catalog, value store, permissions). Original 9 mostly done/partial.

**Build clusters (owner picks order):**
1. **Collaboration surfacing (#7+#8) — SHIPPED 2026-06-29** (commits 6eaca67, 74ae439): global NotificationInbox (bell, homepage header; All/Mentioned/Assigned + 3d/7d filters, mark-read/all, navigate) + `/feed` activity board (people-events from notifications + system-events from changelog; All/Mentioned/Bookmarked; bookmarks in localStorage). No RLS change needed (changelog_select already uses can_view_project = workspace-visible).
2. **Data integrity + catalog finish — SHIPPED 2026-06-30** (commits c7b7345, 2f6b966): catalog inline edit (name/unit/owner/formula) + search on Tracked tab; stale/orphaned-binding state — SourceNodeData {stale,lastError}, failed Run keeps last series + flags stale, success clears, amber "Disconnected — showing last value" badge on the node. (Lineage view still TODO.) Follow-ups doc: the Obsidian product vault.
3. **Templates & onboarding (#2) — MECHANISM SHIPPED 2026-06-30** (commit 5ae74a4): "Save as Template" (card/table → deep-copy tagged 'template') + "From template" TemplatePicker dialog (lists user templates + public starter examples → duplicateProject → navigate). Templates excluded from working list; deep-copy strips example/template tags. STILL TODO: author the 6 curated starter trees as seed content (Web Analytics/Company KPIs/Marketing/Feature Launch/Lifecycle Cohort/Ecommerce).
4. **Workspace Settings shell (#6.2/6.1/9) — SHIPPED 2026-06-30** (commit a7548c7): /settings/workspace (UserMenu → Workspace Settings) with Appearance (Light/Dark/**Night** added — .night CSS + next-themes themes list), Connections list+delete, Notification prefs (localStorage toggles — backend prefs table TODO), Members via Clerk <OrganizationProfile>.

**ALL 4 CLUSTERS DONE.** Remaining from audit (parked, none blocking): metric-value time-travel, distribution (export PNG/PDF/CSV, embed, read/write API), Cmd+K palette, cross-canvas search, alerting, saved-scenario compare, the 6 curated starter templates (seed content), assigned-notification producer (see canvas-system-followups.md), backend notif-prefs table.

**"THE REST" pass 2026-06-30 (power+intelligence DROPPED by owner):** SHIPPED — live notification badge (notifications added to realtime publication; commit e42cde9); **export** PNG/PDF/CSV (CanvasExportMenu, html-to-image+jspdf; d234777); **embed** public read-only `/embed/:canvasId` + share-panel "Embed" copy (530c890); **read/write API** (metrics-api edge fn verify_jwt off, x-api-key SHA-256, GET/POST values scoped to workspace; api_keys table; Workspace Settings → API keys reveal-once; docs/features/metrics-api.md; 48e2114). STILL TODO (content, NOT auto-generate per CLAUDE.md): 6 curated starter trees — seed as is_public so they show in TemplatePicker "Starter examples"; author WITH owner per metric-tree methodology. DEFERRED (need prereqs): assigned-notification producer (needs an assignment UX), backend notif-prefs (needs email infra).

**Catalog lineage SHIPPED 2026-06-30** (commit d1d1420): each Tracked Metric expands to "Used in N places" → cards/canvases referencing it (getMetricUsage), click-through to canvas. Metric Catalog now COMPLETE (browse/promote/edit/search/lineage). Roadblocks doc: the Obsidian product vault. **Actionable PRD backlog essentially CLEARED** — only enterprise items remain unbuilt (billing/usage, custom 2FA + audit log) and are likely premature; plus the 2 parked roadblocks + dropped power/intelligence.

**Other gaps (parked):** metric-value time-travel (canvas snapshots exist via version-history store, values upsert-in-place); distribution (export PNG/PDF/CSV — only JSON now; embed; read/write API — all MISSING); Cmd+K command palette (stub); cross-canvas global search (current-canvas only); alerting/monitoring (only `gate` operator); saved scenarios+compare (sim runs, no save/compare UI). Assigned-to-me notif filter exists but no 'assigned' producer yet (cards have assignees field — wire on assignment change).

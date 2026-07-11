---
name: alerting-slice
description: Alerting/monitoring feature — threshold alerts on metric cards → notifications
metadata: 
  node_type: memory
  type: project
  originSessionId: 2cfc1040-2ad2-4fc3-8fa3-6ebb77a811c6
---

Alerting/monitoring ("govern/act" leg of the value pipeline) — in-app half SHIPPED 2026-07-03 (on main).

**Model:** `alert_rules` table (migration `20260703150000_alert_rules`, APPLIED to metrimap-v2) — per metric card, `rule_type` in {threshold, change, band} + jsonb `config`, project-scoped RLS via `has_project_access`. Notifications use existing `notifications` table with `type='alert'` (no schema change there). Cross-user notify needed a **`SECURITY DEFINER` RPC `emit_card_alert(rule_id, title, desc, metadata)`** because `notifications_insert` RLS blocks inserting for other users — it fans to rule creator + card owner/creator.

**Flow:** rule editor (Alerts tab in CardSettingsSheet, `AlertsTab.tsx`) → client-side eval `evaluateAlertRules` wired into `canvasStore.persistNodeUpdate` (after value change; debounced by `last_triggered_value`) → `emit_card_alert` RPC → surfaced in NotificationInbox + FeedPage ('alert' filter + amber ⚠ icon) + a Monitored/Breached badge on MetricCard (fed by project-wide `useAlertRulesStore`, one query/canvas). Pure logic (`isRuleTripped`, `describeRule`) unit-tested.

**Decisions:** eval trigger = client-side now + scheduled server-side LATER (edge fn + pg_cron — NOT built, the follow-up); conditions = threshold + change% + band; recipients = rule creator + owner. Commits `e234869`(backend) `fcc2182`(inbox/feed) `762fe5c`(editor) `8a6f8d7`(badge).

**Server-side sweep — DONE:** migration `20260703160000_alert_sweep_cron` (APPLIED) — `run_alert_sweep()` SECURITY DEFINER PL/pgSQL evaluates all enabled rules against `metric_cards.data` last point (threshold/change/band, same debounce), fires notifications for creator+owner. Scheduled via **pg_cron** job `metrimap-alert-sweep` every 15 min. Pure SQL (no edge function). Closes the gap where a rule added to an already-breaching metric wouldn't fire client-side. ALERTING SLICE COMPLETE.

Next per user plan (2026-07-03): finish catalog moat (live cross-canvas propagation) → platform epics (object hierarchy, value versioning/time-travel, permission model depth) → canvas polish. Deferred bugs + debug-log cleanup done in tandem with manual test later. See [[gap-list-build-2026-06-30]], [[canvas-store-split-brain]].

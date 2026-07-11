---
name: system-health-linear-intake
description: Server-side bridge syncing Supabase error_report_groups to deduplicated Linear issues (System Health intake MVP)
metadata: 
  node_type: memory
  type: project
  originSessionId: 013bc508-1cef-453e-8fd4-8a980115bb62
---

Built 2026-07-03 from the owner's vault spec ("System Health Task Intake Prompt", part of a broader Development Operating System: Linear=work, Obsidian=learning, repo=implementation). Implements crash → Linear intake.

Flow: browser ErrorBoundary → `error_reports` (raw) → AFTER INSERT trigger `rollup_error_report()` groups by client-computed `fingerprint` into `error_report_groups` (sync_status='pending') → pg_cron every 5 min → `dispatch_error_report_sync()` (pg_net) → edge fn `sync-error-reports` (holds LINEAR_API_KEY, service role) → creates one Linear issue per fingerprint in Intake/Triage, comments on repeats (rate-limited 45min), records sync_status/errors.

Key files: `src/shared/utils/errorFingerprint.ts` (hash of message+topframe+topcomponent+route, scrubs dynamic ids/bundle hashes so it's stable across deploys; excludes PII), `supabase/functions/sync-error-reports/index.ts`, migrations `20260703130000_error_report_intake` + `20260703140000_error_report_sync_cron`, `scripts/sync-error-reports.mjs` (`npm run sync:errors [--retry-failed]`), `docs/features/system-health-intake.md`. CLAUDE.md now has a Development Operating System section.

**LIVE as of 2026-07-03** (deployed by me via MCP, since the .env SUPABASE_ACCESS_TOKEN is STALE/Unauthorized — CLI secrets/deploy don't work). Config is in **Supabase Vault** (secrets: `linear_api_key`, `linear_team_id`, `error_sync_secret`, `error_sync_url`), read by edge fn via SECURITY DEFINER RPC `public.error_sync_config()` (service_role only) — migration `20260703150000_error_sync_config`. Function deployed via MCP deploy_edge_function (verify_jwt off). Linear: team **Canvasm** id `7f02b994-356e-4594-bd76-fe95f22e08b5` (key CVS), 4 labels created, Triage enabled (state auto-resolved). LINEAR_API_KEY `lin_api_1G4…` lives in .env + Vault (owner said no rotation needed, hobby project). Verified end-to-end (created+deleted CVS-18 in Triage). To rotate/change config: `vault.update_secret`. Bridge only attaches EXISTING Linear labels.

**Loop A (auto-resolve) DONE 2026-07-03** (commit 435fb73): edge fn now has 2 passes — SYNC + RESOLVE. A fingerprint quiet for ERROR_RESOLVE_AFTER_DAYS (default 7) with an untouched Triage/Backlog issue → auto-comment + move to Done + group 'resolved'. Recurrence → rollup trigger flips to 'pending' → sync pass reopens to Triage ("Regression"). Migration 20260703160000 added 'resolved' status + widened cron dispatch to wake on quiet-but-open groups. Verified end-to-end in prod.

**Loop B (agentic auto-fix) = NEXT, chosen config:** scheduled Claude Code routine (via /schedule) + Linear MCP (`claude mcp add --transport http linear-server https://mcp.linear.app/mcp`); autonomy = PROPOSE PR for human review (no auto-merge). Not built yet.

REAL BUG surfaced by the live pipeline: **React #185 (Maximum update depth / infinite re-render) on canvas pages** — recurring on prod (`use.canvasm.app/canvas/*`), multiple users Jul 2-3. Live cron auto-filed it as **Linear CVS-19**. 3 older reports have fingerprint=null (predate feature).

**CVS-19 fix = PR #9** (branch `fix/cvs-19-canvas-render-loop`), issue moved to In Review. Root cause: controlled `<ReactFlow>` got new `nodes`/`edges` identities every render because (1) `useCanvasEvents` returned unmemoized handlers → `edges` memo rebuilt every render; (2) CanvasPage `stableHandleOpenSettingsSheet/SwitchToCard` used `[state]` dep but `useCanvasPageState` returns a fresh object each render → `nodes` memo rebuilt; (3) `convertToEvidenceNode` never set the controlled `selected` prop (asymmetry → selection bounce). Fix: ref-stable handlers + concrete-setter deps + evidence `selected`. Added `useCanvasEvents.test.tsx` stability guard. **NOT runtime-verified** (needs auth + canvas 34d5c80b-...) — owner must smoke-test before merge. Secondary amplifier left as follow-up: `handleNodesChange` calls setExtraNodes on foreign changes. **NOTE: this was shipped as a PR (not direct-to-main) because it's unverified + matches the chosen Loop B "propose PR for review" flow — a deviation from [[commit-and-merge-preference]] direct-to-main, done deliberately for an unverifiable prod-loop fix.** Related: [[error-reports-sink]], [[canvas-store-split-brain]].

---
name: supabase-rebuild-2026
description: "Metrimap's Supabase project was rebuilt on a new ref in June 2026 after the old one was deleted"
metadata: 
  node_type: memory
  type: project
  originSessionId: 026e73b4-2fda-468e-9def-65bb4a109f72
---

On 2026-06-25 the Supabase backend was rebuilt. The old project `metrimap` (ref `pdzcgkngdjmeogbdojum`) was **permanently deleted** by Supabase (free tier, paused > 90 days, not restorable — confirmed via API). No data was recoverable; the user opted for a schema-only fresh start.

New project: **`metrimap-v2`**, ref **`iqrclwolhookzzmiedun`**, org `personal` (`knqarurgnmzdtrpbieph`), region `ap-southeast-1`, free tier, URL `https://iqrclwolhookzzmiedun.supabase.co`.

Schema was rebuilt by applying the 3 migrations in `supabase/migrations/` in order (prisma role → `20250811100849_remote_schema` → `20250813_canvas_nodes`). The 3 files under `src/shared/lib/supabase/migrations/` are **superseded drafts** — do not apply them. All 16 public tables exist with RLS enabled.

**Update 2026-06-26 — went CLOUD-ONLY.** The local Supabase stack (`127.0.0.1:54321`) was `supabase stop`-ped (volumes preserved; user also ran `supabase db dump --local`). `.env` local-dev block removed — the app always targets cloud `metrimap-v2` now. DB password reset to a working value; `SUPABASE_ACCESS_TOKEN` (sbp_…) set and CLI linked.

**Clerk auth mismatch (the one open blocker for cloud auth):** Supabase third-party auth trusts issuer `https://clerk.canvasm.app` (PROD Clerk), but `.env` `VITE_CLERK_PUBLISHABLE_KEY` is a `pk_test` for the DEV instance `modern-phoenix-19.clerk.accounts.dev`. So authenticated requests get rejected. Fix = align on one instance: either put the prod `pk_live` key in `.env`, OR add the dev issuer in the Supabase dashboard. The Management API auth-config endpoint returned `Unauthorized` for the current token, so this is dashboard-only. **RESOLVED 2026-06-26:** aligned on the prod `pk_live` instance everywhere (`.env` + Supabase third-party auth); sign-in works and authenticated writes hit RLS correctly. See [[metrimap-handoff-2026-06]] for current app state.

**RLS hardening migration — APPLIED 2026-06-26** (via MCP `execute_sql`; saved as `supabase/migrations/20260626120000_rls_clerk_hardening.sql`, verification in `scripts/rls-test/rls_clerk_verification.sql`). Post-apply audit: 0 wide-open policies, 0 `auth.uid()` policies, 0 escape-hatch policies, 0 tables without policy, 56 clean policies, 3 SECURITY DEFINER helpers (`can_view_project`/`has_project_access`/`is_project_owner`), `notifications.user_id` migrated uuid→text. The leaked seed rows were deleted (DB is a clean slate: 0 projects/users). This closed the public-key read/write hole and unlocked `canvas_nodes`/`comments`/`notifications` for Clerk. NOTE: the cloud DB now REQUIRES a valid Clerk JWT (`requesting_user_id()`) for writes — so authenticated sign-in must work; anon only sees `is_public` rows. The new `users_insert` policy (`id = requesting_user_id()`) should let the client-side first-login user upsert succeed (it was previously RLS-blocked).

See `BACKLOG.md` (created 2026-06-26, 39 items) for the full known-issues list, incl. P0 "service-role JWT in `.env`" (rotate + remove dev bypass).

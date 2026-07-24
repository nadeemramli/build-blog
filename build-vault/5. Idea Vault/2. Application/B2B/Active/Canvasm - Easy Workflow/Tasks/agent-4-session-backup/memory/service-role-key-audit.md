---
name: service-role-key-audit
description: Service-role key was never leaked via git; rotation is not urgent — real fix is deleting the dev client code path
metadata: 
  node_type: memory
  type: project
  originSessionId: f1f02f34-6a79-49ec-b718-1dec8f0de4f6
---

Re-audited 2026-06-27 (BACKLOG P0-5). The backlog's original "service-role JWT committed to repo" claim is **wrong**.

- `.env` was never git-tracked; `git check-ignore` covers it.
- The only `service_role` JWT in git history belongs to the **old, deleted** Supabase project `pdzcgkngdjmeogbdojum` — already dead, harmless.
- The current live key (project `iqrclwolhookzzmiedun`, see [[supabase-rebuild-2026]]) was **never committed**.

**Why:** rotation costs effort and there's no evidence of leak. **How to apply:** don't recommend rotating the service-role key unless the local `.env` leaked another way (cloud-synced backup, pasted into chat, shared machine).

**RESOLVED 2026-06-27 (P0-5 + P1-14):** the dev/service-role code surface is now deleted — `createDevSupabaseClient`, `isDevelopmentEnvironment`, `DevAuthProvider`, `DevUserback*`, and the `testSupabaseConnection`/`testEnvironmentDetection` exports are gone; the app is Clerk-only (`getClientForEnvironment` always returns the Clerk client). **No code reads any service-role key anymore**, so there is no browser-bundle leak path. Feature flags now use Vite's `import.meta.env.DEV`. `SUPABASE_SERVICE_ROLE_KEY` stays in `.env` on purpose — it's non-`VITE_` (never bundled) and is used by the server-side seed script `scripts/seed/seed-example-trees.mjs`. **Consequence:** local dev no longer bypasses auth — you must sign in with Clerk locally (true cloud-only dev).

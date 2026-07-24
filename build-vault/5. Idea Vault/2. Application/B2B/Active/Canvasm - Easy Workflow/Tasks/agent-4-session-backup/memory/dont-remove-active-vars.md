---
name: dont-remove-active-vars
description: "Never remove env vars / config / variables that are actively used, even if they look like dead or security debt"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: f1f02f34-6a79-49ec-b718-1dec8f0de4f6
---

Do NOT remove environment variables, config, or code that is actively in use — even when it looks like dead code or security debt. Always verify there are zero real consumers (app code AND scripts/tooling/CI) before deleting.

**Why:** During the P0-5/P1-14 cleanup, `SUPABASE_SERVICE_ROLE_KEY` looked like a removable security liability, but it's consumed server-side by `scripts/seed/seed-example-trees.mjs`. It's non-`VITE_` so it never reaches the browser bundle — keeping it was correct. The user explicitly asked to bear this in mind.

**How to apply:** grep the whole repo (src + scripts + supabase + config), not just `src/`, before removing any var/symbol. If it's used anywhere legitimate, keep it and explain why instead of deleting. See [[service-role-key-audit]].

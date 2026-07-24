---
name: mcp-server-deployed
description: Metrimap MCP server is LIVE at mcp.canvasm.app on a Hetzner VPS; deploy runbook + auth chain
metadata: 
  node_type: memory
  type: project
  originSessionId: 0c6415d0-0c00-4b81-bf75-b43856b1d88b
---

The Metrimap MCP server (CVS-99 auth + CVS-100 Node server + CVS-104 hardening) is **deployed and live** as of 2026-07-05.

- **Public endpoint:** `https://mcp.canvasm.app/mcp` (health: `GET /health` → `{"ok":true,...}`).
- **Host:** Hetzner VPS `5.223.49.175` (SSH `ssh -i ~/.ssh/metrimap_mcp root@5.223.49.175`). DNS `mcp` A-record → that IP (Cloudflare/registrar, TTL 60).
- **Stack on the box:** `docker compose` at `/opt/metrimap/mcp-server/deploy` — `mcp` container (node, `expose 8787` internal only) behind a `caddy:2` container that publishes 80/443 and does automatic Let's Encrypt TLS. `curl localhost:8787` on the host FAILS by design (not published); test via the public URL or `docker compose logs mcp`.
- **Code:** `mcp-server/` (server.ts = thin HTTP/Streamable-HTTP adapter) wired over the tested registry in `src/shared/lib/api/mcp/`. Lives in the `../metrimap-integrations` worktree; all merged to `main` (`de17538`). See [[integrations-lane-worktree-2026-07]].

**Deploy = one chained command** (not a named script): `cd ~/workspace/.../metrimap-integrations` → `. ~/.metrimap-deploy.env` → wait-for-docker → `rsync ./` to `/opt/metrimap` → write `deploy/.env` (SUPABASE_URL/ANON_KEY/JWT_SECRET) → `sed` MCP_DOMAIN into Caddyfile → `docker compose up -d --build`. It rsyncs the **working tree**, so to redeploy you just re-run it after editing files. `~/.metrimap-deploy.env` (git-ignored) holds HCLOUD_TOKEN + the Supabase secrets; provisioning script is `mcp-server/deploy/provision.sh`.

**Gotcha fixed:** the Docker build needs `--ignore-scripts` on the root `npm install --omit=dev` (Dockerfile) — else the root `"prepare":"husky"` hook runs husky (a devDep that --omit=dev skips) → `husky: not found` exit 127.

**Two auth paths (composite resolver routes by token):**
1. **API key (`mk_live_`)** — CLI/`claude mcp add ... --header "Authorization: Bearer mk_live_..."`. app `createApiKey` (`services/apiKeys.ts`) stores `key_hash = sha256hex(key)` + `created_by`/`workspace_id` → server `hashApiKey` → `mcp_resolve_api_key` SECURITY-DEFINER RPC (migration 20260704160000, anon-executable) → mints Supabase JWT → RLS client. Full workspace scope.
2. **OAuth sign-in (SHIPPED 2026-07-05, commit 21ec669)** — for claude.ai/Desktop connectors (they auth via OAuth only, no key field). **Clerk is the OAuth 2.1 authorization server** (supports MCP + DCR); our server is the resource server: serves `/.well-known/oauth-protected-resource` (RFC 9728, via `@clerk/mcp-tools`), returns **401 + WWW-Authenticate** on `/mcp` w/o valid creds (this triggers the handshake — the missing 401 was the original bug), verifies Clerk token via `@clerk/backend` `authenticateRequest({acceptsToken:'oauth_token'})` → clerk user id → same `mintSupabaseJwt`. New files: `src/shared/lib/api/mcp/auth/oauthResolver.ts` + `compositeResolver.ts`, `mcp-server/clerkAuth.ts`. **v1 = personal scope** (JWT `sub` only, no `o.id`; RLS additive so user sees canvases they created; workspace scope = v2 follow-up).

**OAuth requires (owner action):** (a) Clerk Dashboard → create prod **secret key** `sk_live_` + **enable Dynamic Client Registration** (OAuth applications) + scopes profile/email; (b) new server env **`CLERK_SECRET_KEY`** + **`CLERK_PUBLISHABLE_KEY`** (pk_live_) + optional `MCP_PUBLIC_URL` — add to `~/.metrimap-deploy.env` AND the deploy one-liner's `.env` printf, then redeploy. Verify: `curl https://mcp.canvasm.app/.well-known/oauth-protected-resource` → JSON w/ authorization_servers=[clerk.canvasm.app]; unauth POST /mcp → 401 + WWW-Authenticate.

Still follow-up: OAuth workspace scope (v2 default-workspace RPC); in-memory rate limiter is per-instance.

#!/usr/bin/env node
/**
 * List Zernio profiles + connected accounts so you can copy the
 * accountId values into posts.json.
 *
 * Usage:  ZERNIO_API_KEY=sk_... node accounts.mjs
 * Docs:   https://docs.zernio.com  (Key Concepts: Profiles, Accounts)
 */
const API = "https://zernio.com/api/v1";
const KEY = process.env.ZERNIO_API_KEY;
if (!KEY) { console.error("Set ZERNIO_API_KEY (see .env.example)."); process.exit(1); }

async function api(path) {
  const res = await fetch(`${API}${path}`, { headers: { Authorization: `Bearer ${KEY}` } });
  const body = await res.json().catch(() => ({}));
  if (!res.ok) { console.error(`GET ${path} → ${res.status}: ${JSON.stringify(body)}`); process.exit(1); }
  return body;
}

const { profiles = [] } = await api("/profiles");
const { accounts = [] } = await api("/accounts");

console.log("\nPROFILES");
for (const p of profiles) console.log(`  ${p._id}  ${p.name}`);

console.log("\nACCOUNTS  (copy the id into posts.json → platforms[].accountId)");
if (!accounts.length) console.log("  (none yet — connect Instagram + TikTok in the Zernio dashboard)");
for (const a of accounts) {
  const handle = a.username || a.name || a.displayName || "";
  console.log(`  ${String(a.platform).padEnd(12)} ${a._id}  ${handle}`);
}
console.log("");

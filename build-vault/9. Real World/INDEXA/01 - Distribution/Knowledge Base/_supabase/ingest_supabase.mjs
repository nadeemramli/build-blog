#!/usr/bin/env node
/**
 * INDEXA — Push the exported Stacks into Supabase.
 *
 * Prereqs:
 *   node >= 18
 *   npm i @supabase/supabase-js
 *   python3 export_vault.py   # produces ./data/stacks.json first
 *
 * Env (never commit):
 *   SUPABASE_URL=https://gqkhhfuafflcfkjczsxg.supabase.co
 *   SUPABASE_SERVICE_ROLE_KEY=...   # service_role, bypasses RLS
 *
 * Run:
 *   node --env-file=.env ingest_supabase.mjs
 *
 * Idempotent: upserts stacks by id, then replaces their components + evidence.
 */
import { createClient } from "@supabase/supabase-js";
import { readFileSync } from "node:fs";
import { fileURLToPath } from "node:url";
import { dirname, join } from "node:path";

const DIR = dirname(fileURLToPath(import.meta.url));
const { SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY } = process.env;
if (!SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY)
  throw new Error("Set SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY");

const sb = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, { auth: { persistSession: false } });
const chunked = (a, n) => Array.from({ length: Math.ceil(a.length / n) }, (_, i) => a.slice(i * n, i * n + n));

const { stacks, stack_components, stack_evidence } =
  JSON.parse(readFileSync(join(DIR, "data", "stacks.json"), "utf-8"));

(async () => {
  console.log(`INDEXA stacks -> Supabase (${new Date().toISOString()})`);

  // 1) parent rows
  for (const b of chunked(stacks, 500)) {
    const { error } = await sb.from("stacks").upsert(b, { onConflict: "id" });
    if (error) throw new Error("stacks: " + error.message);
  }
  console.log(`  upsert stacks: ${stacks.length}`);

  // 2) FK guard: null product_ids that aren't in the catalog
  const { data: prods } = await sb.from("products").select("id");
  const known = new Set((prods || []).map((p) => p.id));
  let nulled = 0;
  for (const c of stack_components)
    if (c.product_id && !known.has(c.product_id)) { c.product_id = null; nulled++; }
  if (nulled) console.log(`  (nulled ${nulled} component product_ids not in catalog)`);

  // 3) replace children for these stacks
  const ids = stacks.map((s) => s.id);
  await sb.from("stack_components").delete().in("stack_id", ids);
  await sb.from("stack_evidence").delete().in("stack_id", ids);
  for (const b of chunked(stack_components, 500)) {
    const { error } = await sb.from("stack_components").insert(b);
    if (error) throw new Error("stack_components: " + error.message);
  }
  for (const b of chunked(stack_evidence, 500)) {
    const { error } = await sb.from("stack_evidence").insert(b);
    if (error) throw new Error("stack_evidence: " + error.message);
  }
  console.log(`  components: ${stack_components.length}  evidence: ${stack_evidence.length}`);
  console.log("Done.");
})().catch((e) => { console.error("FAILED:", e.message); process.exit(1); });

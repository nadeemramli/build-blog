#!/usr/bin/env node
/**
 * Indexa -> Zernio publisher (CI/repo edition)
 * Uploads local media via Zernio presigned URLs and creates each post in
 * posts.json as a draft, a scheduled post, or publishes now.
 *
 * Safety + automation gates (run before anything is uploaded):
 *   1. Restricted-terms lint  - a 'block' term aborts the run (unless --force).
 *   2. Idempotency ledger      - posts already pushed (per published.json) are
 *                                skipped, so re-runs never duplicate.
 *   3. Account auto-resolve    - a REPLACE/empty accountId is filled from your
 *                                connected accounts by platform.
 *
 * Usage:
 *   ZERNIO_API_KEY=sk_... node publish.mjs               # mode from posts.json (default: draft)
 *   node publish.mjs --mode=schedule|now
 *   node publish.mjs --only=POST-ID
 *   node publish.mjs --dry-run                            # validate + lint, no network/ledger writes
 *   node publish.mjs --force                              # ignore block-term findings
 *   node publish.mjs --republish=POST-ID                 # clear that post from the ledger and push again
 *   node publish.mjs --no-ledger                          # ignore the ledger entirely
 *
 * Requires Node 18+ (global fetch). No dependencies.
 */
import { readFile, writeFile } from "node:fs/promises";
import { basename, dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { loadTerms, lintPosts, report } from "./lint.mjs";

const API = "https://zernio.com/api/v1";
const KEY = process.env.ZERNIO_API_KEY;
const HERE = dirname(fileURLToPath(import.meta.url));

const args = Object.fromEntries(
  process.argv.slice(2).map((a) => {
    const m = a.match(/^--([^=]+)(?:=(.*))?$/);
    return m ? [m[1], m[2] ?? true] : [a, true];
  })
);
const DRY = !!args["dry-run"];
const FORCE = !!args.force;
const USE_LEDGER = !args["no-ledger"];
const LEDGER_PATH = resolve(HERE, "published.json");

const MIME = { png: "image/png", jpg: "image/jpeg", jpeg: "image/jpeg", gif: "image/gif", webp: "image/webp", mp4: "video/mp4", mov: "video/quicktime", webm: "video/webm" };
const ext = (f) => f.split(".").pop().toLowerCase();
const kindOf = (f) => (["mp4", "mov", "webm", "avi"].includes(ext(f)) ? "video" : "image");
const PASSTHROUGH = ["tiktokSettings", "instagramSettings", "threadsSettings", "firstComment"];
const keyOf = (p, mode) => p.id + "@" + mode + "@" + (p.scheduledFor || "");

function die(msg) { console.error("\n[x] " + msg + "\n"); process.exit(1); }

async function api(path, init = {}) {
  const res = await fetch(API + path, {
    ...init,
    headers: { Authorization: "Bearer " + KEY, "Content-Type": "application/json", ...(init.headers || {}) },
  });
  const body = await res.json().catch(() => ({}));
  if (!res.ok) die((init.method || "GET") + " " + path + " -> " + res.status + ": " + JSON.stringify(body));
  return body;
}

async function readLedger() {
  if (!USE_LEDGER) return { pushed: {} };
  try { const l = JSON.parse(await readFile(LEDGER_PATH, "utf8")); l.pushed ||= {}; return l; }
  catch { return { pushed: {} }; }
}
async function writeLedger(l) { if (USE_LEDGER && !DRY) await writeFile(LEDGER_PATH, JSON.stringify(l, null, 2) + "\n"); }

async function uploadMedia(absPath) {
  const fileName = basename(absPath);
  const fileType = MIME[ext(absPath)] || "application/octet-stream";
  const buf = await readFile(absPath);
  if (DRY) { console.log("   - would upload " + fileName + " (" + (buf.length / 1024).toFixed(0) + " KB, " + fileType + ")"); return "dry://" + fileName; }
  const pres = await api("/media/presign", { method: "POST", body: JSON.stringify({ filename: fileName, contentType: fileType }) });
  const put = await fetch(pres.uploadUrl, { method: "PUT", headers: { "Content-Type": fileType }, body: buf });
  if (!put.ok) die("upload PUT failed for " + fileName + " -> " + put.status);
  console.log("   - uploaded " + fileName);
  return pres.publicUrl;
}

async function resolveAccounts(posts) {
  const need = new Set();
  for (const p of posts) for (const x of p.platforms) if (!x.accountId || /REPLACE/i.test(x.accountId)) need.add(x.platform);
  if (!need.size) return;
  const { accounts = [] } = await api("/accounts");
  const byPlat = {};
  for (const a of accounts) (byPlat[a.platform] ||= []).push(a);
  for (const p of posts) for (const x of p.platforms) {
    if (x.accountId && !/REPLACE/i.test(x.accountId)) continue;
    const list = byPlat[x.platform] || [];
    if (!list.length) die("No connected " + x.platform + " account in Zernio. Connect it in the dashboard, then retry.");
    x.accountId = list[0]._id;
    console.log("   - resolved " + x.platform + " -> " + (list[0].username || list[0].name || x.accountId));
  }
}

function validateTikTok(posts) {
  for (const p of posts) {
    if (!p.platforms.some((x) => x.platform === "tiktok")) continue;
    const isPhoto = !(p.media || []).some((m) => kindOf(m) === "video");
    const title = p.caption || "";
    if (isPhoto && title.length > 90)
      die(p.id + ": TikTok photo posts use `content` as the slideshow title (max 90 chars); yours is " +
          title.length + ". Shorten `caption`, and put the long text in tiktokSettings.description.");
  }
}

async function run() {
  if (!KEY && !DRY) die("Set ZERNIO_API_KEY (see .env.example). Or run with --dry-run.");
  const file = resolve(HERE, String(args.file || "posts.json"));
  const cfg = JSON.parse(await readFile(file, "utf8"));
  const tz = cfg.timezone || "Asia/Kuala_Lumpur";
  const mode = String(args.mode || (cfg.defaults && cfg.defaults.mode) || "draft");
  if (!["draft", "schedule", "now"].includes(mode)) die('Unknown mode "' + mode + '".');

  let posts = cfg.posts || [];
  if (args.only) posts = posts.filter((p) => p.id === args.only);
  if (!posts.length) die("No posts to publish (check --only / posts.json).");

  // ---- ledger: drop already-pushed posts ----
  const ledger = await readLedger();
  if (args.republish) { for (const k of Object.keys(ledger.pushed)) if (k.startsWith(args.republish + "@")) delete ledger.pushed[k]; }
  const queue = [], skipped = [];
  for (const p of posts) (ledger.pushed[keyOf(p, mode)] ? skipped : queue).push(p);
  if (skipped.length) console.log("Ledger: skipping " + skipped.length + " already-pushed (" + skipped.map((p) => p.id).join(", ") + ")");

  // ---- GATE 1: restricted-terms lint (on the queue) ----
  const terms = await loadTerms(HERE);
  const nBlocks = report(lintPosts(queue.length ? queue : posts, terms), terms);
  if (nBlocks && !FORCE) die(nBlocks + " block-term finding(s). Fix the copy, or re-run with --force.");
  if (nBlocks && FORCE) console.log("\n[!] --force: ignoring " + nBlocks + " block-term finding(s).");

  validateTikTok(queue);
  if (!queue.length) { console.log("\nNothing new to push. Up to date.\n"); return; }
  console.log("\nIndexa -> Zernio  |  mode=" + mode + "  |  tz=" + tz + (DRY ? "  |  DRY RUN" : "") + "  |  " + queue.length + " to push\n");

  if (!DRY) await resolveAccounts(queue);

  for (const p of queue) {
    console.log("> " + p.id + "  [" + p.platforms.map((x) => x.platform).join(", ") + "]");
    if (DRY && p.platforms.some((x) => /REPLACE/i.test(x.accountId))) console.log("   - (accountId auto-resolves at publish time)");
    const mediaItems = [];
    for (const m of p.media || []) mediaItems.push({ url: await uploadMedia(resolve(HERE, m)), type: kindOf(m) });
    const payload = { content: p.caption, mediaItems, platforms: p.platforms };
    for (const k of PASSTHROUGH) if (p[k] !== undefined) payload[k] = p[k];
    if (mode === "schedule") { payload.scheduledFor = p.scheduledFor; payload.timezone = p.timezone || tz; }
    if (mode === "now") payload.publishNow = true;
    if (DRY) { console.log("   - would createPost (" + mediaItems.length + " media)\n"); continue; }
    const out = await api("/posts", { method: "POST", body: JSON.stringify(payload) });
    const postId = out.post && out.post._id;
    const what = mode === "draft" ? "draft saved" : mode === "now" ? "publishing now" : "scheduled " + p.scheduledFor;
    console.log("   [ok] " + what + "  |  id=" + postId + "\n");
    ledger.pushed[keyOf(p, mode)] = { id: p.id, postId, mode, at: new Date().toISOString() };
    await writeLedger(ledger);
  }
  console.log("Done. " + queue.length + (DRY ? " would be pushed (dry run, no writes)." : " pushed. Ledger updated.") + "\n");
}

run().catch((e) => die(e.stack || String(e)));

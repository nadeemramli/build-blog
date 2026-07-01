#!/usr/bin/env node
/**
 * Restricted-terms linter for Indexa social posts.
 * Scans each post's caption, on-image text, and note against
 * restricted-terms.json. 'block' terms = hard fail; 'caution' = warning.
 *
 * Standalone:  node lint.mjs [--file=posts.json]
 *   exit 0 = clean (or only cautions);  exit 1 = a block term was found.
 * Imported:    import { lintPosts } from "./lint.mjs"
 *
 * Matching is case-insensitive and whole-word (so "dose" won't trip on "diagnose").
 */
import { readFile } from "node:fs/promises";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const HERE = dirname(fileURLToPath(import.meta.url));

export async function loadTerms(dir = HERE) {
  return JSON.parse(await readFile(resolve(dir, "restricted-terms.json"), "utf8"));
}

const esc = (s) => s.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
function hits(text, terms) {
  if (!text) return [];
  const found = [];
  for (const t of terms) {
    // whole-word-ish: term bounded by non-letter/digit (handles hashtags & punctuation)
    const re = new RegExp("(^|[^a-z0-9])" + esc(t.toLowerCase()) + "([^a-z0-9]|$)", "i");
    if (re.test(text)) found.push(t);
  }
  return found;
}

/** Returns { blocks:[], cautions:[] } of findings across all posts. */
export function lintPosts(posts, terms) {
  const blocks = [], cautions = [];
  for (const p of posts) {
    const fields = { caption: p.caption, onImageText: p.onImageText, note: p.note, tiktokDescription: p.tiktokSettings && p.tiktokSettings.description };
    for (const [where, text] of Object.entries(fields)) {
      for (const term of hits(text, terms.block)) blocks.push({ id: p.id, where, term });
      for (const term of hits(text, terms.caution)) cautions.push({ id: p.id, where, term });
    }
  }
  return { blocks, cautions };
}

export function report({ blocks, cautions }, terms) {
  const sw = (t) => terms.swaps[t.toLowerCase()] ? "  -> use: " + terms.swaps[t.toLowerCase()] : "";
  if (cautions.length) {
    console.log("\n[caution] review before publishing (allowed, but high-risk on IG/TikTok):");
    for (const c of cautions) console.log("  ~ " + c.id + " (" + c.where + "): \"" + c.term + "\"" + sw(c.term));
  }
  if (blocks.length) {
    console.log("\n[BLOCK] these will get the account suppressed/banned - publishing is refused:");
    for (const b of blocks) console.log("  x " + b.id + " (" + b.where + "): \"" + b.term + "\"" + sw(b.term));
  }
  if (!blocks.length && !cautions.length) console.log("[clean] no restricted terms found.");
  return blocks.length;
}

// standalone
if (import.meta.url === ("file://" + process.argv[1])) {
  const fileArg = (process.argv.find((a) => a.startsWith("--file=")) || "").split("=")[1] || "posts.json";
  const terms = await loadTerms();
  const cfg = JSON.parse(await readFile(resolve(HERE, fileArg), "utf8"));
  const findings = lintPosts(cfg.posts || [], terms);
  const nBlocks = report(findings, terms);
  console.log("");
  process.exit(nBlocks ? 1 : 0);
}

---
title: "Zernio API Gotchas & Field Notes"
type: reference
date: 2026-06-04
tags: [indexa, distribution, zernio, automation, reference, gotchas]
---

# Zernio API Gotchas & Field Notes

A running list of things that bit us (and the fix), so neither we nor any future agent repeats them. Authoritative over the public docs where they conflict — these are confirmed against the live API. Toolkit: `Automation/indexa-publisher/` (CI) and `Automation/Zernio/` (local). See [[SOP — Zernio Publishing]].

## 1. Presign body fields are `filename` + `contentType`
`POST /v1/media/presign` requires **`filename`** and **`contentType`** — NOT `fileName`/`fileType`.
- The docs **curl example is wrong**; the Python SDK (`filename` / `content_type`) is right.
- Symptom: `400 {"error":"Missing required fields: filename and contentType"}`.
- Fixed in `publish.mjs` (`uploadMedia`).

## 2. TikTok photo posts: `content` is the TITLE, capped at 90 chars
For a TikTok **photo / slideshow** post, Zernio uses the post `content` as the **slideshow title**, which TikTok caps at **90 characters**.
- Symptom: `400 TIKTOK_PHOTO_TITLE_TOO_LONG ("Your content is N characters...")`.
- Fix pattern: keep `caption` (the `content`) a **short title ≤ 90 chars**, and put the full caption + hashtags in **`tiktokSettings.description`**. (For a TikTok *video* post the cap doesn't apply.)
- Guarded in `publish.mjs` (`validateTikTok`) — the run now aborts early with a clear message instead of failing at the API.

## 3. The lint gate must scan `tiktokSettings.description`
Because the long TikTok text now lives in `tiktokSettings.description`, the restricted-terms linter scans that field too (`lint.mjs`). Don't move copy into a field the gate can't see.

## 4. Obsidian / OneDrive sync drops dot-folders
`.github/`, `.gitignore`, `.env.example` and similar **don't survive the vault sync** — they show up as ghost entries that can't be read or overwritten locally.
- Consequence: `git add .` from the synced folder won't include the workflow.
- Fix: **create/edit the workflow directly on GitHub** (web UI → Add file → `.github/workflows/publish.yml`). Normal files (`posts.json`, `media/`, `*.mjs`) sync fine and can be pushed from local.

## 5. The ledger must commit even when a run partially fails
If one post succeeds and a later one fails, the publish step exits non-zero and the **"Commit updated ledger" step is skipped** → the success isn't recorded → the next run **re-pushes it (duplicate)**.
- Fix: add **`if: always()`** to the ledger-commit step so partial progress is always saved.
- Recovery when it already happened: manually add the succeeded post's key to `published.json` (`id@mode@scheduledFor`) before re-running. (We did this for POST-20260603-001 after its IG run.)

## 6. Network: only zernio.com-reachable hosts can publish
The Cowork sandbox **cannot reach `zernio.com`** (egress allowlist; DNS fails). GitHub Actions runners and your laptop can. So publishing runs there; the sandbox only builds/validates via `--dry-run`.

## 7. GitHub Actions — Node 20 deprecation (non-fatal)
`actions/checkout@v4` / `actions/setup-node@v4` warn that their Node 20 runtime is deprecated (forced to Node 24 on **2026-06-16**). This is a **warning, not a failure**. Options: bump those actions when newer majors ship, or set `FORCE_JAVASCRIPT_ACTIONS_TO_NODE24=true` (test first — forcing it on @v4 can break). Our own script runs on the `setup-node` `node-version` (22), independent of this.

## 8. TikTok requires `tiktokSettings`
Photo posts need `privacy_level` (e.g. `PUBLIC_TO_EVERYONE`), `media_type: "photo"`, `photo_cover_index`, and consent flags (`content_preview_confirmed`, `express_consent_given`). Already set on the TikTok post.

## 9. Media formats / limits (confirmed)
Instagram: JPEG/PNG, ≤ 8 MB (auto-compressed), 10 images per carousel. TikTok photos: JPEG/PNG/WebP, ≤ 20 MB, 9:16 recommended, up to 35. We ship IG 1080×1350, TikTok 1080×1920 PNG.

## Status log
- 2026-06-04: IG carousel POST-20260603-001 scheduled OK (Zernio id `6a214642ae36d9edac710a0e`). TikTok POST-20260603-002 fixed (title→description split) and re-queued; ledger seeded to prevent IG duplicate.

## 10. Pushing more posts in waves — pull the ledger first
`published.json` is committed back to GitHub by the Action (via `if: always()`), so **GitHub's ledger is the source of truth**, not the local Obsidian copy (which only has the seeded entries). Before pushing a new wave from the vault repo:
1. `git pull` first (fetch the Action's ledger + any committed state).
2. Commit **only** `posts.json` + `media/` — do **NOT** `git add published.json` (don't overwrite GitHub's ledger with the stale local one, or already-scheduled posts get re-pushed = duplicates).
3. Push. The Action skips everything already in the ledger and schedules only the new posts.

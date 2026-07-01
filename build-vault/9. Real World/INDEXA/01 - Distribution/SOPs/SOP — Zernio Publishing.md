---
title: "SOP — Zernio Publishing"
type: sop
date: 2026-06-03
tags: [indexa, distribution, sop, zernio]
---

# SOP — Zernio Publishing

**Goal:** get finished posts from the vault onto Instagram and TikTok reliably, on schedule, with a human approval gate before anything goes live. This SOP is the publishing leg of [[SOP — Content Publishing]] and the [[Workflow — Content Production Pipeline]].

**Tool:** Zernio (one API for 14+ platforms). Toolkit lives in `Automation/Zernio/` (`publish.mjs`, `accounts.mjs`, `posts.json`). Docs: https://docs.zernio.com.

**Cadence:** batch weekly. Schedule 7 days ahead. Keep the 2:1:1 pillar ratio (education-or-proof : product : promo).

## Mental model
Zernio publishes media + a caption to accounts you've connected. It does **not** design the creative — the vault does that. The flow is always: **finished art (`_assets/`) + caption (`POST` note) → `posts.json` → Zernio draft → human review → schedule/publish.**

Key objects: **Profile** (a brand container — we use one: "Indexa") → **Accounts** (the connected IG + TikTok) → **Posts** (what we schedule).

## One-time setup
1. Create a Zernio account; create a **Profile** named `Indexa`.
2. Connect **Instagram** and **TikTok** to that profile (dashboard OAuth). Note: Instagram must be a Business/Creator account.
3. Dashboard → Settings → API Keys → **Create API Key** (shown once). Save it in `Automation/Zernio/.env` (copy from `.env.example`). Never commit it.
4. Run `node accounts.mjs` and paste the real IG + TikTok `accountId`s into `posts.json`.

## Weekly run
1. **Confirm the week's posts** are `scheduled` in the vault (notes exist, art rendered in `_assets/`, captions final, guardrail boxes checked).
2. **Update `posts.json`** — one entry per post: `id`, `caption`, `scheduledFor` (local `YYYY-MM-DDTHH:mm:ss`), `platforms[]`, `media[]` (paths, in carousel order).
3. **Dry-run:** `node publish.mjs --dry-run` — confirms files resolve and limits are sane (IG ≤10 images, TikTok ≤35 photos / 1 video).
4. **Create drafts:** `node publish.mjs` (default mode = draft).
5. **Review in the Zernio dashboard** — preview each platform's render. Fix art/caption if needed and re-run.
6. **Schedule:** `node publish.mjs --mode=schedule`. (Or `--mode=now` to publish immediately; `--only=POST-…` for a single post.)
7. **Back-fill the vault:** once live, paste each post's `link` into its note and set `status: published`.
8. **Hand off demand:** any DMs/comments that signal intent → create `#lead` notes (see [[SOP — Lead to Sale]]).

## Posting times (Malaysia / Asia/Kuala_Lumpur)
Default slots: **TikTok 20:00**, **Instagram 19:00**. Adjust from analytics after 2–3 weeks. The Reta/promo posts go out separately under [[SOP — Campaign Launch]].

## Guardrails (non-negotiable)
- **Research-use framing only.** No human dosing, no "treats/cures/prevents", no medical before/after. COA and process content is encouraged. A post that fails this does not ship — full stop (it's what keeps the brand alive).
- **Disclaimer** present on-image and in caption.
- **Approval gate:** posts are created as **drafts** first; a human schedules/publishes. The script refuses to run with placeholder account IDs.
- **TikTok comment hygiene:** block/limit off-topic spam comments early (build-journal policy).
- **Threads is different** — do **not** publish to Threads as INDEXA from this pipeline. Threads runs disposable alias-brand accounts (see [[Content — Playbook]] / content-threads memory). This SOP covers IG + TikTok only.

## Definition of done
Every planned post is live, each vault note has its `link` and `status: published`, and inbound interest is captured as leads.

## Troubleshooting
- **401 / auth error** → key missing or wrong; re-export `.env`.
- **accountId placeholder error** → run `node accounts.mjs`, update `posts.json`.
- **Upload/PUT failed** → file too big or wrong type (images: JPG/PNG/GIF/WebP; video: MP4/MOV/WebM).
- **Platform rejected media** → check per-platform limits in `README.md`; resize (IG 1080×1350, TikTok 1080×1920).
- **Error envelope reference:** https://docs.zernio.com/guides/error-handling.

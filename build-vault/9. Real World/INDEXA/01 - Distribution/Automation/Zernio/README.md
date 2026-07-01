# Indexa -> Zernio publisher

A tiny, dependency-free Node toolkit that pushes Indexa content to Instagram, TikTok (and any other Zernio platform) from `posts.json`. It lints captions/creative against our platform safe-words, uploads local media, and creates each post as a **draft**, a **scheduled** post, or **publishes now**.

> Default mode is `draft`. Nothing goes live without you choosing `--mode=schedule`/`--mode=now` and reviewing in the Zernio dashboard.

## Files
- `publish.mjs` — lint gate -> upload media -> create posts from `posts.json`.
- `lint.mjs` — restricted-terms checker (run standalone or auto-runs inside publish).
- `restricted-terms.json` — the block/caution/swap word lists (edit this to change the rules).
- `accounts.mjs` — lists your Zernio profiles + connected account IDs.
- `posts.json` — the post queue (captions, on-image text, media, schedule, targets).
- `.env` — your API key (gitignored; never commit).

## Why it must run on your machine
This workspace can't reach `zernio.com` (sandbox allowlist), so the live API calls happen when **you** run the commands below on your computer. Everything is pre-built and validated; you just run it.

## One-time setup
1. **Node 18+** (`node -v` ≥ 18 — has built-in `fetch`).
2. **API key:** already saved in `.env` as `ZERNIO_API_KEY`. (To rotate: dashboard -> Settings -> API Keys.)
3. **Connect accounts** in the Zernio dashboard: Instagram (Business/Creator) + TikTok, under one profile ("Indexa").

## Run it
```bash
cd "Automation/Zernio"
export $(grep -v '^#' .env | xargs)     # load the key

node lint.mjs                 # check copy against restricted-terms.json
node accounts.mjs             # (optional) see connected accounts; publish auto-resolves anyway
node publish.mjs --dry-run    # validate + lint + show the plan, no network writes
node publish.mjs              # create DRAFTS in Zernio (default, safest)
node publish.mjs --mode=schedule   # schedule at each post's scheduledFor
node publish.mjs --mode=now        # publish immediately
node publish.mjs --only=POST-20260603-001   # one post only
```

You do **not** need to copy account IDs by hand — `publish.mjs` auto-resolves a `REPLACE_*`/empty `accountId` from your connected accounts by platform. (If you have multiple accounts on one platform, set the exact `_id` from `node accounts.mjs` in `posts.json`.)

## Safety gates (both run before any upload)
1. **Restricted-terms lint.** A **block** term (named pharma drugs, injection/dosing, medical claims) aborts the whole run; **caution** terms (peptide, vial, weight loss…) print a warning + suggested swap. Edit `restricted-terms.json` to tune. Full policy: `Playbooks/Policy — Platform Restricted Terms.md`. Override (rare): `--force`.
2. **Placeholder/account guard.** Won't publish to a platform with no connected account.

## Post shape (`posts.json`)
| field | meaning |
| --- | --- |
| `id` | matches the vault note `POST-YYYYMMDD-NNN`. |
| `caption` | post body + hashtags (`\n` for line breaks). |
| `onImageText` | the text shown in the creative — lint scans this too (platforms OCR images). |
| `scheduledFor` | local `YYYY-MM-DDTHH:mm:ss` (used in `schedule` mode). |
| `platforms[]` | `{ platform, accountId }`; `accountId` may be `REPLACE_*` (auto-resolved). |
| `media[]` | local file paths (relative to this folder); order = carousel order. |
| `tiktokSettings` | TikTok requires `privacy_level`, `media_type`, consent flags — already set for the TikTok post. |

Per-platform limits Zernio enforces: IG 10 images / 1 reel · TikTok 35 photos / 1 video · Threads 10 images. Specs we ship: IG 1080×1350, TikTok 1080×1920.

## Flow under the hood
`lint -> presign -> PUT file -> createPost`. Docs: https://docs.zernio.com/guides/media-uploads.

## Security
- `.env` holds a secret — it's gitignored; keep it out of Obsidian sync exports.
- `--dry-run` any new batch first.

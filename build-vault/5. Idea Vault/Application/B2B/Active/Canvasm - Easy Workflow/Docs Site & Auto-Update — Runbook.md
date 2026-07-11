---
title: Docs Site & Auto-Update — Runbook
created: 2026-07-08
updated: 2026-07-08
status: active
product: Metrimap
brand: Canvasm
linear_team: CVS
tags: [docs, runbook, automation, canvasm]
---

# Docs Site & Auto-Update — Runbook

Last verified: 2026-07-08, Asia/Kuala_Lumpur. Stores **no secrets**.

This note is your "I'll forget this next week" memory for the public docs site
**docs.canvasm.app** and the agent that keeps it up to date. See also
[[Project Memory - Metrimap]].

---

## 1. TL;DR

- **Public docs live at → https://docs.canvasm.app** (Next.js + Fumadocs + MDX).
- Separate repo from the app: **`nadeemramli/metrimap-docs`**
  (WSL: `/home/nadeemramli/workspace/github.com/nadeemramli/metrimap-docs`).
- Separate Vercel project **`metrimap-docs`** → auto-deploys on merge to `main`.
- A **weekly "docs-drift" agent** checks whether the app shipped things the docs
  don't reflect, and files a GitHub issue. It runs **locally on the Claude Code
  subscription** via cron (**Mondays 08:17 +08**). Logs → `~/.docs-drift.log`.
- To actually *apply* fixes: push one of the **prompts in §7** to a Claude Code
  agent opened in the docs repo.

---

## 2. Who / what built this

- Built by a **Claude Code agent session** (model **Opus 4.8, 1M context**),
  acting as "**Agent 2 — Canvasm public docs lane**", on **2026-07-07 → 08**.
- It worked from a one-off brief (`AGENT-SUPERPLAN.md`, since deleted from the
  repo) and, more importantly, from **Linear**:
  - Team **Canvasm** (`CVS`), project **"Docs site - docs.canvasm.app"**,
    label **`lane:docs-canvasm-app`**, issues **CVS-290 → CVS-299**.
- Every issue = one branch → one PR → merged to `main`. PRs **#1–#14** (see §10).
- Product truth was read (read-only) from the app repo `nadeemramli/metrimap`
  (`docs/features/*`, `src/features/*`) so terminology matches the app.

### Issue map (what each did)

| Issue | What | Status |
|---|---|---|
| CVS-290 | Scaffold Fumadocs + Next.js + MDX | ✅ Done |
| CVS-292 | Info architecture, sidebar, 34 pages + stubs | ✅ Done |
| CVS-293 | Concepts (6 pages) | ✅ Done |
| CVS-294 | Learn / education (5 lessons) | ✅ Done |
| CVS-295 | Product System (5 pages) | ✅ Done |
| CVS-296 | Reference (MCP/API/connectors/data/access) | ✅ Done |
| CVS-297 | Search, feedback footer, metadata/sitemap/robots/OG, quality gate | ✅ Done |
| CVS-298 | Content-source / CMS decision doc | ✅ Done |
| CVS-291 | Vercel project + `docs.canvasm.app` domain | ✅ Done (domain live + verified) |
| CVS-299 | Launch checklist (owner-run manual QA) | ✅ Done |

> **All 11 issues closed to Done on 2026-07-08** after the owner ran manual QA.
> (Agents leave issues at "Waiting for Manual Test"; the owner promotes to "Done".)

### Branding (bonus, outside the 10 issues)

- Docs nav logo + favicon mirror the marketing mark (canvasm.app): the
  connected-node "map" glyph + wordmark. Docs PR **#11**.
- The same mark was applied to the **app** (`nadeemramli/metrimap` PR **#139**).
- Source of truth for the mark:
  `metrimap-marketing/src/components/layout/logo.tsx` (inline SVG, `currentColor`)
  and `metrimap-marketing/src/app/icon.svg` (favicon badge).

---

## 3. Key locations & URLs

| Thing | Where |
|---|---|
| Live docs | https://docs.canvasm.app |
| Docs repo (GitHub) | https://github.com/nadeemramli/metrimap-docs |
| Docs repo (WSL) | `/home/nadeemramli/workspace/github.com/nadeemramli/metrimap-docs` |
| App repo (product truth, read-only) | `nadeemramli/metrimap` → use.canvasm.app |
| Marketing repo | `nadeemramli/metrimap-marketing` → canvasm.app |
| Vercel project | `metrimap-docs` (team "nadeemramli's projects") |
| Content (MDX) | `content/docs/**` |
| Sidebar/ordering | `content/docs/**/meta.json` |
| Internal notes | `docs/ia.md`, `docs/deploy.md`, `docs/quality-gates.md`, `docs/launch-checklist.md`, `docs/decisions/0001-content-source.md` |
| Drift agent playbook | `docs/automation/docs-drift-check.md` |
| Drift local schedule doc | `docs/automation/local-schedule.md` |

---

## 4. Editing / publishing docs (the normal loop)

1. `cd ~/workspace/github.com/nadeemramli/metrimap-docs`
2. Branch (never commit to `main`): `git checkout -b docs/<change>`
3. Edit MDX under `content/docs/**`. New page → add it to that folder's `meta.json`.
4. **Required frontmatter on every page**: `title`, `description`, `owner`,
   `status` (`draft|review|stable`), `lastReviewed` (`YYYY-MM-DD`).
5. Verify: `npm run check && npm run lint && npm run build` (all must pass).
6. `git push` → open a PR → Vercel builds a **preview URL** → merge to `main`
   → production deploys to docs.canvasm.app.

Run it locally: `npm install` then `npm run dev` → http://localhost:3001

Useful:
- `npm run check` — fails on missing frontmatter or broken internal `/docs` links.
- `npm run build` — production build (must pass before every PR).

---

## 5. The docs-drift agent (auto-detection)

**What it is:** a weekly agent that asks *"has the app shipped anything the docs
don't reflect?"* and files a **`docs-drift` GitHub issue** with a checklist.
It is **report-only** — it never edits docs and never leaks internals.

**Signals it reads:** merged PRs + production deployments on `nadeemramli/metrimap`
(via `gh`), plus Linear if available. It compares against the reference pages'
**Current vs Planned** claims, `lastReviewed` dates, and IA coverage.

### How it runs — LOCAL cron only (as of 2026-07-08)

| | **Local cron (ACTIVE — sole runner)** |
|---|---|
| Auth | **Claude subscription** (no API key) |
| Runs | Only when this PC + WSL are up |
| Cost | counts against your Claude plan |
| File | `scripts/docs-drift-local.sh` + crontab |

**Local cron on the subscription is the only mechanism.** The GitHub Actions
variant (`.github/workflows/docs-drift.yml`) was **deleted in docs PR #14** — it
needed an `ANTHROPIC_API_KEY` secret that was never set, so it would have failed
every run. To add an always-on cloud fallback later, re-add a scheduled workflow
that runs the same playbook and set that secret.

### Current schedule (installed)

```
crontab -l
# 17 8 * * 1 /home/nadeemramli/workspace/github.com/nadeemramli/metrimap-docs/scripts/docs-drift-local.sh >> /home/nadeemramli/.docs-drift.log 2>&1
```
- Fires **Mondays 08:17 local (+08)**. Cron daemon confirmed running.
- `scripts/docs-drift-local.sh` forces subscription auth (`unset ANTHROPIC_API_KEY`),
  fixes PATH for cron, `git pull`, then runs the playbook headless on **Sonnet**.
- Only fires if WSL/PC is awake at 08:17 Monday. A missed week is caught by the
  next run's 8-day rolling window.

### Dry run (2026-07-08) — confirmed working + found real drift

Verified under a cron-like minimal env: tools resolved, subscription auth used,
read-only, produced a correct report. Real items it caught:
1. ✅ **FIXED (docs PR #14, 2026-07-08).** `reference/connectors.mdx` — GA4 native
   connector shipped (metrimap#137, CVS-146: OAuth + Data API) but page said
   "Planned"; now marked **Current** (other sources stay Planned).
2. ⬜ `reference/mcp.mdx` + `reference/data-model.mdx` — **new `Exploratory`
   relationship type** shipped (CVS-254); pages list only the original 4 types.
   *Still open — good candidate for the next "fix all drifts" pass.*
3. ⬜ `product-system/evidence-and-governance.mdx` + `guides/share-views.mdx` —
   public evidence share/embed shipped (CVS-248); not covered. *Still open.*

---

## 6. Logs, checks & troubleshooting

### Where logs live
- **Weekly runs → `~/.docs-drift.log`** (appended each run).
- **Dry runs → `~/.docs-drift-dryrun.log`** (kept separate).
- Durable "output" of a real run = the **`docs-drift` GitHub issue** on the docs repo.

### Everyday commands (run with `!` prefix in Claude Code, or a normal terminal)
```bash
# See the schedule
crontab -l
# Read the last run
tail -n 60 ~/.docs-drift.log
# Test the check now (real: may open the docs-drift issue)
~/workspace/github.com/nadeemramli/metrimap-docs/scripts/docs-drift-local.sh; tail -n 60 ~/.docs-drift.log
# See the open drift issue
gh issue list --repo nadeemramli/metrimap-docs --label docs-drift --state open
# Remove the schedule
crontab -l | grep -v docs-drift-local | crontab -
```

### Troubleshooting
| Symptom | Fix |
|---|---|
| Nothing ran Monday | PC/WSL was asleep at 08:17. Next week's run catches up (8-day window). For guaranteed runs, use Windows Task Scheduler → `wsl.exe -e bash -lc ".../docs-drift-local.sh"` with "run ASAP after missed start" (see `docs/automation/local-schedule.md`). |
| `cron` not running after reboot | `sudo service cron start`. Auto-start: add that line to `~/.bashrc`. Check: `pgrep -x cron`. |
| "claude: command not found" in log | PATH issue. The wrapper resolves nvm's node bin; if you changed Node versions, confirm `command -v claude`. |
| It used the API, not my plan | An `ANTHROPIC_API_KEY` is set in your env. The wrapper `unset`s it, but check `echo $ANTHROPIC_API_KEY` is empty in your shell too. |
| `gh` auth errors | `gh auth status`; re-login `gh auth login`. Cron uses the file token in `~/.config/gh`. |
| Duplicate issues | Playbook dedupes by week; it edits the existing weekly issue instead of creating a new one. |
| Want a different day/time | Edit the crontab line (local time). Cron format: `min hour * * dow`. |
| Switch to always-on cloud | The cloud Action was **removed** (PR #14). Re-add a scheduled workflow that runs the playbook, then set repo secret `ANTHROPIC_API_KEY` (Settings → Secrets → Actions). Then local cron is optional. |

> Note: Claude Code's in-session `CronCreate` also uses the subscription **but is
> session-only and expires after 7 days** — not durable. That's why we use OS cron.

---

## 7. How to AUTO-UPDATE docs.canvasm.app (detection → application)

Keeping docs current is a **two-part loop**:

1. **Detection (automatic):** the weekly drift agent (§5) files a `docs-drift`
   issue listing what changed and which pages to touch.
2. **Application (you trigger):** open **Claude Code in the docs repo** and paste
   one of the prompts below. The agent edits the MDX, runs the checks, and opens
   a PR **for you to merge** — agent self-merge of its own PR is blocked by the
   permission guard, so the last click is always yours. Merge → live.

> **Your intended cadence:** let drift issues accumulate for a few weeks, then run
> **Prompt A once** to clear them all in a single PR, and update this runbook after.

Open the repo first:
```bash
cd ~/workspace/github.com/nadeemramli/metrimap-docs && claude
```

### Prompt A — Apply this week's drift issue (the main one)

> You're in the `metrimap-docs` repo (public docs for docs.canvasm.app). Read the
> latest open `docs-drift` GitHub issue (`gh issue list --repo nadeemramli/metrimap-docs
> --label docs-drift --state open`, then `gh issue view <n>`). For each item under
> **"Likely needs updating"**, make the edit in `content/docs/**`:
> - House style: plain language, **Current vs Planned** labels, the recurring MRR
>   example, cross-links, and **no internals** (no table names, secrets, RLS text,
>   private URLs, or internal Linear links — these docs are public).
> - Read the app repo `nadeemramli/metrimap` (`docs/features/*`, `src/features/*`)
>   read-only for product truth; never modify that repo.
> - Update each edited page's frontmatter `lastReviewed` to today; bump `status`
>   if warranted.
> Then run `npm run check && npm run lint && npm run build` (all must pass), create
> a branch, and open a PR titled `docs: apply drift fixes (week of <date>)`. After
> it's green, comment on the drift issue linking the PR. Don't touch unrelated pages.

### Prompt B — Document a specific new feature (when you ship something)

> In the `metrimap-docs` repo, document **<FEATURE>** which just shipped in the app
> (`nadeemramli/metrimap`, <PR #… / CVS-…>). Read the app's `docs/features/<file>.md`
> and relevant `src/features/<area>` for product truth (read-only; never modify that
> repo). Add or update the right page(s) under `content/docs/**` — `reference/` for
> integration detail, `concepts/` for the model, `learn/` for how-to, `guides/` for
> tasks. Mark **Current vs Planned** honestly, use the MRR example, cross-link, set
> required frontmatter (`title/description/owner/status/lastReviewed`), and leak no
> internals. Run `npm run check && npm run lint && npm run build`, branch, and PR.

### Prompt C — Re-brand / logo parity (reference)

The connected-node mark lives in `metrimap-marketing/src/components/layout/logo.tsx`
(inline SVG, `currentColor`) and `.../src/app/icon.svg` (favicon). To apply it to any
surface: create a `Logo` component using that inline SVG + point the favicon at a copy
of `icon.svg`; keep the existing component's props/API so callers don't change. (This
was already done for docs PR #11 and app PR #139.)

### When there's no drift issue but you know something changed

Just use **Prompt B** with the specific PR/CVS number — you don't have to wait for
the weekly run.

---

## 8. One-time / occasional owner tasks

- [x] **CVS-299** — launch QA run + **CVS-290..299 all closed to Done (2026-07-08)**.
- [ ] Decide whether to fill the **Guides** section and **Release notes** (currently
      honest stubs with visible "This page is a stub" callouts) before wide launch,
      or hide them from the sidebar.
- [ ] Next drift pass: apply the still-open drift items — `Exploratory` relationship
      type (CVS-254) and public evidence share/embed (CVS-248) — via §7 Prompt A.
- [ ] Optional: re-add a cloud Action + `ANTHROPIC_API_KEY` secret as an always-on
      fallback to the local cron (the previous Action was deleted in PR #14).

---

## 9. Guardrails (don't break these)

- **Docs are public.** Never expose table names, RLS/policy text, API/JWT secrets,
  server IPs, private URLs, or internal Linear links.
- **Current vs Planned** must be honest — never present roadmap as shipped.
- **Never modify the app repo** from the docs flow (read it for truth only).
- Docs are **Git-backed MDX via PRs** — not Supabase, not a CMS (see
  `docs/decisions/0001-content-source.md` for the CMS threshold).

---

## 10. Changelog

### 2026-07-08 — launch closeout + first drift fix (PR #14)
- **All 11 Linear issues (CVS-290 → CVS-299) closed to Done** after owner manual QA.
  Previously most sat at "Waiting for Manual Test"; CVS-299 was "Todo".
- **Verified the sync loop points at the right app repo.** The local folder
  `~/workspace/github.com/nadeemramli/metric-mapping` is just a clone whose git
  remote is **`nadeemramli/metrimap`** — that (not the lookalikes `metric-map-app`
  / `mapping-of-metrics`) is the live app behind use.canvasm.app (139+ merged PRs).
  The drift playbook's hard-coded target is correct.
- **Confirmed docs.canvasm.app is live** — resolves to Vercel, serves the real site
  (title "Canvasm Docs…", `/docs/concepts` prerendered).
- **docs PR #14** (owner-merged):
  - `reference/connectors.mdx` — **GA4 flipped Planned → Current** (matches shipped
    app PR metrimap#137 / CVS-146: OAuth + GA4 Data API). Other sources stay Planned.
  - **Deleted `.github/workflows/docs-drift.yml`** (the dormant cloud Action — its
    `ANTHROPIC_API_KEY` secret was never set, so it would fail every run). **Local
    cron is now the sole runner.** Updated `docs/automation/local-schedule.md`.
- **Still-open drift** for the next pass: `Exploratory` relationship type (CVS-254),
  public evidence share/embed (CVS-248). See §5.
- Mirrored into Claude Code memory (project `metrimap-docs`): `docs-project-complete`,
  `docs-drift-loop`, `docs-drift-scheduling`, `docs-drift-fix-workflow`.

### 2026-07-07 → 08 — initial build
- Docs site built across CVS-290 → CVS-299, PRs #1–#13; drift agent + local cron
  installed; branding parity (docs PR #11, app PR #139).

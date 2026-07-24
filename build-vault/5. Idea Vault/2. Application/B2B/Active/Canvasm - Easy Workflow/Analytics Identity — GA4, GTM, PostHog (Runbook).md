# Analytics Identity — GA4, GTM, PostHog (Runbook)

*Written 2026-07-08 · status of record for how Canvasm identifies users end-to-end across the marketing site, the app, and every analytics tool. Companion to [[Project Memory - Metrimap]].*

---

## The identity spine (one id everywhere)

**`clerkUserId` is the canonical identity.** Every system keys on the same id, so any two systems can be reconciled by one join key:

| System | How it carries the id |
|---|---|
| Clerk | The user record itself (+ signup UTM attribution in `unsafeMetadata.attribution`) |
| Supabase | `users.id` **is** the Clerk id |
| PostHog | `identify(clerkUserId)` on sign-in, `reset()` on sign-out (`src/shared/lib/analytics.ts`) |
| GA4 | `user_id = clerkUserId`, pushed on login/sign_up (via GTM dataLayer; app container `GTM-KJWN2F2L`, GA4 `G-F98ELRQJMT` — **app code wired 2026-07-08**; live once `VITE_GTM_ID` set + container populated) |

First-touch UTM attribution is captured once at landing (`src/shared/utils/attribution.ts`, localStorage, first-touch-wins) and fans out to: Clerk `unsafeMetadata` at signup, PostHog super/person properties, and (once GTM lands) the dataLayer.

---

## How the marketing → app handoff stitches

A structural gift does most of the work: **`canvasm.app` and `use.canvasm.app` share the same root domain**, so GA4's `_ga` cookie is set on `.canvasm.app` and is automatically shared between the marketing site and the app. **No cross-domain linker configuration needed** (linker is only for different root domains). The anonymous visitor reading canvasm.app and the person landing in the app are already the same `client_id` in GA4.

The flow then stitches like this:

1. **Anonymous on canvasm.app** — GTM + GA4 tag fire; the visitor gets a `client_id`; UTMs are captured natively by GA4 *and* by the app's localStorage attribution when they cross over.
2. **They click "Get started"** → land on `use.canvasm.app/signup?utm_...` — same GA4 cookie, same session. (The `/signup`·`/login` alias routes preserve the full query string; the old catch-all used to eat it.)
3. **They sign up / log in** — the app pushes `{ event: 'login' | 'sign_up', user_id: clerkUserId }` to the dataLayer and sets GA4's `user_id`. GA4's identity stitching merges the pre-login anonymous history with the identified user — including which campaign brought them.
4. **From then on** every GA4 hit from the app carries `user_id` → logged-in segments, cross-device journeys, campaign → activation reporting all work.

**GA4 admin steps (one-time):** Reporting Identity → **Blended** (User-ID first) · mark `sign_up` as a key event/conversion.

---

## Container architecture: 2 GTM, 1 GA4

**Decision: two GTM containers — one per surface — but one shared GA4 property (same measurement ID in both).** The GA4 property is what unifies reporting and identity; the GTM container is just the tag-management surface, and the two surfaces have different needs.

Why separate containers:

1. **The app's CSP makes a shared container half-broken by design.** use.canvasm.app has a strict Content-Security-Policy (vercel.json) — every external script/endpoint must be explicitly allowed. In a shared container, "add a pixel once, runs everywhere" fails silently: a new marketing tag would be blocked by the app's CSP until an app deploy ships. All the coupling, none of the convenience.
2. **Blast radius.** Marketing containers accumulate experiments (pixels, heatmaps, chat widgets). A Friday tag tweak on the site must never slow or break the logged-in app. The app container stays boring and tiny: GA4 config + dataLayer events, essentially never changing.
3. **Different event vocabularies.** Marketing thinks in page views / scroll / CTA clicks; the app speaks its dataLayer contract (`login`, `sign_up`, `canvas_created`, `tour_completed`…). One container would need `Page Hostname` conditions on every trigger — easy to forget one and misfire.

What stays shared (and does the actual unification): the **GA4 property**, the **Clerk `user_id`**, and **consent-mode settings** (keep consistent across both containers when a consent banner lands).

Concretely: **`GTM-T336859X`** for canvasm.app (marketing playground, owner/site-agent managed — **live**, see [[Analytics — Marketing Site (canvasm.app) GTM Setup]]) · **`GTM-KJWN2F2L`** for use.canvasm.app (minimal, stable; loader gated by `VITE_GTM_ID`, no-ops when unset — same pattern as PostHog). Shared GA4 measurement ID: **`G-F98ELRQJMT`** (use the same in the app container).

---

## Do we need to connect Supabase? No.

- **For GA4/GTM identification: no.** The `user_id` flows client-side from Clerk; GA4 never sees the database. (Only DB-adjacent option is GA4's BigQuery export — not needed.)
- **PostHog ↔ Supabase warehouse link: optional, unrelated to identification.** It's for *enrichment analysis* — "do users with 3+ canvases retain better?" — joining events with product tables. Configured in PostHog UI (Data pipeline → Sources → Postgres, read-only Supabase connection string). Do it when those questions come up.
- Worthwhile follow-up (small, not urgent): sync signup attribution from Clerk `unsafeMetadata` into the `users` table via the existing Clerk webhook, so attribution lives in our own DB too.

---

## Server-side instrumentation — when it earns its place

Client-side covers the current questions (onboarding funnels, activation, campaign attribution) because those journeys *are* browser journeys. Server-side becomes the right tool in four situations:

**1. When the event *is* a server-side fact.** Some events either don't happen in a browser or can't be trusted from one:
- **MCP/API activity** — agents create metrics, push values, and build trees through `mcp.canvasm.app` with no browser involved. Already invisible to client-side PostHog/GA4. "Agent built a tree" in a funnel must come from the MCP server (PostHog Node SDK, capturing with the acting user's Clerk id as `distinct_id` — same identity spine).
- **Webhooks and background jobs** — the Clerk user-provisioning webhook is the true "account created" moment; connector runs, alert firings, scheduled measurement-window closes. None of these have a client to fire from.

**2. When revenue and truth matter more than convenience.** The moment billing lands (Stripe is on the connector roadmap), conversion events like `subscription_started` fire from the Stripe webhook, not the browser — client-side "purchase" events get lost to ad-blockers, closed tabs, and double-fires. Ad platforms also increasingly prefer server-side signals (GA4 Measurement Protocol, Meta CAPI — already run for another property via GTM server-side, so the pattern is familiar).

**3. When ad-blocker loss starts distorting decisions.** Typically 15–30% of client events vanish to blockers. Early on that loss is uniform noise; when optimizing paid campaigns against conversion counts, it isn't — that's when a server-side GTM container or PostHog reverse proxy becomes worth the infrastructure.

**4. When events must be exactly-once and auditable.** `impact_contract_reviewed`, `evidence_created` — if these ever feed customer-facing reporting or billing, server-side capture from the Supabase/service layer is the only trustworthy source.

### Practical sequencing

1. **MCP server events** — soonest and cheapest win; the infrastructure (Hetzner box, Node server) already exists, and agent activity is a core product loop currently invisible.
2. **Clerk webhook `signed_up` event** — makes signup counting ad-blocker-proof and attaches the attribution from `unsafeMetadata` server-side into both PostHog and the `users` table.
3. **Billing webhooks** — the day Stripe lands, non-negotiable.
4. **Server-side GTM / proxying** — only when paid-acquisition spend justifies fighting the ad-blocker gap.

The identity design makes all of this drop-in later: everything keys on the Clerk user id, so a server-side event with `distinct_id = clerkUserId` merges seamlessly with the client-side history — no migration, just additional emitters.

---

## Current implementation state (2026-07-08)

**Shipped in the app (Linear CVS-114 + CVS-115, Waiting for Manual Test):**
- PostHog live — project 204116, US Cloud; env-first (`VITE_POSTHOG_KEY/HOST`) with the public write-only key as fallback; `person_profiles: identified_only`; SPA pageviews; session replay enabled (project settings).
- Funnel events: `welcome_seen{path}` → `demo_copied` → `tour_started/completed/skipped{at_step}` → `canvas_created`, plus `checklist_dismissed`.
- Onboarding loop this measures: welcome dialog → demo-canvas copy (by `example` tag lookup) → driver.js guided tour → getting-started checklist → one-shot feature tips.
- UTM alias routes + first-touch attribution capture + Clerk `unsafeMetadata` at signup.
- CSP allows `us.i.posthog.com` + `us-assets.i.posthog.com` (both vercel.json header rules — the `/embed/*` rule is separate; keep both updated when adding tags).

**Shipped on the marketing site (canvasm.app, 2026-07-08):**
- [x] Both GTM containers exist — marketing `GTM-T336859X`, app `GTM-KJWN2F2L`. App container id is ready for the app agent.
- [x] Marketing GTM fully built + published (v3): Google tag `G-F98ELRQJMT` + GA4 event tags for `cta_click`, `use_app_click`, `contact_intent`, `article_view`, `article_read_depth`, `loop_select`, mapping dataLayer params. Verified live on prod.
- [x] **Consent Mode v2** live on the marketing site (vanilla-cookieconsent, defaults denied before container). Full detail: [[Analytics — Marketing Site (canvasm.app) GTM Setup]].

**Shipped in the app (GTM/GA4 code wiring, 2026-07-08):**
- [x] App agent done: GTM loader (`GTM-KJWN2F2L`) behind `VITE_GTM_ID` (no-op when unset, same gating as PostHog) in `initGtm()` (`src/shared/lib/analytics.ts`), booted from `main.tsx`.
- [x] dataLayer identity push on the Clerk lifecycle: `identifyUser()` now emits `{ event: 'login' | 'sign_up', user_id: clerkUserId, ...utm }` — `sign_up` when the Clerk account was created <5 min ago (once ever per browser, `localStorage` guard), else `login`; fired at most once per session (`sessionStorage` guard) so SPA remounts don't inflate counts. `user_id` stays current on every hit; `resetAnalytics()` clears it on sign-out.
- [x] Semantic events mirrored: `track()` pushes the same flat `{ event, ...props }` to the dataLayer, so onboarding events (`welcome_seen`, `demo_copied`, `tour_*`, `canvas_created`, `checklist_dismissed`) reach GA4 via the container.
- [x] CSP: `www.googletagmanager.com` added to `script-src`; `googletagmanager.com` + `google-analytics.com` + `*.google-analytics.com` + `*.analytics.google.com` added to `connect-src` — **both** `vercel.json` header blocks (main + `/embed/*`).

**App container built + published (2026-07-08, via Stape GTM MCP):**
- [x] `GTM-KJWN2F2L` populated and **published as v1** ("App identity + onboarding events"). Google tag `G-F98ELRQJMT` on *Initialization - All Pages* with `user_id = {{DLV - user_id}}` (config setting → rides every hit). 6 DLVs (`user_id`, `path`, `source_example`, `at_step`, `completed`, `canvas_id`), 9 `CE -` triggers + 9 `GA4 Event -` tags for `login`, `sign_up`, `welcome_seen`(path), `demo_copied`(source_example), `tour_started`, `tour_completed`, `tour_skipped`(at_step), `checklist_dismissed`(completed), `canvas_created`(canvas_id). Mirrors marketing `GTM-T336859X` conventions; same measurement ID.

**Pending (owner):**
- [ ] Owner: set `VITE_GTM_ID=GTM-KJWN2F2L` in the app's Vercel env → redeploy. This is the last switch; loader stays inert until set. **Once set, GTM/GA4 goes live on use.canvasm.app.**
- [ ] Owner (GA4 admin, shared property): register custom dimensions for the params the site sends (`location`, `slug`, `title`, `tags`, `reading_time`, `depth`, `loop_id`, `loop_name`, `source`) **plus the app params** (`path`, `source_example`, `at_step`, `completed`, `canvas_id`); Reporting Identity = Blended; `sign_up` as key event. (`user_id` is user-scoped/automatic. Cross-domain: skip — shared root domain.)
- [ ] Optional QA: with `VITE_GTM_ID` set, use GTM Preview against use.canvasm.app to confirm `login`/`sign_up` + onboarding events fire with their params and `user_id` populates.
- [ ] Owner (later): PostHog activation funnel insight (`welcome_seen → demo_copied → tour_completed → canvas_created`); PostHog↔Supabase warehouse when enrichment questions arise.

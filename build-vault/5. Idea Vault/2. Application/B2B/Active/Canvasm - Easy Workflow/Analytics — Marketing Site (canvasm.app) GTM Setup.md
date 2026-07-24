# Analytics — Marketing Site (canvasm.app) GTM Setup

*Written 2026-07-08 · status of record for the **canvasm.app** (marketing) GTM/GA4 tagging. Companion to [[Analytics Identity — GA4, GTM, PostHog (Runbook)]]. This is the reference the **app GTM agent** should read so the `use.canvasm.app` container aligns with the marketing container — same GA4 property, same conventions, coherent reporting.*

---

## TL;DR for the app agent

- **Same GA4 property.** Use measurement ID **`G-F98ELRQJMT`** in the app container too. That property is what unifies reporting + identity; the two GTM containers are just separate tag surfaces (per the runbook's "2 GTM, 1 GA4" decision).
- **No cross-domain linker.** `canvasm.app` ↔ `use.canvasm.app` share the `.canvasm.app` root, so the `_ga` cookie is shared automatically. Do **not** configure a linker.
- **Marketing is anonymous** (GA `client_id` only). Identity (`user_id = clerkUserId`) is set **app-side** on `login`/`sign_up` — see the runbook. GA4 stitches the pre-login marketing history to the identified user via the shared client_id.
- **Consent Mode v2** defaults are set **denied** by the marketing site before its container loads. Keep the app's consent handling consistent (same four signals) so a user's choice is coherent across surfaces.
- **Mirror the naming conventions below** (snake_case events + params, `DLV - x` / `CE - x` / `GA4 Event - x` GTM objects, `gaawe` event tags) so both containers produce the same-shaped GA4 events.

---

## Container facts

| | |
|---|---|
| GTM account | **Canvasm** (`6364862843`) |
| Marketing container | **canvasm.app** — `GTM-T336859X` (containerId `257668837`) |
| App container | **use.canvasm.app** — `GTM-KJWN2F2L` (containerId `257660400`) — *empty as of writing; app agent to populate* |
| GA4 property (shared) | measurement ID **`G-F98ELRQJMT`** |
| Marketing container published | v3 "Content + product-exploration events" (2026-07-08) |

The marketing site loads `GTM-T336859X` `afterInteractive` + the standard noscript iframe. Container id lives in `SITE.gtmId` (`src/lib/site.ts`). Repo: `nadeemramli/metrimap-marketing`; code-side taxonomy doc: `docs/analytics-events.md`.

## How events get into GTM (the dataLayer contract)

The site fires everything through one typed wrapper (`src/lib/analytics.ts`) that pushes `{ event, ...props }` to `window.dataLayer` (and also to cookieless Vercel Analytics). GTM reads each prop as a **Data Layer Variable** named exactly like the prop key.

**Convention the app should copy:** push flat `{ event: '<snake_case>', <param>: <value>, ... }`. Values are strings/numbers only (arrays are pre-joined to comma strings, e.g. `tags`).

## Event → parameter contract (marketing)

| Event | Params | Meaning |
|---|---|---|
| `cta_click` | `location` | Primary "Get started" (sign-**up**) CTA |
| `use_app_click` | `location` | "Sign **in**" / open-app / live-demo link — distinct from sign-up |
| `docs_click` | `location` | docs.canvasm.app link (`header_nav`, `mobile_nav`) |
| `book_call` | `location` | "Book a discovery call" / consultation CTA |
| `contact_intent` | `location`, `subject` | Contact / demo mailto |
| `pricing_plan_click` | `plan`, `price`, `seats`, `action` (`signup`\|`contact`), `location` | Which plan |
| `faq_toggle` | `question` | Which FAQ questions matter |
| `article_view` | `slug`, `title`, `tags` (comma-joined), `reading_time` | Which posts + topics |
| `article_read_depth` | `slug`, `depth` (25/50/75/100) | How far readers get in an article |
| `page_scroll_depth` | `depth` (25/50/75/100), `page_path` | Site-wide scroll engagement |
| `loop_select` | `loop_id`, `loop_name`, `source` (`tab`\|`deeplink`) | Which operating loops resonate |
| `video_play` | `loop_id`, `loop_name` | Proxy for watching a loop's real-app demo video |
| `cookie_consent_update` | `analytics` (`granted`\|`denied`) | Consent choice (internal; no GA4 event tag) |

As of 2026-07-08 the marketing container (v4) has GA4 event tags for all of the
above except `cookie_consent_update`, each mapping its params. **Owner GA4 admin:
register the new params as custom dimensions** to see them in reports — the full
set is now `location, slug, title, tags, reading_time, depth, page_path,
loop_id, loop_name, source, plan, price, seats, action, question`.

All CTAs also carry launch **UTMs** (`utm_source=canvasm.app&utm_medium=site&utm_campaign=launch&utm_content=<location>`) into the app, where PostHog auto-captures them.

## GTM object naming (mirror in the app container)

- **Variables:** `DLV - <name>` — Data Layer Variable, version 2, name = the dataLayer key. (Marketing has: `location`, `slug`, `depth`, `subject`, `analytics`, `title`, `tags`, `reading_time`, `loop_id`, `loop_name`, `source`.)
- **Triggers:** `CE - <event>` — Custom Event, filter `{{_event}}` equals `<event>`.
- **Tags:**
  - `Google Tag - GA4 (G-F98ELRQJMT)` — type `googtag`, tagId `G-F98ELRQJMT`, on *Initialization - All Pages*. **Consent settings left at "Not set"** — the Google tag honors Consent Mode natively.
  - `GA4 Event - <event>` — type `gaawe`, `measurementIdOverride = G-F98ELRQJMT`, `eventName = <event>`, and an `eventSettingsTable` list of `{parameter, parameterValue: {{DLV - x}}}` rows.

The app container adds the app's own vocabulary on the **same** pattern: `login`, `sign_up` (with `user_id`), `canvas_created`, `tour_completed`, etc. — see the runbook's app event list.

## Consent Mode v2 (keep consistent)

Marketing sets defaults **before** the container loads (inline in `<head>`):

```
gtag('consent','default',{ad_storage:'denied',ad_user_data:'denied',
  ad_personalization:'denied',analytics_storage:'denied',wait_for_update:500});
gtag('set','url_passthrough',true);
```

CMP: **vanilla-cookieconsent** (open source, MIT, self-hosted). Accept/decline pushes `gtag('consent','update',…)` + a `cookie_consent_update` dataLayer event. With denied defaults, GA4 still sends cookieless modeled pings.

**App side:** whatever consent mechanism the app uses, keep the same four signals and default-denied-before-load posture so a user's consent is coherent across canvasm.app and use.canvasm.app.

## Owner GA4-admin steps (one-time, apply to the shared property)

These make the parameters above actually usable in reports — they're not GTM steps:

- **Register custom dimensions** (Admin → Custom definitions) for the event params we send, so they appear in reports: `location`, `slug`, `title`, `tags`, `reading_time`, `depth`, `loop_id`, `loop_name`, `source`. (Event-scoped; plus the app's `user_id` is user-scoped and automatic.)
- **Mark key events / conversions:** `sign_up` (the real conversion, app-side). Optionally `cta_click`, `contact_intent` as marketing micro-conversions.
- **Reporting Identity → Blended** (from the runbook).
- Cross-domain: **skip** (shared root domain).

## Verified working (2026-07-08)

End-to-end on production `canvasm.app`: Google tag fires with consent state (`gcs=G100` denied → `G111` granted on accept); `cta_click{location}`, `article_view{title,tags,reading_time}`, and `loop_select{loop_id}` all reach GA4 with their parameters. Consent banner gates cookie-setting; Vercel cookieless analytics run regardless.

## Cross-references

- [[Analytics Identity — GA4, GTM, PostHog (Runbook)]] — the identity spine (clerkUserId everywhere), the marketing→app stitch, server-side sequencing.
- Repo `docs/analytics-events.md` — code-side taxonomy + the `track()` wrapper.

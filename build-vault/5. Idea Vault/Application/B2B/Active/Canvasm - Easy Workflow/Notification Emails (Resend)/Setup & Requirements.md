# Notification Emails — Setup & Requirements (Resend + Supabase)

**Linear:** CVS-81 (Notification preferences backend + send pipeline)
**Status:** Design complete — **blocked on owner setup** (Resend account + domain + secret). Once the checklist below is done, hand back to the builder to implement the pipeline.
**Author:** Claude (builder) · 2026-07-04

---

## 1. Goal

Today, notifications only appear **in-app** (the bell + `/feed`). Notification preference toggles persist to `localStorage` only (`metrimap-notif-prefs`), and **no email is ever sent**. This delivers:

1. **Preferences in the backend** (a `notification_preferences` table) instead of localStorage, so choices sync across devices.
2. **An email send pipeline** — when a notification is created for a user, send them an email **if their preference for that type allows it**, via **Resend**.

## 2. What emails we send

There are exactly **three** notification types in the app today. Each gets one email template:

| Type | Fires when | Template | Suggested subject |
| --- | --- | --- | --- |
| `mention` | Someone @mentions you in a comment | `templates/mention.html` | `{{actor}} mentioned you in {{canvasName}}` |
| `assigned` | You're assigned to a metric card | `templates/assigned.html` | `You were assigned to "{{cardTitle}}"` |
| `alert` | A data/source **alert rule** trips | `templates/alert.html` | `⚠ Alert: {{cardTitle}} {{condition}}` |

> Source of truth: `notifications.type` — created by `comments.ts` (`mention`), `notify_card_assigned` RPC (`assigned`), and `emit_card_alert` / the alert-sweep cron (`alert`).

Each template is a **standalone, inline-CSS, 600px** HTML email (works in Gmail/Outlook/Apple Mail) with a header, the message, a **CTA button** deep-linking into the app, and a footer with a **"manage preferences"** link. Placeholders use `{{double_brace}}` tokens — see §7.

## 3. Architecture (how it will work once you've set up Resend)

```
notification INSERT (public.notifications)
        │
        ▼
 pg_cron (every 1 min)  ──calls──►  Edge Function: send-notification-emails (Deno)
        │                                   │
        │  1. select notifications where emailed_at IS NULL
        │  2. join notification_preferences → is email enabled for this (user,type)?
        │  3. resolve recipient email (Clerk user → users table)
        │  4. render the matching template with row data
        │  5. POST https://api.resend.com/emails   (RESEND_API_KEY from Vault)
        │  6. set notifications.emailed_at = now()
        ▼
    Resend  ──►  recipient inbox
```

- **Server-side only.** The Resend key never touches the browser (same posture as the System Health → Linear bridge).
- **Cadence:** a 1-minute `pg_cron` batch (simple + reliable, matches the existing alert-sweep cron). Near-instant email is a later upgrade (DB trigger → `pg_net`), not needed for v1.
- **Idempotent:** `emailed_at` guarantees one email per notification even if a cron run overlaps.
- **RLS-safe:** the edge function uses the service role for the send loop; per-user reads stay scoped.

## 4. Data model changes (builder will add these — listed so you know what's coming)

```sql
-- 1. Track which notifications have been emailed
ALTER TABLE public.notifications ADD COLUMN emailed_at timestamptz;

-- 2. Backend preferences (replaces localStorage). One row per user.
CREATE TABLE public.notification_preferences (
  user_id           text PRIMARY KEY DEFAULT public.requesting_user_id(),
  email_mention     boolean NOT NULL DEFAULT true,
  email_assigned    boolean NOT NULL DEFAULT true,
  email_alert       boolean NOT NULL DEFAULT true,
  inapp_mention     boolean NOT NULL DEFAULT true,
  updated_at        timestamptz NOT NULL DEFAULT now()
);
-- RLS: a user reads/writes only their own row.
```

Defaults = **opt-in** (email on) for all three types — revisit if you'd prefer opt-out.

## 5. ✅ Owner checklist — what I need from you (do these, then hand back)

Mirror of the Linear "pending owner" issue. Do them in order:

- [x] **1. Resend account** — confirm the workspace/team to use (existing or new).
- [x] **2. Sending domain** — add a domain in Resend → Domains. **Use the chosen subdomain** so it can't affect your root-domain deliverability: `notify.canvasm.app`.
- [x] **3. DNS records** — add the **SPF (TXT)**, **DKIM (TXT/CNAME)**, and (recommended) **DMARC (TXT)** records Resend shows you, at your DNS provider. Wait for Resend to mark the domain **Verified** (green).
- [x] **4. From identity** — current Supabase SMTP sender is From `Nadeem from Canvasm <team@notify.canvasm.app>`. Use this for Supabase Auth emails. For app notification emails, keep the Resend/Edge Function sender aligned unless a product-only sender is chosen later.
- [x] **5. API key** — create a Resend **API key** (sending scope). Copy it once.
- [x] **6. Store the key in Supabase** — add it as a secret the edge function reads. Either:
  - Supabase **Vault**: `select vault.create_secret('re_xxx', 'RESEND_API_KEY');`, **or**
  - Edge Function secret: `npx supabase secrets set RESEND_API_KEY=re_xxx`.
  - (Tell me which you used.)
- [ ] **7. App base URL** — confirmed target is **`https://use.canvasm.app`** unless product routing changes. Email CTAs should deep-link from this base URL (e.g. `/canvas/:id`).
- [ ] **8. Sender email resolution** — confirm the `public.users` table has recipients' **email** populated by the Clerk webhook (`CVS-74`). If some users have no email row, they simply won't be emailed (in-app still works). Run the SQL checks in §8 and flag if a backfill is needed.
- [ ] **9. (Optional) Preview + tweak templates** — open the 3 files in `templates/` in a browser, check branding/copy, and note any changes.
- [ ] **10. Hand back** — comment on the Linear issue with: domain verified ✓, key stored (Vault or secret?), from-address, confirmed base URL. Then I build the pipeline.

## 6. What I'll build once you hand back (no action needed from you)

1. Migrations: `notifications.emailed_at` + `notification_preferences` table + RLS.
2. Edge Function `send-notification-emails` (render template + Resend send + mark emailed).
3. `pg_cron` schedule (every 1 min) → `pg_net` call to the function (same pattern as the alert-sweep cron / System Health bridge).
4. Wire `AccountSettingsPage` toggles to read/write `notification_preferences` (replacing `localStorage`), keeping the same UX.
5. Move the 3 templates from this vault folder into the edge function; add a plain-text fallback part.
6. A manual-test sub-issue (send a real test notification of each type → email arrives / respects the toggle).

## 7. Template variables (contract between templates ↔ edge function)

Common to all templates:

| Token | Meaning |
| --- | --- |
| `{{appName}}` | "Canvasm" |
| `{{logoUrl}}` | hosted logo (or omit / inline) |
| `{{ctaUrl}}` | deep link, e.g. `https://use.canvasm.app/canvas/{{projectId}}` |
| `{{ctaLabel}}` | "Open in Canvasm" / "View card" |
| `{{preferencesUrl}}` | `https://use.canvasm.app/settings` (notifications section) |
| `{{year}}` | current year for the footer |

Per-type: `mention` → `{{actor}}`, `{{canvasName}}`, `{{excerpt}}`; `assigned` → `{{actor}}`, `{{cardTitle}}`; `alert` → `{{cardTitle}}`, `{{condition}}`, `{{value}}`, `{{threshold}}`.

> Identity note: to stay consistent with CVS-33, `{{actor}}` should be the **codename** (`userCodename()`), not a raw id or real name.

## 8. Supabase Auth Emails vs Canvasm Notification Emails

The Supabase dashboard page **Authentication → Emails** is for **Supabase Auth system emails**, such as:

- Confirm sign up
- Invite user
- Magic link or OTP
- Change email address
- Reset password
- Reauthentication
- Security notifications such as password changed, email changed, sign-in method changed, and MFA method changed

These are **not** the same as the Canvasm app notification emails in this plan.

Canvasm currently uses **Clerk** for user authentication, so the Supabase Auth templates are not the main product notification pipeline. The three app notification templates created for `CVS-81` are:

- `templates/mention.html`
- `templates/assigned.html`
- `templates/alert.html`

Those app notification templates will be rendered by the `send-notification-emails` Edge Function and sent through Resend. They do not depend on Supabase Auth email templates.

### If configuring Supabase Auth SMTP anyway

Use the same verified Resend sending domain:

- Enable custom SMTP: on
- Sender email: `team@notify.canvasm.app`
- Sender name: `Nadeem from Canvasm`
- SMTP host: `smtp.resend.com`
- SMTP port: `465`
- Minimum interval per user: `1` second
- SMTP username: `resend`
- SMTP password: Resend API key

Current screenshot state:

| Field | Value |
| --- | --- |
| Enable custom SMTP | On |
| Sender email address | `team@notify.canvasm.app` |
| Sender name | `Nadeem from Canvasm` |
| Host | `smtp.resend.com` |
| Port number | `465` |
| Minimum interval per user | `1` second |
| Username | `resend` |
| Password | Resend API key |

Security notification toggles worth enabling if Supabase Auth is used:

- Password changed
- Email address changed
- Sign-in method linked
- Sign-in method removed
- MFA method added
- MFA method removed

Leave **Phone number changed** off unless phone auth is enabled.

Do not spend time heavily customizing Supabase Auth templates unless Supabase Auth becomes user-facing. If needed, create a separate issue:

> Configure Supabase Auth SMTP and minimal branded auth templates.

### App base URL check

For Canvasm app notification emails:

- Use `https://use.canvasm.app` as the base URL.
- CTA example: `https://use.canvasm.app/canvas/{{projectId}}`
- Preferences example: `https://use.canvasm.app/settings`

For Supabase Auth emails:

- In Supabase, go to **Authentication → URL Configuration**.
- Set **Site URL** to `https://use.canvasm.app`.
- Add production redirect URLs for `https://use.canvasm.app/**`.
- Keep local/dev redirect URLs separately for development only.

### Recipient email check

Run this in Supabase SQL Editor before enabling app notification emails:

```sql
select
  count(*) as total_users,
  count(email) as users_with_email,
  count(*) filter (where email is null or email = '') as users_missing_email
from public.users;
```

Then inspect missing rows:

```sql
select *
from public.users
where email is null or email = ''
limit 50;
```

If `users_missing_email > 0`, create or update a follow-up under `CVS-74`:

> Backfill `public.users.email` from Clerk before enabling notification emails.

Do not send notification emails until the missing-email count is understood. In-app notifications still work without email.

---

**Related:** [[Project Memory - Metrimap]] · CVS-78 (live bell badge, done) · CVS-33 (codenames) · System Health → Linear bridge (same server-side secret pattern).

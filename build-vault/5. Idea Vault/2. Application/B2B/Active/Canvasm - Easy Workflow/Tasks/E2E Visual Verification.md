---
draft: false
title: "E2E Visual Verification"
date: "2026-07-06"
tags:
  - canvasm
  - qa
  - playwright
  - screenshots
  - clerk
  - visual-verification
---

# E2E Visual Verification

Canvasm has a Playwright screenshot harness for checking the running product before UI changes merge. It captures real app surfaces, including authenticated workspace routes and a real canvas, so layout regressions can be seen instead of inferred from code review.

This exists because an app-shell change previously shipped with a broken visual state: the logo overflowed the homepage and there was no reliable screenshot pass to catch it before merge.

## Current Implementation

The harness:

1. Starts Vite over HTTPS at `https://dev.canvasm.app:3000`.
2. Uses production Clerk credentials because Supabase only accepts JWTs from the production Clerk instance.
3. Signs in with a dedicated E2E test user.
4. Activates the real Teroka Digital organization.
5. Captures screenshots into `e2e/screenshots/`.

Implemented history:

- PR `#106`: initial Playwright + `@clerk/testing` harness.
- PR `#116`: HTTPS dev instance on `dev.canvasm.app`.
- PR `#126`: production Clerk + real-data canvas capture.
- First useful verification: CVS-163 filter popover checked on a real canvas before merge.

## How To Run

Run this from the relevant app worktree, for example `metrimap-home-settings`:

```bash
npm run screenshots
```

The script:

1. Runs `prescreenshots`.
2. Creates a self-signed cert in `e2e/certs/` if missing.
3. Starts the dev server with `E2E_HTTPS=1`.
4. Opens `https://dev.canvasm.app:3000`.
5. Signs in headlessly.
6. Saves PNG screenshots in `e2e/screenshots/`.

After it finishes, inspect:

- `e2e/screenshots/home.png`
- `e2e/screenshots/home-explore.png`
- `e2e/screenshots/catalog.png`
- `e2e/screenshots/feed.png`
- `e2e/screenshots/canvas.png`
- `e2e/screenshots/filter.png`

Add more screenshots in `e2e/visual.spec.ts` and `e2e/canvas.spec.ts` when new important surfaces land.

## Why HTTPS And Production Clerk Are Required

Two constraints drive the setup:

1. Supabase only trusts the production Clerk instance. Dev Clerk JWTs are rejected with `PGRST301: No suitable key was found to decode the JWT`, so authenticated data routes cannot load real canvases with `pk_test`.
2. Production Clerk is domain-locked to `canvasm.app` and needs a secure context. It rejects `localhost`, and `http://dev.canvasm.app:3000` fails because browser crypto and secure cookies require HTTPS.

The working combination is:

- Production Clerk publishable key.
- Production Clerk secret key for the Playwright setup.
- HTTPS dev server.
- `dev.canvasm.app` mapped to localhost.
- `https://dev.canvasm.app:3000` allowed in the production Clerk instance.

## One-Time Local Setup

Add this hosts entry if it is not already present:

```text
127.0.0.1 dev.canvasm.app
```

Add the local HTTPS origin to Clerk production `allowed_origins` only when the UI verification lane needs it:

```bash
curl -X PATCH https://api.clerk.com/v1/instance \
  -H "Authorization: Bearer $CLERK_SECRET_KEY" \
  -H "Content-Type: application/json" \
  -d '{"allowed_origins":["https://dev.canvasm.app:3000"]}'
```

Remove the local origin when the verification lane is done:

```bash
curl -X PATCH https://api.clerk.com/v1/instance \
  -H "Authorization: Bearer $CLERK_SECRET_KEY" \
  -H "Content-Type: application/json" \
  -d '{"allowed_origins":[]}'
```

Do not put real secret values in the vault. Keep them only in git-ignored `.env` files or the secret manager.

## Required Environment Variables

These belong in `.env`, not in the vault and not in git:

| Variable | Purpose |
|---|---|
| `VITE_CLERK_PUBLISHABLE_KEY` | Production Clerk publishable key used by the app. |
| `CLERK_SECRET_KEY` | Production Clerk secret used by `clerkSetup` and the temporary `allowed_origins` patch. |
| `E2E_TEST_EMAIL` | Dedicated test account email. Must belong to the real Teroka Digital organization. |
| `E2E_TEST_PASSWORD` | Dedicated test account password. |
| `E2E_CLERK_PUBLISHABLE_KEY` | Dev Clerk fallback key. Not useful for real data. |
| `E2E_CLERK_SECRET_KEY` | Dev Clerk fallback secret. |

The test user must be a member of the real Teroka Digital organization. The app is org-only, so the specs call `activateOrg()` after sign-in.

## Implemented Files

`playwright.config.ts`

- Loads `.env`.
- Uses production Clerk keys for the screenshot flow.
- Sets `baseURL` to `https://dev.canvasm.app:3000`.
- Ignores self-signed HTTPS errors.
- Uses system Chrome with `channel: "chrome"`.
- Starts the dev server with `E2E_HTTPS=1`.

`vite.config.ts`

- Adds `server.allowedHosts: [".canvasm.app"]`.
- Enables HTTPS only when `E2E_HTTPS` is set.
- Reads the self-signed cert from `e2e/certs/`.
- Leaves normal `npm run dev` as HTTP on localhost.

`e2e/global-setup.ts`

- Calls `clerkSetup()`.
- Fetches a Clerk Testing Token to bypass bot detection.
- Keeps dev-user creation guarded to `sk_test` only.

`e2e/visual.spec.ts`

- Signs in.
- Activates the org.
- Screenshots workspace routes:
  - `/`
  - `/?view=explore`
  - `/catalog`
  - `/feed`

`e2e/canvas.spec.ts`

- Signs in.
- Activates the org.
- Opens a real canvas.
- Screenshots the canvas and the toolbar filter popover.
- Exports `activateOrg`.

`e2e/certs/`

- Holds the self-signed certificate.
- Is git-ignored.
- Is generated automatically.

`package.json`

- Adds `screenshots`.
- Adds `prescreenshots` for certificate bootstrap.

## Runtime Flow

1. `prescreenshots` checks for `e2e/certs/key.pem` and `e2e/certs/cert.pem`.
2. If the cert is missing, it creates a local self-signed cert.
3. Playwright starts Vite with `E2E_HTTPS=1`.
4. Vite serves HTTPS at `dev.canvasm.app:3000`.
5. `global-setup` runs `clerkSetup()`.
6. Each spec calls `setupClerkTestingToken`.
7. The browser visits `/`.
8. Clerk signs in with the E2E account.
9. `activateOrg()` sets the active org.
10. Specs navigate to the target routes and save screenshots.

## What Future Agents Should Do

For UI lanes:

1. Run `npm run screenshots` before handing off or merging.
2. Inspect the PNGs, not only the terminal result.
3. Add new screenshot cases for new first-class surfaces, popovers, dialogs, and canvas states.
4. Mention screenshot results in the Linear handoff.
5. Create or update the manual-test child issue with any human visual checks that still need Nadeem's eyes.

For canvas or authenticated-data lanes:

1. Prefer real-data screenshots when the change affects canvases, cards, filters, dashboards, or org-specific navigation.
2. Keep the test account scoped to the real org.
3. Do not create production users or organizations unless Nadeem explicitly approves it.

## Gotchas

- Email aliases with `+` must be URL-encoded in Clerk API calls. Otherwise the `+` can be interpreted as a space and the user lookup fails.
- Dev Clerk needs Organizations enabled or an organizations-required dialog can cover screenshots. This is a dev config issue, not an app bug.
- Dev Clerk is not enough for real Supabase data because Supabase trusts the production Clerk issuer.
- Worktrees do not automatically inherit the git-ignored `.env`. Link or copy the local `.env` intentionally.
- The production Clerk `allowed_origins` entry is temporary. Remove `https://dev.canvasm.app:3000` when the lane is finished.

## Security Notes

- Never commit `.env`.
- Never paste `E2E_TEST_PASSWORD`, `sk_live`, or `sk_test` into Linear, the vault, PR descriptions, screenshots, or chat transcripts.
- Treat production Clerk configuration as a production-auth setting even when the origin points back to this machine.
- Do not auto-create production orgs or users from an agent. Ask Nadeem first.

## When To Use This

Use this harness for:

- Homepage and navigation redesign.
- Card, sheet, dialog, and popover UI changes.
- Canvas node, edge, toolbar, and filter changes.
- Dashboard and catalog changes.
- Any visual change that would be hard to trust from code review alone.

For routine backend-only work, this is optional unless the change affects authenticated routing or visible data state.

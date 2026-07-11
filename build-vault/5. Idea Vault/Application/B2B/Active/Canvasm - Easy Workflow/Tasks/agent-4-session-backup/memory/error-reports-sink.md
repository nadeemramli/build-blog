---
name: error-reports-sink
description: ErrorBoundary now lets users report crashes into a Supabase error_reports table + shows details in-UI
metadata: 
  node_type: memory
  type: project
  originSessionId: 013bc508-1cef-453e-8fd4-8a980115bb62
---

The "Something went wrong" `ErrorBoundary` (`src/shared/components/common/error/ErrorBoundary.tsx`) was upgraded 2026-07-03: it now shows an always-visible "Technical details" collapsible + Copy button (the old `NODE_ENV === "development"` gate was removed — it never showed in prod builds since we push straight to main), plus an optional note and a "Report this error" button.

Reports land in the `public.error_reports` table (migration `20260703120000_error_reports.sql`, applied to prod `iqrclwolhookzzmiedun`/metrimap-v2). It's an **insert-only sink**: RLS allows anon+authenticated INSERT, but NO select/update/delete — so **read reports via the Supabase dashboard (service_role) only**; there is no in-app admin UI yet. `clerk_user_id` is captured server-side from the JWT (null for anon); `reporter_*` are best-effort client hints.

The boundary is the outermost wrapper (above providers), so it reads identity hook-free via `useAppStore.getState().user` (+ `window.Clerk` fallback) and renders its own raw sonner `<Toaster>`.

**Why:** owner wanted crash reports sent "to me" instead of just Reload, and to see the log without DevTools. Chosen over mailto/Userback for reliability (lands in DB regardless of follow-up). **How to apply:** if extending, consider an admin view (needs a service_role/edge-fn read path since RLS blocks client reads). Related: [[commit-and-merge-preference]], [[system-health-linear-intake]].

**UPDATE 2026-07-03:** already caught a REAL recurring prod bug — 3 reports of "Minified React error #185" (Maximum update depth exceeded / infinite re-render loop) on `use.canvasm.app` canvas pages (`/canvas/:id`), multiple canvases, Jul 2-3. Left in the table as evidence (fingerprint null — predate the intake feature). Worth fixing.

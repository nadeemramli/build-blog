---
draft: false
title: "Development Backlog by Intake Group"
date: "2026-07-04"
tags:
  - canvasm
  - backlog
  - task-intake
  - operation
---

# Development Backlog by Intake Group

Canvasm-specific build backlog, organized by the five intake groups from the [[1. Development Operating System|Development Operating System]]. The general pipelines and reasoning live in `3. Operation`; this note is the **product-specific implementation backlog** — what to build so each intake group actually works for Canvasm.

Each per-group pipeline note has the same backlog with more context. This page is the single place to scan and promote items into Linear when they're concrete.

> **Legend:** ✅ live · 🔨 in progress · ⬜ to build. Promote a ⬜ to Linear only when it's a concrete, scoped follow-up (see the "promote to Linear" rules in each pipeline note).

## Group 1 — Strategy & Discovery

See [[2.a.i Strategy and Discovery Pipeline]]. Direction is documented in the PRD; discovery reasoning isn't yet pooled.

- ⬜ Enable **Linear Initiatives**; create the first Initiative per metric-tree objective (Projects underneath)
- ⬜ Initiative template (problem, hypothesis, success metric, scope, non-goals)
- ⬜ Hypothesis / bet register in the product vault
- ⬜ Experiment log (tried → metric → result → decision)
- ⬜ Competitive / market learning log
- ⬜ Define the "promote to Linear" bar for strategy work
- ⬜ Link each initiative to the metric-tree node it targets

## Group 2 — Product Evolution

See [[2.a.ii Product Evolution Pipeline]]. Rich backlog already exists in the repo (`BACKLOG.md`, `docs/backlog/*`, ADRs) — the gap is routing it through triage.

- ⬜ Build-log template (observation, why, decision, follow-up?)
- ⬜ Reconcile repo `BACKLOG.md` + `docs/backlog/*` into Linear follow-ups (keep rest as learning)
- ⬜ Habit: architecture-changing decision → ADR; concrete follow-up → Linear
- ⬜ Define the "promote to Linear" rule for evolution items
- ⬜ Tag evolution issues to the affected `area:*`
- Known open **P0s** to route: ⬜ autosave · ⬜ duplicate · ⬜ version history · ⬜ evidence persistence

## Group 3 — System Health

See [[2.a.iii System Health Pipeline]]. **Runtime-crash → Linear automation is LIVE** (verified in prod 2026-07-03, auto-filed CVS-19). Only React runtime exceptions are captured so far; widen the funnel next.

- ✅ Runtime crash → `error_reports` → group → pg_cron → edge fn → Linear (dedup, auto-resolve, regression reopen)
- ⬜ Global JS errors: `window.onerror` + `unhandledrejection`
- ⬜ API / network failures (Supabase + edge 4xx/5xx, unexpected RLS denials)
- ⬜ Failed background jobs / cron / edge functions
- ⬜ Performance: Web Vitals (slow pages) + slow queries (`get_logs` / `get_advisors`)
- ⬜ Build / deploy failures (Vercel) → System Health intake
- ⬜ Security / privacy: surface Supabase advisors as issues
- ⬜ Data-inconsistency integrity checks
- ⬜ In-app admin dashboard for error groups
- ⬜ Auto-prioritization via the `triage_score` model ([[2.c Agentic Triage Automation and Source Routing]])
- ⬜ Decide build-vs-adopt (e.g. Sentry breadcrumbs) feeding the same Linear bridge
- ⬜ Evaluate **Sentry** — passive capture (global JS/promise errors, perf) alongside the bespoke bridge
- ⬜ Evaluate **Snyk** — GitHub PR checks → bridge selected findings into Linear via API
- ⬜ Adopt **Linear Releases** — GitHub→Vercel via `linear-release` action; Done-on-deploy; regression keyed off release (Business+)

## Group 4 — Quality & Verification

See [[2.a.iv Quality and Verification Pipeline]]. Template + manual test plan + test tooling exist; the loop is still manual (Cowork → Linear by hand).

- ✅ Manual QA Finding Template + manual test plan; Vitest / Playwright / Storybook / RLS tests
- ⬜ Per-feature QA doc requirement (each shipped feature gets one, owned by builder)
- ⬜ `qa_findings` evidence table + semi-automated grouping → Linear
- ⬜ Grow Playwright coverage for core value flows (build → diagnose → govern). The authenticated visual screenshot harness is documented in [[E2E Visual Verification]].
- ⬜ Acceptance criteria in the Linear issue as a gate before "Ready"
- ⬜ Visual-regression checks for key component states
- ⬜ QA → learning-note loop for recurring findings

## Group 5 — User & Operations Signals

See [[2.a.v User and Operations Signals Pipeline]]. **Userback is live**; there's no product analytics or structured feedback clustering yet.

- ✅ Userback in-app feedback (bug / feature / general / visual, Clerk-identified)
- ⬜ Instrument PostHog: event taxonomy, onboarding-to-aha funnel, retention, session replay
- ⬜ Enable **Linear Customer Requests** + build the **Userback → API bridge** (`customerNeedCreate` / `customerCreate`)
- ⬜ Register community business owners as **Customers** (mark-important, customer-count views for prioritization)
- ⬜ `feedback_items` / `feedback_clusters` tables + clustering → Linear (only if native grouping insufficient)
- ⬜ Marketing incentives for feedback (referral/reward loop) — ties to `PRD/1. Distribution/*`
- ⬜ Closed-community program: launch to a cohort, hand-hold business owners, capture direct signal
- ⬜ Support workflow: request → UX issue / docs update / feature candidate
- ⬜ Onboarding-friction analytics tied to `PRD/3. Onboarding/*`
- ⬜ Interpret-before-Linear rule (cluster + name the job first)

## How to use this backlog

1. Scan for ⬜ items that have become concrete and scoped.
2. Shape them (problem, expected outcome, acceptance criteria) using [[Templates/1. Linear Intake Template]].
3. Create the Linear issue in **Intake/Triage** — Cowork plans and writes Linear; Claude Code builds from it.
4. Flip the item to 🔨, then ✅ when shipped, and capture any reusable lesson as a learning note.

## Related

- [[1. Development Operating System]] · [[2.a Task Sources and Intake Groups]] · [[2.c Agentic Triage Automation and Source Routing]] · [[5. Implementation Roadmap]]

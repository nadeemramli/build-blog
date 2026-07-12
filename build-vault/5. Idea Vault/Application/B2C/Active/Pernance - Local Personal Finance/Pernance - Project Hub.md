---
title: Pernance - Project Hub
description: Project hub for a private local-first personal finance evidence engine.
created: 2026-07-12
updated: 2026-07-13
status: active-build
review_date: 2026-08-09
product: Pernance
platform: Tauri desktop
tags: [project-hub, b2c, active, personal-finance, local-first]
---

# Pernance - Project Hub

Pernance is a local-only personal finance application that turns user-imported statements and balance snapshots into an auditable cash-flow ledger, commitment model, budget, behavior review, freedom/runway calculation, and net-worth record.

Its purpose is not to tell the user what to value or automatically allocate money. Its purpose is to create reality contact: what came in, what went out, which movements were transfers, what is recurring, which commitments are already funded, what is liquid, and which conclusions are supported by reconciled evidence.

## Product promise

Import a monthly or quarterly statement, resolve the review queue, and receive a reconciled view of:

- Cash in and cash out.
- True recurring burn versus one-time purchases.
- Internal transfers that must not be double-counted.
- Subscriptions and contractual/household commitments.
- Spending patterns and user-owned behavior experiments.
- Survival, maintenance and independence floors.
- Liquid runway and freedom targets.
- Stock-covered future needs without treating stock as cash.
- Assets, liabilities, liquidity classes and net worth.

## Current status

- Product discovery and PRD: complete as of 12 July 2026.
- Architecture: proposed and assessed (see Linear project doc "Architecture Assessment — 2026-07-12"); encryption spike (PFN-9) still required before the storage layer is locked.
- Code repository: created 12 July 2026 at `~/workspace/github.com/nadeemramli/pernance` (WSL), bootstrapped per the DevOS Bootstrap Protocol — Cargo workspace, Tauri v2 + Svelte 5 shell, money/journal invariants under property tests, baseline commit `6c5f003`.
- Phase 1 sources selected: HSBC bank, GXBank, and TNG eWallet across the same three-month period. Exact native formats and adapter order will be locked from representative files supplied locally by the user (Linear PFN-2).
- Build-sprint admission: **admitted 12 July 2026.** Pernance and Twinagent run as separate product tracks by explicit user decision; neither is treated as displaced by the other (Linear PFN-1 should reflect this clarification).
- Work tracking: Linear team Pernance (PFN), project https://linear.app/canvasm/project/pernance-d528f7a48131 — milestones M0–M4 + Phase 2–4, issues PFN-1…38.

## Admission record

| Question | Working answer |
| --- | --- |
| Evidence | PA Control's Point A remains provisional because cash, debt, subscriptions, business commingling and current burn are stale or incomplete. |
| Strategic role | Cash/liquidity evidence for the Operating System and PA Control; finance/data-engineering/software proof for the operator-investor path. |
| Smallest falsifiable test | Import HSBC, GXBank, and TNG across one aligned three-month window; reconcile each source, match cross-account transfers, classify the review queue, and reproduce a trusted consolidated sources-and-uses statement. |
| Work displaced | None by current user decision. Pernance and Twinagent run separately, while each retains its own scope, next action, evidence target and review date. |
| Time/capital at risk | Primarily build time; no bank-provider subscription or hosted infrastructure in the initial product. |
| Continue signal | Two consecutive monthly closes reconcile, take under 15 minutes after rules learn, and expose a decision-relevant fact not reliably available from the current manual ledger. |
| Kill/redesign signal | Actual statements cannot reconcile, import correction remains burdensome after templates, privacy requires cloud processing, or the app only reproduces a spreadsheet with more maintenance. |
| Review date | 9 August 2026 or after the second real close, whichever comes first. |

## Source-of-truth boundary

- Pernance local vault: raw statements, import batches, normalized transactions, reconciliation state, local calculations and audit history.
- Operating System: accepted monthly personal-finance summary, current assumptions and decision-ready reports.
- Build Vault: product requirements, architecture, build journal and anonymized test fixtures only.
- PA Control: decision-level liquidity, solvency, transition and portfolio signals only.

Never commit real bank statements, account numbers, unredacted transaction exports, encryption keys or production database files into the Build Vault or source repository.

## Project documents

- [PRD](<./PRD.md>)
- [Architecture and Data Model](<./Architecture and Data Model.md>)
- [Phase 1 Breakdown](<./Phase 1 Breakdown.md>)
- [Maybe Finance Reference](<./Reference/Maybe Finance Reference.md>)

## Next decision

Supply one representative native export from HSBC, GXBank, and TNG locally and choose the aligned three-month window (Linear PFN-2). Also decide statement retention default (PFN-3) and unlock model (PFN-4). These gate the M0 encryption spike's acceptance and the M1 adapter order.

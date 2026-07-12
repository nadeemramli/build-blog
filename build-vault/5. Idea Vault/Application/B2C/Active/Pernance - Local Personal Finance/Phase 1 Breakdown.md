---
title: Pernance Phase 1 Breakdown
description: Milestones and acceptance criteria for the first reconciled local cash-flow slice.
created: 2026-07-12
updated: 2026-07-13
status: active-phase-1
tags: [pernance, phase-1, breakdown, active]
---

# Pernance Phase 1 Breakdown

## Goal

Import an aligned three-month period from HSBC, GXBank, and TNG, preserve the source evidence locally, reconcile every source and statement period, resolve cross-account transfers/classification through a review queue, and produce a trusted consolidated sources-and-uses cash-flow report.

Phase 1 is successful only if it creates correct evidence. Budgeting, behavior, freedom, inventory and net worth do not enter the build until the ledger closes reliably.

## Entry gates

- [x] Pernance is admitted and runs separately from Twinagent by explicit user decision.
- [ ] One representative native export from HSBC, GXBank, and TNG is supplied locally and approved for private development use.
- [ ] Choose one aligned three-month window covered by all three sources.
- [ ] A redacted/synthetic derivative is created for committed test fixtures; the real file stays outside the repo/Build Vault.
- [ ] Statement retention default is decided.
- [ ] Unlock and encrypted-backup expectations are decided.

## Milestone 0 - Domain and privacy spike

- [ ] Create Cargo workspace with `domain`, `import`, `store`, `report` and Tauri app boundaries.
- [ ] Lock money type: integer minor units + currency.
- [ ] Implement balanced journal/posting invariants with property tests.
- [ ] Prove encrypted local database and retained-file encryption.
- [ ] Prove lock/unlock, inactivity lock and encrypted backup/restore.
- [ ] Configure narrow Tauri capabilities and no network permission.
- [ ] Verify logs contain no raw financial payload.

Exit evidence:

- Encrypted vault cannot be opened outside the app without its key.
- Restore works into a clean profile.
- Frontend cannot read an arbitrary local file or execute arbitrary SQL.

## Milestone 1 - Import evidence

- [ ] Manual account creation during onboarding/import.
- [ ] Generic CSV mapping wizard with saved per-account template.
- [ ] File hash, import batch, immutable raw rows and parser version.
- [ ] Exact duplicate and overlapping-period detection.
- [ ] Parse preview: row count, debit/credit totals, dates, warnings, opening/closing balances.
- [ ] Institution adapters for the actual HSBC, GXBank, and TNG native formats, sequenced after file inspection; generic CSV/tabular mapping remains the fallback.
- [ ] Revert import batch.

Exit evidence:

- Same file imported twice produces zero new facts.
- Parser output matches the statement row count and signed totals.
- Real source data never appears in the repo, logs or Build Vault.

## Milestone 2 - Ledger and reconciliation

- [ ] Normalize imported records into balanced journal entries/postings.
- [ ] Support cash/bank, credit-card and controlled unclassified accounts required by the first source.
- [ ] Opening/closing reconciliation with discrepancy drill-down.
- [ ] Balance correction as a distinct evidence-backed event.
- [ ] Closed period, reopen-on-change and stale-report states.
- [ ] Rebuild report inputs deterministically from ledger revision.

Exit evidence:

- Every target statement satisfies opening + activity = closing, or displays an explicit accepted exception.
- Journal is balanced by currency.
- Editing history makes prior close reports stale rather than silently changing them.

## Milestone 3 - Review queue, transfers and classification

- [ ] Impact-ranked review queue.
- [ ] Merchant normalization while preserving original description.
- [ ] Category, commitment layer, ownership, recurrence and tags as separate fields.
- [ ] Suspected transfer matching by amount/date/account.
- [ ] Credit-card payment treatment if applicable.
- [ ] Split transaction and refund/reversal handling.
- [ ] Explainable rules created from user decisions.
- [ ] Bulk edit, undo and audit history.

Exit evidence:

- Internal transfers do not inflate spending or income.
- User can explain every automated classification from its rule/evidence.
- Material ownership/transfer decisions require confirmation.

## Milestone 4 - Cash-flow UI and monthly close

- [ ] Home view: liquid cash, net cash change, recurring burn, next commitment and review status.
- [ ] Transactions table with search, filters, bulk review and source drill-down.
- [ ] Sources-and-uses statement.
- [ ] Recurring economic-burn view with one-time separation.
- [ ] Income reliability labels.
- [ ] Reconciliation coverage and unresolved amount on every report.
- [ ] Monthly-close checklist and immutable close snapshot.
- [ ] Export sanitized close summary to a user-selected local path.

Exit evidence:

- User can trace every aggregate to underlying postings and source rows.
- Cash-flow report explains at least 95% of movement; the rest is visibly unresolved.
- Second monthly close takes less than 15 minutes after rules learn.

## Phase 1 acceptance

1. Import HSBC, GXBank, and TNG across the same three-month window.
2. Re-import and overlap tests create no duplicates across any source.
3. Each statement reconciles or carries a documented exception.
4. Cross-account transfers and card payments do not double-count.
5. All reports identify ledger revision and reconciliation coverage.
6. Vault, retained statements and backups meet the encryption spike.
7. App performs the complete workflow with networking disabled.
8. Operating System export contains summaries only and requires explicit preview/confirmation.
9. Two closes reveal whether Pernance materially improves the current process.

## Explicitly out of Phase 1

- Multiple bank adapters beyond the selected source and generic CSV.
- OCR for scanned statements.
- Automated bank connectivity.
- Budgets and sinking funds.
- Subscription detection beyond manually confirmed recurrence.
- Behavior insights.
- Freedom/runway calculations.
- Stock-aware commitments.
- Net worth and scenarios.
- Local language model or chat.
- Mobile, cloud sync or multi-user support.

## Kill or continue review

Continue to Phase 2 only if:

- Reconciliation is reliable.
- Monthly use becomes faster than the manual process.
- User corrections produce reusable rules.
- The reports change or clarify a real cash/liquidity decision.
- Privacy works without awkward manual security steps that destroy usability.

Otherwise redesign the import/review loop or stop before adding more modules.

## Links

- [Project Hub](<./Pernance - Project Hub.md>)
- [PRD](<./PRD.md>)
- [Architecture and Data Model](<./Architecture and Data Model.md>)

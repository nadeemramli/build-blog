# Build log — 2026-07-14: Transfer review, audited decisions, materiality threshold (PFN-25)

Commits `b06b031` + `8cb7359` on `main`. In Review; manual test PFN-58.

## What landed

- **Transfers card in the labelling view**: suggested pairs (Confirm / Not a transfer), confirmed pairs (Unmatch), rejected pairs re-matchable under a toggle. Decisions immediately update transfer chips and the Income card exclusions.
- **Audited, reversible decisions** (schema V8 `audit_event`): `set_transfer_status` is now a validated transition machine — suggested→confirmed/rejected, confirmed→suggested (unmatch), rejected→suggested (re-match). Every transition writes an audit row inside the same transaction; invalid moves are refused. First use of the AuditEvent convention from CLAUDE.md — other mutating ops (classify, imports) still don't write audit events; adopt incrementally.
- **Materiality threshold** (Settings → Transfers, stored in `app_setting` as minor units): suggested pairs at or below the threshold that moved same/next day auto-confirm during matching, audited as `transfer-auto-confirmed`. Default is empty = fully manual, so *material transfers always require confirmation* holds trivially and small recurring wallet top-ups can be waved through by choice. The RM amount is parsed in Rust (`money_text::parse_minor_units`) — no frontend money arithmetic.
- **Card payments end-to-end**: source profiles now carry `account_kind` (asset | liability); the pipeline normalizes onto that kind, so a card source's statement lands on a liability account and the bank→card payment matches as cash → liability. Settings has a "Credit card (liability)" option.
- **Aggregates + proof**: `month_flow_totals` (income and spending with confirmed-transfer legs excluded from both sides), a dedicated card-payment test (purchases counted once, payment never a second expense, card balance = remaining debt), and a proptest: for arbitrary generated ledgers, whatever pairing the greedy matcher picks, confirmed pairs drop out of both aggregates exactly, net to zero, and matching never mutates balances.

## Decisions

- **Threshold semantics**: auto-confirm requires *both* amount ≤ threshold *and* day-gap ≤ 1. Confidence alone was rejected as the gate because it's derived from the gap anyway and a same-amount coincidence weeks apart should never silently confirm.
- **Unmatch goes back to `suggested`**, not deletion — the link (and its audit trail) is the durable record; deleting would forget the pairing evidence.
- **`account_kind` folded into the unreleased V8 migration** rather than a V9 — no build with V8 had shipped to Windows yet.

## Open / follow-ups

- Audit events cover transfer decisions only; classify/import/close mutations still unaudited (CLAUDE.md says every mutating op should write one — worth a small Linear issue if it should be systematic).
- Matching remains exact-amount only; cross-currency and fee-tolerant matching (e.g. RM50.00 out, RM49.00 in + RM1 fee) are out of scope.
- PFN-19 remainder (accepted_exception / stale reconciliation flows) still open.

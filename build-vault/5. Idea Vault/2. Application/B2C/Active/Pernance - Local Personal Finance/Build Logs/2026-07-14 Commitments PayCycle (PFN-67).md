# Build log — 2026-07-14: Commitments / PayCycle (PFN-67)

Commit `6973eee` on `main`. In Review; manual test PFN-68. Concept source: Nadeem's PayCycle doc v0.1 (28 Jun 2026).

## What landed

- **Salary-cycle engine** (schema V9 + `commitments.rs`): with salary on day S, a cycle covers dues from S up to the day before the next S — due Jul 19 / salary 23rd → June 23 cycle. Pure function, unit-tested including year rollover. Salary day is a vault setting (1–28, Settings card, default 25).
- **Commitments tab**: summary bar (remaining committed, debt-free-after cycle), cycle groups mirroring the manual master-schedule tables, per-due paid **checkbox** (reversible, audited — the thing the LLM-chat workflow couldn't do), inline editor for amount corrections and date shifts (re-groups cycles automatically).
- **Add form**: per-installment amount × count, every-N-days, "already paid" count, and first due either as a date or as **days-from-today** exactly as BNPL apps display — anchored to today in SQL, honoring the "days remaining anchored to today" constraint from the concept doc.

## Decisions

- Commitments are **plans, not ledger facts** — separate tables, no journal entries, no effect on reconciliation or income/spending aggregates. The evidence loop (statement row proves a due was paid) is deferred and designed to ride PFN-66's matching machinery.
- `seq_total` kept per due (not derived) so plans can be extended without renumbering.
- Salary day restricted to 1–28 to avoid month-length clamping rules.

## Discovery

The Purchase Orders folder (`operating-system/4. Management/Purchase Orders`) has machine-readable YAML frontmatter per PO (`po_id`, `date`, `vendor`, `total_rm`, `item_count`) — PFN-66's enrichment source can parse those notes directly, no CSV export needed. Key shaping insight posted to PFN-66: a PayLater-paid PO should *generate* a commitment plan, and statement rows then match the plan's dues — PO ↔ commitment ↔ statement becomes one chain.

## Deferred (from the concept doc)

Auto-checkmark from statements, salary buffer warnings (vs income_source expectations), new-purchase simulator, screenshot OCR intake, multi-salary cycles.

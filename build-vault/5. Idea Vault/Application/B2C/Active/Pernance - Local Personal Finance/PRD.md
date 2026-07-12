---
title: Pernance PRD
description: Product requirements for a private local-first cash, liquidity, commitments, freedom and net-worth evidence engine.
created: 2026-07-12
updated: 2026-07-13
status: active-build-draft
review_date: 2026-08-09
product: Pernance
platform: Windows desktop via Tauri v2
tags: [prd, pernance, personal-finance, local-first, tauri, rust]
---

# Pernance PRD

## 1. Product summary

Pernance is a private local-first desktop application that converts user-supplied bank statements, account balances and manual financial facts into a reconciled personal-finance evidence system.

The first product loop is:

**Import -> normalize -> reconcile -> review uncertain items -> classify -> learn rules -> produce cash-flow and liquidity evidence.**

The later loop extends that foundation into commitments, subscriptions, budgets, spending patterns, stock-aware freedom calculations, scenarios and net worth.

Pernance does not make capital-allocation decisions, move money, connect to banks in the initial product, or present generic financial advice as truth. It shows the data, assumptions, uncertainty and consequences so the user can decide.

## 2. Why this product exists

The current personal finance system has useful principles but weak current evidence:

- Bank activity is not ingested into one reconciled ledger.
- Cash, debt, business money and commitments are updated manually and become stale.
- Subscription and recurring-tool spend can change faster than the Monthly Nut.
- Personal and business money may be commingled.
- Transfers can be double-counted as income or expense.
- One-time stock purchases distort monthly spending, while stock coverage can make near-term cash needs look lower than long-run consumption.
- Freedom targets change depending on survival, maintenance, independence and employment scenarios.
- Net worth requires balances and valuations that transaction imports alone cannot infer.
- Behavior conclusions are easy to narrate without enough dated evidence.

Pernance should close those gaps without asking the user to trust a cloud service with full financial history.

## 3. Target user

### Primary user

A privacy-sensitive operator with several income sources, personal and household commitments, business activity, subscriptions, debts, restricted retirement assets, consumption stock, and changing employment scenarios.

### Future user profile

A solo builder or household that wants local control, is willing to import statements monthly or quarterly, and prefers auditability over automatic bank connectivity.

### Jobs to be done

- "When I import a statement, show me that every line and balance is accounted for."
- "Help me resolve uncertain transactions quickly and remember my decisions."
- "Tell me my actual recurring cash burn without double-counting transfers or letting one-time purchases distort the pattern."
- "Show which commitments are fixed, variable, temporary, annual, debt-related or already stocked."
- "Calculate runway and freedom using the floor I select and the cash that is genuinely liquid."
- "Show net worth while distinguishing liquid, restricted, business, illiquid and uncertain assets."
- "Help me observe behavior and run experiments without moralizing or making decisions for me."

## 4. Product principles

1. **Reconciliation before insight.** No dashboard claim outranks an unreconciled source.
2. **Evidence before automation.** Preserve source lineage, original values and user decisions.
3. **Local by default.** Core use must work with networking disabled.
4. **Cash is not consumption; consumption is not liquidity.** Show all three separately.
5. **Transfers are first-class.** Never hide uncertainty inside an "other" category.
6. **Pipeline is not income.** Income carries reliability, source and end date.
7. **Stock shifts timing, not reality.** Consumable inventory may defer future purchases but is not liquid cash.
8. **Rules suggest; the user confirms.** Every automated classification is explainable and reversible.
9. **Behavior without shame.** Describe patterns, expose trade-offs and let the user define experiments.
10. **Simple surface, rigorous core.** The home view stays calm even when the ledger is precise.

## 5. Success definition

### Product success

- Two consecutive monthly closes reconcile across HSBC, GXBank, and TNG.
- Re-importing the same file creates zero duplicate transactions.
- After rules learn, the user completes a monthly review in under 15 minutes for the initial account set.
- Internal transfers do not inflate income or spending.
- The app can reproduce opening balance + net activity = closing balance for every statement period.
- The cash-flow view explains at least 95% of cash movement; unresolved items remain visible rather than silently excluded.
- The user can identify current liquid cash, true recurring burn, next 90-day commitments and freedom runway from one accepted close.
- The app produces at least one decision-relevant correction to the manual Financial OS during validation.

### Evidence success for the career thesis

- Demonstrates local data ingestion, normalization, reconciliation, financial-domain modeling, privacy architecture, Rust/Tauri delivery and decision-oriented UX.
- Produces an anonymized case study without exposing real statements, balances or merchants.

## 6. Product scope and terminology

### The three financial truths

| View | Question | Example treatment |
| --- | --- | --- |
| Cash movement | What entered or left an account in this period? | A bulk stock purchase is cash out now. |
| Economic consumption | What resources were consumed to sustain the period? | The stocked item burns gradually over its coverage period. |
| Liquidity | What value is available to meet an obligation now? | Stored consumables do not count as liquid cash. |

The UI must never collapse these into one number.

### Classification dimensions

Each ledger item may carry independent dimensions:

- **Cash-flow class:** income, operating/living outflow, debt principal, interest/fees, investment/asset acquisition, asset sale, financing inflow, internal transfer, refund/reversal.
- **Category:** food, transport, household, tools, health, education, dependent, housing, etc.
- **Commitment layer:** essential, foundational, executional, discretionary, excluded/unresolved.
- **Recurrence:** fixed recurring, variable recurring, annual/lumpy, installment, one-time, unknown.
- **Ownership:** personal, household, dependent, business, reimbursable, shared.
- **Project/person tags:** user-defined dimensions such as Ayra, INDEXA, Teroka or ACCA.
- **Evidence state:** imported fact, user-confirmed, rule-suggested, inferred, stale or unresolved.

These dimensions must not be encoded as one overloaded category tree.

## 7. Core user journeys

### 7.1 First-run vault setup

1. User creates a Pernance vault and selects base currency, locale, date format and financial month start.
2. User chooses unlock method and encrypted-backup policy.
3. App creates no network permission and shows an always-visible local/offline state.
4. User creates accounts or creates them during import.
5. User selects initial review dimensions; defaults may be edited later.

Acceptance:

- A vault can be created, locked, reopened and backed up without internet access.
- Losing the unlock secret is clearly explained as potentially unrecoverable.
- No analytics, crash payload, document content or account data leaves the device.

### 7.2 Statement import

1. User selects CSV, OFX/QFX/QIF if supported, or a PDF statement through the system file picker.
2. User chooses/creates the account and statement period.
3. Pernance fingerprints the file, identifies a saved import template, and shows the parse preview.
4. User maps columns/fields when no adapter is available.
5. App shows opening/closing balances when present, row count, total debits/credits and parsing warnings.
6. Duplicate and overlapping periods are detected before commit.
7. Import is committed as one reversible batch.

Requirements:

- CSV is the reliability-first generic path.
- The first PDF release supports adapter-based text/table PDFs for one institution selected from real user evidence.
- Scanned-image OCR is a later local-only fallback, never silently trusted.
- Password-protected PDFs may be unlocked in memory; the password must not be logged or retained by default.
- Every imported field retains source file, page/row, original text and parser version.
- The raw statement is optionally retained in encrypted storage; the default may retain only a hash and normalized raw records after user confirmation.

### 7.3 Reconciliation

The app proves:

`opening balance + signed imported activity = closing balance`

It also supports a user-entered balance snapshot when the statement does not expose both endpoints.

Requirements:

- Show the discrepancy and the exact records contributing to it.
- Support pending-versus-posted timing, statement date boundaries and user-created reconciliation notes.
- Never create a fake spending transaction to force a zero difference.
- A balance correction is a distinct reconciliation event with source, reason and user confirmation.
- Imported batches can be reverted without deleting unrelated user rules or prior accepted periods.

### 7.4 Review queue and learning

The queue groups work by impact:

1. Reconciliation blockers.
2. Suspected duplicate or transfer pairs.
3. Business/personal ownership uncertainty.
4. Unclassified high-value or recurring items.
5. Low-confidence merchant/category suggestions.

User actions:

- Confirm or reject merchant normalization.
- Match transfer pairs.
- Split a transaction across categories/owners.
- Mark refund, reimbursement, installment, one-time or recurring.
- Apply category, commitment layer and tags.
- Save an explainable rule from the decision.
- Undo/bulk edit with an audit record.

The app must show why a suggestion exists: exact merchant rule, previous user decisions, amount/cadence similarity or local model confidence.

### 7.5 Monthly close

The close checklist requires:

- Statement coverage complete for all included accounts.
- Every period reconciled or explicitly accepted with a documented discrepancy.
- Transfers resolved above the configured materiality threshold.
- Unresolved amount and record count visible.
- Personal/business cash boundary reviewed.
- Balance snapshots refreshed for non-transaction assets and liabilities when due.
- Cash-flow, budget, commitments and net-worth snapshots generated from the same ledger version.

A closed period is immutable by default. Later edits reopen the period and mark derived reports stale until reclosed.

## 8. Feature requirements

### 8.1 Accounts and balances

Account types:

- Cash, bank, e-wallet.
- Credit card and revolving debt.
- Loan/payable/receivable.
- Investment and retirement account.
- Business money held personally.
- Property/vehicle/other asset.
- Consumption stock reserve.

Every account/asset has currency, ownership, institution label, liquidity class, inclusion rules, source date and confidence.

Liquidity classes:

- Immediate personal cash.
- Near-cash with time/penalty.
- Restricted retirement.
- Business-restricted.
- Illiquid asset.
- Consumable stock.
- Uncertain/unverified.

### 8.2 Ledger and transfers

- Preserve raw imported records separately from normalized ledger facts.
- Represent one transaction as one balanced journal event with one or more postings.
- Match transfers by amount, currency, timing, account pair and user rules.
- A credit-card payment normally transfers cash to a liability and must not double-count the original card expenses.
- A loan payment can split principal, interest and fees.
- Support refunds, chargebacks, reimbursements, cash withdrawals, deposits and foreign-currency fees.
- Monetary values use integer minor units or fixed decimals; never binary floating point.

### 8.3 Merchant, category, tags and rules

- Preserve original bank description beside normalized merchant.
- Category nesting is shallow and editable.
- Tags are many-to-many and independent from category.
- Rule predicates may use account, original description, merchant, amount range, direction, date/cadence and prior classification.
- Rule actions can suggest or apply fields; destructive or ownership-sensitive actions default to review.
- Rule preview shows affected historical/future records before activation.
- Every rule application records rule version and can be reverted.

### 8.4 Subscriptions and commitments

Recurring detection should propose a series when merchant/description and amount/cadence patterns recur. The user confirms whether it is:

- Subscription.
- Contractual commitment.
- Household/dependent commitment.
- Debt service.
- Annual renewal/sinking-fund item.
- Variable recurring essential.
- Temporary recurring item with end date.

Each commitment supports amount model, cadence, start/end date, renewal date, cancellation notice, owner, importance/floor, funding state and evidence.

The app must not label a transaction a subscription solely because it appears twice.

### 8.5 Cash-flow statement

Provide two connected views:

1. **Sources and uses of cash:** direct, understandable view of income received, living/operating outflows, debt cash flows, investing/asset cash flows and net cash change.
2. **Recurring economic burn:** normalized consumption view excluding internal transfers and separating one-time/lumpy cash events.

Required breakdowns:

- Actual versus prior period.
- Actual versus trailing median/average.
- By category, commitment layer, ownership, account, merchant and tag.
- Reliable, temporary, variable and one-time income.
- Personal cash versus business/reimbursable cash.
- Unresolved amount and confidence coverage.

### 8.6 Budgeting and sinking funds

Budget creation begins from evidence, not a blank ideal:

- Suggest a baseline from three to six reconciled months.
- Separate fixed commitments, variable baselines, annualized sinking funds, debt plans, one-time decisions and savings/investing transfers.
- Support survival, maintenance and independence budget profiles.
- Show planned, actual, forecast and variance.
- A variance is descriptive; it does not automatically roll forward or cut another category.
- The user can record a decision note and future review date.

### 8.7 Spending patterns and behavior

Possible observations:

- Subscription creep and price increases.
- Merchant/category trend changes.
- Convenience or impulsive-spend clusters defined by the user.
- Payday/timing effects.
- Increasing fixed-commitment ratio.
- Income concentration and volatility.
- Repeated one-time expenses that are actually recurring.
- Business/personal commingling.
- Forecast misses and habitual underbudgeting.

Behavior requirements:

- Use neutral language and show the supporting transactions.
- Separate correlation from causal claim.
- Let the user dismiss, relabel or suppress an insight.
- Support a user-owned experiment with hypothesis, start/end date, target signal and review.
- Do not use shame scores, manipulative streaks or autonomous restrictions.

### 8.8 Freedom, runway and optionality

User selects a floor profile:

- Survival.
- Maintenance.
- Independence.
- Custom scenario.

Core calculations:

- `liquid runway months = eligible liquid personal reserves / selected monthly cash floor`
- `emergency target = selected floor x target months + due lumpy commitments - eligible dedicated reserves`
- `freedom target = selected floor x freedom months x user-defined contingency/inflation factor + known lumpy commitments`
- `commitment ratio = fixed and highly probable commitments / reliable income`
- `coverage gap = target reserve - eligible funded reserve`

Income sources carry reliability and end dates. Scenario results show strict, base and upside cases rather than one blended income number.

### 8.9 Stock-aware commitment model

This general-purpose feature models user-owned consumption inventory such as household supplies, work consumables or other recurring goods. It must not recommend medical use, dosing or acquisition.

For each item:

- Quantity on hand and unit.
- As-of date and evidence confidence.
- User-provided consumption rate or replacement cadence.
- Current replacement price and source date.
- Shelf life/expiry when relevant.
- Reorder threshold and lead time.
- Ownership and whether resale is realistic.

Outputs:

- Coverage through date.
- Expected next purchase window.
- Future cash requirement by month/quarter.
- Economic monthly consumption.
- Cash already prepaid into stock.
- Stale/missing-input warnings.

Rules:

- Stock may reduce near-term purchase cash but never increases liquid runway.
- Consumption stock is excluded from primary net worth by default.
- Optional resale value must be conservative, user-supplied and shown separately from cost.
- Expired, uncertain or unavailable stock cannot be assumed usable.
- Economic burn continues while stock is consumed even when cash outflow is zero that month.

### 8.10 Net worth and balance sheet

`net worth = accepted asset values - accepted liabilities`

Required views:

- Total net worth.
- Liquid net worth.
- Personal net worth excluding business-restricted value.
- Assets by liquidity class.
- Liabilities by interest, due status and priority.
- Value history with source date and confidence.

Requirements:

- Cash accounts derive from reconciled balances.
- EPF/retirement is an asset but restricted, never liquid runway.
- Business cash/equity is separate unless formally available to the user.
- Property, vehicle and business equity require manual valuation snapshots with method and date.
- Consumption stock is excluded from the headline by default.
- Unknown debt interest/accrual is visibly unresolved.
- Stale values reduce report confidence rather than silently carrying forward forever.

### 8.11 Scenario planning

Scenarios copy assumptions without changing accepted current state. Examples:

- 2X exit and EFFEN full-time.
- Lawful two-job overlap.
- Independence/rent scenario.
- Debt settlement or payoff alternatives.
- New subscription/tool stack.
- Business income haircut.

Every scenario lists changed assumptions, source/confidence, cash-flow result, runway, commitment ratio and difference from accepted baseline. No scenario executes payments or investments.

### 8.12 Operating System export

Pernance can produce a user-reviewed Markdown/JSON summary for the private Operating System:

- Period and close identifier.
- Closing personal liquid cash.
- Income by reliability.
- Recurring cash burn and economic burn.
- Debt balances/status.
- Next 90-day commitments.
- Freedom/runway metrics and selected floor.
- Net worth by liquidity class.
- Unresolved amount, stale sources and confidence.

Raw transactions, bank descriptions and source files are excluded by default. Export is manual, previewed and written only to a user-selected local path.

## 9. Information architecture and UI

### Primary navigation

- Home
- Review
- Transactions
- Cash Flow
- Plan
- Commitments
- Freedom
- Net Worth
- Imports
- Settings

### Home view

The home view should answer, without scrolling through a dense dashboard:

1. How much personal liquid cash is available?
2. Did cash increase or decrease in the selected period, and why?
3. What is the accepted recurring burn and next major commitment?
4. How many months of the selected floor are funded?
5. What needs review before these numbers are trustworthy?

### Visual direction

- Use Maybe as inspiration for calm hierarchy, whitespace, transaction readability and progressive disclosure.
- Do not copy Maybe's branding, assets or protected design implementation.
- Show an offline/local privacy indicator and active vault name.
- Red is reserved for reconciliation failure, overdue obligation or genuine risk—not ordinary spending.
- Every aggregate can drill down to the underlying records and assumptions.
- Confidence and stale-state indicators are compact but never hidden.
- Keyboard-first review and bulk actions are required for monthly-close speed.

## 10. Proposed technical direction

- Tauri v2 desktop shell, initially Windows-first.
- Rust owns file ingestion, parsing, normalization, ledger logic, reconciliation, rule execution, calculations, encryption boundary, import/export and audit log.
- WebView frontend handles presentation and user interaction; it receives only the minimum data needed for each view.
- React or Svelte with TypeScript may be chosen during scaffold; the domain core must not depend on the frontend framework.
- Local SQLite ledger with migrations; encryption-at-rest solution must be proven in Phase 0 before the store is accepted.
- Tauri Stronghold or an OS secret store may protect key material, but it is not by itself a substitute for database/file encryption.
- No remote content, CDN assets, telemetry, cloud AI or network capability in the default build.
- Optional local classification assistance comes only after deterministic rules and may never bypass review for ownership, transfer or material items.

Detailed design: [Architecture and Data Model](<./Architecture and Data Model.md>).

## 11. Privacy and security requirements

### Threat model

Protect against:

- Accidental cloud upload or telemetry.
- Another local user casually opening statements or the database.
- Frontend compromise reaching arbitrary files.
- Source files leaking through logs, crash reports, temp directories or source control.
- Backup theft.
- Import parser bugs corrupting accepted history.

Not fully protected against:

- Malware or an attacker controlling the unlocked OS account.
- Compromised Rust/native dependencies.
- Screen capture while the app is unlocked.
- Loss of both encrypted backups and unlock material.

### Controls

- Encrypted local data and encrypted exports/backups.
- Explicit app lock and automatic lock after configurable inactivity.
- Narrow Tauri capabilities: selected-file read, app-vault read/write and explicit export path only.
- No arbitrary shell execution, broad home-directory access or remote web content.
- Sensitive operations in Rust core, not JavaScript.
- Content Security Policy and dependency audit.
- Structured logs with IDs and counts, never raw financial payloads.
- Temporary decrypted data held in memory or securely removed where feasible.
- Import batch immutability, checksums, backups and transactional migrations.
- Privacy verification test runs with network disabled and monitors outbound attempts.

## 12. Non-functional requirements

- Correctness: deterministic calculations and reproducible reports from a ledger version.
- Auditability: every derived number can identify source records and rule versions.
- Idempotency: duplicate file/import does not duplicate facts.
- Reversibility: imports, rules, matches and bulk edits can be undone safely.
- Performance: 100,000 transactions remain usable on a normal Windows laptop; import and recomputation run off the UI thread.
- Portability: encrypted backup/restore is tested before production use.
- Accessibility: keyboard operation, sensible focus, contrast and screen-reader labels.
- Locale: MYR-first with configurable currencies, decimal separators and date formats.
- Testability: golden fixtures for every parser and invariant/property tests for ledger math.

## 13. Explicit non-goals for initial releases

- Automatic bank login or open-banking aggregation.
- Payment initiation, transfers, bill payment or investment execution.
- Financial, tax, legal or investment advice.
- Credit scoring or lender application automation.
- Market-price trading dashboard.
- Multi-user household sync.
- Mobile app or cloud synchronization.
- Cloud AI over private financial data.
- Medical/PED optimization or inventory recommendations.
- Replacing INDEXA's business ledger.

## 14. Gap analysis and product improvements

| Gap/risk | Why it matters | Product response |
| --- | --- | --- |
| Bank statements vary wildly | Generic parsing can silently misread signs, dates or balances | Adapter templates, parse preview, parser version, golden fixtures and reconciliation gate |
| PDFs can be image-based or password-protected | OCR errors can corrupt money data | CSV preferred; one text-PDF adapter first; local OCR later with mandatory review |
| Quarterly imports reduce feedback speed | Behavior changes may appear late | Coverage calendar, reminders and optional monthly mini-close using balance snapshots |
| User tagging can become clerical work | High friction kills the habit | Impact-ranked queue, merchant normalization, reusable rules, bulk edit and keyboard flow |
| Transfers inflate spending/income | Destroys cash-flow truth | Transfer matching as a first-class object with explicit principal/interest handling |
| Transactions do not prove balances | Missing cash or duplicate rows can remain invisible | Opening/closing reconciliation and account balance snapshots |
| Personal/business commingling | Personal liquidity and business performance become misleading | Ownership dimension, transfer classification, business-restricted liquidity and commingling alerts |
| Subscription detection has false positives | Repeated purchases are not always commitments | User confirmation, cadence confidence and reversible series detection |
| One-time bulk purchases distort averages | A costly month looks permanently expensive | Separate cash event, economic consumption and one-time treatment |
| Stock can create false confidence | Prepaid goods are not emergency cash | Stock coverage affects future purchase timing only; excluded from liquid runway/headline net worth |
| Net worth values become stale | Old balances produce fictional confidence | Source date, valuation method, freshness policy and confidence-weighted warning—not hidden carry-forward |
| Debt statements omit full economics | Principal, interest and charged-off status differ | Liability snapshots, split payments and explicit unresolved accrual/settlement fields |
| Local-only can still leak | Logs, backups and broad file permissions are risks | Encrypted vault, narrow capabilities, no payload logs, explicit backup threat model |
| Finance apps over-advice | User values and risk appetite are personal decisions | Self-service evidence and scenarios; no autonomous allocation or prescriptive score |
| Feature breadth can bury the core | Net worth and behavior are worthless on bad imports | Phase gates: reconciliation first, then recurring/budget, then freedom/stock, then net worth/scenarios |

## 15. Differentiators

Pernance is better when it provides capabilities generic finance apps usually flatten:

- Auditable monthly close rather than a pretty but unreconciled dashboard.
- Cash burn, economic burn and liquidity as separate lenses.
- Reliability-weighted income and time-bounded commitments.
- Stock-aware future cash timing without counting consumables as wealth.
- Survival, maintenance and independence freedom coordinates.
- Personal/business ownership boundaries for founder-operators.
- Evidence confidence and stale-state propagation.
- Local-first statement processing with no mandatory bank provider.
- Behavior experiments owned by the user rather than gamified judgment.
- Safe export into a broader personal Operating System.

## 16. Delivery phases

### Phase 0 - Architecture and privacy spike

- Prove encrypted vault, key lifecycle, backup/restore and narrow file permissions.
- Parse anonymized CSV plus one representative text-based PDF locally.
- Lock ledger invariants and money representation.

### Phase 1 - Reconciled cash-flow evidence

- Accounts, import batches, raw records, normalized balanced ledger, duplicate detection, transfer matching, review queue, rules and sources/uses cash flow.
- HSBC, GXBank, and TNG across one aligned three-month test window, with adapters determined from the actual native exports.

### Phase 2 - Recurrence, commitments and budget

- Subscription/commitment detection, sinking funds, survival/maintenance/independence profiles, planned versus actual and behavior observations.

### Phase 3 - Freedom and stock-aware planning

- Runway, freedom targets, income reliability, stock coverage, cash-versus-economic burn and 90-day commitment forecast.

### Phase 4 - Net worth, scenarios and OS export

- Valuation snapshots, liquidity classes, debt states, scenario comparison, encrypted backup polish and reviewed Operating System export.

### Later possibilities

- More bank adapters and local OCR.
- Local-only natural-language queries over accepted aggregates.
- Rules/templates that can be exported without transaction data.
- Optional mobile read-only companion only if an encrypted local sync design is justified.

## 17. Open decisions before implementation

1. Resolved sources: HSBC, GXBank, and TNG. Remaining format decision: inspect one representative native export from each and lock adapter order.
2. Will original statements be retained encrypted or deleted after accepted import by default?
3. Unlock model: passphrase every launch, OS-bound key with optional passphrase, or both?
4. Which encrypted SQLite/file approach passes the architecture spike?
5. React or Svelte frontend?
6. Resolved: Pernance and Twinagent run as separate product tracks; neither is treated as displaced by the other.
7. Which financial month and base-currency rules apply to the first vault?
8. Which Operating System summary fields are approved for export?

## 18. Primary references

- Maybe repository and license: https://github.com/maybe-finance/maybe
- Maybe final release/product lessons: https://github.com/maybe-finance/maybe/releases
- Tauri process model: https://v2.tauri.app/concept/process-model/
- Tauri capabilities: https://v2.tauri.app/security/capabilities/
- Tauri Stronghold: https://v2.tauri.app/plugin/stronghold/
- Tauri SQL plugin: https://v2.tauri.app/plugin/sql/
- Internal finance principles: Operating System `FOS 0-3`, `Monthly Nut`, `Freedom Numbers`, and `Stock & Restock Plan`

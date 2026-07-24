# Build log — 2026-07-13: Sources & Compute (PFN-53), Income Sources (PFN-55)

Commit `e1542aa` on `main`. In Review; manual tests PFN-56 / PFN-57.

## What landed

**PFN-53 — the monthly routine becomes one button.**
- `source_profile` in the vault (schema V6): name, folder, adapter, account label, optional statement password. The password is encrypted with the vault *data key* (`encrypt_blob`) on top of SQLCipher — defense in depth — and decrypted in memory only at parse time, never logged or shown back in the UI.
- `app_setting` table for the records-vault path (points at `6. Records`).
- New `pernance-pipeline` crate (testable without webkit): scans each source folder, skips already-imported files by SHA-256, parses via the source's adapter (GXBank / TNG / HSBC-OCR registry), dedupes overlapping rows by fingerprint, normalizes, reconciles, re-runs transfer suggestion, and writes grouped copies: `<records>/<source>/raw/<file>` + `<records>/<source>/csv/<file>.csv` (parsed rows).
- UI: Settings view (sources + records path), Compute button in the header, landing on a Transactions labelling view with per-source summary.

**PFN-55 — income managed where it's classified.**
- `income_source` (reliability: reliable/temporary/variable/one-time, cadence, expected amount, start/end) + `income_source_id` on `txn_class` (schema V7).
- Payer-description aliases remembered exactly like merchant aliases → recurring income auto-suggests.
- Labelling editor shows an income-source picker (create-on-type, defaults to `variable`) plus a reliability select, only for deposits that aren't confirmed transfers.
- Overview Income card: month grouped by source, reliability badges, unassigned-deposits line, confirmed transfers excluded from the query itself.

## Decisions

- **New crate over fattening src-tauri**: `pernance-store` doesn't depend on `pernance-import`; the pipeline needs both, and putting it in src-tauri would make it untestable on machines without webkit. `pernance-pipeline` sits above both and carries the compute tests (fake adapter injection).
- **Password semantics on save**: `null` keeps, `""` clears, text replaces — so editing a source never requires retyping the password and never round-trips it to the UI.
- **"OCR output" acceptance bullet**: covered as the parsed-rows CSV per file (the HSBC adapter's OCR is internal; raw OCR strips aren't exposed). If raw OCR artifacts are wanted in `6. Records`, that's an adapter-surface change → new issue if it matters.
- **Income month boundary**: `posted_date LIKE 'YYYY-MM-%'` in SQL — no date math in the frontend, consistent with "frontend never does arithmetic".

## Open / follow-ups

- CSV template sources (generic-csv) aren't in the adapter registry yet — joins when PFN-16 template storage lands.
- Clearing a classification dimension (set back to empty) isn't possible; COALESCE-update semantics kept consistent with the existing merchant/category behavior.
- Transfer confirmation UI still pending (PFN-25 surface); compute counts suggestions but the confirm/reject flow is CLI/store-only.

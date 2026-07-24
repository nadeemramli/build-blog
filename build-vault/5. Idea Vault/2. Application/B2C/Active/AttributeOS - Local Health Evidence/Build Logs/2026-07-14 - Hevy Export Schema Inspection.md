---
title: Hevy Export Schema Inspection
description: Privacy-safe Phase 0 findings from a representative local-only Hevy CSV export.
created: 2026-07-14
updated: 2026-07-14
status: completed-schema-inspection
linear_issue: ATT-6
review_date: 2026-08-10
tags: [attributeos, build-log, hevy, import, schema]
---

# Hevy Export Schema Inspection

## Privacy boundary

The representative export was inspected locally outside the repository and
outside every Obsidian vault. The raw file, personal rows, workout titles,
exercise roster, notes, dates, loads, reps and source hash were not copied into
this note. The file remains local-only and must never be committed.

## Observed CSV contract

The representative export is valid UTF-8 without a BOM, uses LF line endings,
and follows quoted CSV semantics. Note fields can contain embedded line breaks,
so the adapter must use a real RFC 4180-capable CSV parser rather than reading
one physical line as one record.

Observed column order:

```text
title
start_time
end_time
description
exercise_title
superset_id
exercise_notes
set_index
set_type
weight_kg
reps
distance_km
duration_seconds
rpe
```

| Column | Candidate type | Required in representative file | Adapter posture |
| --- | --- | --- | --- |
| `title` | text | yes | Preserve source text; do not use alone as identity |
| `start_time` | local-naive datetime text | yes | Parse with explicit detected format and user-confirmed timezone |
| `end_time` | local-naive datetime text | yes | Validate end is not before start after timezone resolution |
| `description` | optional multiline text | no | Sensitive; never log |
| `exercise_title` | text | yes | Preserve original; mapping remains a reviewable candidate |
| `superset_id` | optional text | no | Treat as file-local grouping, not a globally stable ID |
| `exercise_notes` | optional multiline text | no | Sensitive; never log |
| `set_index` | non-negative integer | yes | Source index within an exercise occurrence; validate, do not renumber silently |
| `set_type` | enum-like text | yes | Known values: `normal`, `warmup`, `dropset`, `failure`; preserve unknown future values |
| `weight_kg` | optional decimal | no | Unit is declared by the column; blank is valid for non-load sets |
| `reps` | optional non-negative integer | no | Blank is valid when duration/distance represents the set |
| `distance_km` | optional decimal | no | Do not coerce into load/reps |
| `duration_seconds` | optional non-negative integer | no | Do not coerce into load/reps |
| `rpe` | optional decimal | no | Store as source-reported context; missing RPE is normal |

The timestamp shape is English month-name, 12-hour local time with AM/PM and no
UTC offset. Import preview must therefore require a timezone. For Nadeem's
profile the proposed default is `Asia/Kuala_Lumpur`, but acceptance remains
explicit and the raw timestamp text is retained.

## Identity and idempotency consequence

The export does not provide stable workout, exercise-occurrence or set IDs and
does not declare an exporter/schema version. The adapter therefore needs both
an artifact hash and source-specific fingerprints:

1. Exact artifact hash detects a byte-identical re-import.
2. Session candidate fingerprint uses adapter version plus raw start/end and
   title fields, while preserving the possibility that a later export edited
   them.
3. Exercise occurrence is assigned from CSV record order inside the session;
   the same exercise title can appear more than once and must not collapse.
4. Set candidate identity uses session fingerprint, exercise-occurrence ordinal
   and source `set_index`; raw-record hash detects edits.
5. A later complete export creates revisions/tombstones only for a proven
   authoritative window. Missing rows alone are not automatic deletions.

At least one exact duplicate row shape exists in the representative export.
Exact duplicates must not create duplicate accepted sets, but the parser must
retain enough provenance to explain the deduplication.

## Validation rules

- Require the core columns but tolerate and report unknown future columns.
- Detect schema by normalized header set and order; do not assume filename.
- Preserve record order, raw field text and source row pointer.
- Reject structurally invalid numbers into review; do not substitute zero.
- A blank load with duration or distance is valid.
- A blank optional note, superset or RPE is valid.
- Unknown `set_type` becomes a candidate enum value and review item, not a hard
  parser crash.
- Warm-ups, dropsets and failure sets remain distinct from normal working sets.
- No benchmark or progression engine sees a row until import validation and
  user review accept its identity, timezone, unit and load semantics.

## Synthetic fixture required

Write the repository fixture from scratch. It should contain only visibly
synthetic titles, exercises, dates, notes and values and cover:

- all 14 observed columns in the observed order;
- quoted commas and a multiline note;
- every known set type;
- a superset group;
- load/reps, distance-only and duration-only sets;
- blank optional fields and optional RPE;
- decimal loads and RPE;
- an exact duplicate for idempotency;
- an unknown extra column for forward compatibility;
- separate adversarial fixtures for malformed CSV, invalid number, bad time,
  duplicate index and unknown set type.

No real value may be transformed, shifted, rounded or anonymized into the
fixture. Synthetic means newly authored, not modified personal data.

## Scope note (updated 2026-07-14)

- Hevy **screenshot extraction/OCR is descoped** by user decision: the native
  CSV export is the sole Hevy source. The separate screenshot-candidate
  contract is not needed and was not built. See `Decisions/decisions.md`.
- Nothing is "missing" for the Hevy source: the CSV adapter (ATT-6) is complete.
  The real export's header was later confirmed (header-only, no rows) to match
  the locked 14-column schema exactly.

## ATT-6 completion evidence

- Header/schema detector has positive and negative tests.
- Parser handles embedded newlines and all optional field shapes.
- Timezone is explicit and raw time text is preserved.
- Re-import is idempotent and duplicate behavior is explained.
- Synthetic fixtures contain no strings or values copied from the real export.
- Logs contain only adapter/version, artifact-ID prefix, counts, duration and
  error codes; never titles, exercises, notes, dates, loads or reps.


---
title: AttributeOS - Discovery Brief
description: Working concept for a private local health, training, nutrition, wearable and laboratory evidence compiler.
created: 2026-07-13
updated: 2026-07-13
status: hypothesis-not-admitted
review_date: 2026-08-10
product: AttributeOS
tags: [b2c, draft, health-data, local-first, tauri, rust]
---

# AttributeOS - Discovery Brief

AttributeOS is a working product name for a private local-first application that imports and reconciles user-owned health evidence from WHOOP, Apple Health, Hevy, MacroFactor, laboratory PDFs and other approved sources.

The app is a compiler and control surface, not a clinician. It should make the evidence inspectable, comparable and exportable without diagnosing illness, prescribing treatment, designing PED protocols or claiming causality from noisy data.

## Product role in the ecosystem

- AttributeOS local vault holds raw exports, normalized time series, source documents, extraction evidence and dashboard state.
- Operating System receives only accepted health/physique summaries, freshness exceptions and clinician-ready briefs.
- PA Control receives decision-level health-floor and capacity signals only.
- Build Vault holds PRDs, architecture, anonymized fixtures and product learning; never real health exports or lab PDFs.

## Initial sources

| Source | Intended evidence | Format decision |
| --- | --- | --- |
| WHOOP | Sleep, recovery, strain, resting HR and related wearable measures | Inspect the user's native export before locking an adapter |
| Apple Health | Device/health time series and provenance across connected sources | Inspect the user's native export and source-device metadata |
| Hevy | Exercises, sets, reps, load, volume and training history | Inspect native export; preserve exercise identity and edits |
| MacroFactor | Weight trend, intake/macros and expenditure estimates | Inspect native export; distinguish measured values from model estimates |
| Laboratory PDFs | Biomarkers, units, reference ranges, laboratory and collection date | Local PDF extraction/OCR with mandatory field-by-field confirmation |

No source is assumed to expose a stable format until a representative export is inspected. Platform-calculated scores remain external measurements with named provenance; the app does not pretend they are raw physiology.

## Core user loop

```text
import export/PDF
  -> identify source, person, timezone, unit and period
  -> preserve immutable source evidence
  -> normalize into a common timeline
  -> deduplicate and flag conflicts/missing periods
  -> user confirms uncertain fields
  -> dashboard/trend/target view
  -> optional local agent analysis with provenance
  -> reviewed Operating System summary or clinician brief
```

## UI and dashboard modules

- Source coverage and freshness.
- Sleep/recovery timeline with source-specific definitions visible.
- Training load, frequency, volume and progression from Hevy.
- Weight, intake and expenditure-estimate trends from MacroFactor.
- Biomarker table with collection date, units, reference range, source lab and trend.
- Measurement timeline: weight, waist, body-composition method, BP, resting HR and other user-approved attributes.
- Goal evidence: current measurement, target, confidence, constraints and missing inputs.
- Event/annotation layer for user-confirmed context such as travel, illness, schedule change or program phase, without causal claims.
- Clinician-brief builder containing facts, dates, trends, symptoms supplied by the user and explicit questions.

## Agent integration

The app does not need a public API for the initial product. Prefer:

1. Rust importers and validators for deterministic work.
2. Versioned local exports/job packets.
3. A local CLI for rebuilds and validation.
4. Optional MCP over stdio/local-only transport for Codex or Claude Code.

Agents may help:

- Extract candidate fields from PDFs.
- Map exercise or measurement aliases.
- Detect unit/timezone/source conflicts.
- Summarize data coverage and missing evidence.
- Draft a clinician brief or Operating System update for user approval.
- Build or repair adapters and dashboards.

Agents may not:

- Diagnose, prescribe or choose clinical thresholds without an authoritative source and human acceptance.
- Recommend or optimize medication/PED cycles, doses or combinations.
- Infer actual substance use from purchase/inventory records.
- Present wearable correlations as medical causation.
- Export raw health data to a cloud model without a separate explicit privacy decision.

## Proposed architecture

- Tauri v2 desktop app, Windows-first.
- Rust domain/import core with typed source adapters.
- Encrypted local database plus encrypted source-document store.
- Immutable source records, versioned normalization and derived dashboard snapshots.
- Time-series model retaining value, unit, timestamp/timezone, source platform/device, source record ID, confidence and interpretation status.
- Frontend receives narrow domain views, not raw file-system or arbitrary SQL access.
- Reviewed Markdown/JSON export to the Operating System.

## Primary product gaps to solve

| Gap | Risk | Required response |
| --- | --- | --- |
| Timezone/day-boundary differences | Sleep, workouts and nutrition appear on the wrong day | Store source timezone and normalized UTC/local views |
| Unit and naming drift | Biomarker/exercise trends combine unlike measures | Canonical units plus preserved original value/name and explicit mappings |
| Duplicate Apple Health sources | One event may exist from phone, watch and third-party sync | Source priority and dedupe rules with review |
| Proprietary wearable scores | A score can change when the vendor algorithm changes | Preserve vendor/source/version when available and avoid treating it as a universal measurement |
| Modelled versus measured values | MacroFactor expenditure and body-fat estimates may look objective | Field-level evidence type: measured, calculated, vendor-modelled or user-estimated |
| Lab PDF extraction error | Wrong decimal, unit or reference range can be dangerous | Source-page evidence and mandatory confirmation before acceptance |
| Reference ranges vary | Cross-lab comparisons can be misleading | Preserve each lab range; normalized trend never overwrites source range |
| Missingness and selective recording | Dashboard can imply certainty from incomplete periods | Coverage/freshness panel and minimum-data warnings |
| Event correlation | Training, sleep and biomarkers may move together without causal proof | Descriptive associations only; user annotations and clinician interpretation remain separate |
| Sensitive data exposure | Raw health history is highly sensitive | Encryption, no telemetry, no public endpoint, sanitized fixtures only |

## Smallest falsifiable test

Import one representative export from WHOOP, Apple Health, Hevy and MacroFactor plus one laboratory PDF; preserve provenance; normalize one aligned 90-day window; confirm all ambiguous units/identities; and produce a dashboard plus clinician-style factual brief that is faster and more trustworthy than the current manual process.

## Admission gate

AttributeOS remains a draft hypothesis until:

- Pernance's import/reconciliation architecture produces reusable learning.
- The representative export formats are inspected.
- The privacy/encryption approach is proven.
- The first dashboard question and displaced work are explicit.
- A health-safety review locks prohibited and approval-required behaviors.

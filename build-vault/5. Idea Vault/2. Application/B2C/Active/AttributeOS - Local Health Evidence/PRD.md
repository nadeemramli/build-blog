---
title: AttributeOS - Product Requirements Document
description: Product requirements for a private local health, physique, training, nutrition, wearable and laboratory evidence system.
created: 2026-07-13
updated: 2026-07-13
version: 0.3
status: active-design
review_date: 2026-08-10
product: AttributeOS
tags: [b2c, prd, health-data, physique, strength, local-first, tauri, rust]
---

# AttributeOS - Product Requirements Document

## 1. Product summary

AttributeOS is a private, local-first desktop application that turns user-owned health and performance exports into an inspectable evidence system.

It combines:

- **APEX:** athlete performance benchmarking, movement coverage, exercise progression and within-program sequencing analysis.
- **Physique Tracker:** body measurements, body-composition evidence, FFMI, proportional reference comparisons and check-in progress.
- **Health evidence:** WHOOP, Apple Health, laboratory records, symptoms and user-confirmed context.
- **Nutrition and weight:** MacroFactor scale weight, weight trend, intake, macros and vendor-modelled expenditure.
- **Evidence control:** immutable imports, provenance, uncertainty, human review, reports and reviewed Obsidian handoff.

The app is an evidence compiler and control surface. It is not a clinician, diagnostic system, autonomous coach, PED planner or replacement for Hevy, WHOOP, MacroFactor or Apple Health.

## 2. Product outcome

The product succeeds when the user can answer, with traceable evidence:

1. What data is current, missing, duplicated or uncertain?
2. Is training covering the intended movement framework?
3. Which comparable exercises and body measurements are progressing, flat or regressing?
4. How does current performance compare with a selected, versioned benchmark pack?
5. How is physique changing under a consistent measurement protocol?
6. What recovery, nutrition, body-composition or laboratory context coincided with that change?
7. Which facts should be reviewed with a clinician or exported into the private Operating System?

AttributeOS must make the evidence easier to inspect without manufacturing certainty from incomplete data.

## 3. Ecosystem role and authority

| Layer | Authority |
| --- | --- |
| AttributeOS local vault | Raw exports, source documents, normalized records, mappings, review state and derived snapshots |
| Operating System | Accepted private health, biomarker, physique and lifestyle summaries |
| PA Control | Decision-level health-floor, capacity and missing-evidence signals only |
| Build Vault | PRD, technical design, sanitized fixtures and product learning; never production health data |
| Hevy, WHOOP, Apple Health, MacroFactor and laboratories | Named source systems; their records remain source evidence, not universal truth |

An app observation becomes accepted personal truth only after the user reviews it and exports or accepts it into the canonical Operating System.

## 4. Admission and scope decision

| Question | Current decision |
| --- | --- |
| Evidence | The user already built manual APEX and Physique Tracker workflows and now has recurring data spread across Hevy, WHOOP, Apple Health, MacroFactor and laboratory PDFs. |
| Portfolio lane | Bounded health-floor and evidence tool; not a new venture-scale bet. |
| Smallest useful build | APEX + Physique Tracker over a 90-day Hevy window and two dated physique check-ins, with encrypted storage, review and provenance. |
| Displaced work | No broad multi-source platform work until the training/physique slice works. Later connectors are admitted one at a time. |
| Capital at risk | Local development time and storage only in the initial phase; no cloud subscription or public service is required. |
| Continue signal | A recurring import/check-in takes less than 15 minutes, preserves provenance, catches a real gap or false assumption, and produces a trusted reviewed report. |
| Stop/redesign signal | The app requires repeated manual repair, cannot distinguish evidence from heuristics, creates unsafe confidence, or duplicates source apps without improving decisions. |
| Review date | 2026-08-10. |

## 5. Primary user and operating context

Initial user: Nadeem, an advanced self-tracker using resistance training, physique measurements, nutrition tracking, wearables and laboratory evidence.

The app should later support other local users, but Phase 1 optimizes for one private profile, one Windows machine and user-initiated imports. Multi-user accounts, cloud sync and social features are out of scope.

## 6. Product principles

1. **Evidence before score.** Every score must lead back to source records and formula versions.
2. **Measured is not modelled.** Measured, calculated, vendor-modelled, user-estimated and benchmark-derived values are visually distinct.
3. **Review before acceptance.** Ambiguous imports, mappings, units and screenshot extraction remain candidates until confirmed.
4. **Comparable or separate.** Exercises, machines, measurement protocols and laboratory units are never combined merely because their labels resemble each other.
5. **Context without causation.** The app may show coincident changes but cannot claim a cause from an observational timeline.
6. **Health floors outrank performance.** No physique or strength target suppresses missing health evidence or clinician review.
7. **Local by default.** No telemetry, public endpoint or cloud upload is required.
8. **Useful without an LLM.** Core import, calculation, review, browsing and export are deterministic.
9. **Self before population.** Progress against a protocol-consistent personal baseline is primary; external references are secondary context.
10. **Ranges before false precision.** When material input uncertainty exists, the app shows a range or unavailable state rather than a deceptively exact answer.
11. **One governed close.** Recurring health evidence becomes durable only through an explicit import, QC, acceptance, report and export cycle.
12. **Private by construction.** Private, clinician-safe and public outputs are separate report profiles; sensitive fields never depend on users remembering to remove them.

## 7. Evidence classification

Every stored or displayed value has one evidence type:

| Evidence type | Meaning | Example |
| --- | --- | --- |
| `measured` | Direct instrument or laboratory observation | Scale weight, lab result, tape measurement |
| `source_reported` | Source platform record or proprietary score | WHOOP Recovery, Hevy set record |
| `user_reported` | User-declared fact or context | Injury flag, deliberate calf exclusion |
| `calculated` | Deterministic output from accepted inputs | Fat-free mass, FFMI, weekly volume |
| `vendor_modelled` | Vendor estimate using an undisclosed or changing model | MacroFactor expenditure, WHOOP proprietary scores |
| `heuristic` | Product/user rule that is not a validated physiological law | Linear circumference scaling, legacy waist projection |
| `benchmark_derived` | Comparison against a selected reference pack | Natural-elite strength gap |
| `agent_candidate` | Unconfirmed extraction or mapping suggestion | Lab value extracted from PDF, screenshot set value |

Each value also carries source, observation time, import time, original unit, canonical unit, confidence, acceptance status and derivation version when applicable.

## 8. Data sources

| Source | Phase | Required evidence | Import posture |
| --- | --- | --- | --- |
| Hevy native export | 1 | Workouts, exercise names, timestamps, sets, load, reps, RPE and notes when present | Canonical training source after review; representative export locks schema |
| Hevy screenshots | 1 | Session/set detail not conveniently exported or available during partial updates | Candidate extraction only; visual QC required; CSV wins on conflict unless the user confirms otherwise |
| Manual physique check-in | 1 | Height, weight, body-fat estimate/method, circumferences and measurement conditions | Accepted user record after validation |
| Reference athlete/benchmark pack | 1 | Source, date, conditions, equipment, cohort label and confidence | User-curated reference evidence; never silently updated |
| Progress photos | 2 | Dated local images and capture conditions | Encrypted local media; optional; never uploaded by default |
| WHOOP export | 2 | Physiological cycles, sleep, workouts and journal entries available in the native export | Preserve vendor fields and definitions; scores remain source-reported/modelled |
| MacroFactor export | 2 | Scale weight, weight trend, calories, macros, targets and expenditure estimate when selected | Granular or quick spreadsheet import; measured and modelled fields separated |
| Apple Health export | 3 | XML records plus source/device metadata | Streaming import; aggressive duplicate/source review |
| Laboratory PDF/CSV | 3 | Result, unit, reference range, collection time, laboratory and source page | Extraction creates candidates; mandatory field-by-field confirmation |

No adapter is considered stable until it passes sanitized fixtures made from a representative user export.

## 9. Core information architecture

### 9.1 Home / Evidence Health

The home view shows:

- Latest accepted data date per source and module.
- Coverage for the current 7, 28 and 90-day windows.
- Imports awaiting review.
- Duplicate, unit, identity and timezone conflicts.
- Current user-selected goals and their evidence freshness.
- Latest generated reports and reviewed Operating System export.
- Health-floor exceptions without diagnosis or treatment advice.
- Current personal-baseline window and whether each trend has enough comparable data.
- Conflicting source records and the metric-specific source-authority rule used to resolve the display.
- Current AttributeOS close status: open imports, unresolved review items, draft report and last accepted close.

### 9.2 APEX - Training Performance

APEX incorporates the supplied Athlete Performance Benchmark System.

#### Inputs

- Athlete profile: height, bodyweight, accepted body-fat estimate and optional user-declared treatment/training context.
- Versioned 24-pattern movement framework.
- Hevy workout history and optional screenshots.
- Exercise/equipment identity and mapping overrides.
- Training block, program day and phase annotations.
- Injury, equipment, deliberate-exclusion, form-reset and quality-control notes.
- Versioned natural-elite, enhanced-elite or custom benchmark packs.

The presence of an enhanced benchmark pack does not authorize the app to infer or recommend drug use.

#### Processing

1. Extract candidate workouts and sets.
2. Confirm identities, units and ambiguous unilateral/bilateral or bodyweight loads.
3. Deduplicate source records and consolidate comparable exercise variants.
4. Map each exercise to one or more movement patterns and direct/indirect muscle contributions.
5. Select comparable best sets under a named selection rule.
6. Compare against the selected benchmark pack.
7. Calculate movement coverage, body-part scores and progress deltas.
8. Compare repeat exposures across program days only when equipment, execution and rep criteria are comparable.
9. Add user context without turning correlation into causation.

#### Outputs

- 24-pattern coverage map: covered, deliberately excluded, missing, ambiguous.
- Benchmark table: current, selected natural/custom target, selected enhanced/custom target, absolute gap and percentage gap.
- Exercise progress: session, week and block deltas.
- Body-part ranking using versioned direct/indirect stimulus weights.
- Day-level A/B/C comparison and candidate sequencing/fatigue flags.
- Mapping and quality-control queue.
- Block review report with traceable source sets.

### 9.3 Physique Tracker

#### Check-in inputs

- Height and weight with unit and device/method.
- Body-fat percentage with method: DEXA, scan, caliper, visual estimate or other.
- Circumferences: waist, chest, arm, thigh, calf and user-defined measurements.
- Measurement protocol: side, flexed/relaxed, tape location, time of day, food/hydration state and notes.
- Optional progress photos and scan/PDF references.
- User-selected target and reference athletes.

#### Outputs

- Measurement dashboard comparing current, previous, reference athletes and proportional heuristic target.
- Per-measurement gap and progress delta.
- Fat-free mass, raw FFMI and height-normalized FFMI.
- Lean-mass requirement for a user-selected FFMI target.
- Target bodyweight at a user-selected target body-fat percentage.
- Waist projection only when a named projection model and its uncertainty are visible.
- Check-in timeline and measurement-protocol consistency warnings.
- Plausible ranges and sensitivity for FFMI, lean-mass targets and other outputs materially affected by uncertain inputs.
- Explicit unavailable states when the body-fat method, measurement protocol or reference evidence cannot support a trustworthy comparison.

### 9.4 Recovery and sleep

- WHOOP sleep, recovery, strain, RHR, HRV and available native measures.
- Raw/vendor measures and proprietary scores displayed separately.
- Rolling 7/28/90-day descriptive trends.
- Coverage, device/source and vendor-definition visibility.
- Event overlays for illness, travel, schedule changes and training blocks.
- No medical diagnosis or automatic protocol change.

### 9.5 Nutrition and weight

- Scale weight and weight trend as separate series.
- Energy intake, macro intake and user targets.
- MacroFactor expenditure explicitly marked `vendor_modelled`.
- Phase annotations: maintenance, cut, gain or user-defined.
- Adherence and change summaries without autonomous calorie prescriptions.

### 9.6 Laboratories and measurements

- Biomarker table with original result/unit/range and canonical comparable value where valid.
- Trends separated when method, specimen, fasting status or units are not safely comparable.
- Source-page preview and confirmation state.
- User-defined or clinician-accepted thresholds only; generic reference ranges never overwrite source-lab ranges.
- Clinician brief containing facts, dates, trends, user-reported symptoms and explicit questions.

### 9.7 Timeline and context

One timeline aligns accepted events across training, physique, recovery, nutrition and labs.

Context types include training phase, deload, exercise form reset, equipment change, travel, illness, injury, schedule change, user-declared treatment context and other user-defined events. Sensitive context is private and omitted from exports unless explicitly included.

The timeline uses language such as “coincided with” and “followed,” never “caused,” unless the user adds an external clinical interpretation.

### 9.8 Personal baselines and health floors

AttributeOS separates three kinds of comparison:

1. **Personal baseline:** a user-selected rolling window or accepted training block built from comparable evidence.
2. **Source or laboratory reference:** a range or flag supplied by the originating laboratory/vendor.
3. **External benchmark:** a versioned population or athlete reference with declared applicability and confidence.

The personal baseline is the default context for longitudinal change. Population references never overwrite a personal observation, and a personal baseline never replaces a source-lab flag or clinician interpretation.

Health-floor views may preserve source-provided flags, show missing/stale evidence and evaluate user-defined or clinician-accepted thresholds. They may not invent diagnostic thresholds, infer a condition or automatically alter training, nutrition, treatment or medication.

### 9.9 Source authority and conflicts

Each metric has a visible, versioned source-authority policy. Initial proposed authorities must be confirmed during connector implementation; examples are Hevy for resistance workouts, MacroFactor or a selected scale for body weight and nutrition, WHOOP for WHOOP-native recovery/sleep measures, and the original laboratory report for biomarkers.

Secondary sources remain preserved as corroborating or conflicting evidence. The app must detect likely cross-source duplicates, explain which record drives a dashboard, and require review when a source correction, deletion or late-arriving record would change an accepted result.

## 10. Calculations and benchmark rules

### 10.1 Fat-free mass and FFMI

```text
body_fat_fraction = body_fat_percent / 100
fat_free_mass_kg = weight_kg * (1 - body_fat_fraction)
raw_ffmi = fat_free_mass_kg / height_m^2
normalized_ffmi_kouri_1995 = raw_ffmi + 6.3 * (1.80 - height_m)
```

The supplied Physique Tracker concept used `6.1`; AttributeOS uses `6.3`, matching the equation reported in Kouri et al. (1995). The study's reported non-user value near 25 is displayed only as a historical research reference, not an individual natural limit, diagnosis or drug-use classifier.

Every FFMI result must show body-fat method and date because body-fat uncertainty directly affects the result.

### 10.2 Lean-mass target from normalized FFMI

```text
target_raw_ffmi = target_normalized_ffmi - 6.3 * (1.80 - height_m)
target_fat_free_mass_kg = target_raw_ffmi * height_m^2
fat_free_mass_gap_kg = target_fat_free_mass_kg - current_fat_free_mass_kg
target_weight_kg = target_fat_free_mass_kg / (1 - target_body_fat_fraction)
```

Targets are user choices. The calculator does not assess whether a target is healthy, attainable or appropriate.

### 10.3 Proportional circumference benchmark

```text
scaled_reference = reference_measurement * (user_height / reference_height)
combined_target = weighted_mean(scaled_references, reference_confidence)
gap = user_measurement - combined_target
```

This is a product heuristic based on linear geometric scaling. It is not attributed to the Kouri FFMI paper and must always display its heuristic status, reference sources, conditions and confidence. Contest-state, pump, dehydration and unverified public measurements reduce reference confidence.

### 10.4 Waist projection

Supported models:

1. `off` - default when evidence is insufficient.
2. `personal_regression` - preferred after enough consistent check-ins exist.
3. `explicit_legacy_heuristic` - optional user-enabled formula from the supplied concept:

```text
projected_waist_in = current_waist_in -
  (current_bf_percent - target_bf_percent) * 0.35
```

The legacy formula is labelled low-confidence and experimental. It must not be presented as a validated physiological relationship.

### 10.5 Training best-set selection

APEX supports versioned selection policies rather than one hidden rule. Phase 1 includes:

- `observed_5_8_load_primary`: accepted working sets of 5-8 reps, highest comparable load, RPE used as context when present.
- `latest_comparable_best`: most recent accepted best set under the same exercise, equipment, execution and rep-band identity.
- Optional estimated 1RM policies only after the formula and applicable rep range are explicitly selected.

Machine, cable, barbell, dumbbell, assisted, bodyweight, unilateral and bilateral variants are separate comparison identities unless the user approves a mapping.

### 10.6 Movement and body-part scoring

- The APEX-24 framework is versioned reference data with 24 stable pattern IDs.
- Exercise mapping is many-to-many and stores direct/indirect contribution weights.
- Coverage and body-part scores declare the framework version, lookback window and inclusion rule.
- A deliberate exclusion is shown as context, not repeatedly raised as a gap until intent changes.
- A missing or ambiguous mapping cannot silently count as coverage.

### 10.7 Day-level analysis

Day-level A/B/C comparison requires comparable exercise identity and at least the configured minimum observations. The output includes best, worst, spread, order and context.

Flags must say “candidate sequencing or fatigue effect” rather than claiming suppression. Equipment changes, form resets, failed reps, rep-band changes, illness and deliberate programming choices are surfaced before interpretation.

### 10.8 Uncertainty and sensitivity

Uncertainty is part of the result, not a footnote. Each input may carry an explicit lower/upper bound, repeatability tolerance or method-specific uncertainty profile with provenance. The system must not invent a numeric error margin merely from a method label; when no defensible uncertainty range exists, it shows confidence and an `uncertainty_not_quantified` state.

For FFMI and target-weight calculations, the app recalculates the result across the accepted body-fat and measurement bounds and shows which input dominates the range. Circumference deltas smaller than the selected protocol's repeatability tolerance are labelled inconclusive. Reports preserve both the point estimate and range/model used at that time.

### 10.9 Benchmark governance

An APEX benchmark pack is admissible only when every entry declares source, exercise identity, equipment/load model, execution/ROM assumptions, rep policy, bodyweight relationship, cohort definition, applicable sex/age/weight class when stated, confidence and licensing/usage notes.

The product presents training evidence in this order:

1. Progress against the user's own comparable history.
2. Performance relative to bodyweight where the selected rule supports it.
3. Movement coverage and within-program balance.
4. External benchmark comparison.

Natural, enhanced and custom labels describe reference cohorts only. Working-set load, estimated 1RM and relative-strength views remain separate calculations and cannot be substituted silently. Direct/indirect stimulus scores describe configured exposure; they are not measurements of hypertrophy.

### 10.10 Model-change governance

Every formula, baseline policy, benchmark pack, movement taxonomy, mapping and stimulus-weight set has an immutable version and source/assumption record. Before activating a new version, the app previews which accepted snapshots and reports would change. Historical accepted reports remain immutable; recomputation creates a new superseding result.

AttributeOS must not collapse heterogeneous health, recovery, physique and performance evidence into one opaque readiness, health or optimization score.

## 11. Key workflows

### 11.1 First setup

1. Create encrypted local vault and recovery/backup method.
2. Create local profile and preferred units/timezone.
3. Import representative Hevy export.
4. Review exercise identities and seed APEX-24 mappings.
5. Create first physique check-in.
6. Select or create benchmark packs.
7. Generate baseline APEX and Physique reports.

### 11.2 Recurring training refresh

1. Import new Hevy export or explicitly scoped screenshots.
2. Detect existing records and show import delta.
3. Resolve candidate mappings/conflicts.
4. Recalculate affected snapshots only.
5. Review block/week changes and accept report.

### 11.3 Physique check-in

1. Select measurement protocol or create a versioned change.
2. Enter/import measurements and body-composition evidence.
3. Validate ranges and protocol consistency.
4. Review calculated FFMI and heuristic comparisons.
5. Compare with prior accepted check-in and export reviewed summary.

### 11.4 Health-source refresh

1. Import source archive or document.
2. Inspect source, person, timezone, period and schema.
3. Preserve source artifact and parse candidates.
4. Resolve duplicates, units and uncertain identities.
5. Accept records and regenerate affected trends.

### 11.5 Operating System export

1. User chooses period and included modules.
2. App previews facts, derivations, confidence and unresolved exceptions.
3. Sensitive context is excluded by default.
4. User approves a Markdown plus JSON export.
5. Export includes app/schema version and source-coverage summary.

### 11.6 AttributeOS close

The recurring operating unit is a close, not an always-changing dashboard:

```text
import -> deduplicate -> QC -> accept -> recompute -> review -> freeze report -> export
```

A close has a period, included modules, source coverage, unresolved-item policy, draft state, accepted timestamp and supersession history. Acceptance freezes its input set and report. Later corrections create a new close or superseding report rather than editing the accepted record silently.

Initial cadence defaults are proposals the user may change:

- Hevy: weekly and at the end of each training block.
- Physique measurements: every two to four weeks under the same protocol.
- WHOOP, Apple Health and MacroFactor: monthly when those connectors are admitted.
- Laboratories: event-driven after a result is received and reviewed.
- Full reviewed Operating System export: monthly.

Expected cadence and stale-after thresholds are configured per source/metric. Missing or stale evidence produces an explicit state; it does not reuse old data as though it were current. The close UI supports bulk confirmation, remembered aliases and a review budget so recurring use does not become a second tracking job.

### 11.7 Corrections, deletion and portability

The user can revise or supersede an accepted normalization without altering the immutable source artifact. The app must support deletion by import, source record, sensitive artifact, source system and complete vault, while preserving only the minimum tombstone/audit fact required for consistency when the user chooses partial deletion.

The user can export all accepted structured data, model/version metadata and reviewed reports in documented formats. Because storage hardware may not guarantee secure overwrite, the product uses cryptographic erasure for full-vault destruction and clearly explains the limits of file-level secure deletion and external backups.

## 12. Functional requirements

### 12.1 Evidence vault and imports

- **IMP-01:** Preserve every imported source artifact immutably with SHA-256, source, size, import time and parser version.
- **IMP-02:** Importing the same source twice must be idempotent and produce a no-change result.
- **IMP-03:** Display an import preview before accepted records change.
- **IMP-04:** Preserve original values/names/units beside normalized values.
- **IMP-05:** Create review items for ambiguous identity, unit, timezone, duplicate or extraction confidence.
- **IMP-06:** A parser update must not silently rewrite accepted history; it creates a reprocessing proposal.
- **IMP-07:** Real source files and raw payloads never enter logs or source control.
- **IMP-08:** Apply a versioned metric-specific source-authority policy while preserving secondary and conflicting records.
- **IMP-09:** Detect cross-source duplicates and route material source edits, deletions and late-arriving corrections through review.
- **IMP-10:** Support scoped deletion, full portable export and complete-vault cryptographic erasure with backup warnings.

### 12.2 APEX

- **APX-01:** Import and browse workouts, exercises and sets from the representative Hevy export.
- **APX-02:** Accept screenshot-derived candidate sessions with field-level confirmation.
- **APX-03:** Maintain a versioned 24-pattern framework and exercise mapping table.
- **APX-04:** Support direct/indirect muscle contribution and user overrides.
- **APX-05:** Generate movement coverage with covered/excluded/missing/ambiguous states.
- **APX-06:** Select best sets using visible versioned rules.
- **APX-07:** Compare current values against selected versioned benchmark packs.
- **APX-08:** Show week, block and all-time progress deltas.
- **APX-09:** Generate body-part rankings and expose the scoring inputs.
- **APX-10:** Generate descriptive day-level A/B/C comparison with comparability warnings.
- **APX-11:** Preserve injury, equipment, intent, QC and programming context.
- **APX-12:** Validate benchmark-pack completeness, applicability, licensing notes and confidence before activation.
- **APX-13:** Keep observed working-set, estimated-1RM and relative-strength comparisons separate and identify the selected policy.
- **APX-14:** Prioritize personal progress and movement coverage over external cohort comparison in navigation and reports.
- **APX-15:** Require configurable minimum sample counts and comparable conditions for sequencing/fatigue flags.

### 12.3 Physique Tracker

- **PHY-01:** Create dated check-ins with measurement protocol and body-fat method.
- **PHY-02:** Calculate FFM, raw FFMI and Kouri-normalized FFMI from accepted inputs.
- **PHY-03:** Calculate target FFM and bodyweight from user-selected FFMI/body-fat targets.
- **PHY-04:** Compare measurements against prior check-ins and reference athletes.
- **PHY-05:** Calculate proportional reference targets as visibly labelled heuristics.
- **PHY-06:** Support off, personal-regression and explicit legacy waist-projection modes.
- **PHY-07:** Warn when measurement protocol changes make deltas weakly comparable.
- **PHY-08:** Store optional progress images locally and encrypted.
- **PHY-09:** Capture repeatability tolerance or sourced uncertainty bounds and propagate them through FFMI and target calculations.
- **PHY-10:** Mark changes inside protocol tolerance as inconclusive and show which uncertain input dominates a derived range.
- **PHY-11:** Provide a standardized photo protocol covering pose, distance, lighting, timing, crop, metadata handling and explicit inclusion.

### 12.4 Health, nutrition and labs

- **HLT-01:** Import WHOOP native CSV bundle while retaining vendor field definitions.
- **HLT-02:** Import MacroFactor selected spreadsheets and separate measured from modelled fields.
- **HLT-03:** Stream Apple Health XML without loading the complete export into memory.
- **HLT-04:** Preserve Apple source/device metadata and review probable duplicates.
- **HLT-05:** Extract laboratory candidate fields with source-page evidence and mandatory confirmation.
- **HLT-06:** Preserve source-lab ranges and prohibit unsafe unit conversion.
- **HLT-07:** Overlay accepted context events without causal claims.
- **HLT-08:** Maintain personal rolling/block baselines separately from source references and external benchmarks.
- **HLT-09:** Preserve source-provided lab flags and allow only user-defined or clinician-accepted health-floor thresholds with provenance.
- **HLT-10:** Show stale, missing, conflicting and insufficient-sample states instead of calculating from weak evidence.
- **HLT-11:** Record illness, travel, deload, equipment, program, phase and other confounding events without converting them into causal conclusions.

### 12.5 Reports and agents

- **RPT-01:** Generate baseline, weekly, training-block, physique-check-in and clinician-style factual reports.
- **RPT-02:** Every report carries period, source coverage, unresolved exceptions, formula versions and generated/accepted timestamps.
- **RPT-03:** Export reviewed Markdown/JSON to a user-selected Operating System staging path.
- **RPT-04:** Run a period-based close that freezes accepted inputs, review state and report hashes and creates superseding versions for later corrections.
- **RPT-05:** Provide separate private, clinician-safe and public-content report profiles with explicit field allowlists and a redaction preview.
- **RPT-06:** Prevent public-content exports from including raw labs, treatment/PED context, exact private health data, progress photos or identifying metadata by default.
- **AGT-01:** Provide a versioned read-only manifest and allowlisted query/export surface.
- **AGT-02:** Agent outputs are staged candidates and cannot mutate accepted records directly.
- **AGT-03:** Any decrypted agent job material is explicitly scoped and removed after completion.
- **AGT-04:** Require per-job disclosure and consent before any decrypted evidence can leave the local trust boundary.
- **AGT-05:** Record the job purpose, fields/artifacts shared, destination class, expiry, result and reviewer without logging sensitive payloads.

### 12.6 Model and decision governance

- **MDL-01:** Register every formula, taxonomy, mapping set, benchmark pack, uncertainty profile and baseline policy with immutable version, source, assumptions, applicability and confidence.
- **MDL-02:** Preview affected accepted results before activating a model version and recompute into superseding snapshots only.
- **MDL-03:** Show `unavailable`, `insufficient_evidence` or `uncertainty_not_quantified` rather than manufacturing a value.
- **MDL-04:** Do not provide one opaque composite health, readiness or optimization score.

### 12.7 Privacy and data lifecycle

- **SEC-01:** Keep database, artifacts, thumbnails, previews, temporary files, jobs and backups encrypted or explicitly ephemeral and access-restricted.
- **SEC-02:** Exclude the vault from Windows search/indexing where supported, strip or protect photo/document metadata, and clear sensitive UI/clipboard/cache state on lock or expiry.
- **SEC-03:** Provide tested key recovery/no-recovery, backup verification, re-keying, restore and full-vault destruction flows.
- **SEC-04:** Maintain a privacy-safe audit trail for imports, acceptance, corrections, deletions, model changes, exports and agent jobs.

## 13. User experience requirements

- Windows-first Tauri desktop application.
- Dark evidence-console visual language inspired by the supplied APEX reference, with high contrast and compact information density.
- A visible source/evidence badge on every metric detail view.
- One-click path from any score to formula, inputs and original source evidence.
- Persistent review queue count and source-freshness status.
- Accessible keyboard navigation, non-colour status indicators and readable minimum text sizing.
- No social feed, engagement mechanics or motivational scoring.
- First-run path that remains useful with only Hevy and one physique check-in while explaining what is unavailable.
- Bulk review, remembered aliases and safe defaults for repeated imports.
- Plain-language distinction between personal baseline, source reference and external benchmark.
- Backup, restore, deletion and export controls that can be completed without command-line knowledge.
- Report-audience selector and field-by-field redaction preview before any file leaves the vault.

Primary navigation:

1. Home
2. Review Queue
3. Training / APEX
4. Physique
5. Recovery & Sleep
6. Nutrition & Weight
7. Labs
8. Timeline
9. Reports
10. Sources & Privacy
11. Close
12. Models & Benchmarks

## 14. Privacy, safety and decision rights

- Vault and source documents are encrypted at rest.
- No telemetry or public endpoint by default.
- No raw data is sent to a cloud model without a separate explicit user decision for that job.
- The app may normalize, calculate, compare, flag missing evidence and draft reports.
- The app may not diagnose, prescribe, choose clinical thresholds, recommend drug/PED protocols, change doses or infer drug use from FFMI/performance.
- User-declared treatment/PED context may be stored as sensitive context; it is never an optimization instruction.
- Reference cohorts labelled “natural” or “enhanced” describe the benchmark pack, not the user.
- Health alerts are limited to data quality, user-defined thresholds and accepted authoritative thresholds with source metadata.
- Progress photos, laboratory PDFs and treatment context receive the highest sensitivity classification and are excluded from agents and non-private reports by default.
- Temporary previews, thumbnails, crash recovery, clipboard and application logs must not become unencrypted side channels.
- Remote/cloud agent use is off by default and requires a per-job preview of the exact disclosed scope, destination class and expiry.
- Deletion, key recovery, re-keying and backup retention limitations must be understandable before the user relies on them.
- The app preserves source red flags and can help prepare clinician questions; emergency or clinical decisions remain outside the product.

## 15. Non-goals

- Replacing source apps for daily logging.
- Automated workout or nutrition programming in Phase 1.
- Medical diagnosis or treatment recommendations.
- Public athlete leaderboard or social comparison.
- Cloud accounts, sync or collaborative coaching.
- Inferring causality from wearable, nutrition and performance correlations.
- Treating FFMI 25 as a universal biological ceiling.
- Scraping unverified athlete measurements as authoritative benchmarks.
- One opaque health/readiness/optimization score.
- Automatic training, calorie, supplement, medication, treatment or PED changes.
- Public-content generation directly from raw health records or sensitive progress images.
- FHIR/clinical-system integration until a concrete clinician interoperability need is established.
- AgenticOS, Hermes or multi-agent orchestration as a Phase 1 dependency.

## 16. Success metrics

### Phase 1 product metrics

- 100% of accepted APEX and Physique metrics trace to source inputs and formula/mapping versions.
- Reimporting the same Hevy file produces zero duplicate accepted records.
- Second recurring refresh plus review takes less than 15 minutes.
- All 24 movement patterns have an explicit state.
- No ambiguous screenshot value enters benchmarking without confirmation.
- Backup/restore reproduces the same accepted records and report hashes.
- Every benchmark entry used in a report passes the pack's required applicability/source fields.
- Every FFMI or target result affected by quantified body-fat uncertainty shows a range and sensitivity; otherwise uncertainty is explicitly unquantified.
- Conflicting source records identify the active authority rule and remain inspectable.
- An accepted close freezes its inputs and is superseded, never silently rewritten.
- No private-only field appears in clinician-safe or public-content export fixtures.

### Product value metrics

- The app reveals at least one real movement, sequencing, measurement-protocol or evidence-quality issue the manual process missed.
- A reviewed block/check-in report changes a decision or removes uncertainty.
- The user prefers the app over rebuilding the analysis in chat or spreadsheets.
- Maintenance burden declines after the second cycle.
- The recurring close stays within a user-defined review budget and does not require relabelling known aliases.

## 17. Delivery phases

### Phase 0 - Trust and format spikes

- Encrypted vault, key lifecycle and verified backup/restore.
- Inspect representative Hevy export and screenshot.
- Build sanitized fixtures.
- Lock APEX-24 seed framework and benchmark-pack format.
- Implement provenance, units and review-state foundations.
- Define the measurement/photo protocol, uncertainty representation and personal-baseline policy.
- Lock metric-specific source-authority rules for Phase 1 data.
- Complete the Windows side-channel, recovery, deletion and agent-disclosure threat model.

### Phase 1 - APEX + Physique Tracker

- Hevy import and screenshot candidate workflow.
- Exercise identity/mapping and coverage.
- Benchmark, progress, body-part and day-level views.
- Physique check-ins, FFMI, measurement gaps and target calculators.
- Baseline, weekly/block and check-in reports.
- Period close, model-impact preview and private Operating System export.

### Phase 2 - Recovery, nutrition and photos

- WHOOP CSV bundle.
- MacroFactor spreadsheets.
- Timeline overlays and source freshness.
- Encrypted progress-photo workflow.

### Phase 3 - Apple Health and labs

- Streaming Apple Health XML import and dedupe review.
- Laboratory PDF/CSV candidates, source-page QC and clinician brief.

### Phase 4 - Agent and expanded Operating System bridge

- Local CLI and read-only MCP.
- Explicit staged agent jobs.
- Durable schema migration and optional automation around the already-reviewed Markdown/JSON Operating System export.
- Expanded report profiles and optional clinician interoperability only after a concrete use case.

## 18. Phase 1 acceptance

Phase 1 is complete only when:

1. A real 90-day Hevy export imports without duplication and shows import delta.
2. One session screenshot is extracted into candidates, corrected and accepted through the QC queue.
3. Exercises map to the versioned APEX-24 framework and all patterns show a state.
4. A benchmark table displays current, selected references, gap, source and confidence without inferring user drug status.
5. Exercise progress, body-part score and A/B/C comparison lead back to accepted sets.
6. Two physique check-ins produce protocol-aware deltas, FFM, raw FFMI and normalized FFMI using the `6.3` correction.
7. Proportional measurement and waist projection outputs are visibly labelled heuristic with inputs and model version.
8. A reviewed block/check-in report exports without raw source files.
9. Encrypted backup and clean-machine restore pass with matching accepted-record/report hashes.
10. Body-fat/measurement uncertainty produces a range or explicit unquantified state rather than false precision.
11. A period close freezes reviewed inputs and exports a private summary through an allowlisted schema.
12. Source-authority, model-version and benchmark-applicability details are inspectable from every affected output.
13. Private, clinician-safe and public export fixtures pass field-allowlist and metadata-leak tests.

## 19. Open decisions before implementation

- Representative Hevy export columns and screenshot shapes.
- Exact APEX-24 taxonomy and initial exercise mappings from the user's current framework.
- Benchmark source pack: exercises, equipment, rep bands, cohort labels and evidence confidence.
- Svelte 5 versus React for the Tauri UI; technical design recommends Svelte 5 for alignment with Pernance.
- OS key-store-only unlock versus optional app passphrase and recovery design.
- Progress-photo inclusion in Phase 1 or Phase 2.
- Initial Operating System export destination and review workflow.
- Measurement repeatability protocol and admissible uncertainty bounds for each Phase 1 body-composition method.
- Personal-baseline windows, minimum sample counts and stale-after thresholds per metric.
- Confirmed canonical/secondary source matrix for overlapping weight, workout, recovery and nutrition records.
- Exact recurring close cadence, unresolved-item acceptance policy and review-time budget.
- Private, clinician-safe and public report field allowlists.
- Raw artifact/photo retention policy, partial-deletion semantics and backup-retention reminders.
- Repository location, application identifier, license, signing/update posture and sanitized-fixture process before scaffolding.

## 20. Source notes and corrections

- User-supplied APEX product-spec image, 2026-07-13: incorporated movement coverage, Hevy CSV/screenshots, QC, consolidation, benchmark table, progress delta, body-part scoring, context modelling and A/B/C day analysis.
- User-supplied Physique Tracker concept, 2026-07-12: incorporated proportional comparisons, measurements, FFMI, target calculators, waist projection modes and progress tracking.
- [Kouri et al., 1995](https://pubmed.ncbi.nlm.nih.gov/7496846/): source for FFMI definition and the reported `6.3 * (1.80 - height_m)` normalization. The paper calls its findings preliminary; AttributeOS does not convert 25 into a diagnostic classifier.
- [Apple Health export guidance](https://support.apple.com/en-ca/guide/iphone/iph5ede58c3d/ios): current official guidance states that all Health data can be exported in XML.
- [WHOOP data export guidance](https://support.whoop.com/s/article/How-to-Export-Your-Data): current official export delivers multiple CSV files including physiological cycles, sleep, workouts and journal entries.
- [MacroFactor data export guidance](https://help.macrofactorapp.com/en/articles/68-export-your-data): current official workflow provides granular spreadsheets and a quick progress export.

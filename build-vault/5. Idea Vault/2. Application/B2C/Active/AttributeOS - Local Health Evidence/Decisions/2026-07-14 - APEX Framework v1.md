---
title: APEX Framework v1
description: Accepted product decision translating Nadeem's Aesthetic and Strength philosophy into governed AttributeOS reference data.
created: 2026-07-14
updated: 2026-07-14
status: accepted-product-decision
decision_owner: Nadeem
decision_method: user-delegated synthesis from supplied source notes
review_date: 2026-08-10
tags: [attributeos, apex, decision, movement-framework, training-evidence]
---

# APEX Framework v1

## Decision

AttributeOS will use the supplied 24-joint-movement taxonomy as `apex-24/v1`.
It is a coverage and evidence framework, not an autonomous coaching system.
The app may show what was trained, what was not trained, what is comparable,
and what changed. It may not diagnose a stall, prescribe a program change, or
treat an external benchmark as more authoritative than the user's own
comparable history.

The source philosophy is preserved in the Content notes:

- *Part 1.1 - What Actually Matters*
- *Part 3.1 - The Program - Concepts*
- *Part 3.2 - The Program - Rules and Building the Program*
- *Part 3.3 - The Program - Example Programs*
- *Part 5.0 - Tech Integration*

Those notes are authoritative for the user's philosophy. This decision is
authoritative for how AttributeOS represents it.

## Evidence order

APEX presents evidence in this order:

1. Personal progress under the same exercise, equipment, execution, laterality,
   load model, rep policy and material context.
2. Bodyweight-relative performance where the selected policy supports it.
3. Coverage across the 24 joint movements and six compound patterns.
4. External benchmark comparison from an activated, versioned pack.

No layer may overwrite another. A benchmark gap cannot erase personal progress,
and a strong benchmark result cannot hide a movement-coverage gap.

## The 24 stable patterns

The display groups reproduce the supplied framework. Stable keys are product
identifiers introduced here; labels may be clarified later, but a semantic
change requires a new framework version rather than editing `v1` in place.

| Order | Stable key | Display group | Display label | Supplied meaning |
| ---: | --- | --- | --- | --- |
| 1 | `back.vertical_pull` | Back | Vertical Pull | Frontal-plane shoulder adduction plus elbow flexion |
| 2 | `back.horizontal_pull_low` | Back | Horizontal Pull - Low Row | Shoulder extension plus elbow flexion at a low angle |
| 3 | `back.horizontal_pull_high_scapular` | Back | Horizontal Pull - High / Scapular Row | Shoulder horizontal abduction plus scapular retraction |
| 4 | `back.spinal_extension` | Back | Spinal Extension | Erector-driven trunk extension |
| 5 | `legs.knee_flexion` | Legs | Knee Flexion | Hamstring-curl pattern |
| 6 | `legs.knee_extension` | Legs | Knee Extension | Quad-dominant extension |
| 7 | `legs.ankle_plantar_dorsiflexion` | Legs | Plantarflexion + Dorsiflexion | Calf raise through full range, retaining calf and tibialis contributions |
| 8 | `legs.hip_adduction` | Legs | Hip Adduction | Leg moves toward the midline |
| 9 | `legs.hip_abduction` | Legs | Hip Abduction | Leg moves away from the midline |
| 10 | `legs.hip_extension` | Legs | Hip Extension | Glute-driven hip drive |
| 11 | `arms.elbow_flexion_neutral` | Arms | Elbow Flexion - Neutral Grip | Brachialis / brachioradialis bias |
| 12 | `arms.elbow_flexion_shoulder_extension` | Arms | Elbow Flexion + Shoulder Extension | Biceps long-head bias |
| 13 | `arms.elbow_extension_overhead` | Arms | Elbow Extension - Overhead | Triceps long-head bias |
| 14 | `arms.elbow_extension_pressdown` | Arms | Elbow Extension - Pressdown | Triceps lateral / medial-head bias |
| 15 | `arms.wrist_flexion_extension` | Arms | Wrist Flexion + Extension | Forearm flexors and extensors |
| 16 | `chest.horizontal_adduction_low_to_high` | Chest | Shoulder Horizontal Adduction - Low to High | Supplied lower / sternal-pec bias |
| 17 | `chest.horizontal_adduction_fly` | Chest | Shoulder Horizontal Adduction - Fly | Supplied mid / clavicular-pec bias |
| 18 | `chest.horizontal_push` | Chest | Horizontal Push | Bench-press pattern |
| 19 | `shoulders.flexion_vertical_push` | Shoulders | Shoulder Flexion / Vertical Push | Anterior-delt press or raise pattern |
| 20 | `shoulders.abduction` | Shoulders | Shoulder Abduction | Lateral-raise / medial-delt pattern |
| 21 | `shoulders.horizontal_abduction` | Shoulders | Shoulder Horizontal Abduction | Rear-delt pattern |
| 22 | `shoulders.external_internal_rotation` | Shoulders | Shoulder External + Internal Rotation | Rotator-cuff pattern |
| 23 | `trunk.spinal_flexion` | Abs | Spinal Flexion | Rectus-abdominis / oblique contribution |
| 24 | `trunk.hip_flexion` | Abs | Hip Flexion | Iliopsoas / rectus-femoris / TFL contribution |

The source notes explicitly place serratus and neck outside the 24. They may be
represented later as optional user-defined patterns, but they do not silently
become patterns 25 and 26 inside `apex-24/v1`.

## Six compound-pattern views

The six compounds are derived views over the atomic framework, not replacement
taxonomy rows.

| Compound view | Required atomic contributions | Coverage posture |
| --- | --- | --- |
| Vertical Push | shoulder flexion / vertical push plus elbow extension | Expected weekly unless deliberately excluded |
| Vertical Pull | vertical pull plus elbow flexion | Expected weekly unless deliberately excluded |
| Horizontal Push | horizontal adduction / push plus elbow extension | Expected weekly unless deliberately excluded |
| Horizontal Pull | low or high horizontal pull plus elbow flexion | Expected weekly unless deliberately excluded |
| Squat | hip extension plus knee extension plus ankle contribution | Expected weekly unless deliberately excluded |
| Hinge | hip extension with relatively stable knee | Expected weekly unless deliberately excluded |

The UI reports `covered_direct`, `covered_indirect`, `deliberately_excluded`,
`missing`, `ambiguous`, or `no_recent_data`. "Missing" is an evidence state,
not an instruction to add an exercise.

## Exercise identity and mappings

An exercise comparison identity is:

```text
canonical exercise
+ equipment / load model
+ execution and material ROM
+ laterality
+ assistance or bodyweight semantics
```

Name similarity may create a candidate but may not accept a mapping. Exercise
to pattern mapping is many-to-many and carries `primary`, `secondary`,
`stabilizer`, or `excluded`, plus source, confidence, version and user override.

The initial configured-exposure heuristic is:

- direct / primary contribution: `1.0`
- indirect / secondary contribution: `0.5`
- stabilizer: visible, but excluded from the numeric exposure total in `v1`
- excluded: `0.0` with the reason retained

These weights express configured exposure only. They are not measurements of
hypertrophy, recovery or muscle growth. A different mapping or weight set is a
new immutable model version.

## Progress policies

The source philosophy and the PRD use different rep bands for different jobs.
Both are retained as named policies:

- `observed_5_8_load_primary/v1`: the PRD benchmark-selection policy. Use only
  for accepted comparable working sets of 5-8 reps.
- `double_progression_8_12/v1`: the supplied hypertrophy-program policy. First
  compare reps at the same load and form; increase load only after the top of
  the range is reached under the accepted rule.
- `latest_comparable_best/v1`: the most recent best set within an explicitly
  selected rep band and full comparison identity.

The progress signal order is load at the same reps and accepted execution,
then lower RPE at the same load/reps, then more reps at the same load, then RIR,
then an explicitly selected estimated-1RM policy. Hevy does not prove form, so
form-dependent conclusions remain unavailable unless a reviewed form-check
artifact is linked.

Warm-ups are excluded from best-set selection. `normal`, `failure`, and
`dropset` remain distinct set classifications and are included only when the
selected policy says so.

## Variation lifecycle

Each exercise may record the seven supplied variation axes:

1. stability
2. overloadability
3. isolation potential
4. moment arm
5. effective range of motion
6. mind-muscle connection
7. resistance curve / bias

Safety is stored separately as context, not as an eighth stimulus score.
Variation changes split comparison series by default. Bridging two variations
requires a reviewed mapping and never makes their loads identical.

## Benchmark-pack decision

The strength tables in *Part 1.1* and the natural/enhanced comparison intent in
*Part 5.0* are retained as user-supplied research notes, not an active pack.
They mix bodyweight ratios, working-set targets, machine-dependent values and
1RM-style standards, and they do not yet provide the complete execution,
equipment, cohort, licensing and rep-policy metadata required by the PRD.

Therefore:

- create `apex-strength-reference-notes/v0` only as inactive research metadata;
- do not calculate benchmark gaps from it;
- do not invent an enhanced-elite pack;
- activate the first pack only after every entry passes the PRD benchmark
  validator and the user accepts the pack.

This does not block personal progress, coverage, mapping, or Hevy import work.

## Safety translation

Some source prose uses diagnostic or prescriptive language. AttributeOS does
not encode that behavior. It translates it into bounded observations such as:

- "all selected comparable lifts declined in this window";
- "this exercise has not improved under the selected policy";
- "recovery context coincided with the change";
- "consider reviewing programming, technique or recovery context."

The app cannot diagnose recovery failure, prescribe volume/calorie changes,
change a program, or optimize medication/PED use. Natural and enhanced labels
describe benchmark cohorts only and never classify the user.

## Acceptance checks

- Exactly 24 stable pattern keys exist in `apex-24/v1`.
- Every pattern has a source label, display order and active state.
- The six compound views are derived from atomic patterns.
- Missing and deliberately excluded are distinct.
- Mapping and exposure models are versioned and inspectable.
- Every progress result names its comparison and rep policy.
- No active benchmark entry lacks required provenance and comparability fields.
- No output claims diagnosis, causation, hypertrophy measurement or autonomous
  programming authority.


---
title: eval.yaml — Template
type: template
created: 2026-06-05
tags: [template, agent, eval, definition-of-done, golden-examples]
---

# eval.yaml — Template

> [!summary]
> The **definition of done** for an agent task, written as testable cases rather than prose. Each case carries a **golden example** (the reference "good" output the agent imitates) and **assertions** (what the output must pass). Also serves as a **regression suite**: re-run it whenever you change [[policies.template|policies.md]] or [[skills.template|skills.md]]. See [[Part A1 - Agent Operating Files#5. eval.yaml — definition of *done* (with golden examples)]].

## How to use
- One `eval.yaml` per agent task.
- Keep reference outputs in a sibling `./golden/` folder; promote your *best real outputs* into it (candidates come from the [[decision-log.template|decision log]]).
- The agent loads it at generation time (imitate goldens) **and** validates against it before marking done.
- Run it as a regression check after every weekly [[Part A1 - Agent Operating Files#Policy-change cadence|policy change]].

## Template

```yaml
# eval.yaml — <agent name>
version: 0.1
task: produce_slide_carousel
last_updated: 2026-06-05

# Hard, machine-checkable assertions (mirror the numbers in policies.md)
assertions:
  - title_len <= 100
  - description_len <= 2200
  - no_banned_words            # references policies.md banned_words
  - no_health_claims           # critical for peptides
  - has_disclaimer
  - slide_count between 6 and 10
  - saved_path matches /content/<account>/<date>/
  - tracker_row updated

# Qualitative rubric (score 1-5; judged by human or an LLM-judge)
rubric:
  hook_strength:   "first slide opens a curiosity gap in <1 line"
  on_brand_voice:  "matches brand guideline tone"
  one_idea_per_slide: true
  source_cited:    "every factual claim ties to a knowledge-base note"

# Cases: each pairs an input with a reference 'good' output + pass bar
cases:
  - id: glp1_education_carousel
    input: "brief: GLP-1 basics for beginners"
    golden_example: ./golden/glp1_education_carousel.md
    must_pass: [title_len, no_banned_words, no_health_claims, has_disclaimer]
    min_rubric_score: 4

  - id: peptide_myth_busting
    input: "brief: common peptide myths"
    golden_example: ./golden/peptide_myth_busting.md
    must_pass: [no_health_claims, has_disclaimer, source_cited]
    min_rubric_score: 4

# What happens on failure
on_fail:
  - reject output, do not publish
  - log failure to /logs/eval/<date>
  - if assertion 'no_health_claims' fails → flag for human review
```

> [!tip] Assertions vs rubric
> **Assertions** are pass/fail and machine-checkable — they overlap with [[policies.template|policies.md]] on purpose (policies *state* the rule; eval *tests* it). **Rubric** items are graded quality, scored by a human or an LLM-judge. An output is "done" only when it passes all `must_pass` assertions *and* clears `min_rubric_score`.

> [!warning] Golden examples are taste, codified
> The `./golden/` references are the highest-value part — they turn "on-brand" from a vague instruction into a concrete target. Curate them deliberately; a weak golden teaches the agent to be weak.

Related: [[policies.template]] · [[guardrail.template]] · [[skills.template]] · [[Part A1 - Agent Operating Files]]

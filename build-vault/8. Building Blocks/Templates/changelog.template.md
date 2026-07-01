---
title: CHANGELOG.md — Template
type: template
created: 2026-06-05
tags: [template, agent, changelog, versioning]
---

# CHANGELOG.md — Template

> [!summary]
> A dated record of what changed in the agent's operating files (policies / skills / eval) and why. Prevents silent drift, makes changes reversible, and gives every change a clean before/after window. Governed by the [[Part A1 - Agent Operating Files#Policy-change cadence|weekly policy-change cadence]].

## How to use
- One CHANGELOG per agent (or per pipeline).
- Add an entry **only on the weekly change slot** — unless it's a big/significant or compliance change (those go in immediately, marked `[urgent]`).
- Each entry: what file, what changed, why, and the evidence (link the [[decision-log.template|decision-log]] entry).
- After a change, **re-run [[eval.template|eval.yaml]]** to confirm no regression.

## Template

```markdown
# CHANGELOG — <agent name>

## [2026-06-12]  (weekly batch)
### policies.md
- Changed: banned_words += ["miracle", "fixes"]
- Why: 2 posts flagged borderline-claim in week of 06-05
- Evidence: [[Decisions 2026-06#borderline-claims]]
### skills.md
- Changed: write_hook → add "question-first" pattern
- Why: question hooks beat statement hooks on hook-rate (saves +18%)
- Evidence: [[Decisions 2026-06#hook-ab-test]]
### eval.yaml
- Changed: added golden ./golden/peptide_myth_busting.md
- Regression re-run: PASS (8/8 cases)

## [2026-06-05]  (initial)
- Established policies.md, skills.md, eval.yaml v0.1
```

> [!tip] The changelog IS your agent's decision log
> It's the [[decision-log.template|lab notebook]] applied to the agent system itself. When you wonder "why did output quality shift three weeks ago?", this is the file that answers it.

Related: [[Part A1 - Agent Operating Files#Policy-change cadence]] · [[policies.template]] · [[eval.template]]

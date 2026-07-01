---
title: guardrail.md — Template
type: template
created: 2026-06-05
tags: [template, agent, guardrail, pre-flight]
---

# guardrail.md — Template

> [!summary]
> The meta-rule: **never run a task without fully loading and understanding the context first.** This is the agent's pre-flight checklist ("definition of ready") plus its hard stop conditions. See [[Part A1 - Agent Operating Files#guardrail.md]].

```markdown
# Guardrail — <agent name>
version: 0.1

## Pre-flight (MUST complete before acting — definition of ready)
- [ ] Loaded root context (CLAUDE.md): mission, business context, state location
- [ ] Loaded policies.md and parsed hard limits
- [ ] Loaded relevant skills.md procedure(s)
- [ ] Loaded eval.yaml: golden examples to imitate + done criteria
- [ ] Retrieved task-relevant knowledge from the knowledge base (RAG)
- [ ] Loaded objective + proxy metric from the driver tree
- [ ] Confirmed current state from the tracker (idempotency: is this already done?)

If ANY box is unchecked → STOP, do not act, report what's missing.

## Hard stops (never proceed autonomously)
- Task moves money / files with authorities → require human approval
- Task publishes public brand content → require human approval (Pilot)
- Output contains a banned word / health claim → reject and flag
- Required context is stale or missing → stop and request refresh

## Definition of done (before marking complete — run eval.yaml)
- [ ] Output passes all eval.yaml `must_pass` assertions
- [ ] Output clears eval.yaml `min_rubric_score`
- [ ] Saved to correct path (per policies.md conventions)
- [ ] Tracker updated to new state
- [ ] Run logged (audit + decision log if a learning occurred); CHANGELOG updated if files changed
```

> [!note] Ready vs done
> This file owns **both gates**: the pre-flight checklist is the *definition of ready*; the [[eval.template|eval.yaml]] run is the *definition of done*. An output that's "produced" isn't "done" until it passes eval.

> [!important] This file is what makes the artifacts matter
> The whole point of building [[Governing Artifacts]] first is wasted if the agent doesn't *load* them. guardrail.md is the enforcement. No context, no action.

Related: [[policies.template]] · [[skills.template]] · [[agent-spec.template]]

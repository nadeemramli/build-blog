---
title: Agent Spec — Template
type: template
created: 2026-06-05
tags: [template, agent, spec, architecture]
---

# Agent Spec — Template

> [!summary]
> One spec per agent in a pipeline. Defines the agent's single job, its input/output contract, its autonomy level, and which operating files it loads. Forces the "one agent, one job" discipline from [[Part A2 - Multi-Agent Orchestration#Core principles]].

```markdown
# Agent — <name>  (e.g. "ideate-agent")
version: 0.1
pipeline_step: 2 of 5
single_job: "Turn knowledge base into content angles + calendar + briefs"

## Type
script_or_agent: agent        # use 'script' if deterministic (see decision matrix)
autonomy_level: L2            # L0 manual · L1 assisted · L2 approval-gated · L3 autonomous · L4 self-optimizing
approval_gate: "human glances at calendar before produce step"  # or 'none'

## Contract
inputs:
  - knowledge base (RAG)
  - tracker (current backlog)
outputs:
  - content briefs ([[content-brief.template]])
  - updated tracker rows (status: briefed)

## Context it MUST load (enforced by guardrail.md)
- CLAUDE.md (root context)
- policies.md
- skills.md: [ideate_angles, build_calendar ]
- eval.yaml (golden examples + done criteria)
- driver tree (objective: control-panel inputs, not follower count)

## Reliability
idempotent: yes — skip items already briefed
on_error: retry x2 → write to dead-letter note → flag human
rate_limit: max N LLM calls/run
logs_to: /logs/ideate/<date> + decision log on notable learnings

## Success metric
- briefs produced/day, % approved without edit
```

> [!tip] Fill one of these per agent before you build it
> If you can't fill the `single_job` line in one sentence, the agent is doing too much — split it.

Related: [[Part A2 - Multi-Agent Orchestration]] · [[Part B1 - Automation Decision Matrix]] · [[Part A1 - Agent Operating Files]]

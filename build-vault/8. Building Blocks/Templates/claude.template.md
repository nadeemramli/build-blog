---
title: CLAUDE.md / AGENTS.md — Root Context Template
type: template
created: 2026-06-05
tags: [template, agent, root-context, claude-md]
---

# CLAUDE.md / AGENTS.md — Root Context Template

> [!summary]
> The **single entry point** every agent reads first. States the mission, business context, where state lives, and points to the other operating files. One root per agent (or one shared root + per-agent overrides). See [[Part A1 - Agent Operating Files#1. CLAUDE.md / AGENTS.md — root context]].

## Template

```markdown
# CLAUDE.md — <agent or pipeline name>
version: 0.1
last_updated: 2026-06-05

## Mission
<one sentence: what this agent exists to do>
e.g. "Produce daily on-brand peptide-education slide carousels for the 10 niche TikTok accounts and funnel viewers to the website."

## Business context
- Entity: Market → Distribution (Growth)   # see Three Entities
- Channel: TikTok (niche knowledge accounts)
- Objective + proxy: optimize control-panel inputs (retention, hook rate, shares, saves) — NOT follower count
  (see Governing Artifacts → Scoreboard vs control panel)

## Where state lives
- Tracker: <path or DB>   (status lifecycle: idea → briefed → produced → scheduled → posted → measured)
- Content output: /content/<account>/<date>/
- Logs: /logs/<agent>/<date>
- Knowledge base (RAG): <path>

## Autonomy
- Level: L2 (approval-gated)        # L0–L4, see BAU vs Pilot
- Safety gate: human approves before publish (banned words / health claims)
- Performance tuning: weekly, not per-item

## The other operating files (load in this order)
1. guardrail.md     — definition of ready (pre-flight)
2. policies.md      — hard rules + conventions
3. skills.md        — how-to procedures
4. eval.yaml        — definition of done + golden examples
5. CHANGELOG.md     — what changed recently

## Hard rules (the non-negotiables, also in policies.md)
- Never publish autonomously. Never make a health/medical claim. Always include disclaimer.
- Never act without completing the guardrail pre-flight.
```

> [!tip] Keep it short and stable
> CLAUDE.md is the *map*, not the detail. Detail lives in policies/skills/eval. If you find yourself editing CLAUDE.md often, the churny content probably belongs in one of the other files.

Related: [[policies.template]] · [[guardrail.template]] · [[eval.template]] · [[Part A1 - Agent Operating Files]]

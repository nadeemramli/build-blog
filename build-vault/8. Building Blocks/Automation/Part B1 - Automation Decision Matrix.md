---
title: Automation Decision Matrix
type: tool
created: 2026-06-05
tags: [automation, agentic, decision, matrix, scoring]
---

# Automation Decision Matrix

> [!summary]
> A practical tool for turning the [[Part B2 - BAU vs Pilot Framework|BAU vs Pilot]] intuition into a decision: *should this task be automated, and at what autonomy level?* Built around two axes — **how repeatable** the task is, and **how high the stakes** are.

## The 2×2

```
                 HIGH STAKES (Pilot)
                        │
   L1 Assisted /        │      L2 Approval-gated
   keep human           │      (agent does it,
   (judgment-heavy,     │       human approves)
   one-off)             │
   ─────────────────────┼─────────────────────  →  HIGH REPEATABILITY
   L0 Manual /          │      L3 Autonomous
   not worth automating │      (full agent,
   (rare, low value)    │       audit log)
                        │
                 LOW STAKES (BAU)
```

- **Top-left (high stakes, low repeatability):** creative/strategic one-offs → human or **L1 assisted**.
- **Top-right (high stakes, high repeatability):** the sweet spot for **L2 approval-gated** automation — speed *and* control.
- **Bottom-right (low stakes, high repeatability):** automate fully, **L3 autonomous**. The clearest wins.
- **Bottom-left (low stakes, rare):** leave manual; automating costs more than it saves.

## Scoring a task (quick rubric)

Score each 1–5; higher total → higher autonomy.

| Factor | 1 (keep human) | 5 (automate) |
|---|---|---|
| **Repeatability** | one-off | daily, identical shape |
| **Rule-clarity** | fuzzy judgment | explicit rules exist |
| **Reversibility** | hard to undo | trivially reversible |
| **Stakes if wrong** | brand/legal/money | cosmetic |
| **Measurability** | no clear metric | clear proxy metric |

- 20–25 → **L3 autonomous**
- 14–19 → **L2 approval-gated**
- 8–13 → **L1 assisted**
- <8 → **L0 manual**

## Add the static/dynamic lens first

Before scoring autonomy, classify the task using [[Static and Dynamic Functions]]:

- **Static tasks** usually score higher on repeatability and rule-clarity. They are better candidates for scripts, SOPs, templates, and L3 automation once stakes are low.
- **Dynamic tasks** usually score lower on rule-clarity and reversibility. They may still be automated, but usually as L1/L2 assisted work with human judgment around the final decision.
- **Hybrid tasks** should be split before scoring. Example: "digital marketing" is too broad; website tracking setup is static, while content strategy is dynamic.

This prevents broad departments from being misclassified. Score the specific task, not the umbrella.

## The approval-gate rule

> [!important] Some things never reach full autonomy regardless of score
> Any task that **moves money, files with authorities, or speaks publicly as the brand in a non-reversible way** caps at **L2 (approval-gated)** — never L3. Examples: ad budget changes, payments, tax filings, PR responses, partnership commitments. The surrounding *production* can be autonomous; the *commit* needs a human click.

## Don't over-classify — the script test

> [!tip] Many "automation candidates" aren't agent tasks at all
> Before assigning an LLM agent, ask: *does this need judgment, or just execution?* News scraping, tracker audits, scheduling, inventory sync are **deterministic** — a plain script/cron does them more reliably and cheaply than an LLM. Reserve agents for genuinely fuzzy work (content angles, copywriting, analysis). See [[Critique and Best Practices#5. Don't reach for an LLM when a script will do]].

## Output of this exercise
For every task you classify, record:
- Autonomy level (L0–L4)
- Whether it's script or agent
- The approval gate (if any)
- Where it logs its work

…in the [[agent-spec.template|agent spec]] and the [[decision-log.template|decision log]].

## Related
- [[Part B2 - BAU vs Pilot Framework]] — the conceptual layer
- [[Part A2 - Multi-Agent Orchestration]] — building the automatable ones

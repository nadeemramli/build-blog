---
title: Building Blocks — Index / Map of Content
type: MOC
created: 2026-06-05
tags: [moc, system, business-model, agentic, automation]
---

# 00 — Building Blocks Index (MOC)

> [!summary] What this vault is
> A living documentation of the operating system behind the business: the **strategic architecture** (how the business is structured and grows) and the **agentic/automation system** (how that growth gets executed by agents). It exists so that *learning-while-building never gets lost* — every model, test, and decision has a home.

This is a **Map of Content**. Start at [[01 - System Overview]], then dive into whichever layer you need.

## The two halves of the system

```
                STRATEGY (what & why)              AUTOMATION (how)
        ┌─────────────────────────────┐   ┌──────────────────────────────┐
        │  Three Entities             │   │  BAU vs Pilot Framework      │
        │   ├─ Market (Brand/Prod/Dist)│  │  Automation Decision Matrix  │
        │   ├─ Capital                │ → │  Multi-Agent Orchestration   │
        │   └─ Operation              │   │  Agent Operating Files       │
        │  Governing Artifacts ───────┼───┤  (policies / skills / guard) │
        └─────────────────────────────┘   └──────────────────────────────┘
                         │                              │
                         └──────────► Driver Tree / KPIs ◄──────────┘
                                   (the shared measurement spine)
```

## Strategy layer
- [[Three Entities]] — Market · Capital · Operation (the three top-level entities)
- [[Market]] — own the demand; umbrella over the three pillars below
  - [[Branding]] — moats · advantage · power
  - [[Product]] — value architecture · JTBD · value proposition · demand
  - [[Distribution]] — the Growth pillar (acquisition → conversion → retention)
    - [[Acquisition Channels]] — paid · content · virality · social commerce
    - [[Conversion and Engagement]] — website + social media
    - [[Retention]] — stickiness · database · community
- [[Capital]] — bookkeeping, accounting, finance; raise · allocate · wield
- [[Operation]] — costing, supply chain, inventory, the fulfilment spine
- [[Governing Artifacts]] — the context layer that powers both strategy and agents

- [[Static and Dynamic Functions]] - prioritization lens: stable reusable functions first, market-sensitive functions second

## Tactical layer
- [[Tactical]] — the *how*: concrete plays beneath Strategy, split by maturity
  - [[Practical]] — built & executed → documented, trusted
    - [[Practical Market]] · [[Practical Capital]] · [[Practical Operation]]
  - [[Theoretical]] — observed & collected → brainstormed, unproven until built
    - [[Theoretical Market]] · [[Theoretical Capital]] · [[Theoretical Operation]]

## Automation layer
- [[Part B2 - BAU vs Pilot Framework]] — deciding what to automate vs keep human
- [[Part B1 - Automation Decision Matrix]] — the practical 2×2 + scoring
- [[Part A2 - Multi-Agent Orchestration]] — reference architecture for agent pipelines
- [[Part C1 - Case Study - Peptide TikTok Network]] — the worked example, end to end
- [[Part A1 - Agent Operating Files]] — policies.md · skills.md · guardrail.md and how they fit

## Critique & corrections
- [[Critique and Best Practices]] — where the model is strong, where to adjust
- [[Risks and Open Questions]] — what could break, what's still undecided

## Templates (copy these)
- Agent operating files: [[claude.template]] · [[policies.template]] · [[skills.template]] · [[guardrail.template]] · [[eval.template]] · [[changelog.template]]
- Workflow: [[content-brief.template]] · [[agent-spec.template]] · [[decision-log.template]]

---

> [!tip] The single most important habit
> The pain that started this vault — *"I forgot what I tested and have to relearn"* — is solved by one artifact: a **[[decision-log.template|Decision / Experiment Log]]**. Treat it as a lab notebook. Every test, every learning, dated and tagged. See [[Critique and Best Practices#The decision log is your highest-leverage artifact]].

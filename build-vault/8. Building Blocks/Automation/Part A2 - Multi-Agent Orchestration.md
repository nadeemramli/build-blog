---
title: Multi-Agent Orchestration
type: architecture
created: 2026-06-05
tags: [automation, agentic, architecture, orchestration, rag, obsidian]
---

# Multi-Agent Orchestration (Reference Architecture)

> [!summary]
> The general pattern behind the [[Part C1 - Case Study - Peptide TikTok Network|peptide TikTok example]]: a chain of single-purpose agents that read shared context (Obsidian knowledge base + artifacts), do one job each, and write their state to a shared tracker. Scheduling glue (cron / GitHub Actions) runs the pipeline daily.

## Core principles

1. **One agent, one job.** Each agent has a single responsibility with a clear input and output contract. This is what makes the system debuggable.
2. **Shared state is the backbone.** Agents don't talk to each other directly; they read and write a **tracker** (the single source of truth). State, not chat, coordinates them.
3. **Context comes from artifacts.** Every agent loads the relevant [[Governing Artifacts]] (brand, policies, knowledge base) before acting — enforced by a [[Part A1 - Agent Operating Files#guardrail.md|guardrail]].
4. **Log everything.** Each run writes what it did. This *is* the audit trail and doubles as the [[decision-log.template|decision log]] feed — it's how you stop forgetting what happened.
5. **Use the least powerful tool that works.** Deterministic steps = scripts; fuzzy steps = LLM agents. See [[Part B1 - Automation Decision Matrix#Don't over-classify — the script test]].

## The reference pipeline (generic)

```
 ┌─────────────┐   ┌──────────────┐   ┌──────────────┐   ┌──────────────┐   ┌──────────────┐
 │ 1. INGEST   │ → │ 2. IDEATE    │ → │ 3. PRODUCE   │ → │ 4. PUBLISH   │ → │ 5. ANALYZE   │
 │ scrape →    │   │ angles +     │   │ create asset │   │ audit tracker│   │ read KPIs via│
 │ knowledge   │   │ calendar +   │   │ + copy, save │   │ → schedule   │   │ driver tree, │
 │ base (RAG)  │   │ brief        │   │ + log        │   │ (gate here)  │   │ propose iter.│
 └─────────────┘   └──────────────┘   └──────────────┘   └──────────────┘   └──────┬───────┘
        ▲                                                                            │
        └──────────────── feedback: learnings update policies/knowledge ◄───────────┘
                                   (human ratifies — L4 gate)

 SHARED STATE:  Tracker (structured frontmatter / DB)   CONTEXT:  policies.md · skills.md · knowledge base
 GLUE:          Scheduler (cron / GitHub Actions, e.g. "Zernio")
```

Which steps are scripts vs agents:
- **Ingest** — mostly script (fetch + format); light LLM for summarizing/tagging.
- **Ideate** — agent (genuine judgment).
- **Produce** — agent (copywriting/creative).
- **Publish** — script for audit + scheduling; **human approval gate** before posting (Pilot → L2).
- **Analyze** — agent for interpretation; script for pulling the raw metrics.

## Shared state is the backbone

> [!important] Make the tracker structured, not freeform
> If the "tracker" is freeform prose, agents will misread it. Use **structured state**: Obsidian notes with consistent frontmatter (status, channel, scheduled_date, posted, metrics) readable via Dataview, **or** a small SQLite DB. Each content item has one record that moves through states: `idea → briefed → produced → scheduled → posted → measured`.

### The deeper point: conventions matter more than the store

The choice of store (Dataview vs SQLite) is secondary. What actually makes the system reliable is that **agents are instructed to always use shared rules and context** when executing — the tracker is just one of those conventions. Think in reusable convention-templates the whole agent fleet obeys:

| Convention                     | Why it matters                                                                         | Lives in                                                  |              |
| ------------------------------ | -------------------------------------------------------------------------------------- | --------------------------------------------------------- | ------------ |
| **Naming convention**          | Predictable filenames so agents find/avoid collisions (e.g. `YYYY-MM-DD_account_slug`) | [[Part A1 - Agent Operating Files#policies.md]]           |              |
| **Folder management**          | Deterministic paths so "save where it should" is unambiguous                           | policies.md                                               |              |
| **Frontmatter schema**         | The state record's fields are fixed, so every agent reads/writes the same keys         | policies.md + [[content-brief.template]]                  |              |
| **State lifecycle**            | The allowed status values + transitions (idea→…→measured)                              | this note                                                 |              |
| **ID / idempotency key**       | One stable ID per item so re-runs don't duplicate                                      | agent spec                                                |              |
| **Logging convention**         | Where + how each run logs what it did (audit + [[decision-log.template                 | decision log]])                                           | guardrail.md |
| **Versioning convention**      | How policies/skills changes are stamped & batched                                      | [[Part A1 - Agent Operating Files#Policy-change cadence]] |              |
| **Citation/source convention** | Every fact ties back to a knowledge-base note                                          | policies.md                                               |              |

> [!tip] "What else?" — the short answer
> Beyond naming + foldering: a **fixed frontmatter schema**, an **ID/idempotency key**, an **explicit state lifecycle**, a **logging/audit format**, a **source-citation rule**, and a **definition-of-done checklist**. Encode all of these as *rules the guardrail forces every agent to load* — then the store you pick (files or SQLite) is interchangeable.

## Knowledge base as RAG

The Obsidian vault doubles as the retrieval corpus. To make it work:
- **Atomic notes** — one idea per note.
- **Consistent frontmatter** — type, tags, source, date.
- **Separate evergreen from transient** — durable knowledge vs time-stamped signal/news.
- **Chunk-friendly formatting** — clear headings; the [[Part C1 - Case Study - Peptide TikTok Network#Daily pipeline|ingest agent]] formats new material "for RAG purposes."
- **Date everything** — so the agent knows what's current.

## Human-in-the-loop cadence (let it run before you touch it)

> [!important] Humans are *mild, periodic QC* — not a real-time approver of every output
> The human role is light-touch quality control and tuning, applied on a **delay**, not a tight per-item loop. Rule of thumb: **let a new agent/workflow run for at least a week before a human steps in to QC and optimize it.**
>
> **Why the delay matters — fast feedback causes overfitting.** Reacting to every early output (one bad post, one good post) makes you tune the agent to noise. The result is a model that gets *worse* over time, or produces blatantly *uncreative*, regression-to-the-mean output. A week of runs gives a real distribution to judge — signal, not noise.
>
> This pairs with the [[Part A1 - Agent Operating Files#Policy-change cadence|weekly policy-change cadence]]: observe for a week → make one considered batch of changes → observe again. It also reframes the approval gates from [[Part B2 - BAU vs Pilot Framework]]: the publish gate exists for *brand/compliance safety* (catching a banned claim), while *performance tuning* happens on the slower weekly QC rhythm. Don't conflate the two — safety gates are per-item; optimization is weekly.

## Reliability concerns (don't skip these)

> [!warning] What a demo ignores and production can't
> - **Idempotency** — a re-run shouldn't double-post. Check state before acting.
> - **Error handling / retries** — network and API calls fail; need retry + a dead-letter note for human review.
> - **Rate limits & cost** — cap LLM calls; batch where possible.
> - **The feedback loop is dangerous if closed** — letting an agent rewrite its own [[Part A1 - Agent Operating Files#policies.md|policies]] from performance with no human check causes drift. Agent *proposes*, human *ratifies* (L4 gate), and changes are batched weekly. See [[Part A1 - Agent Operating Files#Policy-change cadence]].

## Tech stack pattern (as used in the case study)
Obsidian (knowledge base + state) + scheduler (GitHub Actions / "Zernio") + multi-agent runtime + 3rd-party platform APIs = a full agentic orchestration. The pattern generalizes beyond TikTok to any channel.

## Related
- [[Part C1 - Case Study - Peptide TikTok Network]] — this pattern, fully worked
- [[Part A1 - Agent Operating Files]] — the context every agent loads
- [[Governing Artifacts]] — what feeds the knowledge base

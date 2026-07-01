---
title: Case Study — Peptide TikTok Network
type: case-study
created: 2026-06-05
tags: [automation, agentic, case-study, tiktok, content, peptide]
status: 🟡 piloting
---

# Case Study: Peptide TikTok Network

> [!summary]
> A worked example of the [[Part A2 - Multi-Agent Orchestration|reference architecture]]. The peptide brand is hard to grow directly on TikTok, so instead of one brand account, the strategy is **10 niche knowledge accounts** that share knowledge (slide-style content) and funnel viewers to the website. The daily content operation behind those accounts is run by a chain of agents.

## Why this structure

> [!note] Channel-fit reasoning
> Growing a peptide *brand* directly on TikTok is hard (restrictions, trust, niche). But **knowledge content** in the peptide space is in demand and platform-friendly. So the move is: run 10 niche accounts that teach (via slides/carousels), build authority, and route interested viewers to the website where the actual peptide offer lives. This is the [[Acquisition Channels#2. Content|content channel]] chosen to fit the constraint — not because TikTok is fashionable.

## The daily pipeline

Each day, a chain of agents runs:

1. **Ingest agent** — scrapes news / sources to update the **knowledge base in Obsidian**, formatting entries *for RAG purposes* (atomic, tagged, dated).
2. **Ideate agent** — reads the knowledge base to produce **content angles**, arranges them into a proper **content calendar**, and writes a **content brief** + updates the tracker.
3. **Produce agent** — follows the content calendar to **produce content** (slides + copywriting), **saves it where it should go**, and updates the tracker on completion.
4. **Publish/audit agent** — audits the tracker to find content **posted vs not-yet-posted**; for not-yet-posted, **schedules posting via the scheduler ("Zernio", GitHub Actions workflows)**. ← *approval gate here*
5. **Analyze agent** — analyzes the **KPI breakdown through the [[Governing Artifacts#4. Driver tree / value architecture|driver tree]]**, decomposing until it finds a measurable **proxy for the most impactful KPI** (e.g. *saves* for content), learns from it, and **iterates the performance policies**.

```
 Ingest ──► Ideate ──► Produce ──► Publish/Audit ──► Analyze ──┐
 (RAG)      (angles,   (slides +   (schedule via     (driver    │
            calendar,   copy, save  "Zernio" / GH    tree →     │
            brief)      to tracker) Actions; GATE)   proxy:saves)│
   ▲                                                             │
   └──────────── learnings update policies / knowledge ◄─────────┘
```

## Mapping to autonomy levels (see [[Part B2 - BAU vs Pilot Framework]])

| Step | Script or agent | Autonomy | Note |
|---|---|---|---|
| Ingest | Script + light LLM | L3 | Deterministic fetch; LLM only to tag/summarize |
| Ideate | Agent | L2 | Angles shape the brand → human glance |
| Produce | Agent | L2 | Content is brand-facing (Pilot) → approve before publish |
| Publish/audit | Script | L2 | **Approval gate** before live posting |
| Analyze | Agent | L1→L4 | Reads metrics autonomously; **policy changes need human ratify** |

## The context each agent needs (this is the real lesson)

> [!important] The pipeline only works because the artifacts exist first
> For these agents to perform well, a lot must be set up beforehand (the [[Governing Artifacts]] layer):
> - **Platform policies** — TikTok content rules: title length, photo/description length, banned words, etc. → [[Part A1 - Agent Operating Files#policies.md|policies.md]]
> - **Content strategy** — buzzwords, the "brainrot"/hook style that works in-niche → policies + [[Part A1 - Agent Operating Files#skills.md|skills.md]]
> - **Skills** — reusable how-to for producing a slide carousel, writing a hook, formatting a brief → skills.md (always iterated)
> - **Guardrail** — the rule that an agent must fully load all this context *before* running any task → [[Part A1 - Agent Operating Files#guardrail.md|guardrail.md]]
>
> Without these, the produce agent writes off-brand, banned-word-tripping, low-performing content. The artifacts are the difference between a demo and a system.

## The proxy-metric insight

The analyze agent can't measure *revenue per post*, and it must never be pointed at a lagging outcome like follower count. So it decomposes the driver tree until it reaches **controllable inputs it can actually steer** — **retention rate, hook rate (% past 3s), completion, shares, and saves** — and optimizes those. Followers and reach are the *scoreboard* (humans watch); retention/shares/saves are the *control panel* (the agent steers). Full logic: [[Governing Artifacts#Scoreboard vs control panel (the key to setting agent targets)]].

> Saves remain a *candidate* proxy, not a proven one — they still need validation against downstream click-through (see open items below). The driver-tree decomposition is what makes that test structured instead of a guess.

## Tech stack
Obsidian (knowledge base + tracker state) · multi-agent runtime · scheduler ("Zernio" / GitHub Actions) · TikTok + 3rd-party APIs. A full agentic orchestration. Pattern generalizes — see [[Part A2 - Multi-Agent Orchestration]].

## Human QC cadence

> [!note] Let it run a week before tuning
> Per the [[Part A2 - Multi-Agent Orchestration#Human-in-the-loop cadence|human-in-the-loop cadence]], the human does *mild, periodic QC* — let the 10-account operation run for at least a week before stepping in to optimize. Per-item human involvement is reserved for the **publish safety gate** (banned words / health claims), not performance tuning. Performance changes are batched [[Part A1 - Agent Operating Files#Policy-change cadence|weekly]].

## Open items / to test
- [ ] **Validate the proxy:** does "saves" actually correlate with website click-through? Test before optimizing it (the [[Governing Artifacts#Scoreboard vs control panel (the key to setting agent targets)|control-panel decomposition]] makes this a structured test).
- [ ] **Approval gate location:** the per-item *safety* gate (banned words/claims) needs a physical home — Obsidian checkbox or a Telegram/Slack approve button. (Performance QC is weekly, not per-item — see above.)
- [ ] **State store:** confirm the frontmatter schema + ID convention for idempotent "posted vs not-posted" tracking. See [[Part A2 - Multi-Agent Orchestration#The deeper point: conventions matter more than the store]].
- [ ] **Metrics consolidation:** wire Zernio social data + web tracking into one place so the analyze agent reads a single source. See [[Conversion and Engagement#Current instrumentation stack]].

## Related
- [[Part A2 - Multi-Agent Orchestration]] — the general pattern
- [[Part A1 - Agent Operating Files]] — policies / skills / guardrail in detail
- [[Acquisition Channels#2. Content]] — the channel this serves

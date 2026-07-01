---
title: Critique and Best Practices
type: critique
created: 2026-06-05
updated: 2026-06-05
tags: [critique, best-practices, corrections, analysis]
---

# Critique and Best Practices

> [!summary]
> An honest pass over the model: what's strong, what to adjust, and the best practices that make it production-grade. The core thinking is genuinely good — the corrections below are about *running* it, not rebuilding it.

## What's strong (keep doing this)

- **The three-entity split** is a clean, real value-chain decomposition — now upgraded to the [[Three Entities|Market · Capital · Operation]] triad with Distribution nested under [[Market]].
- **The acquisition → conversion → retention** funnel is textbook-correct and well-populated.
- **Elevating artifacts to "governing"** is sophisticated — you intuitively built the agent context layer before knowing that's what it's called.
- **Proxy-metric thinking** (using "saves" because you can't measure revenue per post) is exactly how good operators instrument content.
- **Sequencing instinct** ("artifacts must be set first for agents to work well") is the single most correct call in the whole braindump.

---

> [!check] Resolved items have moved into the docs
> Two earlier critique points are now settled and folded into the permanent notes:
> - *Three entities → make it a loop* and *Capital expertise (raise / allocate / wield)* → [[Three Entities]] and [[Capital#Capital expertise: raise, allocate, wield]]. The model also upgraded to the [[Market]] · [[Capital]] · [[Operation]] triad.
> - *Instrument conversion before automating* → [[Conversion and Engagement#Current instrumentation stack]] (web + social are solved; metrics consolidation is the remaining gap).
>
> Item numbering below is preserved from the original so existing links keep working — that's why it starts at 2.

## 2. Acquisition channels — sort them by compounding vs rented
The four-channel split (paid/content/virality/social commerce) is good, but the most *decision-relevant* attribute isn't the name — it's whether the channel **compounds** (content, some virality) or must be **rented daily** (paid, social commerce). This determines where to invest automation: compounding channels build an asset, so automating their production pays off forever; rented channels need cost discipline more than scale. Detail: [[Acquisition Channels#Correction: sort channels by]].

## 4. Treat operating files as context engineering
policies.md / skills.md / guardrail.md was the right instinct — now expanded into the full **six-file core set** (adopted): root context (`CLAUDE.md`), policies, skills, guardrail (*ready*), **eval.yaml** (*done* + golden examples), and CHANGELOG (versioning). Key principles: make policies *data not prose*; encode "definition of done" as testable eval cases with reference outputs, not a vague checklist; version every change. Detail: [[Part A1 - Agent Operating Files#The six operating files]].

## 5. Don't reach for an LLM when a script will do
The biggest practical risk in multi-agent systems is **over-agentifying**. News scraping, tracker audits, scheduling, inventory sync are deterministic — plain scripts/cron are cheaper, faster, and far more reliable than LLM calls. Reserve agents for genuinely fuzzy work: angles, copywriting, analysis. Each unnecessary LLM hop adds latency, cost, and a new failure mode. Detail: [[Part B1 - Automation Decision Matrix#Don't over-classify]].

## 6. Crawl, walk, run — don't build the full orchestra first
You correctly saw that artifacts come first. Extend that into a build sequence:
1. **Artifacts** — brand, driver tree, knowledge base, tracking.
2. **One documented manual workflow** — do it by hand, write down every step (this *becomes* skills.md).
3. **Semi-automate with human gates** — agent drafts, you approve.
4. **Full autonomy** only for steps proven boring and safe (BAU).
Building the full daily multi-agent pipeline before steps 1–2 means automating a process you haven't validated.

## 7. Pilot ≠ "don't automate"
The BAU/Pilot binary leaves leverage on the table. Reframe as **autonomy levels (L0–L4)**: Pilot work gets *assisted or approval-gated* automation (agent produces, human approves), not zero automation. Detail: [[Part B2 - BAU vs Pilot Framework#The important correction]].

## 8. Close the loop carefully — don't let agents rewrite their own rules unchecked
"Iterate performance policies" is powerful and dangerous. An agent editing its own policies.md from short-term metrics will **drift** and chase noise. Pattern: agent **proposes** a change with evidence → **human ratifies** → change is logged, and changes are **batched weekly** (immediate only for big/significant ones). Detail: [[Part A1 - Agent Operating Files#Policy-change cadence]].

## 9. Validate the proxy before optimizing it
"Saves" is a smart proxy — but a proxy is only useful if it correlates with the real outcome (website click-through, sales). Before you let an agent optimize for saves, **check that saves actually predict downstream conversion**. Otherwise you'll perfectly optimize a metric that doesn't matter (Goodhart's law). The [[Governing Artifacts#Scoreboard vs control panel (the key to setting agent targets)|scoreboard vs control panel]] split makes this test structured. Detail: [[Part C1 - Case Study - Peptide TikTok Network#Open items / to test]].

---

## The decision log is your highest-leverage artifact

> [!important] This solves the problem that started the whole vault
> The stated pain — *"I'm learning and building at the same time, not documenting it, so I forget what I tested and have to relearn, which wastes time and energy"* — has one clean fix: a **Decision / Experiment Log**. A lab notebook where every test gets a row: **hypothesis · what I did · result · learning · next action · date · tags.**
>
> Why it's the highest-leverage thing here:
> - It converts one-time learning into **compounding knowledge** — you never relearn the same lesson.
> - It feeds **skills.md** (proven procedures) and **policies.md** (proven rules) — your agents inherit your learnings.
> - It's the **memory** the analyze agent should write to, closing the loop safely (human-readable, auditable).
>
> Make it the *first* thing you start, today. Template: [[decision-log.template]]. Don't aim for polish — aim for *never losing a learning again*.

## Related
- [[Risks and Open Questions]] — what could still break
- [[01 - System Overview]] — the corrected mental model

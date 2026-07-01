---
title: "Playbook — Automated Content Engine (Indexa Labs)"
type: playbook
status: practical
created: 2026-06-05
tags: [tactical, practical, market, distribution, automation, content, agent, tiktok, instagram]
---

# Playbook — Automated Content Engine (Indexa Labs)

> [!summary]
> A built-and-running agent system that runs daily, **hands-off** ("brain-dead") content for [[Distribution]] across TikTok and Instagram (handle: `@indexalabs`). Agents build a product/market knowledge base, mine it for content angles, produce the posts, and schedule them — governed by three policy layers and shipped via GitHub Actions ("Zernio"). This is a worked [[Practical Market]] example of the automated posting + creation + audience-education system we'd discussed in principle.

## What it is

An end-to-end content pipeline where agents own the loop from *knowledge → angle → asset → schedule → post*, with the human only setting policy and reviewing. The niche is research compounds / peptides, so the content is **educational** ("what is it, really — a 60-second primer, minus the hype") and must navigate platform censorship.

## Architecture

### 1. Knowledge base (the RAG foundation)
Agents build and maintain a **product + market knowledge base** — a large, interlinked graph of notes (Bases, Behaviors, Compounds, Concepts, Mechanisms, Methods, Papers, Peptides, Resources, Stacks, Supplements, Transcripts, plus a "Knowledge Base — Strategy & Policy" section). Everything is **formatted for RAG retrieval**, not human reading.

### 2. Per-agent account knowledge
Each agent has its own **account knowledge** folder holding:
- **Brand strategy & tone** — how this account speaks.
- **Channel block list** — words that can't be used on that channel (e.g. TikTok keeps deleting the literal compound name, so it's banned from captions and worked around — "just a short chain of amino acids" instead of the censored term).
- Account assets: `posts`, `publish`, `lint`, `lims.txt`, `restricted-terms`, README, etc.

## The daily loop

Runs **every day**, four agent stages:

1. **Update knowledge** — agent scrapes news/sources and updates the knowledge base, *formatting for RAG purposes*.
2. **Plan** — agent mines the knowledge base to produce **content angles**, lays them into a **content calendar**, and writes a **content brief** + updates the tracker.
3. **Produce** — agent follows the calendar and creates the content (copywriting + image), saves the asset to its designated location, and marks the tracker complete.
4. **Audit & schedule** — agent audits the tracker to find posted vs. not-yet-posted content; anything outstanding gets **scheduled** for publishing via **Zernio** (GitHub Actions workflows).

```
scrape/update KB ──► mine KB → angles → calendar + brief ──► produce copy + image ──► audit tracker ──► schedule via Zernio (GitHub Actions) ──► TikTok / Instagram
   (RAG-formatted)        (tracker)                          (assets saved)         (posted vs not)
```

## The three governing policies

Every agent must follow three policy layers (these are the [[Part A1 - Agent Operating Files|operating files]] for this system):

| Policy | Governs | Example |
|---|---|---|
| **Channel policies** | Per-platform rules | TikTok vs Instagram formatting; banned/censored words |
| **Brand policies** | Voice & style | Tone, visual style, education-first framing |
| **Performance policies** | What to prioritize | Lean into content that performs, drop what doesn't |

## Channel-specific adaptation (the clever bit)

Same angle, reshaped per platform and per platform's censorship:
- **TikTok** — the compound's name keeps getting auto-deleted, so posts **censor/euphemize** it ("[CENSORED] … just a SHORT CHAIN of amino acids"). Photo posts use TikTok's own settings: optional photo description (≤4000 chars), "save to TikTok inbox as draft", and **let TikTok auto-add recommended music** (auto song pick). Observation: TikTok's algo rewards this native behaviour.
- **Instagram** — same idea rendered in a cleaner "research notes / primer" carousel format ("What is it, really? A 60-second primer, minus the hype").

## Scheduling & publishing

A **Posts** dashboard manages scheduled vs published content. Outstanding items are scheduled straight through, and publishing fires via **GitHub Actions workflows ("Zernio")** — no manual posting step.

## Why it works (learnings)

- **Knowledge base as the moat.** Because angles are mined from a deep, RAG-formatted KB, content is differentiated and defensible rather than generic.
- **Policy layers make it safe to run hands-off.** Channel + brand + performance policies are the guardrails that let the human step back. See [[Part B1 - Automation Decision Matrix#The approval-gate rule]].
- **Censorship is a content format, not a blocker.** Treating platform word-deletion as a creative constraint (euphemism + "amino acid" framing) turned a problem into a recognisable post style.
- **Native platform behaviour beats fighting it.** Letting TikTok pick the music and using draft-to-inbox leans into the algorithm instead of against it.

> [!note] Status
> Built and running. This is the reference implementation for [[Distribution]] automation — copy its structure (KB → per-agent account knowledge → daily loop → 3 policies → Actions scheduling) for new channels.

## Related
- [[Practical Market]] — parent domain
- [[Distribution]] — the strategy pillar this executes (acquisition → conversion → retention)
- [[Acquisition Channels]] · [[Conversion and Engagement]] — channels this feeds
- [[Part A2 - Multi-Agent Orchestration]] — the agent-pipeline pattern
- [[Part A1 - Agent Operating Files]] — policies / skills / guardrail files
- [[Part C1 - Case Study - Peptide TikTok Network]] — the related worked case study

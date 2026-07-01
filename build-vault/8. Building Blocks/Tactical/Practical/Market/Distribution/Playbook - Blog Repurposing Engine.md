---
title: "Playbook — Blog Repurposing Engine (Naval-bot)"
type: playbook
status: practical
created: 2026-06-05
tags: [tactical, practical, market, distribution, automation, content, agent, repurposing, blog]
---

# Playbook — Blog Repurposing Engine ("Naval Ravikant bot")

> [!summary]
> A built-and-running agent system that takes **finished long-form we already own** (a blog series, articles) and mines it into atomic, postable visual content. Agents read the article → write a brief → make a poster → insert that poster back into the article → post the poster with an excerpt. Mentally it's a **"Naval Ravikant bot"**: turn a deep body of writing into an endless stream of quotable, on-brand micro-content. A [[Practical Market]] / [[Distribution]] tactic that runs daily.

## What it is

Where the [[Playbook - Automated Content Engine|Automated Content Engine]] *creates* content from a knowledge base, this engine **repurposes finished work**. The input is content that's already done and proven; the output is distribution assets (posters + excerpts) plus an enriched original article. Each stage runs as its own scheduled job — observed as daily runs: *Blog viz daily*, *Blog viz poster daily*, *Blog viz insert daily*.

## The pipeline

A finished blog/series is handed to a chain of single-purpose agents:

1. **Analyze / read** — agent is given access to the finished blogs and reads them to extract the postable ideas, quotes, and hooks.
2. **Brief** — agent writes a content **brief** for each extracted idea (the angle + what the visual should say).
3. **Poster** — agent generates a **poster** from that brief (the visual asset).
4. **Insert** — agent **inserts the poster back into the article** — enriching the original long-form with native visuals.
5. **Post** — agent **publishes the poster with an excerpt** drawn from the article, driving back to the source.

```
finished blog/series ─► read & extract ─► brief ─► poster ─► insert poster into article
                                                              └─► post poster + article excerpt ─► social
   (already done)         (Blog viz)      (brief)   (Blog viz   (Blog viz insert)
                                                      poster)
```

## Why this is high-leverage

- **Compounds work you've already paid for.** The expensive part (the writing) is done; this engine extracts near-unlimited distribution from a fixed corpus — the core "Naval-bot" insight: one good essay → hundreds of posts.
- **Two-way value.** It doesn't just spit out social posts; inserting posters back into the article makes the *original* better (more visual, more shareable).
- **Single-purpose agents = clean handoffs.** Each step (read, brief, poster, insert, post) is a small, delegatable interface — easy to debug, swap, or improve in isolation. See [[Part A2 - Multi-Agent Orchestration]].
- **Excerpt-as-hook drives traffic back to the source**, so distribution feeds the owned asset rather than replacing it.

## Relationship to the other engine

| | [[Playbook - Automated Content Engine|Content Engine]] | Blog Repurposing Engine (this) |
|---|---|---|
| Source | Product/market **knowledge base** | **Finished blogs/series** we own |
| Mode | Create net-new angles | Repurpose proven long-form |
| Output | Daily TikTok/IG posts | Posters + enriched articles + excerpt posts |
| Mental model | Research desk | "Naval Ravikant bot" |

Both should share the same three governing policy layers (channel / brand / performance) — see [[Playbook - Automated Content Engine#The three governing policies]].

> [!note] Status
> Built and running (daily jobs: Blog viz / poster / insert). Reference implementation for **repurposing** owned long-form into [[Distribution]] assets.

## Related
- [[Practical Market]] — parent domain
- [[Playbook - Automated Content Engine]] — the sibling create-from-scratch engine
- [[Distribution]] — the strategy pillar this executes
- [[Conversion and Engagement]] — where the enriched articles and excerpt posts land
- [[Part A2 - Multi-Agent Orchestration]] — the single-purpose agent-chain pattern

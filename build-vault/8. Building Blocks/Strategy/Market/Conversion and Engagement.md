---
title: Conversion and Engagement
type: framework
created: 2026-06-05
tags: [strategy, distribution, conversion, engagement, website, social]
---

# Conversion and Engagement

> [!summary]
> The phase where acquired attention lands and is captured. Two surfaces do the work: the **website** and **social media**. The original model calls this "conversion or engagement" — worth separating the two, because they're different jobs.

## The hinge

Every [[Acquisition Channels|acquisition channel]] ends the same way: the person either **searches for you** or **follows you**. This note is about what happens at that moment and just after.

> [!note] Conversion ≠ Engagement
> - **Conversion** = turning attention into a *measurable action now* (lead, email, sale).
> - **Engagement** = *nurturing* attention over time so it converts later.
> They use the same two surfaces but optimize for different things. Keeping them separate stops you from judging a brand-awareness post by sales metrics, or a sales page by follower count.

## Website

The conversion workhorse. Once it has enough traffic and domain authority, it becomes a testing surface:
- **A/B testing** — only meaningful with enough traffic; don't test prematurely.
- **Email flows** — capture then nurture (the bridge into [[Retention#Customer database]]).
- **Popups** — capture mechanism; use sparingly.
- Powered by the inventory/price sync from [[Operation#The bridge into Distribution]].

> [!tip] Instrument before you optimize
> A/B tests, email attribution, and channel ROI all require **one source of truth for tracking** (consistent UTMs + analytics) set up *first*. This is an artifact-layer prerequisite — see [[Governing Artifacts]].

### Current instrumentation stack 🟢

| Surface | How it's tracked | Status |
|---|---|---|
| **Website** | SOP: **Stape (server-side GTM) + GA4 MCP** — one-shot builds a complete website tracking mechanism | 🟢 solved |
| **Social media** | **Zernio webhook** fetches social performance data | 🟢 solved |
| **Consolidation** | Pulling website + social into *one place* — the unsolved gap | 🔴 open |

> [!warning] The real instrumentation problem is consolidation, not collection
> Per-surface collection is handled (Stape+GA4 for web, Zernio webhook for social). The remaining problem is **consolidating these signals into one source of truth** — a metrics-aggregation layer along the lines of [doubleloop.app](https://doubleloop.app/). Until that exists, the [[Part A2 - Multi-Agent Orchestration|analyze agent]]'s driver tree is reading from two disconnected places. **This consolidation layer is the next instrumentation artifact to build.** Tracked in [[Risks and Open Questions#Single source of truth drift]].

## Social media

The engagement workhorse. Its job is to **maintain presence and trust**: regular posting, brand updates, announcements, issue responses.

> [!note] Same platform, different objective
> A subtle but important point from the original model: on one platform you may run **two objectives at once**. Example — Instagram: *Reels* do **acquisition** (reach new people via content), while *feed posts/stories* do **engagement** (maintain the brand for existing followers). Don't conflate their metrics.

- **Link in bio** is critical — it's the literal bridge from "follow" to "convert." Treat it as a mini-conversion page, not an afterthought.

## What this phase produces
| Output | Flows to |
|---|---|
| Captured email / lead | [[Retention#Customer database]] |
| First purchase | [[Capital]] (revenue), [[Retention]] (cohort) |
| Follower / subscriber | [[Retention#Community]] |

## Automation notes
- **Social posting & scheduling:** strong BAU automation (see [[Part C1 - Case Study - Peptide TikTok Network]]).
- **A/B test execution & email flows:** semi-automatable; the *decision* to change a page is Pilot-ish.
- **Brand issue / announcement responses:** keep human or human-approved — reputation risk.

## Related
- [[Acquisition Channels]] (before) · [[Retention]] (after)
- [[Operation]] — feeds website inventory
- [[Governing Artifacts]] — tracking + brand context

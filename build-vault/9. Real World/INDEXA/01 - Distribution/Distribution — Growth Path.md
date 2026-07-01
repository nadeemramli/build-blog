---
title: "Distribution — Growth Path"
type: pillar
date: 2026-06-01
tags: [indexa, distribution, growth]
---

# 🟣 Distribution — Growth Path

**Why this note exists:** [[Distribution — Strategy]] describes the *funnel* (content → lead → order). This note describes the **growth engine** — the specific ways we add volume on top of that funnel. Today our real engine isn't the website; it's **people who resell for us**. The plan is to grow three engines in parallel, each owning a different market.

> Guardrail unchanged: every path stays in **research-use** framing. No dosing or medical claims, by anyone selling under our name — agents included. This is what keeps the brand alive.

## Where we are today (honest baseline)

Our volume comes from a small reseller/agent network, not from inbound:

| Seller | Role | Status | Read |
| --- | --- | --- | --- |
| **Muz** | Dropshipper | Main seller | Our single biggest dependency. If Muz stalls, revenue stalls. Concentration risk. |
| **Haikhal** | Reseller | Active, growing | Proven the model works with more than one person. Worth investing in. |
| **Kio** | Reseller | Shaky / not growing | Either under-supported, mismatched, or low-effort. Diagnose before writing off. |

The strategic problem this creates: **one person (Muz) is the business.** Every path below exists to widen that base so growth doesn't depend on any single seller.

## The three growth paths (run in parallel, different markets)

These are deliberately *different audiences* so they don't cannibalise each other.

### Path 1 — Community & Agents *(people-led distribution)*
**Market:** existing buyer circles, gym/biohacker communities, word-of-mouth networks.
**Engine:** recruit and support more sellers like Muz/Haikhal, plus seed closed communities (WhatsApp/Telegram groups) where a trusted voice does the selling.
**Why it grows:** highest-trust, fastest-converting channel we already have. The model is proven — it just needs more nodes and less single-person risk.
**First moves:**
- Diagnose Kio: is it support, supply reliability, margin, or fit? Fix or replace.
- Define a repeatable **agent offer** (margin/commission, what we supply, what they own) so onboarding a 4th, 5th agent is a copy-paste, not a one-off deal. *(Detailed program design is a separate doc — flagged below.)*
- Stand up / formalise a Telegram community (@indexalabs already exists) as the warm pool agents and we both sell into.

### Path 2 — Threads *(knowledge-led, research-minded market)*
**Market:** the more educated, research-minded buyer who wants to understand before they buy — a *different* segment from TikTok's broad reach.
**Engine:** knowledge sharing — COA literacy, reconstitution/storage, how to read purity reports, the science framing. Authority builds trust; trust converts research buyers.
**Why it grows:** plays directly to our strongest trust asset (third-party COAs / Verify) and reaches buyers who'd never convert on a hype video.
**First moves:**
- Repurpose the **Education** and **Social proof** content pillars into long-form Threads.
- One owner, consistent cadence, CTA → Verify/COA page, then WhatsApp to close.

### Path 3 — TikTok *(content/video-led, broad market)*
**Market:** broad top-of-funnel — discovery audience that skews younger / impulse, distinct from Threads.
**Engine:** short video — bundle spotlights, transparency/COA reveals, goal-based stacks. Already named our top-of-funnel engine in the strategy doc; this path is about *committing resourcing* to it rather than treating it as one of many channels.
**Why it grows:** widest reach, lowest cost per impression, feeds both the website and the agents with warm demand.
**First moves:**
- Lock a weekly video cadence (planned 7 days ahead, all `scheduled`).
- Hand qualified DMs to WhatsApp close — or route to an agent in their region.

## Brand-improvement pipeline *(enabler, not a path)*

Better packaging, branding, and labelling sits *underneath* all three paths — it raises conversion and lets agents sell at confidence/price. Treat as a parallel workstream feeding every channel:

- **Packaging** — unboxing that signals research-grade quality (protects margin, drives social proof).
- **Labelling** — compliant, COA-linked, Verify-enabled, research-use framing on every label.
- **Branding** — consistent identity across agent material, Threads, and TikTok so all three paths look like one brand.

## Owners & rhythm

Parallel only works with clear single owners — one named person per path, or it defaults back to Muz-dependency by another name.

| Path | Owner | Cadence | Primary metric |
| --- | --- | --- | --- |
| Community & Agents | _TBD_ | Weekly check-in per active agent | # active agents · revenue per agent |
| Threads | _TBD_ | 3–5 posts/week | Followers → leads → won |
| TikTok | _TBD_ | Weekly video batch, 7 days ahead | Reach → DM leads → won |
| Brand pipeline | _TBD_ | Per release | Packaging/label shipped |

Keep the existing weekly rhythm from [[Distribution — Strategy]]: one promo live, ROAS reviewed, every inbound lead qualified within 24h.

## Tracking gap to close

Our [[Data Model & Conventions]] has no **agent / seller** dimension yet — so right now we can't measure "revenue per agent" or tell a Muz order from a Haikhal order in the Bases. Recommended fix:

- Add an optional `agent:` field (and an `agent` source value) to the **Sales Order** and **Lead** schemas.
- Then [[Sales Orders.base|Sales Orders]] and [[Leads.base|Leads]] can group by agent, and we can see concentration risk and per-agent growth at a glance.

This is the single highest-leverage instrumentation change — without it, Path 1 is unmeasurable.

## Next deliverable (flagged)

A dedicated **Agent / Reseller Program** sub-doc + SOP: tiers, margin/commission split, what we supply vs. what they own, onboarding checklist, and how to diagnose a shaky agent (the Kio playbook). Say the word and I'll draft it.

## Related

- [[Distribution — Strategy]] — the funnel this growth path sits on top of
- [[SOP — Content Publishing]] · [[SOP — Lead to Sale]] · [[SOP — Campaign Launch]]
- [[Content Calendar.base|Content Calendar]] · [[Leads.base|Leads]] · [[Sales Orders.base|Sales Orders]] · [[Campaigns.base|Campaigns]]

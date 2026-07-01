---
title: "Workflow — Content Production Pipeline"
type: workflow
date: 2026-06-03
tags: [indexa, distribution, workflow, content]
---

# Workflow — Content Production Pipeline

The end-to-end system that turns an idea into a published, lead-generating post. This is the operating layer above [[SOP — Content Publishing]] (what to make) and [[SOP — Zernio Publishing]] (how to ship it). It exists because distribution is a core part of the business and should run the same way every week, by anyone (or any agent).

## The pipeline at a glance

```
IDEA → BRIEF → DESIGN → COPY → ASSEMBLE → REVIEW → SCHEDULE → PUBLISH → MEASURE → HAND-OFF
 │       │       │        │        │          │         │          │          │          │
pillar  POST    _assets  caption  posts.json guardrail Zernio    live link  analytics  #lead
```

Each post moves through one status at a time: `idea → drafting → scheduled → published` (the same field used by the [[Content Calendar.base|Content Calendar]]).

## Stage by stage

**1. Idea.** Pull an angle from a content pillar (Education · Product · Social-proof · Promo · Research/Literature). Sources: the [[Article Backlog]], COA results, new arrivals, competitor gaps, a question a lead asked twice. Hold the **2:1:1** ratio (education-or-proof : product : promo) across the week.

**2. Brief → note.** Copy `Content/_Template — Content Post.md` → `POST-YYYYMMDD-NNN`. Set `channel`, `format`, `pillar`, `publish_date`, `hook`. Decide the **track** (see below). One note = one post = one row on the calendar.

**3. Design.** Produce the visual to the right track's style guide. Editable source + exported PNG go in `Content/_assets/`, named `POST-…-<n>.png`. Specs: IG 1080×1350, TikTok 1080×1920. (Renders are built from SVG → PNG; sources kept so anyone can re-edit.)

**4. Copy.** Write the on-image text, the caption, and hashtags into the note. Caption carries the hook in the first line (the only part that shows before "more").

**5. Assemble.** Add the post to `Automation/Zernio/posts.json` — caption, `scheduledFor`, target accounts, media paths in order.

**6. Review (guardrail gate).** Tick the note's guardrail box: research-use framing only, no dosing/medical claims, disclaimer present. This gate is mandatory and is where most rewrites happen.

**7. Schedule.** Run the Zernio toolkit: `--dry-run` → drafts → review in dashboard → `--mode=schedule`. Status → `scheduled`.

**8. Publish.** Zernio fires at the slot. Status → `published`; paste the live `link` into the note.

**9. Measure.** After ~72h, log reach/saves/profile-clicks. Kill formats that underperform; double down on what saves. Feeds the next week's ideas.

**10. Hand-off.** DMs and intent comments → `#lead` notes → [[SOP — Lead to Sale]] → WhatsApp close. This is the point of the whole pipeline: content is top-of-funnel, WhatsApp is the close.

## The two creative tracks

We run two deliberately different looks so the brand shows range without losing identity. Same guardrails, same disclaimer, opposite energy.

| | **TikTok — "Braindead Poster"** | **Instagram — "Beautiful"** |
| --- | --- | --- |
| Goal | stop the scroll, get saved/sent | build authority + trust |
| Feel | loud, ugly-on-purpose, meme | premium, clinical, editorial |
| Format | single 1080×1920 poster (or 5–9s clip) | 1080×1350 carousel (3–5 slides) |
| Build time | minutes | ~30–45 min |
| Style guide | [[Style Guide — TikTok Braindead Poster]] | [[Style Guide — Instagram Beautiful]] |
| Reference posts | [[POST-20260603-002]] | [[POST-20260603-001]] |

A single idea (e.g. "what is a peptide") should usually be produced **for both tracks** — braindead for reach, beautiful for the save/authority — as a paired set.

## Roles (RACI-lite)
- **Producer** (you / agent): ideas, briefs, copy, assembling `posts.json`. **R**
- **Designer** (you / agent / Canva): the art to spec. **R**
- **Approver** (you): guardrail gate + dashboard review before publish. **A**
- **Closer** (you / WhatsApp): turns inbound into orders. **R**

## Weekly rhythm
Mon: plan + brief the week (idea → notes). Tue–Wed: design + copy both tracks, batch. Thu: assemble `posts.json`, dry-run, drafts, review, schedule 7 days out. Fri: keep one promo live; reply to/qualify every lead within 24h. Ongoing: comment hygiene on TikTok; log analytics for last week's posts.

## Cadence target (starting point)
≥ 1 TikTok/day (cheap, high-variance — volume wins) and 3–4 IG carousels/week. Adjust once analytics exist. Right now TikTok/Threads/website contribution is RM0 — the entire point of this pipeline is to change that without breaking the research-use guardrail.

## Related
[[SOP — Content Publishing]] · [[SOP — Zernio Publishing]] · [[SOP — Campaign Launch]] · [[SOP — Lead to Sale]] · [[Distribution — Strategy]] · [[Content Calendar.base|Content Calendar]]

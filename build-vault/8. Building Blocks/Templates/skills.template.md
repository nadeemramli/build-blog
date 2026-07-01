---
title: skills.md — Template
type: template
created: 2026-06-05
tags: [template, agent, skills, procedures]
---

# skills.md — Template

> [!summary]
> Reusable how-to procedures the agent can invoke. Each skill is a named, step-by-step recipe that has been *proven to work* (promoted from the [[decision-log.template|decision log]]). Always iterated. See [[Part A1 - Agent Operating Files#skills.md]].

```markdown
# Skills — <agent name>
version: 0.1
last_updated: 2026-06-05

## Skill: produce_slide_carousel
when_to_use: turning a content brief into a TikTok slide carousel
inputs: content_brief, brand_assets
steps:
  1. Read brief + load policies.md limits
  2. Draft hook slide (style per policies.hook_style)
  3. 1 idea per slide, slide_count within policies range
  4. Add source citation slide + disclaimer
  5. Apply brand design system
  6. Save to /content/<account>/<date>/ and update tracker
output: carousel files + tracker row (status: produced)
proven_by: [[Decisions 2026-06#... ]]   # link the evidence

## Skill: write_hook
when_to_use: first line / first slide
steps: ...
proven_by: ...

## Skill: format_for_RAG
when_to_use: adding a source to the knowledge base
steps:
  1. One atomic note per concept
  2. Frontmatter: type, tags, source, date
  3. Clear headings, short chunks
  4. Tag evergreen vs transient
```

> [!tip] Promotion rule
> A procedure only earns a place in skills.md once a [[decision-log.template|decision-log]] entry shows it worked. Link the evidence with `proven_by`. This keeps skills.md trustworthy instead of aspirational.

Related: [[policies.template]] · [[guardrail.template]] · [[Part A1 - Agent Operating Files]]

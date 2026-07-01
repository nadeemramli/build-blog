---
title: policies.md — Template
type: template
created: 2026-06-05
tags: [template, agent, policies, guardrails]
---

# policies.md — Template

> [!summary]
> Hard constraints an agent must obey. Written as **checkable data, not prose**, so the agent can validate its output against it. One policies file per channel/agent, or a shared base + channel overrides. See [[Part A1 - Agent Operating Files#policies.md]].

```markdown
# Policies — <channel/agent name>
version: 0.1
last_updated: 2026-06-05
owner: <you>

## Hard limits (platform)
title_max_chars: 100
description_max_chars: 2200
hashtags_max: 5
slide_count_range: [6, 10]

## Banned words / claims  (agent must reject output containing these)
banned_words:
  - cure
  - guaranteed
  - <add health-claim words — critical for peptides>
banned_claims:
  - any medical/treatment claim
  - any dosage instruction

## Required
must_include:
  - link-in-bio CTA
  - source citation for any factual claim
disclaimer_required: true   # e.g. "educational purposes only"

## Voice / strategy
approved_buzzwords: [ ... ]
hook_style: "<brainrot/curiosity-gap style notes>"
tone: "<from brand guideline>"
reading_level: simple

## Validation checklist (definition of done)
- [ ] title ≤ title_max_chars
- [ ] no banned_words / banned_claims present
- [ ] disclaimer included
- [ ] on-brand voice
- [ ] saved to correct path + tracker updated
```

> [!tip] Keep it machine-checkable
> Numbers as numbers, banned items as a list, rules as a checklist. The [[agent-spec.template|agent]] should *run* this checklist before marking a task done — not just read it.

Related: [[skills.template]] · [[guardrail.template]] · [[Part A1 - Agent Operating Files]]

---
title: Content Brief — Template
type: template
created: 2026-06-05
tags: [template, content, brief, distribution]
---

# Content Brief — Template

> [!summary]
> The handoff artifact from the **ideate** step to the **produce** step in the [[Part A2 - Multi-Agent Orchestration|pipeline]]. A good brief is what lets the produce agent (or a human) create on-brand content without re-thinking strategy.

```markdown
# Brief — <date> — <account/channel>
status: idea | briefed | produced | scheduled | posted | measured
account: <which niche account>
channel: tiktok
scheduled_date: YYYY-MM-DD

## Angle
hook_idea: "<the opening line / curiosity gap>"
topic: <from knowledge base — link the source note>
why_now: <trend / news hook if any>

## Objective
primary_proxy_metric: saves        # from driver tree
secondary: follows, profile_clicks
cta: "link in bio → <page>"

## Constraints (inherited from policies.md)
slide_count: 6-10
banned: <reminder of key banned words/claims>
disclaimer: required

## Source / evidence
knowledge_note: [[...]]
must_cite: yes

## Output target
save_to: /content/<account>/<date>/
tracker_row: <id>
```

> [!tip] One brief = one tracker row
> The brief's `status` field *is* the shared-state record that moves through the pipeline. Keep it structured so the publish/audit agent can read it. See [[Part A2 - Multi-Agent Orchestration#Shared state is the backbone]].

Related: [[agent-spec.template]] · [[Part C1 - Case Study - Peptide TikTok Network]]

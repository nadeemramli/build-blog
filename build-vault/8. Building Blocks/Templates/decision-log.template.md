---
title: Decision / Experiment Log — Entry Template
type: template
created: 2026-06-05
tags: [template, decision-log, experiment, memory]
---

# Decision / Experiment Log — Entry Template

> [!summary]
> The lab notebook that stops you relearning what you already tested. One entry per test or decision. Keep it fast — a half-filled entry beats a forgotten lesson. See why this matters: [[Critique and Best Practices#The decision log is your highest-leverage artifact]].

## How to use
- Copy the block below for each test/decision.
- Keep entries in one note per month (e.g. `Decisions 2026-06.md`) or one note each — whatever you'll actually maintain.
- Tag so agents and Dataview can find them. Feed proven learnings into [[skills.template|skills.md]] / [[policies.template|policies.md]].

---

## Entry block (copy this)

```markdown
### [YYYY-MM-DD] <short title>
- **Area:** Capital / Operation / Distribution / Agent system
- **Status:** 🟢 working · 🟡 piloting · 🔴 idea · ⚫ deprecated
- **Hypothesis:** what I expected to be true
- **What I did:** the actual test / change
- **Result:** what happened (numbers if any)
- **Learning:** the durable takeaway
- **Next action:** what this implies I should do
- **Feeds:** skills.md? policies.md? knowledge base? (where the learning goes)
- **Tags:** #channel/tiktok #metric/saves ...
```

## Worked example

```markdown
### [2026-06-04] 10 niche TikTok accounts vs 1 brand account
- **Area:** Distribution
- **Status:** 🟡 piloting
- **Hypothesis:** niche knowledge accounts funnel to site better than a brand account
- **What I did:** spun up 3 of 10 planned niche accounts, slide content, link in bio → site
- **Result:** [fill in: reach, saves, site clicks]
- **Learning:** [fill in]
- **Next action:** validate saves → click-through before scaling to 10
- **Feeds:** skills.md (slide format), policies.md (hook style)
- **Tags:** #channel/tiktok #peptide #metric/saves
```

## Dataview roll-up (optional, if you use Dataview)

````markdown
```dataview
TABLE status, Area, Learning
FROM #decision-log
SORT file.day DESC
```
````

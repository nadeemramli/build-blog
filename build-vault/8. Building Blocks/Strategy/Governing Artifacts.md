---
title: Governing Artifacts
type: framework
created: 2026-06-05
tags: [strategy, artifacts, context-layer, brand, intel, driver-tree, rag]
---

# Governing Artifacts

> [!summary]
> The artifacts that govern all the moving parts. In a human org these are "the playbooks"; in an agentic system they are the **context layer** — the ground truth agents read before acting. Weak artifacts = weak agents. This is the layer that must be built *first*.

## The four artifacts in the original model

### 1. Brand guideline + brand identity + design system
Voice, tone, visual rules, components. Governs everything customer-facing.
- For agents: becomes the brand voice/policy context for any content task. See [[Part A1 - Agent Operating Files#policies.md]].

### 2. Raw footage + product mockups (+ asset library)
The reusable creative inventory — clips, photos, mockups, B-roll.
- For agents: the asset pool a content agent draws from instead of generating from nothing.

### 3. Market & competitor intel / knowledge
What the market wants, what competitors do, positioning, objections.
- For agents: this is the **RAG knowledge base**. Format it for retrieval (atomic notes, consistent frontmatter, dated). See [[Part A2 - Multi-Agent Orchestration#Knowledge base as RAG]].

### 4. Driver tree / value architecture
Decomposing **revenue → actionable, controllable levers → KPIs** for each moving part. The measurement spine of the whole system.
- For agents: defines *what to optimize* and *which proxy metric to read*. Without it, automation has no objective.

```
                         Revenue
            ┌───────────────┼───────────────┐
        Traffic        Conversion %        AOV
        ┌──┴──┐          ┌──┴──┐          ┌─┴─┐
     reach  freq    page  offer       price  bundle
       │                                  (controllable levers)
       ▼
   leading proxy (e.g. content "saves") ──► what an agent can actually move
```

> The art is decomposing far enough that each leaf is **controllable** and has a **measurable leading proxy**. For content, you often can't measure revenue per post, but you *can* measure saves/follows as a proxy that correlates with downstream conversion.

#### Scoreboard vs control panel (the key to setting agent targets)

> [!important] An agent must optimize *inputs*, never lagging outcomes
> Social isn't performance marketing — you can't set "gain 10k followers" as an agent target and have it act on that directly. The fix is the driver-tree discipline itself: decompose the lagging outcome down to controllable inputs, and let the agent act **only on the inputs**.
>
> ```
> Follower growth        (lagging — you influence, can't control)
>   └─ Reach / impressions served by algo   (lagging)
>        └─ Retention + share rate + engagement velocity   (leading — controllable via craft)
>             └─ Hook quality, format, topic fit, length, post time   (inputs — agent acts HERE)
> ```
>
> So the agent never optimizes for follower count. It optimizes for **retention rate, hook rate (% past 3s), completion, shares, and saves** — because on discovery surfaces those are the inputs the algorithm converts into reach, and reach is what converts into followers.
>
> - **Scoreboard** = lagging outcomes you *watch* (followers, reach, revenue).
> - **Control panel** = leading inputs the agent *steers* (retention, shares, hook rate, saves).
>
> Build a **driver tree specific to each business model** so the scoreboard→control-panel split is explicit. This is what turns "is saves a good proxy?" from a guess into a structured, testable decomposition. The analyze agent reads the control panel; humans watch the scoreboard. Applied in [[Part C1 - Case Study - Peptide TikTok Network#The proxy-metric insight]].

## The artifact the model is missing

> [!tip] Add a fifth: the Decision / Experiment Log
> The reason this whole vault exists — *"I forgot what I tested and have to relearn"* — is solved by a **lab notebook**: every hypothesis, test, result, and learning, dated and tagged. It is the artifact that turns "learning while building" into compounding knowledge instead of repeated rediscovery. Template: [[decision-log.template]]. Argument: [[Critique and Best Practices#The decision log is your highest-leverage artifact]].

## Why artifacts come first (sequencing)

> [!important] Build the context layer before the agents
> The original realization is correct and worth stating as a rule: **agents perform far better when the artifacts are set up first.** They give the agent more context, more precision, and a better shot at a good output. Building the multi-agent pipeline before the artifacts exist means building agents that hallucinate your brand and guess your strategy.
>
> Recommended order: brand + driver tree + knowledge base → one documented manual workflow → semi-automation with human gates → full automation of proven BAU. See [[Critique and Best Practices#6. Crawl, walk, run — don't build the full orchestra first]].

## Artifact → agent mapping (quick reference)

| Artifact | Becomes (in agent terms) |
|---|---|
| Brand guideline | `policies.md` brand/voice rules |
| Asset library | The media pool an agent pulls from |
| Market/competitor intel | RAG knowledge base |
| Driver tree | The objective + proxy metrics an agent optimizes |
| Decision log | Memory of what's been tried (anti-repeat) |

## Related
- [[Part A1 - Agent Operating Files]] — how artifacts become agent context
- [[Part A2 - Multi-Agent Orchestration]] — how agents consume them
- [[Three Entities]] — artifacts sit beneath all three

---
title: Agent Operating Files
type: architecture
created: 2026-06-05
tags: [automation, agentic, context-engineering, policies, skills, guardrails]
---

# Agent Operating Files

> [!summary]
> The files that give an agent its context and constraints. The full core set is **six files**: **CLAUDE.md** (root context), **policies.md** (rules), **skills.md** (how-to), **guardrail.md** (definition of *ready*), **eval.yaml** (definition of *done* + golden examples), and **CHANGELOG.md** (versioning). This is "context engineering": the agent is only as good as these files.

## The six operating files

### 1. CLAUDE.md / AGENTS.md — root context
**The single entry point the agent always reads first.** States the mission, the business context, where state lives, and points to all the other files. Without it you re-write the same context into every agent. One root file per agent (or one shared root + per-agent overrides).
- Contains: mission, business context (this vault), state/tracker location, links to the other five files, the autonomy level.

### 2. policies.md — the rules
**The hard limits the agent must obey.** Not suggestions.
- Platform limits: TikTok title length, photo/description length, **banned words**.
- Content strategy rules: approved buzzwords, the hook/"brainrot" style, tone.
- Brand rules: drawn from the [[Governing Artifacts#1. Brand guideline + brand identity + design system|brand guideline]].
- Conventions: naming, foldering, frontmatter schema (see [[Part A2 - Multi-Agent Orchestration#The deeper point: conventions matter more than the store]]).

> [!tip] Make policies *data*, not prose
> Agents skim long prose and ignore rules buried in paragraphs. Write policies as **structured, checkable lists** (max lengths as numbers, banned words as an array, a yes/no checklist). The agent should be able to *validate* its output against them, not just "read" them.

### 3. skills.md — the how-to
**Reusable procedures** — the agent's capabilities. "How to build a slide carousel," "how to write a hook," "how to format a content brief." Always iterated: when something works, the learning goes back into skills.md.
- Mirrors how reusable skills work generally — a named procedure the agent can invoke.

### 4. guardrail.md — definition of *ready*
**The meta-rule: never run a task without fully loading all the context first.** The pre-flight checklist that forces the agent to load CLAUDE.md, policies, skills, eval references, brand, and relevant knowledge *before* acting, plus the hard stops (banned claims, money movement → human gate).

### 5. eval.yaml — definition of *done* (with golden examples)
**The testable definition of a good output.** guardrail.md handles *ready*; eval.yaml handles *done*. Rather than a vague prose checklist, it encodes done as **cases**: a scenario, a **reference / golden example** of an ideal output, and **assertions** the output must pass. It does double duty:

- **At generation time** — the golden examples are few-shot references the produce agent imitates ("good looks like *this*").
- **At validation time** — the agent self-checks its output against the assertions before marking the task done.
- **At change time** — it's a regression suite: re-run the evals whenever you edit policies.md or skills.md to confirm you didn't make quality worse.

```yaml
# eval.yaml — <agent name>
version: 0.1
task: produce_slide_carousel

assertions:                    # hard, machine-checkable (mirror policies.md)
  - title_len <= 100
  - no_banned_words
  - has_disclaimer
  - slide_count between 6 and 10
  - saved_path matches /content/<account>/<date>/

rubric:                        # qualitative score (1-5), human or LLM-judge
  hook_strength: "first slide creates a curiosity gap in <1 line"
  on_brand_voice: "matches brand guideline tone"
  one_idea_per_slide: true

cases:
  - id: glp1_education_carousel
    input: "brief: GLP-1 basics for beginners"
    golden_example: ./golden/glp1_education_carousel.md   # the reference 'good' output
    must_pass: [title_len, no_banned_words, has_disclaimer]
    min_rubric_score: 4
```

> [!tip] Where golden examples come from
> Promote your *best actual outputs* into `./golden/` as references — the same way a proven procedure graduates into skills.md. Wins logged in the [[decision-log.template|decision log]] are the candidates. Over time eval.yaml becomes the codified taste of the operation.

### 6. CHANGELOG.md — versioning
**A dated log of what changed in these files and why.** Since policies.md, skills.md, and eval.yaml are "always iterated," version them so changes are auditable and reversible — this prevents silent drift and is itself a [[decision-log.template|decision log]] for the agent system. Governed by the [[#Policy-change cadence|weekly cadence]] below.

## Policy-change cadence

> [!important] Batch policy edits weekly — don't tinker continuously
> An agent (or human) that edits policies.md continuously from short-term performance will **drift** and chase noise. The rule:
> - **One batched policy change per week.** Accumulate small edits and apply them as a single, considered lump-sum change on a weekly rhythm.
> - **Exception for big/significant changes.** If a change is directionally large or high-impact (a strategy pivot, a compliance fix), make it immediately — don't wait for the weekly slot.
> - **Small/cosmetic edits always wait** for the weekly batch.
>
> This is the operating-file expression of the same discipline as the [[Part A2 - Multi-Agent Orchestration#Human-in-the-loop cadence|≥1-week QC delay]]: observe a full week → change once → observe again. It keeps the agent stable enough to actually learn, and gives every change a clean before/after window to judge. Pair it with the safe pattern: **agent proposes a change with evidence → human ratifies → change is logged** (never autonomous editing of its own rules).

## How the files map to the artifacts

| Operating file   | Built from artifact                                                       |                                                  |
| ---------------- | ------------------------------------------------------------------------- | ------------------------------------------------ |
| CLAUDE.md (root) | Mission + business context (this vault, [[Three Entities]])               |                                                  |
| policies.md      | [[Governing Artifacts#1. Brand guideline + brand identity + design system | Brand guideline]] + platform rules + conventions |
| skills.md        | Accumulated learnings + [[decision-log.template                           | decision log]]                                   |
| guardrail.md     | The discipline layer — points at all files                                |                                                  |
| eval.yaml        | Definition of done + golden examples (promoted from decision-log wins)    |                                                  |
| CHANGELOG.md     | Version history of all the above                                          |                                                  |
| knowledge base   | [[Governing Artifacts#3. Market & competitor intel / knowledge            | Market/competitor intel]] (RAG)                  |
| objective/proxy  | [[Governing Artifacts#4. Driver tree / value architecture                 | Driver tree]]                                    |

## Loading order (what guardrail.md should enforce)

```
1. CLAUDE.md (root context)        → mission, business context, where state lives
2. guardrail.md                    → confirm pre-flight checklist (definition of ready)
3. policies.md                     → load hard constraints
4. skills.md                       → load relevant procedures
5. eval.yaml                       → load golden examples + done criteria
6. knowledge base (RAG retrieve)   → pull task-relevant facts
7. driver tree                     → load objective + proxy metric
   ─────────────────────────────────
8. THEN act on the task (imitating golden examples)
9. Validate output vs eval.yaml    → assertions + rubric (definition of done)
10. Log the run (audit + decision log); if files changed, update CHANGELOG.md
```

## Templates
Copy-ready starting points:
- [[claude.template]] — root context (CLAUDE.md / AGENTS.md)
- [[policies.template]]
- [[skills.template]]
- [[guardrail.template]]
- [[eval.template]] — eval.yaml (definition of done + golden examples)
- [[changelog.template]] — CHANGELOG.md (versioning)
- [[agent-spec.template]] — one spec per agent (job, I/O, autonomy level, files it loads)

## Related
- [[Part A2 - Multi-Agent Orchestration]] — how loaded agents run together
- [[Governing Artifacts]] — the source material for these files
- [[Critique and Best Practices#4. Treat operating files as context engineering]]

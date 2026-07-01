---
title: BAU vs Pilot Framework
type: framework
created: 2026-06-05
tags: [automation, agentic, decision, bau, pilot]
---

# BAU vs Pilot Framework

> [!summary]
> Before deciding what to automate, classify each task as **Pilot** (strategically critical to the business model) or **BAU** (business-as-usual; routine, repeatable). The classification tells you *how much human oversight* a task needs — not simply whether to automate it.

## The two categories

- **Pilot** — work that is *core to the business model's success*. For a course business: the personal brand and the content about the course. Getting it wrong hurts the moat. High stakes, often higher creativity/judgment.
- **BAU** — work that *keeps the lights on*. Welcoming a new community member, syncing inventory, posting a scheduled clip. Routine, repeatable, low individual stakes.

## The original examples (kept verbatim in spirit)

| Task | Classification | Why |
|---|---|---|
| Course business: personal brand + making content about the course | **Pilot** | It *is* the differentiator for that model |
| Updating/welcoming a user entering the community | **BAU** | Routine, repeatable, low stakes |
| Peptide brand: growing directly on TikTok | Hard / poor channel fit | → restructure into 10 niche knowledge accounts (see [[Part C1 - Case Study - Peptide TikTok Network]]) |

## The important correction

> [!warning] Pilot does NOT mean "don't automate"
> The intuitive read — *Pilot = keep human, BAU = automate* — is too blunt and will leave huge leverage on the table. The better rule:
> - **BAU → automate fully autonomously.** Let agents run end to end.
> - **Pilot → automate the *production*, gate the *publication*.** Agents draft, research, and prepare; a human approves before it ships.
>
> Concretely: even "Pilot" course content can be 80% agent-produced (angles, drafts, edits, scheduling) with a human approval gate before publish. You keep the judgment where it matters and still get the speed. This converts the binary into a spectrum of **autonomy levels**. Detailed in [[Part B1 - Automation Decision Matrix]].

## Reframed as autonomy levels

| Level | Human involvement | Fits |
|---|---|---|
| L0 — Manual | Human does it | New/unproven, highest stakes |
| L1 — Assisted | Agent drafts, human edits & ships | Pilot, creative |
| L2 — Approval-gated | Agent does it all, human clicks approve | Pilot, repeatable |
| L3 — Autonomous | Agent runs end to end, logs for audit | BAU |
| L4 — Self-optimizing | Agent also proposes policy changes (human ratifies) | Mature BAU only |

## Worked examples

- **Community welcome message** → BAU → **L3 autonomous**.
- **Community relationship/answering** → Pilot-ish → **L1 assisted** (keep humans; see [[Retention#Don't over-automate community]]).
- **TikTok niche content production** → repeatable but brand-shaping → **L2 approval-gated** (the whole [[Part C1 - Case Study - Peptide TikTok Network]] pipeline ends in an approval/scheduling gate).
- **Inventory→website sync** → BAU → **L3 autonomous**.
- **Ad budget change** → money movement → **L2 at most** (never autonomous; see [[Part B1 - Automation Decision Matrix#The approval-gate rule]]).

## How to use it
1. List the task.
2. Ask: *is this core to the moat (Pilot) or keeping-lights-on (BAU)?*
3. Ask: *how repeatable / rule-bound is it?*
4. Assign an autonomy level (L0–L4) using [[Part B1 - Automation Decision Matrix]].
5. Record the decision in the [[decision-log.template|decision log]].

## Related
- [[Part B1 - Automation Decision Matrix]] — the scoring tool
- [[Part A2 - Multi-Agent Orchestration]] — how the automatable tasks get built

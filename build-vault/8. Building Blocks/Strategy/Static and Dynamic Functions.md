---
title: Static and Dynamic Functions
type: framework
created: 2026-06-05
tags: [strategy, business-model, tactical, static, dynamic, prioritization]
---

# Static and Dynamic Functions

> [!summary]
> A second lens for deciding what to build first. Some business functions are **static**: they look mostly the same across businesses once the rules are known. Others are **dynamic**: they depend heavily on the market, offer, channel, timing, audience, or competitive environment. Static functions should usually be prioritized first because they are easier to document, automate, and reuse.

## The core distinction

| Type | Meaning | Typical behavior | Build priority |
|---|---|---|---|
| **Static function** | The function is broadly similar across businesses | Rule-bound, stable, reusable | Build first |
| **Dynamic function** | The function changes based on context | Judgment-heavy, market-sensitive, iterative | Build after the static base exists |
| **Hybrid function** | A department contains both static and dynamic work | Needs decomposition before deciding | Split into static and dynamic tasks |

The important point: **static vs dynamic is about the nature of the task, not the department label**.

That is why "digital marketing" can contain static work and dynamic work at the same time. Website setup, tracking, product page structure, link-in-bio infrastructure, and basic email capture are closer to static tactical work. Creative strategy, positioning, channel testing, content angles, hooks, offers, and CRO interpretation are dynamic.

## Static functions

Static functions are the stable operating pieces every business needs in roughly the same shape. They still require customization, but the core mechanic does not change much.

Examples:
- **Accounting / bookkeeping** - transaction capture, categorization, reconciliation, statements.
- **Basic finance reporting** - cash-flow view, runway, margin reporting.
- **Inventory logs** - stock in/out, SKU records, reorder alerts.
- **Website infrastructure** - basic site structure, analytics, tracking, product page plumbing, link-in-bio routing.
- **Agent operating files** - root context, policies, skills, guardrails, evals, changelog.

These are good early targets because they are stable, repeatable, and easier to turn into templates, scripts, SOPs, and low-risk automation.

## Dynamic functions

Dynamic functions are sensitive to market reality. They require more observation, more judgment, and more iteration. They are not "better" or "more strategic" by default, but they are less transferable.

Examples:
- **Positioning** - what the market believes, what competitors claim, what angle creates contrast.
- **Content strategy** - which topics, hooks, formats, and narratives work for a specific audience.
- **Paid media strategy** - creative-market fit, audience testing, spend allocation.
- **Offer design** - packaging, guarantees, pricing psychology, value proposition.
- **CRO interpretation** - deciding what a test result means and what to change next.
- **Community building** - tone, trust, relationship dynamics, moderation calls.

Dynamic work should be brainstormed and captured, but it needs tighter evidence discipline. Most dynamic tactics begin in [[Theoretical]] and graduate only after execution.

## The trap: classifying by department

Do not classify the whole department as static or dynamic.

| Department / area | Static tactical pieces | Dynamic tactical pieces |
|---|---|---|
| **Capital** | bookkeeping, reconciliations, statements | capital allocation, when to raise, where to deploy cash |
| **Operation** | stock logs, reorder alerts, inventory sync | supplier choice, product roadmap, fulfilment redesign |
| **Market / Distribution** | website setup, tracking, link-in-bio, scheduling system | positioning, content angles, channel selection, creative testing |
| **Agent system** | folder rules, schemas, guardrails, eval format | performance policy changes, taste, creative judgment |

This is the useful move: decompose a function until you can see which parts are static and which parts are dynamic.

## Relationship to other lenses

Static vs dynamic does not replace the other classifications in this vault. It sits beside them:

| Lens | Question it answers |
|---|---|
| **[[Three Entities]]** | Which business entity owns this? Market, Capital, or Operation? |
| **Static vs Dynamic** | How stable and reusable is the work across businesses? |
| **[[Part B2 - BAU vs Pilot Framework]]** | How much human oversight does it need? |
| **[[Practical]] vs [[Theoretical]]** | Has this tactic actually been executed yet? |

These lenses stack. For example:
- Accounting reconciliation = Capital + static + BAU + likely L3 automation.
- Website tracking setup = Market/Distribution + static + BAU-ish + likely script/SOP first.
- TikTok hook strategy = Market/Distribution + dynamic + Pilot-ish + Theoretical until tested.
- Product roadmap choice = Operation/Product interface + dynamic + Pilot + human-gated.

## Prioritization rule

> [!important] Build static tactical infrastructure first
> Static tactical work gives the business a stable operating base. It creates cleaner data, clearer context, better templates, and fewer repeated chores. Once the static base exists, dynamic tactics become easier to test because the system can measure, log, and repeat the experiment.

Recommended order:
1. **Static foundations** - accounting, tracking, website plumbing, inventory logs, schemas, operating files.
2. **Static automation** - scripts, syncs, dashboards, scheduled jobs, validation checks.
3. **Dynamic capture** - collect market observations and tactic ideas in [[Theoretical]].
4. **Dynamic experiments** - run small tests with clear metrics and decision-log entries.
5. **Promotion** - move proven tactics into [[Practical]] once executed.

## How to use this in tactical brainstorming

When brainstorming tactics, tag or label each candidate:
- **Entity:** Market / Capital / Operation.
- **Function type:** static / dynamic / hybrid.
- **Maturity:** theoretical / practical.
- **Autonomy:** L0-L4 using [[Part B1 - Automation Decision Matrix]].
- **First test:** what would prove or disprove it cheaply?

This keeps the tactical layer from becoming a pile of ideas. Static tactics become the first build queue. Dynamic tactics become the experiment queue.

## Related
- [[Tactical]] - where concrete tactics live.
- [[Part B1 - Automation Decision Matrix]] - how function type affects automation readiness.
- [[Governing Artifacts]] - static foundations that dynamic agents depend on.
- [[Theoretical]] - where dynamic tactic ideas are captured before testing.

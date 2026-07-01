---
title: Risks and Open Questions
type: critique
created: 2026-06-05
updated: 2026-06-05
tags: [critique, risks, open-questions]
---

# Risks and Open Questions

> [!summary]
> Failure modes to watch, plus the questions still genuinely open. Resolved questions have been folded into the permanent docs (pointers below). Capture new answers here as you learn them and log them in [[decision-log.template|the decision log]].

## Resolved — now documented in context

These were open questions; the decisions are made and live in the docs:

- **Where does Product/R&D sit** → promoted the triad to **Market · Capital · Operation**; Product and Branding are now [[Market]] pillars alongside [[Distribution]]. See [[Market#Why Market is the umbrella]], [[Product]], [[Branding]].
- **How agents should target metrics ("is saves a proxy?")** → resolved via the scoreboard-vs-control-panel driver-tree split; agents optimize inputs, not lagging outcomes. See [[Governing Artifacts#Scoreboard vs control panel (the key to setting agent targets)]]. *(Still requires an empirical proxy-validation test — tracked in [[Part C1 - Case Study - Peptide TikTok Network#Open items / to test]].)*
- **Where the human sits in the loop** → mild *periodic* QC; let a workflow run ≥1 week before tuning to avoid overfitting. See [[Part A2 - Multi-Agent Orchestration#Human-in-the-loop cadence]].
- **How shared state is stored** → conventions over store; fixed naming/foldering/schema/ID/logging rules the guardrail enforces. See [[Part A2 - Multi-Agent Orchestration#The deeper point: conventions matter more than the store]].
- **Closed-loop policy editing** → batch policy changes weekly (immediate only for big/significant ones); agent proposes → human ratifies → logged. See [[Part A1 - Agent Operating Files#Policy-change cadence]].
- **Instrumentation** → web (Stape GTM + GA4 MCP) and social (Zernio webhook) are solved; consolidation into one place is the open gap (see *Single source of truth drift* below). [[Conversion and Engagement#Current instrumentation stack]].

## Failure modes to watch

### Goodhart's law on proxy metrics
**Risk:** "when a measure becomes a target, it ceases to be a good measure." Optimize saves hard enough and you get save-bait that doesn't sell.
**Mitigation:** periodically re-validate proxy ↔ outcome correlation; keep a downstream guardrail metric (actual conversion). Reinforced by the [[Governing Artifacts#Scoreboard vs control panel (the key to setting agent targets)|scoreboard vs control panel]] split — always keep watching the scoreboard while the agent steers the control panel.

### Over-automation / brittleness
**Risk:** an LLM agent doing a deterministic job fails in new, weird ways and costs more.
**Mitigation:** the script test in [[Part B1 - Automation Decision Matrix#Don't over-classify]].

### Brand / compliance risk (peptides especially)
**Risk:** peptides are a regulated, claims-sensitive space; an agent making health claims or tripping platform rules is a real liability.
**Mitigation:** banned-words + claims rules as hard policy; **human approval gate on all public content** (this is a per-item *safety* gate, distinct from the weekly performance QC); never let medical/health claims publish autonomously.

### Context staleness
**Risk:** knowledge base / intel goes stale; agents act on old facts.
**Mitigation:** date everything; ingest agent refreshes; separate evergreen from transient. See [[Part A2 - Multi-Agent Orchestration#Knowledge base as RAG]].

### Single source of truth drift
**Risk:** inventory, price, tracking, or metrics state diverges across systems. Currently live: web tracking (Stape+GA4) and social (Zernio) are **not yet consolidated**.
**Mitigation:** one authoritative store per data type; everything else syncs from it. Build the metrics-consolidation layer (doubleloop-style) so the analyze agent reads one source. See [[Conversion and Engagement#Current instrumentation stack]] and [[Operation#The bridge into Distribution]].

## Still open

- **Per-pipeline safety-gate UX** — what the banned-claim approval gate physically looks like for the peptide network (Obsidian checkbox vs Telegram/Slack button). Tracked in [[Part C1 - Case Study - Peptide TikTok Network#Open items / to test]].
- **Proxy validation test** — empirical check that saves predict click-through, before scaling.

## Related
- [[Critique and Best Practices]] — the corrections these risks motivate
- [[decision-log.template]] — log resolutions here

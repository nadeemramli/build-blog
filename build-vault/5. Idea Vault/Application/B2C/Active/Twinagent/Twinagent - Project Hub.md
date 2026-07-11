---
title: Twinagent - Project Hub
description: Project hub for a local agent work command center inspired by Agent Notch and Superwhisper-style hover UI.
created: 2026-07-09
updated: 2026-07-09
tags: [project-hub, b2c, active, agent-workflow, local-first]
---

# Twinagent - Project Hub

Twinagent is a local-first command center for watching and steering active AI agent work from one glance.

The product should feel like a small hoverable notch or tray layer: always close, visually quiet, and useful when the user needs to know what agents are doing, which ones need approval, how much context or plan usage remains, and what is scheduled to run next.

## User Intent

Create something in the spirit of [Agent Notch](https://www.agentnotch.app/) and Superwhisper: a compact desktop UI where the user can hover to monitor and manage agent work.

Initial sources:

- User description from 2026-07-09.
- User-provided reference screenshots of Agent Notch-style UI.

## Core Idea

One glance for:

- Codex and Claude agent sessions.
- VPS-hosted agents.
- Other active local or remote agents.
- Running work, waiting work, failed work, and scheduled work.
- Needs-you alerts and inline approvals.
- Context remaining, plan usage, token/credit usage, and reset windows.
- Click-to-jump back into the right agent, thread, terminal, repo, or browser session.

## Working Shape

Twinagent should be a thin local coordination layer, not another heavy project manager.

It should answer:

- What is running right now?
- Which agent needs me?
- What is close to hitting a limit?
- What is scheduled next?
- Where do I click to resume or approve the work?
- Which projects have active background agent work?

## Tracking

Issues and roadmap live in Linear: [Twinagent project](https://linear.app/canvasm/project/twinagent-agent-monitoring-notch-6864ceb449e9) (team **TWI**, 8 milestones, TWI-1 … TWI-21). The vault holds the thinking; Linear holds the execution state.

## Project Docs

- [PRD](<./PRD.md>)
- [Phase 1 Breakdown](<./Phase 1 Breakdown.md>)
- [Task List](<./Task List.md>)
- [2026-07-09 - Project Start](<./Build Journal/2026-07-09 - Project Start.md>)
- [2026-07-09 - AgentNotch Research and PRD v2](<./Build Journal/2026-07-09 - AgentNotch Research and PRD v2.md>)
- [Agent Notch Reference Notes](<./Reference/Agent Notch Reference Notes.md>)

## Current Status

Planning complete (2026-07-10): stack and UX decisions locked, [Phase 1 Breakdown](<./Phase 1 Breakdown.md>) written with 5 milestones and acceptance criteria. Next: scaffold the repo at `~/workspace/github.com/nadeemramli/twinagent` and start Milestone 0.


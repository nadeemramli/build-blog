---
title: 2026-07-09 - AgentNotch Research and PRD v2
description: Researched AgentNotch's architecture and refined the Twinagent PRD around a hub-and-collector model.
created: 2026-07-09
updated: 2026-07-09
tags: [build-journal, twinagent]
---

# 2026-07-09 - AgentNotch Research and PRD v2

## What happened

Researched [AgentNotch](https://www.agentnotch.app/) to ground the Twinagent PRD in a real architecture, with the goal of building a private version that runs on our own machine and VPS.

## Key discovery

AgentNotch is open source: [AppGram/agentnotch](https://github.com/appgram/agentnotch) (Swift, macOS-only). Its docs reveal the whole detection layer needs no APIs and no scraping:

- Claude Code writes full session transcripts to `~/.claude/projects/{project-key}/{uuid}.jsonl` — watch and parse those.
- Codex writes to `~/.codex/sessions/YYYY/MM/DD/rollout-*.jsonl`.
- Claude Code natively exports OTEL telemetry to a local endpoint (port 4318).
- Claude Code hooks (`Notification`, `Stop`, `PreToolUse`) give push-based needs-you alerts — and `PreToolUse` is the mechanism for remote inline approvals later.

This resolves the biggest risk in PRD v1 ("Codex and Claude may not expose stable public APIs").

## Decisions made in PRD v2

- Hub-and-collector architecture: collectors run inside WSL and on the VPS (inotify does not cross the WSL/Windows boundary — collector must live where the agents live), hub holds state (SQLite + WebSocket), one web frontend shipped as both a Tauri v2 Windows tray app and a browser view served by the hub.
- Hub defaults to the VPS behind a private network (Tailscale/WireGuard/SSH tunnel) — always-on, reachable from any device, still fully private.
- Four build phases: Watch → Alert and Jump → Multi-Machine → Act.

## Next

Get sign-off on the PRD v2 stack choices (Tauri + Go/Rust collector), then scaffold the Phase 1 slice: WSL collector parsing real Claude Code sessions into a tray panel.

## Links

- [PRD](<../PRD.md>)
- [Task List](<../Task List.md>)
- [Agent Notch Reference Notes](<../Reference/Agent Notch Reference Notes.md>)

---
title: Twinagent Task List
description: Task list for Twinagent, updated after AgentNotch architecture research.
created: 2026-07-09
updated: 2026-07-09
tags: [tasks, twinagent, active]
---

# Twinagent Task List

## Done

- [x] Create active B2C project folder.
- [x] Create initial project hub, PRD, build journal, and reference notes.
- [x] Research AgentNotch architecture (open source: JSONL watching + OTLP + state machine — see [Agent Notch Reference Notes](<Agent Notch Reference Notes.md>)).
- [x] Research limits around Codex and Claude session visibility — resolved: transcripts on disk (`~/.claude/projects/`, `~/.codex/sessions/`) + hooks + OTEL cover it, no APIs or scraping needed.
- [x] Define the first adapter schema for agent status (see PRD "Other Agents").
- [x] Refine PRD v2 with hub-and-collector architecture and build phases.

## Next (Phase 1 — Watch)

Detailed milestones and acceptance criteria: [Phase 1 Breakdown](<5. Idea Vault/2. Application/B2C/Active/Twinagent - Monitoring and steering AI agent works/Phase 1 Breakdown.md>). Decisions from 2026-07-10: widget = notch pill + hotkey + tray; repo at `~/workspace/github.com/nadeemramli/twinagent`; usage = local-file providers first; VPS deferred (nothing critical there yet).


- [x] Confirm stack (2026-07-09): Rust everywhere, Tauri v2 widget, local-first — hub embedded in the app, VPS-standalone deferred to Phase 3.
- [x] Research usage tracking across providers (see [Usage Tracking Research](<Usage Tracking Research.md>)).
- [ ] Implement Claude Code + Codex local-file usage sources (tokens, context %, plan windows).
- [x] Scaffold repo (2026-07-10, TWI-1): cargo workspace + Tauri v2 shell at `~/workspace/github.com/nadeemramli/twinagent`, builds green, first commit `13136e0`.
- [ ] Scaffold WSL collector: watch `~/.claude/projects/` JSONL, port AgentNotch's parsing state machine.
- [ ] Scaffold hub: SQLite + WebSocket push, runnable both locally and on the VPS.
- [ ] Prototype Tauri tray + hover panel with mock Codex/VPS cards and real Claude Code data.
- [ ] Sketch the compact tray, hover panel, and full dashboard states.

## Later Phases

- [ ] Phase 2: Claude Code hooks (Notification/Stop) for exact needs-you alerts + Windows toasts.
- [ ] Phase 2: Deep links — `vscode://` folder URIs, `wt.exe` into WSL directories.
- [ ] Phase 2: Codex JSONL parser (`~/.codex/sessions/`).
- [ ] Phase 3: Move hub to VPS, private network access (Tailscale/WireGuard), VPS collector + heartbeat contract.
- [ ] Phase 4: Inline approvals via PreToolUse hook decision loop (timeout falls back to terminal prompt).
- [ ] Phase 4: Scheduling view for recurring agent work and follow-ups.
- [ ] Design needs-you alert categories and severity.

## Open Questions

- Should Twinagent be personal-only first, or should team/shared agent visibility be designed from day one?
- Hub location default: VPS (always-on, any device) vs local (fully offline)? PRD proposes VPS with private network access.
- Collector language: Go, Rust, or Node? PRD leans Go/Rust for single-binary deploys to WSL + VPS.
- Should scheduling be native, or initially mirror existing cron/reminder systems? PRD proposes mirroring cron first.
- How should the Windows tray app authenticate to a VPS-hosted hub — Tailscale identity, mTLS, or a simple shared token over the tunnel?

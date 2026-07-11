---
title: Twinagent PRD
description: Product requirements for a private, local-first agent monitoring and control layer, informed by AgentNotch architecture research.
created: 2026-07-09
updated: 2026-07-09
tags: [prd, twinagent, agent-workflow, desktop-app, local-first]
---

# Twinagent PRD

## Product Summary

Twinagent is a private command center for monitoring and steering AI agent work across Claude Code, Codex, VPS agents, and scheduled automation.

It acts like an agent operations notch: compact by default, expanded on hover, and focused on the few signals that matter when multiple agents work in parallel — across the local machine (Windows + WSL) and remote machines (VPS).

Everything runs on infrastructure the user controls. No third-party service sees prompts, code, or credentials.

## Problem

Agent work is distributed across tools, terminals, browser sessions, cloud machines, and scheduled jobs. The user needs a single glanceable surface that shows what is running, what needs attention, what is close to a usage or context limit, and where to jump back in.

## Target User

Solo builder or small team operator running multiple AI agents across product, code, research, infrastructure, and business workflows. Primary environment: Windows 11 with WSL2, plus one or more VPS hosts.

## Prior Art: AgentNotch (researched 2026-07-09)

[AgentNotch](https://github.com/appgram/agentnotch) is open source (Swift, macOS-only). Its architecture validates the core approach and hands us the integration playbook:

- **Claude Code detection**: watches `~/.claude/projects/{project-key}/{uuid}.jsonl` session transcripts plus `~/.claude/ide/*.lock` files. No API needed — the transcripts on disk are the source of truth.
- **Codex detection**: watches `~/.codex/sessions/YYYY/MM/DD/rollout-*.jsonl`, `~/.codex/history.jsonl`, and reads `~/.codex/config.toml`.
- **State machine**: thinking (thinking blocks / assistant activity), tool running (tool_use without matching tool_result), permission needed (tool pending > 2.5s), done (`stop_reason == "end_turn"`), interrupted (`[Request interrupted by user`), idle (no records for ~10s).
- **Token tracking**: input/output tokens plus cache read and cache creation tokens, per session, with a context progress bar (green < 50%, yellow 50–70%, orange 70–90%, red > 90%).
- **OTLP telemetry server**: listens on port 4318 for OpenTelemetry logs/metrics (`/v1/logs`, `/v1/metrics`) — Claude Code exports natively via `OTEL_EXPORTER_OTLP_ENDPOINT`.
- **100% local**: no data leaves the machine.

Full notes: [Agent Notch Reference Notes](<./Reference/Agent Notch Reference Notes.md>)

**What Twinagent adds beyond AgentNotch**: Windows/WSL support (AgentNotch is macOS-only), multi-machine visibility (VPS agents), scheduling, needs-you approvals from the panel, and a roster spanning more than coding agents.

## Architecture

Hub-and-collector model. Three parts:

### 1. Collectors (run where agents run)

A small daemon per machine that observes agent activity locally and pushes normalized events to the hub.

- **WSL collector**: watches Claude Code and Codex JSONL files inside WSL, receives Claude Code hook events, exposes an OTLP receiver. Pushes to the hub over localhost or to the VPS.
- **Windows-side watching (discovered 2026-07-10)**: agents run on both sides of this machine — Claude Code and Codex both have data dirs under `C:\Users\Nadeem\` as well as in WSL. The Tauri app's Rust core watches the Windows-side files natively (no separate collector process needed on Windows).
- **VPS collector**: same binary, plus heartbeat intake for custom agents, cron/queue health checks, and log tailing. Deferred to Phase 3 — nothing critical runs on the VPS yet (confirmed 2026-07-10).
- **Critical constraint**: inotify file-watching does not propagate reliably across the WSL/Windows 9P boundary. The WSL collector must run *inside* WSL (and on each VPS), never watch `\\wsl$` paths from Windows.

### 2. Hub (state + API)

A single lightweight server holding current agent state, history, schedules, and pending approvals.

- SQLite storage, WebSocket push to UIs, REST for collectors.
- Runs on the VPS by default (always on, reachable from any device) or locally for a fully offline setup. Both modes use the same binary.
- VPS mode is private: bind to localhost + access via Tailscale/WireGuard or SSH tunnel. No public exposure, no auth service dependency.

### 3. UI (one frontend, two shells)

- **Windows tray/hover app**: Tauri v2 shell — tray icon with badge counts, hover/click opens the notch-style panel. Small footprint, native feel.
- **Browser view**: the same web frontend served by the hub, for checking agents from any device (phone, laptop) over the private network.

Data flow: `agent activity → collector (normalize) → hub (state, rules, alerts) → UI (tray panel / browser)`.

## Integrations

### Claude Code (first connector)

Three complementary mechanisms, in order of build priority:

1. **JSONL transcript watching** — `~/.claude/projects/` in WSL. Richest signal: tools, thinking, tokens, subagents, todos. Zero configuration; works retroactively on existing sessions. Port AgentNotch's parsing state machine.
2. **Hooks** — `Notification`, `Stop`, and `PreToolUse` hooks in `~/.claude/settings.json` POST to the collector. Push-based, exact needs-you alerts (no 2.5s heuristic). Later: `PreToolUse` hook can *query the hub* for an allow/deny decision — this is the mechanism for inline approvals.
3. **OTEL export** — `CLAUDE_CODE_ENABLE_TELEMETRY=1` + `OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4318` for cost/usage metrics.

### Codex

JSONL watching of `~/.codex/sessions/` using AgentNotch's documented event types (`session_meta`, `turn_context`, `event_msg`/`token_count`, `response_item`/`function_call`).

### VPS Agents

Heartbeat contract: agents POST a small status JSON to the local collector on state change plus a periodic heartbeat. Collector marks agents stale/dead on missed heartbeats. Cron and queue health via collector-side checks.

### Other Agents

Adapter contract (one JSON shape all sources normalize to):

```json
{
  "agent_id": "",
  "source": "claude-code | codex | vps | script | cron",
  "machine": "",
  "project": "",
  "status": "thinking | tool_running | needs_you | done | failed | idle | stale",
  "current_task": "",
  "needs_user": false,
  "needs_user_reason": "",
  "usage": { "input_tokens": 0, "output_tokens": 0, "cache_read": 0, "cache_write": 0, "context_pct": 0 },
  "last_activity": "",
  "jump": { "type": "vscode | terminal | url | ssh", "target": "" }
}
```

## Core Features

### 1. Agent Roster

Every connected source with status, machine, project, current task, and last activity. Sources: Claude Code, Codex, VPS agents, local scripts, scheduled jobs.

### 2. Needs-You Alerts

Permission requests, blocked/failed agents, review requests. Sourced from hooks (exact) and transcript heuristics (fallback). Tray badge count + Windows toast for high-severity.

### 3. Context and Usage Gauge

Per-session context bar with AgentNotch's color thresholds, token/cache counters, plan usage, and long-run duration.

Plan usage across providers (Claude Pro/Max 5h + weekly windows, Codex 5h + weekly windows, others) via the `UsageSource` ladder in [Usage Tracking Research](<./Reference/Usage Tracking Research.md>). Phase 1 covers the pure local-file sources: Claude Code JSONL usage records and Codex `token_count.rate_limits` payloads (which include `used_percent` and `resets_at` directly).

### 4. Click to Jump

Deep links per card: `vscode://` folder URIs, `wt.exe` (Windows Terminal profile into the right WSL directory), browser URLs, `ssh` targets for VPS agents.

### 5. Live Subagents

Child workers under a parent task — parsed from Claude Code transcript sidechains and Task tool records: name, current step, status, last heartbeat.

### 6. Inline Approvals

Phase-gated (see Build Phases). Mechanism: `PreToolUse` hook holds the tool call while the hub surfaces an approve/deny card; hook returns the decision. Conservative defaults — anything ambiguous falls through to the normal terminal prompt.

### 7. Scheduling

Upcoming runs, recurring checks, missed/failed runs. Hub-native schedule store that triggers collectors; mirrors existing cron rather than replacing it.

### 8. Private by Design

All components self-hosted. Local-only mode requires no network beyond localhost. VPS mode stays inside a private network (Tailscale/WireGuard/SSH tunnel).

## Interaction Model

### Compact State (decided 2026-07-10)

Superwhisper-style: a small always-on-top pill at top-center of the monitor showing active count, needs-you count, and failure indicator — plus a tray icon as fallback and settings entry.

### Hover State

Click the pill or press a global hotkey to expand into the notch-style panel: agent cards grouped by machine/project, status chips, context/usage gauges, jump actions, approve/deny buttons.

### Full View

Browser dashboard: filter by project/machine, history, connector management, scheduling, failure debugging.

## Build Phases

### Phase 1 — Watch (local, read-only)

WSL collector + Claude Code JSONL parser + Tauri tray panel. Mock cards for Codex and VPS. Success: real Claude Code sessions visible with status, tokens, and context gauge.

### Phase 2 — Alert and Jump

Claude Code hooks for exact needs-you events, Windows toasts, deep links (vscode://, wt.exe). Codex JSONL parser.

### Phase 3 — Multi-Machine

Hub moves to VPS, VPS collector with heartbeat contract, browser view over private network.

### Phase 4 — Act

Inline approvals via PreToolUse hook decision loop. Pause/resume/retry where the underlying agent supports it. Scheduling view.

## Tech Stack (decided 2026-07-09)

- **Language**: Rust everywhere — collector, hub, and the Tauri app core share one language and one codebase.
- **UI**: Tauri v2. The widget is a native always-on-top frameless window rendered by the OS webview (WebView2 on Windows) — not a hosted web UI, no server, no browser. Superwhisper-style: tray icon + compact top-of-screen widget, click/hotkey to expand.
- **Local-first hub**: the hub runs *embedded inside the Tauri app's Rust core* by default — fully local, zero extra processes on Windows. The same hub crate compiles to a standalone VPS binary for multi-machine mode later (Phase 3).
- **Collectors**: Rust single binaries in WSL (systemd user service) and on the VPS.
- **Usage tracking**: pluggable `UsageSource` per provider with a priority ladder — local files → reused OAuth → provider API → cookies/manual — each reading tagged exact/estimated/stale. See [Usage Tracking Research](<./Reference/Usage Tracking Research.md>).
- **Storage**: SQLite (embedded in hub).
- **Transport**: WebSocket (hub→UI), HTTP POST (collector→hub, hooks→collector).

## Risks and Unknowns

- JSONL formats are undocumented internals; Claude Code or Codex updates can break parsers. Mitigation: hooks and OTEL are stable public interfaces — lean on them where possible.
- WSL/Windows file-watching boundary — solved by running the collector inside WSL, but adds a component to manage (systemd user service in WSL).
- Inline approvals must never bypass safety: hook decision loop should time out to "ask in terminal," not to "allow."
- VPS heartbeat contract needs adoption discipline for custom agents.
- UI must stay glanceable and avoid becoming a second task manager.

## Product Principles

- One glance before one more dashboard.
- Private by default — user-controlled infrastructure only.
- Deep link instead of duplicate context.
- Alert only when action is useful.
- Make running agent work feel observable, interruptible, and resumable.

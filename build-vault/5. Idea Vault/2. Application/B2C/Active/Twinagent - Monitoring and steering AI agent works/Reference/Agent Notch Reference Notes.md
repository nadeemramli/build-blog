---
title: Agent Notch Reference Notes
description: Reference notes from user-provided screenshots and description for Twinagent.
created: 2026-07-09
updated: 2026-07-09
tags: [reference, twinagent, agent-notch]
---

# Agent Notch Reference Notes

## Visual Pattern

The reference UI is a small dark hover panel that sits at the top of the screen, like a notch or compact status surface. It expands enough to show live agent state without becoming a full dashboard.

Important visual cues:

- Compact top summary row.
- Small status chips.
- Dense but readable cards.
- Clear active, working, and needs-you states.
- Usage/context bars.
- Minimal text.
- Strong contrast.

## Functional Signals

The reference screenshots point to these main product promises:

- Every agent visible.
- Needs-you alerts.
- Context gauge.
- Plan usage.
- Click to jump.
- Live subagents.
- Approve inline.
- 100 percent local.

## Twinagent Interpretation

Twinagent should adapt the pattern for the user's agent stack:

- Codex sessions.
- Claude sessions.
- VPS agents.
- Local scheduled jobs.
- Background automations.
- Project-level active work.

The key is not just monitoring. The product should make agent work interruptible and resumable from one surface.

## Architecture Research (2026-07-09)

AgentNotch turned out to be **open source**: [AppGram/agentnotch](https://github.com/appgram/agentnotch) — Swift, macOS 14+, menu bar/notch app, installable via Homebrew. Its `CLAUDE.md` documents the internals in detail.

### How it detects Claude Code sessions

- Watches `~/.claude/projects/{project-key}/{uuid}.jsonl` — the session transcripts Claude Code writes to disk. Project keys are the workspace path with `/` replaced by `-`.
- Also watches `~/.claude/ide/*.lock` for IDE-attached sessions.
- File watching via `DispatchSource.makeFileSystemObjectSource` on `.write`/`.extend` events, with fallback directory scans.

### Claude Code parsing state machine

- `tool_use` record → tool added to active set; `tool_result` (matched by `tool_use_id`) → tool completed. Result content containing "rejected" → interruption.
- `thinking` content blocks (or assistant activity without tools) → thinking state, cleared after 3s idle.
- Tool pending **> 2.5 seconds** without result → inferred "permission required."
- `stop_reason == "end_turn"` → session done. `[Request interrupted by user` substring → interrupted.
- No new records for ~10s → idle.

### Codex parsing

- Watches `~/.codex/sessions/YYYY/MM/DD/rollout-*.jsonl`, plus `~/.codex/history.jsonl` and `~/.codex/config.toml`.
- Record types: `session_meta` (session id, cwd, git branch), `turn_context` (model, approval policy), `event_msg` (`token_count`, `agent_reasoning`), `response_item` (`function_call`, `function_call_output`, `message`).

### Token/usage display

- Tracks input, output, cache-read (green), and cache-creation (yellow) tokens per session.
- Context progress bar: green < 50%, yellow 50–70%, orange 70–90%, red > 90%.
- Footer: session duration, git branch badge, token totals.

### Telemetry server

- Embedded OTLP/HTTP server on port **4318** (`/v1/logs`, `/v1/metrics`). Claude Code exports natively with `OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4318`.

### UI states

Closed (minimal wings showing tool/thinking indicators) → Peeking (dropdown alerts for permissions/completions) → Open (tool lists, todos, session footer).

### What this means for Twinagent

- The whole detection layer needs **no APIs and no scraping** — transcripts on disk plus hooks plus OTEL are enough. This de-risks the biggest unknown in the original PRD.
- AgentNotch is macOS/Swift, so nothing is directly reusable as code on Windows/WSL, but the parsing logic and state machine port directly.
- Claude Code hooks (`Notification`, `Stop`, `PreToolUse`) are a push-based complement AgentNotch doesn't lean on — they give exact needs-you alerts and a path to remote approvals.
- See [PRD](<5. Idea Vault/2. Application/B2C/Active/Twinagent - Monitoring and steering AI agent works/PRD.md>) for the hub-and-collector architecture built on these findings.


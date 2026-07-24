---
title: Twinagent Phase 1 Breakdown
description: Concrete milestone and task breakdown for Phase 1 (Watch) — Rust workspace, parsers, embedded hub, and the notch widget.
created: 2026-07-10
updated: 2026-07-10
tags: [breakdown, twinagent, phase-1, active]
---

# Twinagent Phase 1 Breakdown

Goal: real Claude Code and Codex sessions — from both Windows and WSL — visible in a Superwhisper-style notch widget with status, tokens, context gauge, and plan windows. Read-only; no actions yet.

Repo: `~/workspace/github.com/nadeemramli/twinagent` (WSL-native filesystem for fast cargo builds).

## Decisions locked

- Rust everywhere; Tauri v2 for the widget.
- Hub embedded in the Tauri app (local-first). VPS deferred to Phase 3 — nothing critical runs there yet.
- Widget UX: always-on-top pill at top-center + global hotkey + tray icon.
- Usage sources: local-file providers only (Claude Code, Codex; Gemini CLI if logs present).
- Agents live on BOTH sides of the machine: `C:\Users\Nadeem\{.claude,.codex,.gemini}` and `~/.claude`, `~/.codex`, `~/.gemini` in WSL. Tauri core watches Windows-side natively; a small WSL collector daemon pushes over localhost.

## Milestone 0 — Scaffold (half a day)

- [ ] Cargo workspace with crates:
  - `twin-core` — shared types (adapter schema), JSONL parsers, session state machine.
  - `twin-hub` — session registry, SQLite persistence, WebSocket push. Built as a library (embedded in the app) and a thin standalone binary (Phase 3 VPS).
  - `twin-collector` — WSL/VPS daemon binary: file watching + HTTP POST to hub.
  - `app/` — Tauri v2 app (Rust core embeds `twin-hub`, watches Windows-side files; frontend in Svelte or React).
- [ ] Git init, README with architecture sketch, MIT/private decision.
- [ ] CI deferred (personal use).

## Milestone 1 — Parsers in `twin-core` (the heart)

- [ ] Tail-follow JSONL reader: handles partial lines, file rotation, and catch-up on startup.
- [ ] File watcher (`notify` crate) over `.claude/projects/**` and `.codex/sessions/**`, with fallback directory rescan.
- [ ] **Claude Code parser** — port AgentNotch's state machine:
  - `tool_use` / `tool_result` pairing (by `tool_use_id`), "rejected" → interrupted.
  - `thinking` blocks; tool pending > 2.5s → needs-you (heuristic); `stop_reason == "end_turn"` → done; ~10s silence → idle.
  - Usage per message: input, output, cache read, cache creation tokens + model.
  - Subagent/sidechain and todo extraction (best effort).
- [ ] **Codex parser**: `session_meta` (cwd, branch), `turn_context`, `event_msg.token_count` incl. `rate_limits` (`used_percent`, `plan_type`, `resets_at`), `response_item.function_call(_output)`.
- [ ] Golden tests against real transcripts copied from this machine (`~/.claude/projects/` has plenty).

## Milestone 2 — Hub + collectors

- [ ] `twin-hub`: session registry keyed by (machine, source, session id); status transitions; SQLite history; WebSocket broadcast of state diffs.
- [ ] Windows-side watching inside the Tauri core using `twin-core` parsers over `C:\Users\Nadeem\`.
- [ ] `twin-collector` in WSL: same parsers over `~/`, POST to `http://localhost:<hub-port>`; machine tag "wsl". Install as systemd user service.
- [ ] Dedup rule for sessions visible from both sides (same project open via WSL path vs Windows path).

## Milestone 3 — The widget

- [ ] Notch window: frameless, transparent, always-on-top, skip-taskbar, positioned top-center; remembers monitor.
- [ ] Pill (compact): active count, needs-you count, failure dot.
- [ ] Expand on click or global hotkey (default `Ctrl+Shift+Space`, configurable); collapse on blur/Esc.
- [ ] Panel: agent cards grouped by machine → project; status chips; context gauge with AgentNotch thresholds (green <50%, yellow 50–70%, orange 70–90%, red >90%); token + cache counters; session duration; git branch badge.
- [ ] Tray icon with badge + settings menu (autostart, hotkey, thresholds).
- [ ] Windows toast on needs-you transitions.

## Milestone 4 — Usage + jump (closes Phase 1)

- [ ] Claude plan windows: aggregate JSONL usage into rolling 5-hour and weekly estimates (ccusage-style), tagged *estimated*.
- [ ] Codex plan windows: read `rate_limits.used_percent` + `resets_at` directly, tagged *exact*.
- [ ] Gemini CLI logs if present (stretch).
- [ ] Click-to-jump: `vscode://file` folder URIs and `wt.exe -d <dir>` (Windows Terminal into the right WSL directory).

## Acceptance (Phase 1 done when)

1. Start a Claude Code session in WSL and one on Windows → both appear in the widget within ~2s, correctly machine-tagged.
2. A tool waiting on permission turns the pill into needs-you state and fires a toast.
3. Context gauge and token counters update live during a session.
4. Codex 5h/weekly `used_percent` shows with its reset time.
5. Clicking a card opens the right folder in VS Code or Windows Terminal.
6. Kill the app → nothing else keeps running on Windows; WSL collector survives independently.

## Explicitly out of Phase 1

Hooks (Phase 2), Codex-on-WSL polish beyond parser reuse, VPS anything (Phase 3), approvals/actions (Phase 4), scheduling (Phase 4), cookie/API-key usage sources.

## Links

- [PRD](<5. Idea Vault/2. Application/B2C/Active/Twinagent - Monitoring and steering AI agent works/PRD.md>)
- [Task List](<Task List.md>)
- [Usage Tracking Research](<Usage Tracking Research.md>)
- [Agent Notch Reference Notes](<Agent Notch Reference Notes.md>)

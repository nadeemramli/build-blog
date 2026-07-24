---
title: Usage Tracking Research
description: How to monitor token usage and personal plan limits across GPT, Claude, DeepSeek, Gemini, Grok, GLM, Kimi, and Qwen.
created: 2026-07-09
updated: 2026-07-09
tags: [reference, twinagent, usage-tracking]
---

# Usage Tracking Research

Two different problems that need different mechanisms:

1. **API usage** (pay per token) — easy. Every API response body includes a `usage` object (input/output tokens). Sum locally, multiply by the provider price sheet. Some providers also expose balance/usage endpoints (DeepSeek `GET /user/balance`, Moonshot/Kimi `/v1/users/me/balance`, Anthropic Admin API usage/cost, OpenAI dashboard endpoints).
2. **Personal plan usage** (Claude Pro/Max, ChatGPT Plus, SuperGrok, ...) — no official public API anywhere. Every real-world tool uses one of four unofficial mechanisms below.

## The four mechanisms (from studying ccusage, caut, Claude-Code-Usage-Monitor, tokscale)

### 1. Local transcript/log parsing (best: offline, private, zero auth)

- **Claude Code**: `~/.claude/projects/**/*.jsonl` records per-message `usage` (input, output, cache read, cache creation tokens + model). This is exactly how ccusage works. Plan cost on flat-rate plans is *estimated* from tokens × price sheet.
- **Codex**: `~/.codex/sessions/YYYY/MM/DD/rollout-*.jsonl` contains `token_count` events with a `rate_limits` payload: `primary.used_percent` (5-hour window), `secondary.used_percent` (weekly), `plan_type`, `resets_at`. The actual official plan-window numbers, sitting on disk.
- **Gemini CLI / Qwen Code** (Qwen Code is a Gemini CLI fork): local session logs + OAuth creds files.

### 2. Reused OAuth tokens (call the same internal endpoint the official client calls)

- Claude Code stores OAuth credentials locally; tools like caut reuse them to query the internal usage endpoint that powers `/usage` — returns real 5h/weekly/Opus tier percentages.
- Gemini CLI: `~/.gemini/oauth_creds.json` similarly reusable.
- Unofficial but reliable while the endpoint is stable; degrade gracefully.

### 3. Provider APIs (only for API-key usage, not plans)

- Response `usage` fields (all 8 providers).
- Balance endpoints: DeepSeek, Kimi/Moonshot, GLM/Zhipu have them; xAI has console/management endpoints.

### 4. Browser cookie reuse (last resort, fragile)

- For web-only plans (grok.com, kimi.com, chat.qwen.ai, chatglm.cn, chatgpt.com): read the logged-in session cookie from the browser profile and call the internal endpoints the web dashboard uses. This is what caut does on macOS. Breaks whenever the provider changes their frontend; treat as optional plugin, never core.

## Per-provider summary for Twinagent

| Provider | API usage | Personal plan usage | Best mechanism |
|---|---|---|---|
| Claude (Pro/Max) | response usage / Admin API | 5h + weekly + Opus tiers | JSONL logs + OAuth reuse — best supported of all |
| GPT/Codex (Plus/Pro) | response usage / dashboard | 5h + weekly windows | `rate_limits` payload already in rollout JSONL |
| Gemini | response usageMetadata | CLI free-tier quotas | Gemini CLI OAuth + logs |
| DeepSeek | `GET /user/balance` | web chat has no metering | API only |
| Grok (xAI) | response usage, console | SuperGrok limits | cookies only (defer) |
| GLM (Zhipu/z.ai) | balance/usage endpoints | coding-plan quota | API; z.ai coding plan has queryable quota (caut supports it) |
| Kimi (Moonshot) | `/v1/users/me/balance` | web plan | API; cookies for web (defer) |
| Qwen | DashScope console/quotas | Qwen Code free tier | Qwen Code OAuth + logs |

## Design consequence for Twinagent

Pluggable `UsageSource` trait per provider with a priority ladder: **local files → reused OAuth → provider API → cookies/manual**. Each reading carries a confidence tag (exact / estimated / stale) and the UI shows which mechanism produced it. Phase 1 ships the two that are pure local-file reads: Claude Code and Codex.

## Prior art

- [ccusage](https://github.com/ryoppippi/ccusage) — Claude Code JSONL cost analysis
- [caut / coding_agent_usage_tracker](https://github.com/Dicklesworthstone/coding_agent_usage_tracker) — multi-provider quota tracking (CLI → Web → OAuth → API → Local strategy ladder)
- [Claude-Code-Usage-Monitor](https://github.com/Maciek-roboblog/Claude-Code-Usage-Monitor) — real-time window predictions
- [tokscale](https://github.com/junhoyeo/tokscale) — token tracking across Claude Code, Codex, Gemini, Kimi, and more
- [SessionWatcher Codex rate limits guide](https://sessionwatcher.com/guides/codex-rate-limits-explained)

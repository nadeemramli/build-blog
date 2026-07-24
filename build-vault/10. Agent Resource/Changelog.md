---
title: Agent Resource Changelog
description: Dated changes to agent navigation, vault operating memory, and workflow principles.
created: 2026-07-07
updated: 2026-07-12
tags: [agent-resource, changelog]
---

# Agent Resource Changelog

## 2026-07-12

### Central PA Control and Operating System Routing

- Updated the Build Vault agent guide to require the central PA Control guide first.
- Clarified that PA Control owns cross-vault goals, portfolio admission, decision rights, and conflicts while Build Vault retains project/business authority.
- Routed private personal finance, health, biomarker, physique, lifestyle, and protocol records to the separate Operating System vault.
- Added health-commerce legal, privacy, medical-claim, and project-admission boundaries.

### Why

- Agents need one governance layer across vaults without flattening each vault's local source of truth.
- Public content, private personal operations, career learning, and live business records require different authority and privacy rules.

## 2026-07-09

### Twinagent Project Start

- Created [Twinagent](<../5. Idea Vault/Application/B2C/Active/Twinagent/>) under the active B2C idea vault.
- Added initial project hub, PRD, task list, build journal, and reference notes.
- Added Twinagent to [Project Register](<./Project Register.md>) as an active concept.
- Added Twinagent to the root [Build Vault Index](<../index.md>) active projects table.

### Why

- The user is beginning a new B2C project for a local-first agent monitoring and control UI across Codex, Claude, VPS agents, scheduled jobs, and needs-user approvals.

## 2026-07-08

### Operating Cost Capture

- Added [Shared Operating Budget](<../9. Real World/Shared Operating Costs/Shared Operating Budget.md>) for shared tooling and portfolio-level burn.
- Added [2026-07-08 - Owner Cost Inputs](<../9. Real World/Shared Operating Costs/Sources/2026-07-08 - Owner Cost Inputs.md>) as the source note for owner-provided cost figures.
- Added [INDEXA Software and Domain Budget](<../9. Real World/INDEXA/03 - Capital/Software and Domain Budget.md>) and recorded the Lovable Labs 2026-06-26 domain receipt as `EXP-20260626-001`.
- Updated Canvasm economics and shared infrastructure budget with confirmed Hetzner, free-plan, and upgrade-trigger assumptions.
- Added [Pricing and Break Even Model](<Pricing and Break Even Model.md>) to connect stack cost, MRR targets, and Malaysia SaaS pricing benchmarks.
- Added Clerk to the Canvasm stack as sign-in and user management infrastructure.
- Added [Agent Prompts - Pricing Tier Implementation](<Agent Prompts - Pricing Tier Implementation.md>) for app and marketing implementation handoff.
- Clarified that the first pricing implementation should be workspace plans with included seats, not pure per-seat-only pricing.

### Why

- Shared builder tooling should not be treated as Canvasm COGS by default.
- INDEXA-specific website/domain spend belongs in INDEXA Capital, not shared infrastructure.
- User-provided cost screenshots need a durable local source note so future budget changes remain traceable.

### Shared Infrastructure Budgeting

- Created [Shared Infrastructure Budget](<../9. Real World/Shared Infrastructure/Shared Infrastructure Budget.md>) as the canonical home for reusable infrastructure spend.
- Updated the Canvasm economics note so Canvasm carries a planning/allocation view instead of duplicating shared infrastructure expenses.
- Added Shared Infrastructure to the project register and root index.

### Why

- Canvasm uses infrastructure that can serve multiple projects, so the real expense should live at a shared operating layer, with Canvasm receiving an allocation rather than owning the whole cost.

## 2026-07-07

### OpenKnowledge Setup

- Updated project `.mcp.json` so Codex launches OpenKnowledge with the bundled Node 24 runtime.
- Added a workspace-local `.mcp.json` inside `build-vault` so Codex can see the OpenKnowledge MCP config when opened from the vault folder.
- Mirrored the parent `.mcp.json` to the same Windows-compatible launcher with explicit `--cwd C:\Users\Nadeem\Desktop\Obsidian\build-blog`.
- Set `.ok/config.yml` to scope OpenKnowledge content to `./build-vault`.
- Cleaned stale OpenKnowledge server/UI locks.
- Started the local OpenKnowledge server on port `7331` and UI on port `7332`.
- Note: this Codex session still needs a restart or reload before the new MCP tools appear in tool discovery.

### Initial Scaffold

- Added root [AGENTS.md](<../AGENTS.md>) as the future-agent entrypoint.
- Created `10. Agent Resource` as the agent operating memory folder.
- Added [Agent Resource Index](<./Agent Resource Index.md>), [Vault Navigation](<./Vault Navigation.md>), [Project Register](<./Project Register.md>), and [2026-07-07 - Vault Onboarding Notes](<./2026-07-07 - Vault Onboarding Notes.md>).
- Refreshed root [index](<../index.md>) to point at applied domains, project management, active projects, real-world operations, and agent resources.

### Why

- The user wants future agents to navigate the Build Vault without repeated onboarding.
- The vault needed a durable place for agent principles, navigation rules, active-project status, and changes in approach.

### Open Follow-Ups

- Confirm status of non-Canvasm and non-INDEXA projects.
- Decide whether INDEXA needs a canonical project hub under `5. Idea Vault`.
- Define a repeatable budgeting and money-review cadence for active projects.

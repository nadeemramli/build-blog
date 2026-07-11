---
draft: false
title: "WSL Launch Runbook — Bootstrap then Parallel Build"
date: "2026-07-04"
tags:
  - canvasm
  - claude-code
  - wsl
  - runbook
---

# WSL Launch Runbook — Bootstrap then Parallel Build

Run these in WSL. The work items live in Linear (team **CVS**); Claude Code pulls them. Companion: [[Parallel Agent Build — Prompts and Orchestration]], [[AI Agent Linear Workflow]], and [[E2E Visual Verification]].

> Replace `<REPO_DIR>` with your metrimap repo path in WSL. The product-vault path used for `--add-dir` is:
> `/mnt/c/Users/Nadeem/Desktop/Obsidian/build-blog/build-vault/5. Idea Vault/Application/B2B/Active/Canvasm - Easy Workflow`

---

## 0 · One-time setup

```bash
cd <REPO_DIR>
git checkout main && git pull
npm install

# Give Claude Code access to Linear (once; persists across sessions):
claude mcp add --transport http linear-server https://mcp.linear.app/mcp
# then run `claude`, type /mcp, and authenticate the Linear server.
```

---

## 1 · Bootstrap FIRST (CVS-45) — alone, then merge

This installs the agent operating protocol into `AGENTS.md` and cleans the docs. Everything else depends on it.

```bash
cd <REPO_DIR>
claude --add-dir "/mnt/c/Users/Nadeem/Desktop/Obsidian/build-blog/build-vault/5. Idea Vault/Application/B2B/Active/Canvasm - Easy Workflow"
```

Paste this prompt:

```
Read Linear issue CVS-45 (Canvasm team) and execute it exactly. It updates AGENTS.md with the "Agent operating protocol" + docs policy and prunes/migrates the docs. Do only what the issue says: create its branch, apply the AGENTS.md changes, do the docs keep/migrate/delete pass, replace the wrong root README, run `npm run type-check` and `npm run lint`, open a PR referencing CVS-45, move CVS-45 to Waiting for Manual Test, and create a `manual-test` sub-issue in the Manual Test project that verifies AGENTS.md reads correctly, the README is right, and there are no broken doc links. This is docs + AGENTS.md only — do not touch feature code.
```

**Then review and merge that PR to `main`** before Phase 2. Re-pull: `git checkout main && git pull`.

---

## 2 · Parallel lanes (after bootstrap merged)

Run A, B, C in parallel + D as a single serial lane. Give each its own git worktree so they don't fight over the working tree.

```bash
cd <REPO_DIR>
git fetch origin && git checkout main && git pull
git worktree add -b lane-a ../metrimap-lane-a origin/main
git worktree add -b lane-b ../metrimap-lane-b origin/main
git worktree add -b lane-c ../metrimap-lane-c origin/main
git worktree add -b lane-d ../metrimap-lane-d origin/main
# node_modules isn't shared across worktrees:
for d in a b c d; do (cd ../metrimap-lane-$d && npm install); done
```

Open **4 terminals**. In each, `cd ../metrimap-lane-<x>`, launch Claude Code with the vault, and paste the matching kickoff. Launch command (same in every terminal, just from that lane's dir):

```bash
claude --add-dir "/mnt/c/Users/Nadeem/Desktop/Obsidian/build-blog/build-vault/5. Idea Vault/Application/B2B/Active/Canvasm - Easy Workflow"
```

The kickoffs are short because `AGENTS.md` now holds the full protocol.

### Lane A — Integrations (terminal in `../metrimap-lane-a`)
```
Read AGENTS.md and the vault note "AI Agent Linear Workflow" first, then follow the operating protocol for every issue. You are the INTEGRATIONS agent. Your Linear project is "Linear features & integrations" (Canvasm). Work its issues in order: CVS-24 (Initiatives already exist — just finish mapping objectives to metric-tree nodes + post the first Initiative update), CVS-26 (Userback → Customer Requests API bridge), CVS-25 (Releases pipeline — CONFIRM the Linear plan is Business+ first; if not, stop and comment), CVS-27 and CVS-28 (Sentry / Snyk evaluations — deliver a written recommendation on each issue). No React canvas code in this lane.
```

### Lane B — Home (terminal in `../metrimap-lane-b`)
```
Read AGENTS.md, the vault note "AI Agent Linear Workflow", and the vault note "E2E Visual Verification" first, then follow the operating protocol. You are the HOME agent. Work ONLY Linear issue CVS-29 (Redesign canvases home) in the "Navigation & in-canvas UX" project. Follow the direction/mockup in the issue. Files: src/features/projects/pages/HomePage.tsx and related. Do NOT touch CanvasPage.tsx or canvasStore.ts. Run `npm run screenshots` before handoff if the screenshot harness is available in your worktree.
```

### Lane C — Evidence (terminal in `../metrimap-lane-c`)
```
Read AGENTS.md, the vault note "AI Agent Linear Workflow", and the vault note "E2E Visual Verification" first, then follow the operating protocol. You are the EVIDENCE agent. Your Linear project is "Evidence Notebook refactor". Work in order: CVS-35, then CVS-36, then CVS-34. Reuse the CVS-33 codename utility from the canvas lane — do not reimplement it; if it isn't merged yet, note the dependency. Files: EvidenceContentRenderer.tsx, EvidenceNode.tsx, EvidencePage.tsx, editorjs-config.ts. Rebase on main before opening each PR (light CanvasPage overlap). Run `npm run screenshots` before handoff for visible card, notebook, sheet, or canvas changes when available.
```

### Lane D — Canvas engine (terminal in `../metrimap-lane-d`) — SERIAL
```
Read AGENTS.md, the vault note "AI Agent Linear Workflow", and the vault note "E2E Visual Verification" first, then follow the operating protocol. You are the CANVAS-ENGINE agent and you OWN CanvasPage.tsx + canvasStore.ts, so work issues ONE AT A TIME — do not parallelize this lane. Your Linear projects are "Navigation & in-canvas UX" (the canvas items) and "Canvas engine — nodes & edges". Order: CVS-33 (codename utility — FIRST, it's shared with Evidence), CVS-30, CVS-31 → CVS-32, CVS-38 → CVS-43, CVS-41, CVS-42, CVS-40, CVS-37, CVS-39, then CVS-44 (edge routing, last). Honor each issue's "## Decision (locked)" comment. One branch + PR + Waiting for Manual Test + manual-test sub-issue (in the Manual Test project, assigned to the owner) per issue. Run `npm run screenshots` before handoff for visible canvas, toolbar, node, edge, or popover changes when available.
```

---

## 3 · Merge discipline

- Review + merge PRs **one at a time**; after each merge, other lanes `git pull --rebase origin main` in their worktree.
- A feature is **Done** only after a human passes its `manual-test` sub-issue (in the Manual Test project) and the change is merged. Until then it stays **Waiting for Manual Test**.
- When finished: `git worktree remove ../metrimap-lane-a` (etc.).

## Simplest alternative (no worktrees)
Run the lanes **sequentially** in `<REPO_DIR>` (A → B → C → D). Slower, zero setup, zero collisions. Lane D is serial regardless.

## Related
- [[Parallel Agent Build — Prompts and Orchestration]] · [[3.a Workflow Architecture - Linear Obsidian Agents Product Surfaces CI-CD]] · [[manual-test-doc-rule]]

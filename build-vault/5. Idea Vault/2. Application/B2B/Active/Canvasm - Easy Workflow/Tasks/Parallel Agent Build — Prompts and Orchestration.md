---
draft: false
title: "Parallel Agent Build — Prompts and Orchestration"
date: "2026-07-04"
tags:
  - canvasm
  - agents
  - claude-code
  - orchestration
  - qa
---

# Parallel Agent Build — Prompts and Orchestration

For running Claude Code agents against the Linear **CVS** projects. Cowork plans and writes Linear; Claude Code builds from Linear (see [[metrimap-workflow]]).

Before sending any agent prompt, also read [[AI Agent Linear Workflow]]. It is the current status, manual-test, and lane model for Canvasm agents. Older references below to `In Review` now mean `Waiting for Manual Test`.

For UI-heavy lanes, also read [[E2E Visual Verification]] and ask the agent to run `npm run screenshots` before handoff when the work changes visible app surfaces.

## Can we run 4 agents at once?

**Not 1:1 with the four projects.** Two files funnel almost all canvas work: `src/features/canvas/pages/CanvasPage.tsx` (~2,200 lines) and `src/features/canvas/stores/canvasStore.ts` (plus `useCanvasActions.ts`, `useCanvasHistoryStore.ts`). If several agents edit those at once on `main`, you get constant conflicts and broken intermediate states.

Draw lanes by **file ownership**, not by project:

| Lane | Scope (issues) | Parallel? | Why |
|---|---|---|---|
| **A** | Linear features & integrations — CVS-24, 25, 26, 27, 28 | ✅ fully | config, Supabase edge fn, GitHub Action, spikes — no React canvas code |
| **B** | Home redesign — CVS-29 | ✅ fully | `HomePage`/projects feature — separate from the canvas |
| **C** | Evidence — CVS-35, 36, then 34 | ⚠️ mostly | evidence files; only light `CanvasPage` overlap via `EvidenceNode` |
| **D** | In-canvas UX + Canvas engine — CVS-30, 31→32, 33, 37–44 | ❌ serialize | all funnel through `CanvasPage.tsx` + `canvasStore.ts`; real deps (CVS-38→43, 31→32) |

**Verdict:** run **A, B, C in parallel**; **Lane D is ONE agent** working its issues in dependency order (not 8 agents). That's ~3–4 concurrent agents, safely.

Two guardrails make it safe:
- **Branch per issue, not direct-to-`main`.** AGENTS.md already anticipates a preview/PR flow — switch to it for this parallel push. Use the Linear-provided `gitBranchName`. On one machine, use `git worktree` per lane.
- **Merge one PR at a time, rebase the others** — especially Lane D's serial issues.

**Prerequisite — run CVS-45 first.** The bootstrap issue installs the agent operating protocol into `AGENTS.md` and prunes stale docs. Every agent below assumes it's done.

---

## Shared build contract (prepend to EVERY agent prompt)

```
You are a Claude Code agent building Metrimap (React 19 + TS + Vite; React Flow @xyflow/react v12; Dagre/ELK layout; shadcn/Tailwind; Zustand + XState; Supabase + Clerk; Vercel). AGENTS.md is the source of truth for architecture, commands, and conventions — read it first. The product Obsidian vault (…/Canvasm - Easy Workflow) holds product memory; read and update it when relevant.

Work items live in Linear (team CVS), organized as Initiatives → Projects → Issues. Start from your assigned Project and take the next issue by priority + unblocked status (respect blockedBy). For EACH issue:

1. Read the issue in full — description AND all comments. Many carry a "## Deep analysis" comment (current code with file:line refs) and a "## Decision (locked)" comment. Honor the locked decisions.
2. Create a branch from the issue's `gitBranchName` (Linear provides it). Do NOT commit straight to main during this parallel push.
3. Implement to satisfy the acceptance criteria + locked decisions. Match surrounding code; reuse src/shared/components/ui (shadcn) before adding deps. Schema changes: add a migration under supabase/migrations/, run `npm run prisma:types`, update src/shared/lib/supabase/types.ts.
4. Verify: `npm run type-check`, `npm run lint`, `npm run test` (and `npm run test:rls` if RLS is touched). Do NOT bypass the Husky pre-commit hook.
5. MANDATORY — create a manual-test SUB-ISSUE (child of the feature issue): title "Manual test: CVS-XX — <feature>", placed in the Manual Test project, labelled manual-test, assigned to the owner (m.nadeemramli@gmail.com — shows in their Todo). The body MUST contain:
   - a link to the parent issue + the PR,
   - a one-paragraph change summary + preconditions,
   - numbered test cases derived from EACH acceptance criterion (steps → expected result),
   - edge cases, and a pass/fail checkbox per case.
   Model the cases on the vault "Manual QA Finding Template". This sub-issue is the human's vetting task — no feature is "done" without a passing one. Do NOT write a manual-test doc file; tests are Linear sub-issues now. (No dedicated tester account — route by the Manual Test project.)
6. Open a PR that references the issue (keep "CVS-XX" in the branch/PR so Linear links it); link the manual-test sub-issue in the PR.
7. Move the feature issue to "Waiting for Manual Test" (NOT Done). If Linear still shows the old "In Review" status during the rename transition, use it only as the temporary alias for "Waiting for Manual Test". The feature is Done only after a human runs and passes the manual-test sub-issue (in the Manual Test project) and the change is merged/released.

Never expose secrets. Keep Supabase error/evidence stores and RLS intact. If you must edit a shared-hotspot file another lane may be in (CanvasPage.tsx, canvasStore.ts), keep the diff tight and rebase before opening the PR.
```

---

## Agent A — Linear features & integrations (Lane A · fully parallel)

```
[Prepend the Shared build contract.]

Your project: "Linear features & integrations". Issues, in order:
- CVS-24 — Initiatives are already created (the workspace now has them). Finish only the remaining part: map each Initiative's objective to a metric-tree node and post the first Initiative update. (Likely closeable quickly.)
- CVS-26 — Userback → Customer Requests bridge. Server-side edge function: Userback API/webhook → Linear customerCreate (map email domain) + customerNeedCreate. Keys stay server-side. Self-contained; no React canvas code.
- CVS-25 — Releases pipeline. ⚠️ Requires a Business+ Linear plan — CONFIRM the plan first; if not available, stop and report. Otherwise add the linear-release GitHub Action on push to main (repo secret LINEAR_ACCESS_KEY) + status automation.
- CVS-27 — Evaluate Sentry (spike). Deliverable is a written recommendation on the issue; only wire a prototype if cheap. Manual-test sub-issue only if you actually wire something.
- CVS-28 — Evaluate Snyk (spike). Enable GitHub PR checks on the repo; recommend which findings route to Linear. Recommendation on the issue.

This lane touches config / edge functions / CI only — safe to run alongside B, C, D.
```

## Agent B — Home redesign (Lane B · fully parallel)

```
[Prepend the Shared build contract.]

Your single issue: CVS-29 — "Redesign canvases home". Files: src/features/projects/pages/HomePage.tsx and related. Follow the direction in the issue and the planning mockup: one consolidated control bar (space · All/Recent/Starred · search · sort · view · a single "New" split button); collapse the Examples carousel to a slim dismissible entry that remembers its state; user canvases become the primary above-the-fold content. Consider running the design-handoff skill first for exact tokens/specs. Keep every current affordance reachable; WCAG AA; responsive. Separate from the canvas — safe in parallel.
```

## Agent C — Evidence (Lane C · mostly parallel; coordinate CanvasPage)

```
[Prepend the Shared build contract.]

Your project: "Evidence Notebook refactor". Order:
1. CVS-35 — canvas card "No content available". Root cause in EvidenceContentRenderer.tsx: it renders only when evidence.content (EditorJS) is set, else falls back to summary/"No content available". Render populated summary/hypothesis, and fix the field-mapping so the node gets the same data as the full view.
2. CVS-36 — "View Full" wiring. EvidenceNode.tsx uses <Link to=/evidence/:id>; fix the route/page OR switch to an in-canvas side panel (decide + implement consistently).
3. CVS-34 — Notebook-style refactor (umbrella). Unify node preview + full view + comments around the one EditorJS notebook. Folds in comments; reuse the CVS-33 codename utility (coordinate with Lane D — do not duplicate it).

Files: EvidenceContentRenderer.tsx, EvidenceNode.tsx, EvidencePage.tsx, editorjs-config.ts. Light CanvasPage overlap via EvidenceNode — rebase before merging.
```

## Agent D — In-canvas UX + Canvas engine (Lane D · SERIAL, one agent)

```
[Prepend the Shared build contract.]

You own CanvasPage.tsx + canvasStore.ts, so this lane is NOT split — work issues ONE AT A TIME, each on its own branch → PR → manual-test sub-issue → Waiting for Manual Test, in this dependency order:

1. CVS-33 — comment codename utility (build this FIRST; it's shared — Lane C's CVS-34 reuses it).
2. CVS-30 — off-screen wayfinding indicator.
3. CVS-31 — consolidate canvas toolbar  →  4. CVS-32 — relocate toolbar top-right (blocked by 31).
5. CVS-38 — node intersections (foundation)  →  6. CVS-43 — grouping + subflows (blocked by 38; true nested subflows with on-canvas UI per the locked decision).
7. CVS-41 — copy/paste (extend the existing useCanvasActions clipboard; add edges-in-selection + cross-canvas).
8. CVS-42 — undo/redo (extend the existing useCanvasHistoryStore command-stack to cover moves/edits/edge ops; route through updateNodePosition/autosave per the locked decision).
9. CVS-40 — realtime collaboration (fix the LWW "one step behind" reconciliation via applyNodeChanges/setNodes; CRDT is a later phase — do NOT build it now).
10. CVS-37 — easy connect.   11. CVS-39 — node position animation.
12. CVS-44 — edge routing (libavoid, live obstacle-avoidance — heaviest, LAST).

Honor each issue's "Decision (locked)" comment. Undo/redo UI buttons + auto-layout/groups controls land in the CVS-31 toolbar.
```

---

## Why this makes a good feedback loop

Every completed issue lands as: a **branch + PR** (traceable), a **manual-test sub-issue in the Manual Test project** with runnable test cases, and the feature issue in **Waiting for Manual Test** (not Done). Nothing closes until a human passes the sub-issue — so "complete" always means "vetted." This is the verification loop from [[3.a Workflow Architecture - Linear Obsidian Agents Product Surfaces CI-CD]] and [[2.a.iv Quality and Verification Pipeline]] made concrete.

## Related
- [[1. Development Operating System]] · [[metrimap-workflow]] · [[2.a.iv Quality and Verification Pipeline]] · [[Development Backlog by Intake Group]]

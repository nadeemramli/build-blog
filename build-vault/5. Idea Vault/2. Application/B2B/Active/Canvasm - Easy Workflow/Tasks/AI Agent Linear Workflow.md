---
draft: false
title: "AI Agent Linear Workflow"
date: "2026-07-05"
tags:
  - canvasm
  - agents
  - linear
  - manual-test
  - workflow
---

# AI Agent Linear Workflow

Use this note when asking Claude Code, Codex, or another build agent to work on Canvasm Linear issues. It supersedes older vault wording that says agents should move finished runtime issues to `In Review`.

Source references: `CVS-240` updated `AGENTS.md` with this workflow, `CVS-241` is the manual review for that update, and `CVS-239` is the mega manual-test queue.

## Status Meanings

| Status | Meaning |
|---|---|
| `Triage` | Raw intake. Needs shaping, grouping, or owner decision before an agent builds it. |
| `Backlog` | Valid work, but not part of the current execution queue. Not automatically blocked by manual tests. |
| `Todo` | Ready to be picked up, or a manual-test issue waiting for Nadeem to run it. |
| `In Progress` | An agent is actively building or fixing it. |
| `Waiting for Manual Test` | Implementation is ready for owner verification. Until Linear settings are renamed, treat the old `In Review` status as this same queue. |
| `Needs Fix` | Owner manual test failed. Agent should read the failure comment, fix, and return it to `Waiting for Manual Test`. |
| `Done` | Human manual test passed, PR is merged/released where relevant, and no verification work remains. |

## Manual-Test Gate

Every resolved runtime issue must create a Linear manual-test issue before the parent moves to `Waiting for Manual Test`.

The manual-test issue must:

1. Be a child of the runtime issue.
2. Live in the `Manual Test` project.
3. Be assigned to Nadeem.
4. Have the `manual-test` label.
5. Start in `Todo`.
6. Link the parent issue and PR.
7. Include preconditions, numbered steps, expected results, edge cases, and pass/fail checkboxes.

Agents do not self-mark runtime issues `Done`. Nadeem runs the child manual-test issue. If it passes, the parent can move to `Done`. If it fails, the parent moves to `Needs Fix`, the manual-test issue stays open, and the failure comment becomes the fix brief.

Docs-only or spike issues only need a manual-test child when there is something Nadeem must verify in the product or workflow. Otherwise, capture the decision on the issue and keep the acceptance criteria explicit.

## Lanes

Projects are durable product areas. Lanes are short-lived execution slices.

Do not assign an agent to a broad project and hope it finds a safe path. Give each agent a lane with:

1. A `lane:<slug>` label or an explicit ordered issue list.
2. Three to eight issues where possible.
3. Clear dependencies and blockers.
4. A named file or surface ownership boundary.
5. Shared-hotspot warnings, especially `CanvasPage.tsx`, canvas stores, migrations, auth/RLS, and design-system components.
6. The expected end state: PR opened, parent in `Waiting for Manual Test`, manual-test child in `Todo`.

Good lane examples:

- `lane:manual-test-closeout`
- `lane:canvas-stability`
- `lane:ui-modernization`
- `lane:access-visibility`
- `lane:mcp-api`
- `lane:strategy-impact`
- `lane:infra-workers`
- `lane:canonical-schema-foundation`

For UI-heavy lanes, explicitly tell the agent to use `/frontend-design` and to keep the work consistent with the current modern Canvasm UI direction.

## Can Agents Continue While Manual Tests Wait?

Yes, if the next lane is independent.

Waiting manual tests block follow-up work only when the new work depends on unverified behavior, shared files, migrations, or product decisions from that waiting issue. Otherwise, agents can keep closing other `Todo` or well-shaped `Backlog` work and create more manual-test issues for Nadeem.

Use this rule of thumb:

- Same feature chain or shared hotspot: wait, or create a narrow fix lane after the manual result.
- Different surface with no dependency: proceed.
- Broad project with mixed work: split into smaller lanes first.

## Agent Prompt Checklist

Every agent prompt should include:

1. Read `AGENTS.md` first.
2. Read this vault note for status, manual-test, and lane rules.
3. Read the full Linear issue, comments, locked decisions, dependencies, and linked issues.
4. Work on a branch/PR with the `CVS-XX` identifier preserved.
5. Verify with the repo's normal checks.
6. Create the manual-test child issue before moving the parent.
7. Move runtime parents to `Waiting for Manual Test`, not `Done`.
8. If fixing a failed manual test, move from `Needs Fix` back to `Waiting for Manual Test`.
9. Leave a handoff summary with PR, tests run, manual-test issue, risks, and anything not merged.

## Reading Linear Queues

`Waiting for Manual Test` is Nadeem's verification queue. It is not agent backlog unless a test fails.

`Backlog` is valid future work. It might be ready for a new lane after dependencies are checked.

`Triage` should be shaped before build work starts. Merge duplicates, add acceptance criteria, decide project/labels, then move it to `Todo` or `Backlog`.

`Manual Test` project issues are Nadeem's runbook. They should be clear enough to test without reopening the implementation thread.

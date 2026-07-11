---
name: commit-and-merge-preference
description: "User wants work committed (and merged) as it goes, not left uncommitted"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 2cfc1040-2ad2-4fc3-8fa3-6ebb77a811c6
---

The user's standing preference: "Commit and merge everything always." When working through a task, commit each coherent step rather than leaving a large uncommitted working tree; don't pause to ask whether to commit.

**Why:** They move fast and treat git history as the running log; they explicitly authorized committing in-flight work (incl. work I didn't author) rather than stashing/branching it aside.

**How to apply:** Commit each step as it lands (sensible, scoped commits). Still run type-check/lint before committing so nothing breaks — committing broken code is not the intent.

**UPDATE 2026-07-04 — branching changed:** the "default to `main`" part is now SUPERSEDED by the AGENTS.md agent operating protocol. Work is tracked in **Linear (team CVS/Canvasm)**; do **branch-per-issue** (use the Linear `gitBranchName`, keep `CVS-XX` in it), **never commit to `main` directly**, and open a PR (feature issue → In Review, plus a `manual-test` sub-issue for Checkpoint). Direct-to-`main` only returns once the core value pipeline is complete end-to-end. So: still commit as you go, but onto the active CVS branch, not main. The commit-as-you-go / commit-in-flight-work-too preference still holds. Related: [[dont-remove-active-vars]], [[integrations-lane-worktree-2026-07]].

**UPDATE 2026-07-05 — direct-to-`main` is back on:** for the MCP-server deploy work the user said *"always push to main, there's no point of doing this without pushing to main."* So the branch-per-issue/PR gate above is now relaxed toward the AGENTS.md "direct-to-`main` once core pipeline complete" mode — after a green `type-check`/`lint`/`test`, merge the branch and **push straight to `origin/main`** (fast-forward, no PR) unless the user says otherwise. I did this for the whole MCP server (CVS-99/100/104 + Hetzner deploy + a Dockerfile husky-hook fix): merged `origin/main` into `mnadeemramli/mcp-vps-deploy`, verified 222/222 tests + 0 lint errors, pushed `HEAD:main` (`de17538`). The "don't self-merge prod DB/security PRs" caveat below still applies when in doubt — but here the user had already applied the `mcp_resolve_api_key` migration by hand.

**UPDATE 2026-07-04 — merge-as-you-go, WITH one exception:** in the multi-agent worktree build the user asked me to **merge each PR as it lands** (squash) rather than stacking PRs, and rebase the worktree on `origin/main` between issues — stacking makes merges harder. BUT do **not self-merge production-sensitive DB PRs** (grant/RLS/security migrations, e.g. CVS-127): open the PR and leave it for the owner to review + `db push`. Rationale confirmed by the auto-mode classifier blocking agent-chosen `REVOKE/ALTER` against prod. Keep issues in **In Review** (never straight to Done) even after merge — Checkpoint's manual test gates Done.

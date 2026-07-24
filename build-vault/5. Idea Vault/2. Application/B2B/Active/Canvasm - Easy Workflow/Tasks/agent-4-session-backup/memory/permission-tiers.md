---
name: permission-tiers
description: Permission model — Viewer/Commenter/Editor/Admin tiers; org=collaborative
metadata: 
  node_type: memory
  type: project
  originSessionId: 2cfc1040-2ad2-4fc3-8fa3-6ebb77a811c6
---

Permission model depth SHIPPED 2026-07-03 (on main). Model = **"org collaborative"**: every active-workspace (Clerk org) member keeps FULL WRITE via the `workspace_id = requesting_org_id()` branch in `has_project_access`; per-project roles constrain only EXTERNAL/guest `project_collaborators` rows + public links. (User explicitly chose to NOT narrow org-member write.)

**RLS (migration `20260703180000_permission_tiers`, APPLIED):** expanded `project_collaborators` role CHECK to add `editor`+`commenter` (kept legacy member); new `can_comment_project(pid)` helper (view + comment-or-higher role/token, WITHOUT write); repointed comment_threads/comments/comment_mentions INSERT policies off `has_project_access(write)` onto it (so commenters comment but can't edit; UPDATE/DELETE stay editor-gated); `my_project_permission(pid)→none|view|comment|edit` RPC (reuses helpers) for authoritative UI gating. `has_project_access` write logic UNCHANGED (editor/admin/owner role or edit/write/admin token).

**Client:** `useCanvasPermission(projectId)` hook (calls the RPC) → CanvasPage gates nodesDraggable/nodesConnectable/deleteKeyCode on canEdit + shows view-only/comment-only banner; CollaborationPanel comment composer hidden for viewers. Role dropdowns now Admin/Editor/Commenter/Viewer; `addCollaborator`/`updateCollaborator` write a coherent `permissions[]` via `permissionsForRole()` (viewer=[read], commenter=[read,comment], editor=+edit, admin=+admin) so role+tokens never disagree. Commits `fb6cc14`(client) `1f24d2c`(composer). RLS remains the real boundary; UI gating is cosmetic.

**All roadmap platform epics now DONE.** Remaining: canvas polish (user deprioritized), deferred bugs + debug-log cleanup (with manual test session). See [[gap-list-build-2026-06-30]], [[object-model-locked]].

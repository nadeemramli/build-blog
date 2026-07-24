---
name: collab-consolidation-2026-06
description: Canvas Collaborate+Share merged into one right-side panel; comment-refs uuid→text migration APPLIED 2026-06-28
metadata: 
  node_type: memory
  type: project
  originSessionId: bab683fb-413a-43bc-a66a-62ea4d4fdfc9
---

Consolidated the canvas collaboration UI (2026-06-28). The old split **Collaborate** (top-left dialog) + **Share** (top-right) buttons are replaced by a single **Collaborate** button (top-right) opening a right-side slide-over `CollaborationPanel` (Sheet, `modal={false}` so the canvas stays interactive). Tabs: **People** (members + role + remove + invite-by-email + public-link toggle/copy — folds Share in), **Comments** (real DB threads + `CommentComposer` with @mention picker that fires `addMention`+`createNotification`), **Activity** (notifications + changelog + VersionHistoryButton).

New files: `src/features/canvas/components/collaboration/CollaborationPanel.tsx`, `CommentComposer.tsx`; `src/features/canvas/hooks/useProjectMembers.ts`; `src/features/canvas/utils/comments.ts` (`postComment` helper — shared persistence). Deleted: old `collaboration-dialog.tsx`, `CommentSummaryDashboard.tsx`, and the dead duplicate `src/shared/components/layout/CanvasLayout.tsx` (zero importers). The card discussion tab (`panels/relationship-panel/tabs/comments-tab.tsx`, used by CardSettingsSheet) was rerouted from fake card-JSON storage to real DB threads keyed by `source:'node'`, `context:{cardId}`.

**✅ APPLIED 2026-06-28 (via MCP `apply_migration` to prod `iqrclwolhookzzmiedun`).** `20260628130000_comment_user_refs_text.sql` altered `comments.author_id`, `comment_threads.created_by`, `comment_mentions.mentioned_user_id` from **uuid → text** (Clerk ids are text; uuid columns silently rejected them). All three tables were empty + no policy/view referenced the columns, so it was a clean change; verified all three are now `text`. The sibling `20260628120000_source_connections.sql` was applied the same session (tables pre-existed but weren't tracked; re-applied idempotently to record + set policies/REVOKE — RLS on both, 4 owner policies on `source_connections`, 0 on `source_connection_secrets` = service-role-only). Also added the 4 missing tables (`comments`, `comment_threads`, `comment_mentions`, `notifications`) to `src/shared/lib/supabase/types.ts` — they were absent, which is why `collaboration.ts`/`comment-node.tsx` carry `@ts-nocheck`.

Caveat: owner `project_collaborators` row still isn't seeded (backlog P1-12), so the mention picker shows **self + real collaborators only**. See [[metrimap-handoff-2026-06]].

---
draft: true
title: "Issues - Bug"
date: "2025-08-03"
tags:
archived: true
archived_note: "Aug 2025 running to-do/done tracker across Evidence/Canvas/Nodes/Grouping/Org/Collaboration/UI areas. Superseded by BACKLOG.md and docs/backlog/* in the repo. Archived 2026-07-04."
---
1. Evidence Page — Done: EditorJS integrated, Evidence Node aligned with editor, width function, open-in-new-page, contextual evidence placement (General/pegged-to-card/pegged-to-relationship), inline comments under editor. Todo: call metric/card/visualization function.
2. Canvas — Done: infinite scroll, Excalidraw integration, top toolbar (selector/move/hand/scale). Todo: ensure tools work properly.
3. Nodes/Operation — Done: Source/Data Node v0 (SQL/Python transform, Google Sheet/Motherduck), Visualization Node, Operator Node (date picker/boolean/formula/if-statement/dynamic text), Control System. Todo: proper data source, operator usability, side panel.
4. Grouping — Todo: grouping→dashboard still an issue, grouping→slides, nested/closed grouping.
5. Org/User Management — Todo: organization + personal function, force-create-org-to-share flow. Done: WASM, WebSocket, Supabase Realtime.
6. Collaboration — Todo: full-page comment/notification/changelog dialog, share function with a "Growth machine" viral signup gate.
7. UI/Accessibility — Todo: shadcn skeletons, bottom bar refactor. Done: mini toolbar refactor, hold-space-to-select.

Edge types (matches Medium PRD 1.0): Dynamic (causal/deterministic/composite/probabilistic), Operative (pass data via Operative Nodes, Zapier-like), Simple (peg/connect, e.g. evidence to a node). Task: refactor Metric Card to separate it from Data/Metric Card.

Known bugs at the time: unable to drag evidence around; Excalidraw-over-ReactFlow overlay sync issues (persist per canvas, freeze RF while drawing, transparent overlay alignment). Desktop-only constraint: "Canvasm can only be used at Desktop."

---
draft: true
title: "1. UI Task"
date: "2025-08-13"
tags:
archived: true
archived_note: "Aug 2025 bug report describing core interactions (drag/connect/open-sheet) as fully broken, plus dual-canvas (Edit/Draw) sync bugs. Superseded by BACKLOG.md and docs/backlog/canvas-system-followups.md in the repo — these specific bugs are long since fixed. Archived 2026-07-04."
---
Debug state should be able to close (icon toggle, dev-mode only).
Control panel on the left should also be able to collapsible.

We can't drag nodes. We can't connect nodes. We can't open nodes sheet.

Loved the 80% zoom-out default — wanted it as the app default.

Canvas has two states: editing (React Flow: Nodes, Edge, Evidence, Comments, correlation analysis) and drawing (Excalidraw). Issues at the time: adding non-MetricCard node types (e.g. comment node) made all nodes visually disappear (still existed in Debug State); Excalidraw drawing tools stopped working once wired through the custom top toolbar (worked fine when using Excalidraw's own tools directly); wanted a "pegging" mechanism so the Excalidraw overlay's X-Y stays aligned with the ReactFlow canvas as a transparent overlay.

Also noted: block mobile and tablet usage — Canvasm was decided to be desktop-only.

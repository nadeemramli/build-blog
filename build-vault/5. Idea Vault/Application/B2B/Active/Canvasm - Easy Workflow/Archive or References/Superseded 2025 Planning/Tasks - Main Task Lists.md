---
draft: true
title: "Task Lists"
date: "2025-08-10"
tags:
archived: true
archived_note: "Aug 2025 engineering scratchpad (Prisma/Zod/XState adoption notes, a Storybook addon-resolution error, a 'Foundation' hypothesis breakdown). Superseded by BACKLOG.md and docs/backlog/* in the repo. Archived 2026-07-04."
---
- Complete implementation of Prisma and Zod: Do it along the way.
- Identify current state management, and use xState for important state, such as Draw/Edit mode.
- Complete new PRD to differentiate processing, which goes to Comlink, then Supabase, then Temporal.

Implementation of Storybooks, ensure we use it properly:
Could not resolve addon "@storybook/addon-essentials", skipping. Is it installed?
Could not resolve addon "@storybook/addon-interactions", skipping. Is it installed?

Figure out the app true (Foundation) - and start working on it

1. Hypothesis of Foundation:
	1. Canvas — Ensure we can use Excalidraw and Reactflow smoothly; Excalidraw is pretty direct; Reactflow node/edge types, grouping, CSS layout.
	2. Source — Tier Z (random/manual entry), Tier 0 (Google Sheet).
	3. Operation — Transformation, Operative Nodes, push data to target node, bulk operation, node operation.
	4. Computations — Dynamic Edge Calculation, Formula, Simulation.
	5. Editor — Block called out Nodes.
	6. Collaborative — Comments centralize, Changelog, Share function.

Workflows: Use ADR.

Refactor Metric Card. Refactor Sheet. Improve pin for evidence and comments. Add control panel on the left. Glue canvas together. Ensure we can navigate properly. Ensure we can use both environment (toolbar functioning).

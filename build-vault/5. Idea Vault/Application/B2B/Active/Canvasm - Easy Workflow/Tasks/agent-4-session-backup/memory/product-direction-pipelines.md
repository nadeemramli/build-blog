---
name: product-direction-pipelines
description: Product north star is metric-tree building + business value-chain governance; prioritize value pipelines over auth/collab/share
metadata: 
  node_type: memory
  type: project
  originSessionId: f1f02f34-6a79-49ec-b718-1dec8f0de4f6
---

As of 2026-06-27 the user wants to stop treating the audit-driven BACKLOG.md (heavily weighted to auth / collaboration / sharing) as the primary roadmap. The app's north star: **help users build metric trees and govern their business value chain.**

**Why:** the backlog was generated from a code-audit, so it over-indexes on plumbing (auth, RLS, collab, share) rather than the core product-value pipelines users actually come for.

**How to apply:** frame and prioritize work as end-to-end **value pipelines** derived from the product objective, not isolated bug items. The methodology (Levers Labs / Abe Gong metric-trees) is now captured in `docs/reference/metric-tree-methodology.md` and pointed to from AGENTS.md + CLAUDE.md. **Critical nuance the user stressed twice:** that doc is the *principle*, NOT our spec — Metrimap has its own deliberate approach and will diverge. Do NOT auto-create tasks/features from the methodology; discuss with the owner first (the doc's "Our approach" section is filled in collaboratively). Treat auth/collab/share as supporting infrastructure, not the headline. See [[metrimap-handoff-2026-06]].

---
name: manual-tests-assign-to-owner
description: "Linear manual-test sub-issues always go to Nadeem, not the Checkpoint bot"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: bb4291b1-f0d5-4f20-b5be-749bf47866b1
---

When creating `manual-test`-labelled issues in Linear (team **CVS / Canvasm**), assign them to **Nadeem** (owner), Linear user id `3f0b8049-7811-47da-93f8-5d93770d4348` — NOT the `checkpoint.xyz@gmail.com` account the AGENTS.md operating protocol names.

**Why:** the owner drives manual QA himself right now.
**How to apply:** set `assigneeId` to Nadeem's id on every manual-test issue you create; this overrides the "assigned checkpoint.xyz@gmail.com" step in the AGENTS.md agent operating protocol. Team CVS id `7f02b994-356e-4594-bd76-fe95f22e08b5`; "In Review" state `2d0fb908-4cf9-4649-9f36-61d67ce21e53`. Related: [[commit-and-merge-preference]].

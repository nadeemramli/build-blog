---
title: Continue AttributeOS Phase 0
description: Ready-to-paste implementation prompt for the coding agent after the APEX, Hevy and Phase 0 decisions were supplied.
created: 2026-07-14
updated: 2026-07-14
status: ready
tags: [attributeos, prompt, implementation, phase-0]
---

# Continue AttributeOS Phase 0

Use the prompt below from a native Windows PowerShell session opened at
`C:\code\attributeOS`.

---

Continue AttributeOS Phase 0 from the private GitHub repository
`nadeemramli/attributeOS`. You are authorized to edit the app, run local and
Windows verification, create issue-scoped branches and commits, push passing
branches, and update the existing Linear issues ATT-1 through ATT-7 with
evidence. Do not merge to `main`, publish a release, buy/sign up for a service,
or distribute an installer without separate approval.

Start by reading, in order:

1. Repo `AGENTS.md` / `CLAUDE.md`.
2. Product-vault `PRD.md`, `Technical Design.md`, Discovery Brief and latest
   build log.
3. `Decisions/decisions.md`.
4. `Decisions/2026-07-14 - APEX Framework v1.md`.
5. `Build Logs/2026-07-14 - Hevy Export Schema Inspection.md`.

Product-vault root:

`C:\Users\Nadeem\Desktop\Obsidian\build-blog\build-vault\5. Idea Vault\Application\B2C\Active\AttributeOS - Local Health Evidence`

The representative Hevy export is local-only at:

`C:\Users\Nadeem\Desktop\Nadeem Ramli - AttributeOS\workouts.csv`

Never commit, copy into the repo, paste into logs, or reproduce real rows,
titles, exercise names, dates, notes, loads or reps. Inspect it only when a
schema assertion needs verification. Fixtures must be written from scratch with
visibly synthetic content. A Hevy screenshot and an admissible benchmark pack
are still missing; mark those parts blocked and do not invent them.

Before changing three or more files or introducing a schema/API contract, write
the required implementation plan. Preserve any unrelated user changes. Use one
ATT issue per branch/commit series and record exact verification evidence.

Execute in this order:

1. **ATT-7 - identity and license.** Replace provisional
   `com.attributeos.desktop` with `com.nadeemramli.attributeos`; add private
   proprietary license/package metadata; keep bundling/updater/network disabled.
   Verify all existing checks.
2. **ATT-1 - Windows key-store spike.** On native Windows, prove generation of a
   random vault master key, current-user-only protected storage/retrieval,
   explicit lock/zeroization boundary, deletion, wrong/missing credential
   behavior and privacy-safe logs. Use the final app identifier as the key-store
   namespace. Do not use machine-scope DPAPI and do not claim recovery yet.
3. **ATT-6 - Hevy native CSV schema lock.** Implement detection and parsing into
   candidates, not accepted records. Handle the exact 14-column inspected shape,
   RFC 4180 quoting/multiline notes, local-naive timestamps with explicit
   timezone, optional numeric fields, known/unknown set types, record ordering,
   source fingerprints/revisions and exact-duplicate idempotency. Add only
   synthetic golden/adversarial fixtures. Do not implement screenshot OCR.
4. **ATT-5 - APEX framework seed.** Add immutable `apex-24/v1` reference data
   with exactly the 24 accepted stable keys, six derived compound views,
   version/hash validation and tests. Mapping suggestions remain candidates.
   Implement named progress-policy types if needed by the boundary, but do not
   activate benchmark values. Preserve the safety translation: evidence and
   review, no diagnosis, prescription, causation or PED optimization.
5. If the above pass and enough context remains, continue the trust chain with
   **ATT-2 SQLCipher/blob packaging**, then **ATT-3 recovery-wrapper plus
   encrypted backup/clean-machine restore**, then **ATT-4 NSIS/offline WebView2,
   signing-pipeline proof and Windows side-channel tests**. Keep each issue
   separate and stop at a genuine blocker rather than weakening a trust claim.

For ATT-3, implement the accepted two-wrapper design: current-user OS wrapper
for routine unlock and a portable Argon2id recovery-passphrase wrapper. Real
imports remain blocked until recovery is configured and a scratch restore
matches accepted records/report hashes. Never store the recovery passphrase.

Verification requirements:

- Run the existing aggregate verification equivalent to CI.
- Run native Windows checks for every Windows-only claim and record OS,
  architecture, toolchain, package type and result.
- Confirm the real Hevy export remains untracked and absent from Git history.
- Scan fixtures/log snapshots for forbidden personal strings.
- Update the product-vault build log with durable, privacy-safe learnings only.
- Update Linear with passed evidence or the exact blocker; no vague “done”.

Finish by reporting: issue/branch/commit, files changed, checks run and results,
privacy review, decisions consumed, remaining blockers, and the smallest next
action. Do not call encryption, recovery, Windows packaging or benchmark support
complete unless its required platform test actually passed.

---
title: AttributeOS Phase 0 Product Decisions
description: Accepted decisions closing the Phase 0 identity, security, recovery, export, retention and review-policy gates.
created: 2026-07-14
updated: 2026-07-14
status: accepted-product-decision
decision_owner: Nadeem
decision_method: user-delegated recommendation within existing PRD boundaries
review_date: 2026-08-10
tags: [attributeos, decision, phase-0, security, recovery, export]
---

# AttributeOS Phase 0 Product Decisions

## Decision register

| Area | Accepted decision | Review trigger |
| --- | --- | --- |
| Application ID | `com.nadeemramli.attributeos` | Before any deliberate product rename |
| Product name | `AttributeOS` | No planned change |
| Ownership / license | Private proprietary software; all rights reserved; packages are not publishable | Before open-source or commercial distribution |
| Primary Windows package | Per-user NSIS installer with an offline-capable WebView2 posture | Before multi-user or managed-enterprise deployment |
| Windows code signing | Unsigned local development; self-signed only for pipeline tests; trusted signing is a distribution gate | Before anyone outside Nadeem installs it |
| Auto-update | Disabled; no updater plugin, endpoint or runtime network permission | Separate distribution and threat-model decision |
| Routine key access | Current-user Windows key store / DPAPI-backed wrapper; never machine scope | Windows key-store spike result |
| Recovery | A portable passphrase wrapper is required before the first real-data import | Clean-machine restore test |
| No-recovery mode | Allowed only for disposable development vaults; prohibited for a production vault | Explicit future user decision |
| Operating System staging | User-selected folder defaulting to `operating-system/7. Staging/AttributeOS` | Operating System governance change |
| Hevy source | Native CSV export is the sole Hevy source. Screenshot extraction/OCR is descoped (not needed and not built) — decided 2026-07-14 | Explicit future user decision to re-add screenshots |
| Phase 1 photos | Deferred; protocol can be designed, but encrypted photo ingestion remains Phase 2 | Explicit scope decision |

## Repository and checkout posture

- GitHub `nadeemramli/attributeOS` remains the source-code authority.
- The WSL checkout at `~/workspace/github.com/nadeemramli/attributeOS` remains
  the normal implementation workspace and must stay on the Linux filesystem.
- `C:\code\attributeOS` is the native-Windows checkout for ATT-1 through ATT-4
  and other tests that physically require Windows. It is not accessed through
  `/mnt/c` from WSL.
- Work is issue-scoped, branch names carry the ATT ID, and each trust claim
  records the exact environment in which it was verified.

## Identity and licensing

Replace the provisional `com.attributeos.desktop` identifier before creating
production vault paths, key-store records or installers. Tauri uses the reverse-
domain identifier in system configuration and the WebView data directory, so
changing it after real use would create migration risk.

Use `com.nadeemramli.attributeos`. Add a root proprietary `LICENSE` file, set
Cargo packages to `publish = false`, use `license-file` rather than claiming an
OSI license, and retain `"private": true` in the frontend package.

## Packaging, signing and update posture

Phase 0 tests a native x86-64 Windows NSIS per-user installer. The installer
must support an offline clean-machine test; WebView2 packaging is selected and
recorded explicitly rather than depending on an unrecorded online bootstrap.
MSI is deferred because the current product is single-user and does not need
managed enterprise deployment.

Local builds may remain unsigned. A self-signed certificate may prove that the
pipeline signs the executable and installer, but that artifact is never called
trusted or distributed. Before external distribution, acquire an appropriate
trusted Windows code-signing route and sign both executable and installer.

The updater remains disabled. This preserves the no-network default and avoids
creating an update signing-key lifecycle before there is a distribution need.
If updates are later admitted, their signing key is stored outside the repo and
backed up separately; losing it can prevent updates to installed clients.

## Vault unlock and recovery

The master key is a random 256-bit value. Database, blob, backup and export-
authentication subkeys are derived with separate HKDF domain labels.

Two independent wrappers protect the master key:

1. `os_wrapper`: current-user Windows protection for routine unlock. Never use
   machine-scope DPAPI, because that would allow other users on the same machine
   to decrypt the wrapper.
2. `recovery_wrapper`: XChaCha20-Poly1305-wrapped master key protected by an
   Argon2id-derived key from a user recovery passphrase.

Use versioned Argon2id parameters. The initial portable profile follows RFC
9106's second recommended option: `m=64 MiB`, `t=3`, `p=4`, 16-byte random salt
and a 32-byte derived key. Benchmark on the target Windows machine and increase
cost in a new wrapper version if acceptable; never silently lower existing
parameters.

The app opens locked and requires an explicit unlock action. Routine unlock may
use the OS wrapper without retyping the recovery passphrase. Lock clears key
material, sensitive view state, image URLs, and safely identifiable app-owned
clipboard content. Default auto-lock is 10 minutes of inactivity and immediate
on Windows session lock. A stricter passphrase-every-launch mode may be added
later without changing backup recovery.

A production vault cannot accept real imports until a recovery wrapper exists
and an encrypted backup has passed restore verification in a scratch location.
The passphrase itself is never stored. Backup metadata contains only versioned
KDF parameters, salt and wrapped key material.

## Backup, retention and deletion

- Raw source artifacts are retained encrypted until explicit user deletion.
- Keep three verified rolling backups plus up to twelve monthly checkpoints
  when the user has selected sufficient storage.
- Production backup destination must be user-selected outside the application
  data directory. Same-disk backup is allowed for testing but does not satisfy
  the production recovery gate.
- Re-key or deletion marks every known backup that may still contain affected
  ciphertext. The UI offers replacement verification before old backups are
  removed.
- Full-vault destruction removes all wrappers first, then performs best-effort
  file deletion while explaining SSD and external-backup limits.

## Operating System export destination

Default the folder picker to:

```text
C:\Users\Nadeem\Desktop\Obsidian\operating-system\7. Staging\AttributeOS
```

The absolute path is a user-selected profile setting, not a hard-coded product
constant. AttributeOS acceptance and Operating System acceptance are separate:
an accepted AttributeOS close is exported into Staging and remains a proposal
until the Operating System review accepts it.

Each close writes matching immutable Markdown and JSON files from one rendered
model, using an atomic temporary-file-then-rename flow. Re-exporting the same
close is idempotent. The export contains accepted summaries, model/formula
versions, coverage and unresolved exceptions; it excludes raw artifacts,
screenshots, source-note text, progress photos and private treatment context by
default.

## Phase 1 source authority

| Evidence | Canonical source | Secondary / conflict behavior |
| --- | --- | --- |
| Resistance sessions and sets | Reviewed Hevy native CSV (sole source) | Screenshot extraction descoped (2026-07-14); no secondary Hevy source in Phase 1 |
| Exercise identity and equipment | Reviewed canonical mapping | Source label is preserved; ambiguous mappings block affected comparisons |
| Manual physique check-in | User-confirmed protocol record | Scan/device evidence supports the record but does not silently overwrite it |
| Bodyweight during Phase 1 | User-selected check-in value | Do not merge another source until its authority rule is accepted |

## Baseline and close policy

- Initial Hevy analysis window: 90 days.
- A point best requires one accepted comparable exposure; a trend requires at
  least three; A/B/C sequencing comparison requires at least three comparable
  observations for every compared day.
- Active-exercise evidence becomes stale after 28 days without a comparable
  accepted exposure; deliberate exclusions remain explicit rather than stale.
- Physique deltas require two protocol-comparable accepted check-ins. The target
  cadence is every two weeks; stale after 35 days.
- Training close: weekly and at the end of each block.
- Full private Operating System close: monthly.
- Review budget: 15 minutes. The UI must estimate the number of items before
  close acceptance.

Blocking review items are unresolved timezone, unit/load model, duplicate or
source correction that affects an accepted set, ambiguous exercise identity,
benchmark inapplicability, material redaction-policy failure, and failed backup
verification before production use. Optional notes, unused columns and
non-material low-confidence suggestions are non-blocking but remain visible.

## Report profiles

- `private_full`: selected accepted summaries and exact values needed by the
  private Operating System; raw source payloads and unselected sensitive
  context are still excluded.
- `clinician_safe`: dates, methods, trends, source flags, user-reported symptoms
  and questions; excludes benchmark-cohort speculation, private notes and
  photos unless explicitly selected.
- `public_content`: aggregated and de-identified only; denies raw labs, exact
  private health values, treatment/PED context, photos and identifying source
  metadata.

All profiles use positive field allowlists followed by a sensitivity check.

## Physique protocol gate

Phase 1 supports measurements but not progress-photo ingestion. The first
check-in establishes a versioned user protocol rather than assuming that two
similarly named measurements are comparable. Until the user confirms the exact
landmarks and body-fat method, the app stores candidates and reports
`uncertainty_not_quantified`; it must not invent numeric uncertainty bounds.

## Sanitized-fixture procedure

Representative exports are inspected only outside the repo. A fixture is then
written from scratch with visibly synthetic names and values. It reproduces
column order, types, quoting, optional fields and parser edge cases, never a
real row, real date sequence, real note, real exercise roster or transformed
personal value. A second reviewer or deterministic check confirms forbidden
personal strings are absent before commit.

## Implementation order implied by these decisions

1. ATT-7: replace the provisional ID and add proprietary package metadata.
2. ATT-1: prove current-user Windows key storage using the final identifier.
3. ATT-6: lock the Hevy adapter against the inspected schema and synthetic tests.
4. ATT-5: seed `apex-24/v1`; leave benchmark values inactive until admissible.
5. ATT-2 and ATT-3: SQLCipher/blob packaging, then verified backup and clean-
   machine recovery using both wrappers.
6. ATT-4: NSIS/offline installation, signing-pipeline proof and side-channel
   inspection.

## External technical references

- Tauri configuration: https://v2.tauri.app/reference/config/
- Tauri Windows installers: https://v2.tauri.app/distribute/windows-installer/
- Tauri Windows code signing: https://v2.tauri.app/distribute/sign/windows/
- Tauri updater key lifecycle: https://v2.tauri.app/plugin/updater/
- Microsoft DPAPI `CryptProtectData`: https://learn.microsoft.com/en-us/windows/win32/api/dpapi/nf-dpapi-cryptprotectdata
- RFC 9106 Argon2 recommendations: https://www.rfc-editor.org/info/rfc9106/


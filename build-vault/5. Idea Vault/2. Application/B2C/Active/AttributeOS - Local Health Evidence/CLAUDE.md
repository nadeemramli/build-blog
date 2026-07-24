# AttributeOS Product Vault

This folder is the product knowledge base and learning loop for AttributeOS.
It is the source of truth for product meaning; the code repository is the
source of truth for implementation.

## Read first, in order

1. [PRD.md](<5. Idea Vault/2. Application/B2C/Active/AttributeOS - Local Health Evidence/PRD.md>) — authoritative product scope and requirements
2. [Technical Design.md](<Technical Design.md>) — intended architecture
3. [AttributeOS - Discovery Brief.md](<AttributeOS - Discovery Brief.md>) — original discovery record
4. Recent notes in `Build Logs/`

## Repository

- WSL: `~/workspace/github.com/nadeemramli/attributeOS` (alias symlink: `~/workspace/attributeos`)
- Repo agent context: `CLAUDE.md` / `AGENTS.md` at the repo root

## Write learning here

- Build logs: `Build Logs/` — one dated note per meaningful build session
- Decisions, QA learnings, postmortems, insights: create sibling folders as needed
- Durable product learning from implementation work belongs here, not in repo notes

## Rules

- **Production and raw health evidence never belongs in this folder**: no real
  exports (Hevy/WHOOP/Apple Health/MacroFactor), no lab PDFs, no progress
  photos, no production vault/database files, no screenshots of real data.
- No secrets, tokens, credentials or machine paths that expose sensitive labels.
- This vault is not a task board. Linear owns work state: project
  https://linear.app/canvasm/project/attributeos-9e5f64d4996b (team key ATT).
- Do not rewrite PRD.md / Technical Design.md / the Discovery Brief from
  implementation work. If implementation proves a contradiction, stage a
  clearly labelled proposed decision instead of silently changing product truth.
- Prefer updating an existing note over creating duplicates; ask before broad
  reorganizations, renames or deletes.
- The app must remain useful without an LLM; agent work here follows the PRD's
  safety boundaries (no diagnosis, prescribing, PED optimization or opaque
  composite health scoring).

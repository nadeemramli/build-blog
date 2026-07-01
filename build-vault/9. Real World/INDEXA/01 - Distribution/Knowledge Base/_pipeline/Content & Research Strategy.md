---
type: kb-doc
id: content-research-strategy
title: "INDEXA Content & Research Strategy (drives the 3 schedules)"
research_use_only: true
tags: [kb-doc, strategy, content, seo]
---

# INDEXA Content & Research Strategy

The constitution for three automated jobs: **(1) Research Radar**, **(2) Article Engine**, **(3) Ingest**. Each scheduled run is a fresh agent with no memory — it reads this file plus the state files in `_pipeline/` and acts. This document defines the *quality bar* and *rules* so output is consistently useful, not filler.

## Why this exists

We have a deep atomic knowledge graph (54 peptides, 264 papers, mechanisms, physician transcripts, stacks). The 86 live articles do **not** yet exploit it — they're thin and generic. The payoff of all that research is articles a serious customer can *act on*: real protocols, real evidence, real sourcing guidance. Every new article must justify the atomic graph behind it.

---

## Non-negotiable quality bar

An article ships only if it clears all of these:

1. **Beats the SERP.** More useful, specific, and current than the top 3 Google results for its target keyword. If we can't beat them, pick a sharper angle.
2. **Actionable.** Contains a concrete, research-framed protocol: route, dose range, timing, duration/cycling, stacking, monitoring, and sourcing/COA guidance — drawn from our peptide notes, the `Animal-to-Human Dose Conversion` method, physician transcripts (e.g. Koniver), and stacks.
3. **Evidence-anchored.** Key claims cite a specific `kb-paper` (with PMID/DOI) or a physician `kb-transcript`, with provenance honestly labelled (clinical vs animal vs anecdote). No invented studies, no overstated certainty.
4. **Original synthesis.** Connects multiple atomic notes into an angle competitors don't have. Never a paraphrase of one source.
5. **Compliant (policy §9).** Research/educational use only. No medical/treatment advice, no "cure/treat/prevent" claims, no personalized dosing directives. Frame protocols as "what was used/reported in research." Include the research-use-only disclaimer. Exclude hazardous performance dosing (insulin/EPO/high-dose AAS, etc.).
6. **SEO-complete & internally linked** (checklists below).
7. **E-E-A-T.** Author "Indexa Labs Research Team", references section, last-updated date, accurate citations.

If a draft fails any item, fix it or downgrade scope — do not ship filler.

---

## Article archetypes (the engine picks one per run)

1. **Peptide research guide** — mechanism → evidence (human/animal split) → research protocol → forms & sourcing → cautions → FAQ. (Maps to a `kb-peptide` + its papers.)
2. **Physician / goal protocol guide** — e.g. "Dr. Koniver's BPC-157 approach to tissue repair," "GH-axis protocol for sleep & recovery." Built from `kb-transcript` + `kb-stack`. **High priority** — we have these sources and haven't written them.
3. **Comparison** — "X vs Y", "best peptides for <goal> 2026" — with honest tradeoff tables, mechanism differences, evidence grades.
4. **Mechanism / concept explainer** — "How GLP-1 agonism drives fat loss," "What cardiolipin has to do with mitochondrial aging."
5. **Stack guide** — consumer-facing version of a `STACK-*` note (fat-loss, healing, GH-sleep, longevity…), 3-layer rationale + protocol + monitoring.
6. **News-anchored** — "What ASCO 2026 actually showed about GLP-1 and cancer," fed by the Research Radar's `kb-source` notes. Fast lane for breakthroughs.
7. **Pillar hub** — a broad goal page (e.g. "Healing & Recovery Peptides") linking out to spoke articles; updated as spokes are added.

---

## SEO checklist (every article)

- **Search intent first.** Identify the primary keyword + 2–3 secondary terms and the intent (informational/commercial). Quick WebSearch to confirm what ranks and find the gap.
- **Title** ≤ 60 chars, primary keyword near the front, year when it helps freshness.
- **Slug** short, hyphenated, keyword-bearing.
- **Meta description** (the `subtitle`/abstract) ≤ 155 chars, contains keyword, written as a click-worthy promise.
- **Structure**: one H1 (the title), logical H2/H3. Keyword in the first 100 words and in at least one H2.
- **Depth**: research guides 1,500–2,500 words; explainers 1,000–1,500; match intent, never pad.
- **FAQ section** answering real "People Also Ask" questions (concise, schema-friendly).
- **External authority links**: PubMed/DOI for cited studies.
- **No keyword stuffing.** Write for humans; keyword density stays natural.
- **Freshness**: set `published`/`last_updated`; cite the most recent evidence available.

## Internal-linking rules

The website is **not** Obsidian — use real site links in the body, not wikilinks:

- Link to other articles as `[anchor](/blog/<guide-slug>)` and to products as `[anchor](/products/<product-slug>)`.
- **3–6 contextual internal links per article**, descriptive anchors (not "click here").
- Every peptide mentioned → link its article (if one exists) or its product page. Every goal mentioned → link the goal/pillar hub. Every buyable peptide → link the product page.
- **Pillar ⇄ spoke**: spokes link up to their pillar; pillars get a link added down to each new spoke.
- Pull the live link inventory at runtime: article slugs from `Articles/*.md` frontmatter (`slug`), product slugs from Supabase `products.id` (read-only query, project `gqkhhfuafflcfkjczsxg`). Only link to slugs that exist; otherwise leave plain text.
- Maintain the cluster map in `Pipeline Log.md`.

---

## Workflow — Schedule 2: Article Engine (daily 08:30)

1. Read this strategy, `Article Backlog.md`, `Pipeline Log.md`. List existing `Articles/*.md` slugs and titles to avoid duplication.
2. **Choose one topic**: highest-priority unblocked backlog item, or a fresh high-impact item from the latest Radar `kb-source` notes / an obvious keyword gap. Skip anything already covered.
3. **Gather**: read the relevant atomic notes (peptides, papers, mechanisms, transcripts, stacks, sources) + a focused WebSearch for current data and the competitor angle. Note provenance.
4. **Write** the article note in `Articles/` using the frontmatter convention (see `_publish/README — Publishing Articles.md`): `type: kb-article`, `id: ART-<slug>`, `slug`, `title`, `subtitle`, `health_goal`, `read_time`, `published`/`last_updated`, `products: [...]`, `references_raw: [...]`, optional `difficulty_level`/`research_type`, `status: draft`, `pipeline: engine`. Body: H1, italic hook, `> **Abstract:** …`, then `##` sections, internal links, references, FAQ, research-use-only disclaimer. No `db_guide_id` (brand-new guide).
5. **Self-review** against the quality bar + SEO + linking checklists. Verify every internal link target exists.
6. **Log**: append to `Pipeline Log.md` (slug, title, target keyword, cluster, date, status=draft, ingested=false). Remove the item from `Article Backlog.md`; append any new ideas discovered.
7. **Report** to the user: what was written, the angle, target keyword, internal links, sources cited, and anything that needs a human call.

One excellent article per run beats five mediocre ones.

## Workflow — Schedule 1: Research Radar (1st & 15th, 09:00)

See `Source Radar Targets.md` for the source list, standing queries, reputability bar, and discovery method. Each run: search → record genuinely new findings as `kb-source` notes (provenance-tiered) → thread into the relevant peptide/mechanism notes → expand the source list → enqueue high-impact news into `Article Backlog.md` (flag breakthroughs as P0) → write a digest. Never fabricate; WebSearch is primary, web_fetch/Chrome for full text; if a page won't render, rely on search snippets + corroboration and say so.

## Workflow — Schedule 3: Ingest (Sunday 09:00)

Find `Articles/*.md` with `status: draft` and `ingested: false` (cross-check `Pipeline Log.md`). For each, build the guide payload (`_publish/publish_articles.py` does the mapping). Push as **drafts** (`published=false`): try the Edge Function (`~/.indexa/ingest.env`, header `x-ingest-key`); if the runtime has no network, fall back to writing via the Supabase connection (upsert `guides` with `published=false`, replace `guide_sections`). Update the log (`ingested: true`, date). Report what landed and remind the user to review & publish in Supabase Studio. **Never publish live automatically.**

---

## Guardrails for all three

- Research-use-only, no medical advice, honest evidence grading, no fabrication.
- Articles are always created/ingested as **drafts** for human approval — nothing goes live without the user flipping `published=true`.
- Keep secrets out of notes (no INGEST_KEY/service keys in any file).
- Each run ends with a concise report to the user.

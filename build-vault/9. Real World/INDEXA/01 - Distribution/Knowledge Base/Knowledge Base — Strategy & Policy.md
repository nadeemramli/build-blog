---
title: "Knowledge Base — Strategy & Policy"
type: reference
date: 2026-06-01
tags: [indexa, reference, knowledge-base, content, strategy, policy]
status: draft-v1
---

# 🧠 Indexa Knowledge Base — Strategy & Policy

> **What this document is.** The constitution for Indexa's content knowledge base. It defines *how* we mirror the 82 published articles into Obsidian, *how* we decompose them into a reusable peptide knowledge graph, *how* that graph is governed and ingested into Supabase, and *how* downstream channels (TikTok, Threads) borrow from it without ever polluting it. Read this before building anything. Once approved, every scraping run, note, and content piece must comply with it.

---

## 1. North Star

Build **one canonical, interlinked body of peptide knowledge** that is true, traceable, and reusable — so that:

- Customers and researchers can learn from it (surfaced via the site / Supabase).
- Every social asset (TikTok, Threads, captions, emails) is a *derivative* of it, never an original source.
- The knowledge compounds: each new paper, anecdote, or protocol enriches existing nodes instead of spawning duplicates.

**The governing principle:** *The knowledge base states what is true. Channels decide how to say it.* Truth lives in one place; tone, voice, and platform packaging are applied on the way out, never baked in.

---

## 2. Three-Layer Architecture

```
LAYER 1 — SOURCE MIRROR        LAYER 2 — KNOWLEDGE GRAPH       LAYER 3 — CHANNEL OUTPUT
(faithful copy of the 82       (atomic, deduplicated,          (TikTok / Threads / email —
 published articles)            evidence-tagged truth)          tone-manipulated derivatives)

  Article notes  ───extract──▶  Peptide / Mechanism / Paper  ──manipulate──▶  Content posts
  (1:1 rebuild)                 Protocol / Concept notes                      (alias brands, hooks)

         └──────────── Obsidian = source of truth ────────────┘
                                  │ ingest
                                  ▼
                          Supabase (read model)
```

- **Layer 1 — Source Mirror.** A faithful 1:1 rebuild of each published article. This is the *provenance anchor* — proof of what we already say publicly, and the raw material for extraction. We do not editorialise here.
- **Layer 2 — Knowledge Graph.** Atomic notes (one peptide, one mechanism, one paper, one protocol = one note) that articles link *into*. This is the reusable, dedupe'd truth that gets enriched over time and ingested to Supabase.
- **Layer 3 — Channel Output.** Lives in the existing `Content/` pipeline, **not** in the knowledge base. Pulls facts from Layer 2, then applies channel tone/policy. Covered by [[Content — Playbook]].

**Hard rule:** Layers 1 and 2 are the source of truth. Layer 3 never writes back into them. A TikTok hook is not allowed to change what a peptide note says.

---

## 3. The Hybrid Note Model

Every piece of knowledge is one of six note types. The first two are Layer 1; the rest are Layer 2.

| Type | Tag | One note = | Purpose |
| --- | --- | --- | --- |
| **Article** | `#kb-article` | one published blog post (1:1 mirror) | Provenance + the assembled, customer-facing narrative |
| **Resource** | `#kb-resource` | one site resource/guide (dosage, reconstitution, storage, dictionary) | Mirror of evergreen tool/guide pages |
| **Peptide** | `#kb-peptide` | one compound (e.g. BPC-157) | The canonical entry for a molecule — the hub everything links to |
| **Mechanism** | `#kb-mechanism` | one biological pathway/action (e.g. angiogenesis, GH secretagogue) | Cross-functional concept reused across peptides |
| **Paper** | `#kb-paper` | one study / citation (PubMed/PMC) | Evidence node — the acute breakdown of a single paper |
| **Concept** | `#kb-concept` | one reusable idea (e.g. reconstitution, COA, half-life, stacking) | Glossary-grade building blocks |
| **Transcript** | `#kb-transcript` | one external source (podcast/talk/interview transcript) | Layer-1 anecdote source — `provenance: anecdote`; its claims thread into peptide notes' Anecdotes/Protocols sections |
| **Source** | `#kb-source` | one reputable external reference (journal/conference/oncology network) | Higher-tier external evidence (`provenance: literature`) — e.g. ASCO/JAMA findings; cited like transcripts but weighted above anecdote |
| **Supplement** | `#kb-supplement` | one non-peptide nutritional adjunct (CoQ10, NAD, methylene blue, glycine) | Adjunct entity — dose/route/timing/intake/mechanism; linked from stacks |
| **Compound** | `#kb-compound` | one **non-peptide therapeutic** (MK-677, orforglipron, enclomiphene, clomiphene, cardarine) | Non-peptide drugs (SERMs, small-molecule GH/GLP-1 agonists, etc.) that act on the same mechanisms as peptides but aren't peptides — kept honest rather than mislabeled `kb-peptide` |
| **Behavior** | `#kb-behavior` | one lifestyle/behavioral intervention (sauna, cold plunge, Zone 2, HIIT, fasting, sleep, sunlight) | Behavioral layer — the non-pharmacological inputs that compose into stacks alongside peptides/supplements |
| **Stack** | `#kb-stack` | one combination protocol (**peptides + supplements + behaviors**) | **Layer 3 (applied)** — synergy rationale, timing, intake, cycling, cautions, monitoring |
| **Method** | `#kb-method` | one cross-cutting methodology/reference (e.g. animal→human dose conversion) | Reference playbooks for working with the data — the convention for turning animal-study doses into traceable human-equivalent breakdowns |

**Why hybrid (vs. 1:1-only or fully-atomic):** the article mirror preserves SEO structure and provenance; the atomic layer is what makes the base a *graph* — reusable, enrichable, and clean to ingest. Articles become thin assemblies that link to fat, canonical concept notes. One fact (e.g. BPC-157's angiogenesis mechanism) is written **once** in the Peptide/Mechanism note and *referenced* by every article that touches it.

**Anti-duplication law:** if a fact belongs to a peptide, mechanism, paper, or concept, it is written in that atomic note and linked — never re-typed inside an article. Articles narrate and contextualise; atomic notes hold the truth.

---

## 4. Folder Structure

New home: `01 - Distribution/Knowledge Base/`. This is the "compile all content pillars" folder.

```
01 - Distribution/
└── Knowledge Base/
    ├── Knowledge Base — Strategy & Policy.md   ← this file
    ├── _Templates/
    │   ├── _Template — Article.md
    │   ├── _Template — Peptide.md
    │   ├── _Template — Mechanism.md
    │   ├── _Template — Paper.md
    │   └── _Template — Concept.md
    ├── Articles/            ← Layer 1: 86 mirrored posts
    ├── Resources/           ← Layer 1: dosage, reconstitution, storage, dictionary
    ├── Transcripts/         ← Layer 1: external anecdote sources (podcasts/talks)
    ├── Sources/             ← Layer 1: reputable external references (journals, conferences, oncology networks)
    ├── Peptides/            ← Layer 2: one note per compound
    ├── Mechanisms/          ← Layer 2: pathways / actions
    ├── Papers/              ← Layer 2: cited studies
    ├── Concepts/            ← Layer 2: glossary building blocks
    ├── Supplements/         ← Layer 2: non-peptide nutritional adjuncts (CoQ10, NAD, …)
    ├── Compounds/           ← Layer 2: non-peptide therapeutics (MK-677, orforglipron, SERMs, …)
    ├── Behaviors/           ← Layer 2: lifestyle interventions (sauna, cold, Zone 2, HIIT, fasting, sleep, sunlight)
    ├── Stacks/              ← Layer 3: applied protocols (peptides + supplements + behaviors)
    ├── Methods/             ← cross-cutting reference methods (animal→human dose conversion, …)
    └── Bases/
        ├── Articles.base
        ├── Peptides.base
        └── Papers.base
```

Channel output stays where it already lives: `01 - Distribution/Content/` (Layer 3). The knowledge base feeds it; they do not merge.

---

## 5. Note Schemas (frontmatter)

Aligned to [[Data Model & Conventions]] golden rules: *frontmatter is the data, filename = ID, dates are ISO, money is numeric, cross-links are wikilinks, tag drives the Base.*

### Article — `#kb-article`
```yaml
type: kb-article
id: ART-bpc-157-complete-guide-2026
title: "BPC-157 Complete Guide 2026: Benefits & Dosing"
slug: bpc-157-complete-guide-2026
source_url: https://indexalabs.com/blog/bpc-157-complete-guide-2026-benefits-dosing
published: 2026-03-10
cohort: seo-2026            # or product-2025
pillar: education           # education | product | social-proof | promo | research
primary_peptide: "[[BPC-157]]"
peptides: ["[[BPC-157]]"]
mechanisms: ["[[Angiogenesis]]", "[[Cytoprotection]]"]
papers: ["[[PMID-12345678]]"]
products: [bpc-157]         # storefront slugs (Supabase), NOT vault notes — plain strings, never wikilinks
target_keyword: "bpc-157 dosing"
scrape_status: mirrored     # pending | mirrored | extracted | verified
content_hash: ""            # sha256 of source body, for re-scrape diffing
tags: [kb-article]
```

### Peptide — `#kb-peptide`  (the hub note)
```yaml
type: kb-peptide
id: BPC-157
title: "BPC-157"
aliases: ["Body Protection Compound-157", "PL 14736"]
category: tissue-repair     # matches site category taxonomy
sequence: "GEPPPGKPADDAGLV"
molar_mass: 1419.5
half_life: "~4 hours (subcutaneous, est.)"
mechanisms: ["[[Angiogenesis]]", "[[Cytoprotection]]"]
stacks_with: ["[[TB-500]]"]
papers: ["[[PMID-12345678]]"]
product: bpc-157            # storefront slug (Supabase), NOT a vault note — plain string
forms: []                   # extra product slugs that are delivery-forms of this compound
is_blend: false             # true for blends; then list components as wikilinks
components: []              # for blends only: ["[[BPC-157]]", "[[TB-500]]"]
evidence_tier: B            # S | A | B | C | D (Research-pillar tier list)
research_use_only: true
tags: [kb-peptide]
```

### Mechanism — `#kb-mechanism`
```yaml
type: kb-mechanism
id: Angiogenesis
title: "Angiogenesis"
domain: vascular            # vascular | metabolic | neuro | immune | hormonal | dermal
peptides: ["[[BPC-157]]", "[[GHK-Cu]]"]
papers: ["[[PMID-12345678]]"]
tags: [kb-mechanism]
```

### Paper — `#kb-paper`  (evidence node)
```yaml
type: kb-paper
id: PMID-12345678
title: "Pentadecapeptide BPC 157 and tendon healing"
authors: "Sikiric P, et al."
year: 2014
journal: "J Orthop Res"
doi: "10.1002/jor.xxxxx"
pmid: 12345678
url: https://pubmed.ncbi.nlm.nih.gov/12345678/
model: animal              # in-vitro | animal | human-rct | human-obs | review
peptides: ["[[BPC-157]]"]
mechanisms: ["[[Angiogenesis]]"]
evidence_weight: moderate  # strong | moderate | weak | anecdotal
tags: [kb-paper]
```

### Concept — `#kb-concept`
```yaml
type: kb-concept
id: Reconstitution
title: "Reconstitution"
related: ["[[Bacteriostatic Water]]", "[[Storage & Handling]]"]
tags: [kb-concept]
```

**Enrichment fields** (added over time, never overwriting source): atomic notes carry free-text body sections for `## Anecdotes`, `## Physician protocols`, `## Practical notes`, each line provenance-tagged (see §9).

---

## 6. Naming & ID Conventions

Extends the existing ID table in [[Data Model & Conventions]]:

| Entity | Pattern | Example |
| --- | --- | --- |
| KB Article | `ART-<slug>` (filename = article title) | `ART-bpc-157-complete-guide-2026` |
| Peptide | `<COMPOUND>` (filename = common name) | `BPC-157` |
| Mechanism | `<Name>` | `Angiogenesis` |
| Paper | `PMID-<id>` or `DOI-<id>` | `PMID-12345678` |
| Concept | `<Name>` | `Reconstitution` |

Rules: filename matches the human-readable title so `[[BPC-157]]` resolves naturally; `id` in frontmatter is the stable machine key for Supabase. Slugs mirror the live URL exactly so we can round-trip to the site.

---

## 7. Interlinking & SEO Policy

The link graph *is* the SEO asset. Rules:

1. **Every article links to its primary peptide** and to every mechanism/paper it cites. No orphan articles.
2. **Hub-and-spoke:** Peptide notes are hubs. Articles, papers, and mechanisms spoke into them. A peptide hub should be reachable in ≤2 hops from any related note.
3. **Reciprocal links:** if an article links a peptide, the peptide's `peptides`/related list need not list every article (Bases derive that), but mechanism↔peptide and peptide↔paper links are maintained on both ends.
4. **Cluster topology mirrors site categories** (GLP-1/Metabolic, Growth Hormone, Tissue Repair, Nootropics, etc.) so internal-link clusters map to the site's category silos — this is what compounds ranking.
5. **Comparison articles** ("X vs Y", "best peptides for…") must link *both/all* peptides and the relevant mechanism — these are the highest-value link hubs.
6. **Anchor text = descriptive**, never "click here". Wikilink display text should read as the target keyword where natural.
7. **No dead links.** A `[[wikilink]]` to a not-yet-created atomic note is allowed (it marks a stub to fill) but stubs are tracked and burned down before ingestion.

---

## 8. Scraping Methodology & Policy

**Source of record:** the live site sitemap (`indexalabs.com/sitemap.xml`) — already confirmed to list **82 `/blog/` URLs** plus resources and product pages. The sitemap is the canonical work list, not the rendered `/blog` index.

**The 82 split into two cohorts** (drives `cohort` field and review priority):

- **`product-2025`** (~40 posts, lastmod 2025-01) — one-per-product research guides aligned to SKUs.
- **`seo-2026`** (~42 posts, lastmod 2026-03) — comparison, "best-of", dosing, and delivery-method articles built for search.

**Method (per article):**

1. Pull the URL list from the sitemap; write a manifest (`Bases/Articles.base` seeded as `scrape_status: pending`).
2. Fetch each article. The site is partly client-rendered, so the pipeline must render JS (browser-based fetch) rather than raw HTML when the body is empty.
3. Convert HTML body → clean Markdown (headings, lists, tables preserved; nav/footer/boilerplate stripped).
4. Write the **Article note** (Layer 1) with full frontmatter, `source_url`, and a `content_hash` of the source body.
5. Set `scrape_status: mirrored`.

**Extraction (Layer 1 → Layer 2), per article:**

6. Identify the peptide(s), mechanism(s), and any cited papers. Create/append the atomic notes (don't duplicate — link if they exist).
7. Replace inline factual claims in the article with links to the atomic notes that own them.
8. Set `scrape_status: extracted`, then `verified` after the §9 review.

**Re-scrape policy:** on a scheduled cadence, re-fetch and compare `content_hash`. If changed, flag the article for re-mirror + re-extract so the base never drifts from the live site.

**Politeness & integrity:** scrape our own site only, throttle requests, preserve published dates, never invent content that isn't on the page. Mirrors are faithful; *interpretation* happens only in Layer 2 with citations.

---

## 9. Provenance, Enrichment & Citation Policy

The base's value is trust, so every claim is traceable.

- **Three provenance classes**, tagged on each enrichment line/section:
  - `[indexa]` — already published by us (from a mirrored article).
  - `[literature]` — backed by a `[[PMID-…]]` paper note (Research pillar).
  - `[anecdote]` / `[protocol]` — community report or physician protocol; explicitly marked as such, never presented as established fact.
- **No unsourced claims** enter Layer 2. If it can't be tagged to one of the above, it doesn't get written.
- **Evidence tiers** (`evidence_tier` S→D on peptides, `evidence_weight` on papers) power the "Most Researched Peptides Tier List" Research-pillar asset and let channels signal confidence honestly.
- **Stack backing (mandatory):** every synergy, dosing, timing, intake, and cycling claim in a `kb-stack` must trace to a `[[paper]]` (literature) or a named applied-protocol source (`[[transcript]]`, e.g. a physician). The stack's `backed_by:` frontmatter lists them, and the `## Evidence backing` section maps claims → sources. A stack with unbacked claims stays draft, never `verified`. Dosing/timing figures are recorded as **cited research / applied-protocol information under research-use framing** — never as personalised medical advice.
- **Compliance guardrail (non-negotiable):** every peptide/article note carries `research_use_only: true`, and no note makes medical-treatment or dosing-for-humans claims. Framing is research/educational throughout — consistent with the site's own "research and educational purposes only" stance. This guardrail propagates to Layer 3.

---

## 10. Supabase Ingestion Model

Obsidian is the **source of truth (write side)**; Supabase is the **read model** the site/app queries. **The forward pipeline already exists** — it does not need to be built.

**What's already live (project `gqkhhfuafflcfkjczsxg`):**

- The `ingest-content` Edge Function (`/functions/v1/ingest-content`, auth via scoped `x-ingest-key`) maps note frontmatter → the live storefront tables: `guides` (+ `guide_sections`, `guide_products`) and `products` (+ research/variants/prices/images/tags). Upserts by slug; everything lands `published = false` (draft) until reviewed in Studio.
- **86 published `guides`** plus `guide_sections` are the canonical blog content. This KB's Layer-1 Articles folder was **backfilled one-time from those rows** (Supabase → vault) so the vault becomes the forward author-source. From here, edits flow vault → `ingest-content` → Supabase draft → publish.

**The gap — the atomic graph has no DB home yet.** The live schema stores articles (`guides`) and `products`, but **not** the Layer-2 atomic notes (peptides, mechanisms, papers, concepts). Decision needed (see §14): either (a) add `kb_peptides` / `kb_mechanisms` / `kb_papers` / `kb_concepts` + join tables and extend `ingest-content` to populate them, or (b) keep the atomic graph vault-side only and surface it to customers via RAG/embeddings rather than relational tables.

**Direction stays one-way:** vault → Supabase (via `ingest-content`). Supabase rows are never hand-authored as the source; the vault is. The one exception was this initial backfill, now complete.

---

## 11. Knowledge → Content Manipulation Layer (Layer 3)

This is the bridge to TikTok/Threads, governed by [[Content — Playbook]]. The knowledge base supplies *what's true*; the playbook supplies *how each channel speaks*.

- **One-way borrow.** A content post references the atomic notes it draws from (`source_notes: ["[[BPC-157]]"]`) so we can trace any claim back to the base. Posts never edit the base.
- **Channel tone is applied on extraction, not stored in the base.** The peptide note is neutral and evidence-led; the TikTok script is punchy; the Threads alias post is community-voiced. Same fact, three packagings.
- **Threads alias rule (from memory, preserved):** Threads posts run under disposable alias brands, never as INDEXA — but the *facts* still come from the INDEXA base. The base is brand-neutral truth; the alias is just a delivery vehicle.
- **Research pillar** pulls directly from `kb-paper` notes and the tier list — this is the trust engine for the knowledge-minded Threads audience.
- **Guardrail inheritance:** `research_use_only` and the no-medical-claims rule carry into every derived asset automatically.

---

## 12. Governance — Source of Truth Rules

1. **Single source of truth:** Layer 1 + Layer 2 in Obsidian. The live site and Supabase are *projections*; social posts are *derivatives*.
2. **One thing, one note** (inherited golden rule). Facts are written once in the atomic note that owns them.
3. **Frontmatter is the data**; the body is context + provenance-tagged enrichment.
4. **No fact without provenance** (§9). No medical/treatment claims, ever.
5. **Mirrors stay faithful; interpretation stays cited.** Editorialising happens only in Layer 2, against papers.
6. **Changes flow downhill:** vault → Supabase → site/app; vault → playbook → channels. Never upward.
7. **Stubs are debt:** unfilled `[[links]]` are tracked and burned down before a cluster is marked `verified`.

---

## 13. Build Roadmap

| Phase | Deliverable | Status |
| --- | --- | --- |
| **0. Strategy** | This document, approved | ✅ done |
| **1. Scaffold** | Folder tree + 5 note templates + 3 Bases (manifest seeded from sitemap, 86 rows `pending`) | ✅ done |
| **2. Mirror** | All 86 articles backfilled from Supabase `guides`/`guide_sections` as Layer-1 notes (`mirrored`, 455 sections) | ✅ done |
| **3. Extract** | Peptide/Mechanism/Paper/Concept atomic notes created; articles re-linked (`extracted`). Seed papers from `references_raw`. | ⬅ next |
| **4. Verify** | Provenance + compliance pass; stubs burned down (`verified`) | |
| **5. Ingest (forward)** | `ingest-content` Edge Function already live (vault → Supabase drafts). Extend to atomic graph **only if** §14.6 picks relational tables. | partial — forward pipeline exists |
| **6. Operate** | Re-sync cadence + content-borrow workflow into Layer 3 | |

---

## 14. Open Decisions — need your call before Phase 1

1. **Atomic depth for the first pass.** Mirror all 82 first (Phase 2 complete) *then* extract, or do mirror+extract article-by-article? *(Recommend: mirror all 82 first — faster to a complete Layer 1, cleaner dedupe in extraction.)*
2. **Papers scope.** Do articles already cite specific PubMed IDs we can harvest, or do we build `kb-paper` notes from scratch during extraction? *(Changes Phase 3 effort significantly.)*
3. **Supabase + GitHub access.** Share the Supabase project (schema/keys) and the vault's git repo if you want CI-driven ingestion — otherwise I'll spec a manual export script.
4. **Bases vs. backlinks for reverse edges.** Confirm we rely on Obsidian Bases to derive "articles mentioning peptide X" rather than maintaining reverse lists by hand (recommended — less drift).
5. **Resource pages.** Include all six site resources (dosage, reconstitution, calculator, storage, payment, dictionary) as `kb-resource`, or only the science-bearing ones (exclude payment)? *(Recommend: exclude payment-guide — not knowledge.)*
6. **Atomic-graph DB home.** The live schema has `guides` + `products` but no home for peptide/mechanism/paper/concept notes. Either (a) add `kb_*` tables + join tables and extend `ingest-content`, or (b) keep the atomic graph vault-side and serve it to customers via RAG/embeddings. *(Recommend: start with (b) — the graph is for learning/retrieval, not storefront rows; relational tables can come later if a feature needs them.)*

---

*Phases 0–2 are complete: strategy approved, vault scaffolded, all 86 articles mirrored from Supabase. Next is Phase 3 — extracting the atomic peptide/mechanism/paper graph and re-linking the articles into it.*

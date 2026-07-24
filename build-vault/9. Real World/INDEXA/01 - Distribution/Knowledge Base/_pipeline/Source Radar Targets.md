---
type: kb-doc
id: source-radar-targets
title: "Source Radar — reputable sources, queries & discovery method"
tags: [kb-doc, research, radar]
---

# Source Radar — targets & method

Drives Schedule 1 (Research Radar). Goal: catch new peptide-relevant evidence fast — new human trials, oncology/metabolic findings, approvals, major reviews — and record them as `kb-source` notes threaded into the graph.

## Reputability bar (a source must clear this to be recorded)

Peer-reviewed journal, named authors with institutional affiliation, a registered trial, or a recognised conference/oncology network reporting same. Tier honestly in the note:
`literature` (journal/trial) > `clinical-observational` > `conference` > `educational` (named-expert explainer) > `anecdote` (forum/marketing — usually skip).

## Standing sources to check each run

- **PubMed** — newest results for our priority compounds (filter to recent).
- **ClinicalTrials.gov** — new/updated peptide trials & results.
- **ASCO / The ASCO Post / Oncology Central** — oncology + GLP-1/metabolic-peptide signals (the seed source: https://www.oncology-central.com/).
- **High-impact journals** for peptides/metabolism: JAMA Network Open, NEJM, Cell Metabolism, Nature Reviews Endocrinology, Br J Pharmacol, Bull Exp Biol Med (Khavinson/Russian peptide work).
- **Examine.com** — evidence summaries (good for corroboration).
- **Named physician/educator outputs** — Koniver, Attia, Huberman Lab (educational tier; for protocols/angles, not as primary evidence).
- **Sponsor pivotal-trial topline releases** — e.g. Eli Lilly / Novo Nordisk investor newsrooms (added 2026-06-15). High-signal for Phase 3 readouts *before* peer-reviewed publication, but **always corroborate with ≥2 independent medical outlets** and label "topline tier" — never record on a press release alone.
- **Diabetes, Obesity and Metabolism** (Wiley) — added 2026-06-15; peer-reviewed home for GLP-class trial design/readout papers (e.g. TRIUMPH design paper).
- **Reputable trial-news corroborators** — Healio, AJMC, TCTMD, Pharmacy Times, Fierce Biotech/Pharma (added 2026-06-15; corroboration tier, not primary).
- **ADA Scientific Sessions** — added 2026-07-01; the annual diabetes/metabolic conference and the primary venue where GLP-class Phase 3 obesity/metabolic readouts land (e.g. survodutide SYNCHRONIZE-1/-MASLD, 2026). Conference tier; pairs with simultaneous NEJM/Nature Medicine publication.
- **JCO Oncology Practice** (ASCO journal) & **Nature Medicine** — added 2026-07-01; peer-reviewed homes for, respectively, ASCO real-world/oncology-practice analyses (GLP-1 breast-cancer incidence) and high-impact obesity Phase 3 co-publications (survodutide). Literature tier.
- **FDA Advisory Committee Calendar + Federal Register / Regulations.gov dockets** — added 2026-07-01; the **PRIMARY** source for US peptide *regulatory* events (PCAC 503A bulk-list reviews, Category-1/2 changes, FDA briefing documents). Label **"regulatory" tier — NOT efficacy evidence**; corroborate interpretation with National Law Review, Lengea Law, BSCG, Pharmacy Times. Watch this for anything touching catalog peptides (BPC-157/TB-500/MOTS-c/KPV/DSIP/Semax/Epitalon/GHK-Cu/Melanotan II). **Note (2026-07-15): the per-substance FDA briefing PDFs (fda.gov/media/193343–193349) contain the agency's OWN recommendation — read them, not just the agenda; this run they recommended against listing all 7.**
- **The Lancet** — added 2026-07-15; peer-reviewed home for large peptide **neuro / cross-indication** Phase 3 readouts (e.g. semaglutide EVOKE/EVOKE+ in early Alzheimer's). Literature tier; pairs with the neuro conferences below. Qualifies as a top-tier general medical journal already used as a corroborator (ACHIEVE-3) — now promoted to a standing primary venue for non-metabolic GLP-class trials.
- **CTAD (Clinical Trials on Alzheimer's Disease) & AD/PD conferences** — added 2026-07-15; the venues where GLP-1 (and other peptide) **neurodegeneration** trials first present before/with journal publication (EVOKE topline → CTAD 2025 / AD-PD 2026 → Lancet). Conference tier; watch for any catalog-adjacent peptide (semaglutide, DSIP, Semax, Selank) tested for cognition. Corroborate with NeurologyLive, Neurology Advisor, Medscape, Alzheimer's Drug Discovery Foundation (ADDF) and Alzheimer Europe.

## Standing search queries (run with a recency filter)

- "BPC-157 human clinical trial" / "BPC-157 randomized"
- "TB-500 / thymosin beta-4 clinical trial"
- "GLP-1 receptor agonist cancer" / "semaglutide tirzepatide retatrutide outcomes 2026"
- "tesamorelin trial" / "growth hormone secretagogue trial"
- "MOTS-c human study" / "mitochondrial peptide SS-31 elamipretide trial"
- "epitalon / pineal peptide telomere clinical"
- "new peptide therapeutic approval 2026"
- One query per priority peptide we sell, "+ trial OR study 2026".

## Discovery method (grow the list every run)

1. From each strong new finding, harvest its **journal, authors, and citing/cited works** → add recurring high-quality venues/authors to this file.
2. Follow **citation networks**: a new BPC-157 trial → check the group's other work and who cites it.
3. Track **conferences** (ASCO, ENDO, ADA) for peptide-adjacent abstracts.
4. Add any new outlet that clears the reputability bar; note *why* it qualifies.

## Output per run

- New `kb-source` note in `Sources/` per finding (frontmatter: type kb-source, id SOURCE-…, title, publisher, url, provenance, evidence, captured date, linked peptides/mechanisms, research_use_only, tags) + a short "Key findings / Why it matters / Caveats / Corroboration" body.
- Thread the finding into the relevant `Peptides/` and `Mechanisms/` notes (add to `sources:` and a one-line note in the body).
- Append article ideas to `Article Backlog.md` (P0 for breakthroughs).
- Update "Last run" + new sources discovered, below.
- Digest to the user: what's new, impact, what was enqueued.

## Log

- Last run: **2026-07-15** — 2 new `kb-source` notes recorded + 1 existing note materially updated. Highest-impact: **FDA staff briefing documents recommend AGAINST adding all 7 peptides to the §503A Bulks List** (BPC-157, KPV, TB-500, MOTS-c, Emideltide/DSIP, Semax, Epitalon) ahead of the July 23–24 2026 PCAC vote — inadequate characterization + little/no human effectiveness for the injectable routes + insufficient safety/immunogenicity data; the agency **staff** position (not the Committee vote, which is Jul 23–24, and not final rulemaking). Recorded as a dated **Update block on the existing** [[SOURCE-fda-pcac-503a-peptide-review-2026]] (regulatory tier; primary = the 7 FDA briefing PDFs + Federal Register public-inspection 2026-07361; corroborated by Newtropin, Drug Topics, Peptide Hub, HealingMaps, BioInfinity, American Med Spa Assoc) and threaded as a 2026-07-15 `[regulatory]` line into BPC-157/TB-500/MOTS-c. New notes: **semaglutide EVOKE/EVOKE+ Alzheimer's Phase 3 FAILURE** (Lancet 2026 — 3,808 pts, CDR-SB primary missed at 104 wk, honest negative that tempers the "GLP-1 −45% dementia-risk" claim; threaded into Semaglutide/GLP-1 Agonism/Neuroprotection) and **CagriSema REDEFINE-1/-2** (amylin/GLP-1 combo, 20.4%/13.7%, NEJM 2025 + NDA filed, FDA decision late 2026; fills the empty Amylin Agonism mechanism + upgrades Cagrilintide from tier-C; threaded into Cagrilintide/Semaglutide/Amylin Agonism/GLP-1 Agonism). Retatrutide TRIUMPH-2/-3 still pending (P1 stays queued). **Skipped (not corroborated to a primary journal — content-farm only):** an SS-31 "PROGRESS-HFpEF Phase 3 (JACC Feb 2026)" claim and a "Badran & Helal 2026 tesamorelin meta-analysis" — flagged to re-check, NOT recorded (no fabrication). Pages fetched cleanly (ADA press release); no fetch workaround used.
  - Newly discovered sources (this run):
    - `SOURCE-semaglutide-evoke-alzheimers-phase3-2026` — semaglutide EVOKE/EVOKE+ Alzheimer's Phase 3 negative (Lancet 2026; literature).
    - `SOURCE-cagrisema-redefine-phase3-2026` — CagriSema REDEFINE-1/-2 amylin/GLP-1 combo Phase 3 (ADA 2025 / NEJM; literature).
    - (updated) `SOURCE-fda-pcac-503a-peptide-review-2026` — added the 2026-07-15 FDA "do not add" briefing-document recommendation.
  - New venues added to the standing list (this run): The Lancet (peptide neuro/cross-indication Phase 3); CTAD & AD/PD conferences (peptide neurodegeneration readouts) + their corroborators (NeurologyLive, Neurology Advisor, Medscape, ADDF, Alzheimer Europe); plus a note to read the FDA per-substance briefing PDFs (agency recommendation), not just the agenda.
- Last run: **2026-07-01** — 4 new `kb-source` notes recorded. Highest-impact: **FDA PCAC 503A peptide review (July 23–24 2026)** — the agency will vote on adding BPC-157, TB-500, MOTS-c, KPV, DSIP, Semax & Epitalon to the §503A compounding bulk-list; anchored on the FDA.gov advisory-committee page (7 briefing PDFs + docket FDA-2025-N-6895) and the Feb-2026 HHS Category-2 removal of ~12 peptides. Also recorded: **GLP-1 → lower breast-cancer INCIDENCE** (ASCO 2026 Abstract 10506 / JCO Oncology Practice — a new prevention axis distinct from the two existing progression/outcomes notes), the **first registered human RCT of MOTS-c** (NCT07505745, Phase 2a prediabetes, recruiting), and **survodutide SYNCHRONIZE-1 Phase 3** (16.6% weight loss, liver fat −63%; ADA 2026 / NEJM + Nature Medicine). Retatrutide TRIUMPH-2/-3 still **pending** (fast-lane P1 remains queued). SS-31/elamipretide Barth approval already captured (skipped). ClinicalTrials.gov pages JS-rendered → relied on registry-confirmed snippets + corroboration; FDA.gov + ASCO Post fetched cleanly (no workaround used). Notably **resolved** the July-23-2026 PCAC claim that the `does-tb-500-have-human-trials` article had flagged as uncorroborated.
  - Newly discovered sources (this run):
    - `SOURCE-fda-pcac-503a-peptide-review-2026` — FDA PCAC 503A vote on 7 peptides (regulatory tier).
    - `SOURCE-glp1-breast-cancer-incidence-mcdonald-2026` — GLP-1 RA → lower breast-cancer incidence (ASCO 2026 / JCO OP; clinical-observational).
    - `SOURCE-motsc-prediabetes-phase2a-nct07505745` — first registered human MOTS-c RCT (recruiting).
    - `SOURCE-survodutide-synchronize1-phase3-2026` — survodutide Phase 3 obesity readout (ADA 2026; NEJM + Nature Medicine).
  - New venues added to the standing list (this run): ADA Scientific Sessions; JCO Oncology Practice; Nature Medicine; FDA Advisory Committee Calendar + Federal Register/Regulations.gov dockets (regulatory tier).
- Last run: **2026-06-15** — 3 new `kb-source` notes recorded; 1 existing GLP-1/cancer note extended with 2026 corroboration. Highest-impact: **Retatrutide TRIUMPH-1 Phase 3** (up to 28.3% weight loss). SS-31 Barth-syndrome approval checked but **already captured** in the SS-31 note (skipped, no duplicate). ClinicalTrials.gov + Lilly pages were JS-rendered/empty → relied on search snippets + multi-outlet corroboration (per rules; no fetch workaround used).
- Newly discovered sources (this run):
  - `SOURCE-retatrutide-triumph1-phase3` — Retatrutide TRIUMPH-1/-4 Phase 3 (Lilly topline + 5 corroborators).
  - `SOURCE-bpc157-hamstring-rct-nct07437547` — first registered BPC-157 RCT (acute hamstring strain; recruiting).
  - `SOURCE-tb500-ascvd-rct-nct07487363` — first registered TB-500 (TB4 17–23) human trial (Phase 1/2, stable ASCVD).
- New venues added to the standing list (this run): sponsor pivotal-trial topline releases (corroborate-before-recording rule), *Diabetes Obesity & Metabolism*, and reputable trial-news corroborators (Healio/AJMC/TCTMD/Pharmacy Times/Fierce).

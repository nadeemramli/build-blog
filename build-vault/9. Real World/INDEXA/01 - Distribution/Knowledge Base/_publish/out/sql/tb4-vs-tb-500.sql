-- guide: tb4-vs-tb-500
insert into public.guides
(id, slug, title, subtitle, health_goal, abstract, published_date, last_updated, read_time,
 references_list, tags, status, author, difficulty_level, research_type, source, published)
values (
 $IDX$tb4-vs-tb-500$IDX$, $IDX$tb4-vs-tb-500$IDX$, $IDX$TB4 vs TB-500: Why the Full Peptide Beats the Fragment$IDX$, $IDX$TB4 vs TB-500 explained: TB-500 is just a 7-amino-acid fragment of the full 43-aa thymosin β4 — and almost all the healing research uses TB4, not TB-500.$IDX$,
 $IDX$tissue-repair$IDX$, $IDX$TB4 vs TB-500 is the most common point of confusion in healing peptides: TB-500 is only the 7-amino-acid actin-binding fragment (LKKTETQ) of the full 43-amino-acid peptide thymosin β4 (TB4). Because almost every tissue-repair study was run on full-length TB4 — not the fragment — the evidence does not transfer one-to-one, which is why understanding the distinction matters before you compare, source, or stack either one.$IDX$,
 $IDX$2026-06-11$IDX$::date,
 $IDX$2026-06-11$IDX$::date,
 9,
 $IDX$["Bock-Marquette, I., et al. (2004). Thymosin beta4 activates integrin-linked kinase and promotes cardiac cell migration, survival and cardiac repair. Nature, 432(7016), 466-472. doi:10.1038/nature03000. PMID 15565145.", "Philp, D., et al. (2004). Thymosin beta 4 increases hair growth by activation of hair follicle stem cells. FASEB Journal, 18(2), 385-387.", "Goldstein, A. L., Hannappel, E., & Kleinman, H. K. (2005). Thymosin beta4: actin-sequestering protein moonlights to repair injured tissues. Trends in Molecular Medicine, 11(9), 421-429.", "Educational study-synthesis (licensed-MD secondary source): TB4/TB500 deep dive, summarising TB4 human trials in chronic skin wounds (phase-2, ~73 patients), corneal/dry-eye healing (phase-3, ~18 patients), and a cardiac stem-cell pilot (~10 patients). Provenance: educational/anecdote, not primary literature."]$IDX$::jsonb, $IDX$[]$IDX$::jsonb, NULL,
 $IDX$Indexa Labs Research Team$IDX$,
 $IDX$intermediate$IDX$,
 NULL,
 $IDX${"obsidian_path": "Articles/tb4-vs-tb-500.md"}$IDX$::jsonb, false)
on conflict (id) do update set
 slug=excluded.slug, title=excluded.title, subtitle=excluded.subtitle, health_goal=excluded.health_goal,
 abstract=excluded.abstract, published_date=excluded.published_date, last_updated=excluded.last_updated,
 read_time=excluded.read_time, references_list=excluded.references_list, tags=excluded.tags,
 status=excluded.status, author=excluded.author, difficulty_level=excluded.difficulty_level,
 research_type=excluded.research_type, source=excluded.source, published=false, updated_at=now();
delete from public.guide_sections where guide_id=$IDX$tb4-vs-tb-500$IDX$;
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$tb4-vs-tb-500__tb4-vs-tb-500-the-one-sentence-answer$IDX$, $IDX$tb4-vs-tb-500$IDX$, $IDX$TB4 vs TB-500: the one-sentence answer$IDX$, $IDX$**TB4 (thymosin β4) is the complete 43-amino-acid peptide. TB-500 is only a 7-amino-acid fragment of it (residues 17–23, the sequence LKKTETQ).** The fragment carries TB4's central actin-binding site, so it reproduces *some* of TB4's activity — but it is missing every other functional region of the parent molecule. The practical consequence: nearly all the tissue-repair evidence was generated with full-length TB4, and those findings do not translate cleanly to the fragment.

That is the inversion most search results get wrong. Several popular vendor pages claim TB-500 "focuses on muscle repair" while TB4 handles skin and cell migration — but the bulk of the musculoskeletal, cardiac, and wound data was run on TB4 itself. TB-500 alone has surprisingly little direct evidence that it even works at the level people assume.$IDX$, 0);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$tb4-vs-tb-500__what-tb4-actually-is$IDX$, $IDX$tb4-vs-tb-500$IDX$, $IDX$What TB4 actually is$IDX$, $IDX$Thymosin β4 is a **beta-thymosin** — a family of small proteins found in essentially every nucleated cell, where TB4 is both the most abundant and the most studied member. It is structurally and functionally distinct from the **alpha-thymosins** like [thymosin alpha-1](/blog/thymosin-alpha-1-immune-modulation), which are immune-signalling peptides rather than structural-repair ones. Confusing "thymosin" as one thing is a second, separate source of error.

TB4 is best understood as a multi-segment molecule, where different stretches of the 43-amino-acid chain do different jobs:

- **Residues 17–23 (the part TB-500 copies):** binds G-actin, stabilising the actin building blocks cells use to crawl. This drives **cell migration** and **angiogenesis** — endothelial cells migrating to line new blood vessels. This is the core repair engine, and the only piece TB-500 reproduces. The actin-sequestering role and its repurposing for tissue repair were characterised by Goldstein and colleagues, who described TB4 as an actin-sequestering protein that "moonlights" to repair injured tissue.
- **The first 4 residues:** anti-inflammatory and **anti-scar** activity.
- **The first 15 residues:** pro-survival / **anti-apoptotic** signalling — keeping stressed cells alive long enough to repair.
- **Additional regions:** antimicrobial activity plus gene- and signalling-pathway activation.

TB-500 contains the first item on that list and none of the rest. So the fragment can plausibly help with the actin-migration arm of healing, but the anti-scar, pro-survival, and antimicrobial contributions of the parent peptide are simply absent.$IDX$, 1);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$tb4-vs-tb-500__the-evidence-what-was-studied-and-on-which-molecule$IDX$, $IDX$tb4-vs-tb-500$IDX$, $IDX$The evidence: what was studied (and on which molecule)$IDX$, $IDX$Here is the part that decides the comparison. Provenance matters, so each claim below is labelled — human clinical, animal, or educational-synthesis.

**Human data (all on TB4, not the fragment):**

- **Skin / chronic wounds — strongest human signal.** A phase-2 trial (~73 patients) reported accelerated chronic-wound healing by roughly a month, using a topical 0.03% gel daily for up to three months. *(Provenance: educational synthesis of clinical data.)*
- **Eye / cornea.** A phase-3 trial (~18 patients) reported corneal healing of about 60% vs 13% on placebo and improvement in moderate-to-severe dry eye, using a 0.1% solution dosed 4–6× daily for up to 28 days. *(Educational synthesis.)*
- **Heart.** A small pilot (~10 patients) found TB4-pretreated stem cells improved heart function by roughly 50% and walking distance by ~14% versus untreated stem cells. *(Educational synthesis; hypothesis-generating, not a standalone TB4 efficacy trial.)*

**Animal data (also TB4):**

- **Cardiac.** Bock-Marquette and colleagues showed in *Nature* (2004) that thymosin β4 forms a complex with PINCH and integrin-linked kinase (ILK), activating Akt, and after coronary ligation in mice enhanced cardiomyocyte survival and cardiac function — the foundational repair mechanism. *(Animal; peer-reviewed.)*
- **Musculoskeletal.** Mouse fracture models showed stiffer, stronger bone (~+25% stiffness, ~+41% force to refracture) and 2–3× faster, dose-dependent muscle repair. *(Animal.)*
- **Hair.** Philp et al. (2004) reported TB4 increased hair growth by activating hair-follicle stem cells in rodents. *(Animal.)*
- **Brain.** Mouse stroke and TBI models showed better functional recovery via vessel remodelling, neuron growth, and cell protection. *(Animal.)*

**TB-500 (the fragment), studied alone:** comparatively little. The fragment is assumed to inherit the actin-migration benefit, but the human and most animal evidence above was generated with the full peptide. That asymmetry is the entire case for preferring TB4.

This is why our [TB-500 healing research overview](/blog/tb-500-thymosin-beta-4-healing-research) and the deeper data here both lean on TB4's literature: the evidence base is TB4's, borrowed by the fragment.$IDX$, 2);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$tb4-vs-tb-500__tb4-vs-tb-500-at-a-glance$IDX$, $IDX$tb4-vs-tb-500$IDX$, $IDX$TB4 vs TB-500 at a glance$IDX$, $IDX$| | **TB4 (thymosin β4)** | **TB-500 (fragment)** |
| --- | --- | --- |
| **Structure** | Full 43-amino-acid peptide | 7-amino-acid fragment (aa 17–23, LKKTETQ) |
| **Functional regions** | Actin-binding + anti-scar + anti-apoptotic + antimicrobial + signalling | Actin-binding only |
| **Evidence base** | Human trials (skin, eye, cardiac pilot) + broad animal data | Sparse direct evidence; inherits TB4 claims by assumption |
| **Half-life** | Short (~1.5 h) → typically dosed daily | Longer (metabolites ~72 h) → 2–3×/week feasible |
| **Forms** | Topical (skin/eye), SubQ (MSK/cardiac/neuro). **Not orally bioavailable** | Same constraint — no oral |
| **Best framing** | The better-studied, more complete molecule | A convenience-dosed partial; verify you're not getting it mislabelled as TB4 |$IDX$, 3);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$tb4-vs-tb-500__dosing-forms-and-cycling-research-reported$IDX$, $IDX$tb4-vs-tb-500$IDX$, $IDX$Dosing, forms, and cycling (research-reported)$IDX$, $IDX$These are the parameters reported in research and educational synthesis — recorded here for understanding, not as a personal directive.

- **Forms.** Topical for skin and eye; **subcutaneous** for musculoskeletal, cardiac, or neuro contexts. Neither molecule is **orally bioavailable** — unlike acid-resistant [BPC-157](/blog/bpc-157-complete-guide-2026-benefits-dosing), TB4 has no oral studies, so oral "TB-500" products lack a rationale.
- **Dose (SubQ, hypothetical).** Anchored to TB4's human IV-safety data (~5 mcg/kg), a subcutaneous equivalent works out near ~7.14 mcg/kg → roughly **~500 mcg/day** for a 70 kg adult, up to ~1 mg if needed.
- **Frequency.** This is where the half-life difference bites: **TB4 is dosed daily** (~1.5 h half-life) for steadier levels, while **TB-500's** longer-lived metabolites (~72 h) make a 2–3×/week schedule workable. The fragment's main practical advantage is dosing convenience, not superior healing.
- **Cycling.** Research framing uses roughly **4–6 weeks on / ≥6 weeks off** — shorter than a typical BPC-157 cycle, reflecting the more cautious cancer-risk framing below. Targeted, time-limited use; no evidence supports indefinite or preventive dosing.$IDX$, 4);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$tb4-vs-tb-500__the-cancer-risk-nuance-vendor-pages-skip$IDX$, $IDX$tb4-vs-tb-500$IDX$, $IDX$The cancer-risk nuance vendor pages skip$IDX$, $IDX$The same mechanisms that make TB4 a repair peptide — angiogenesis, cell migration / epithelial-mesenchymal transition, anti-apoptosis, and anti-ferroptosis — are also mechanisms a *pre-existing* cancer could exploit to grow, invade, or survive. Educational synthesis rates full-length TB4 as carrying a **slightly higher theoretical cancer-promotion concern than BPC-157**, precisely because it is the more complete, more potent molecule. Human safety data is reassuring for short courses (phase-1 IV up to 1,260 mg/day for 14 days; topical for 3 months) with no toxicities observed — but there is **no long-term post-course human data**.

The research-cautious reading: avoid with any personal or family cancer history or precancerous lesion, treat use as short-term and targeted only, and never as indefinite "preventive" maintenance. See our [peptide side effects and safety guide](/blog/peptide-side-effects-safety-guide-2026) for the broader risk framing.$IDX$, 5);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$tb4-vs-tb-500__how-to-verify-which-one-you-re-actually-getting$IDX$, $IDX$tb4-vs-tb-500$IDX$, $IDX$How to verify which one you're actually getting$IDX$, $IDX$Because TB-500 is cheaper to synthesise than the full 43-amino-acid peptide, **mislabelling runs in one direction**: a fragment sold as "TB4." Compounding pharmacies cannot legally produce TB4 at present, so most research-grade supply is unregulated. If a product is being used for research at all, the COA bar is non-negotiable:

- **HPLC + mass-spec identity and purity** — mass spec is the only way to confirm you have the **full 43-amino-acid TB4** and not the 7-amino-acid fragment relabelled. A purity percentage alone won't tell you which molecule it is.
- **USP <85> endotoxin** and **USP <71> sterility** for any injectable.
- Match the COA's stated identity and mass to full-length TB4 specifically.

A regulated compounding pharmacy is far safer than a research-use-only vendor; verification matters most precisely because the cheaper molecule is the easy substitution. Whatever the source, treat the COA — not the label on a [research-grade TB-500](/products/tb-500) vial — as the real identity check.$IDX$, 6);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$tb4-vs-tb-500__should-you-stack-them-and-with-what$IDX$, $IDX$tb4-vs-tb-500$IDX$, $IDX$Should you stack them — and with what?$IDX$, $IDX$For musculoskeletal repair, the research-reported hierarchy actually favours **BPC-157 first** (more and stronger animal data, and a lower cancer-risk framing), adding TB4 only if healing plateaus — and starting both together for acute major injuries, post-surgery, stroke, or major TBI, where TB4 acts as an early repair signal. The two are mechanistically **synergistic**: TB4 works through actin and cell structure, BPC-157 through nitric-oxide and VEGF-driven angiogenesis. That logic is the basis of the popular [BPC-157 + TB-500 "Wolverine" stack](/blog/bpc-157-tb-500-stack-wolverine-protocol), offered as a [pre-mixed BPC-157 + TB-500 blend](/products/bpc-157-tb-500) — and a reason the distinction in this article matters even inside a blend: you want the stack built on full TB4, not the fragment.$IDX$, 7);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$tb4-vs-tb-500__faq$IDX$, $IDX$tb4-vs-tb-500$IDX$, $IDX$FAQ$IDX$, $IDX$**Is TB4 the same as TB-500?**
No. TB4 (thymosin β4) is the complete 43-amino-acid peptide; TB-500 is a 7-amino-acid fragment of it (residues 17–23). They share one functional region — the actin-binding site — but TB-500 lacks TB4's anti-scar, pro-survival, antimicrobial, and signalling segments.

**Which is better, TB4 or TB-500?**
On the evidence, full-length TB4 is the better-supported choice: almost all the human and animal tissue-repair data was generated with TB4, not the fragment. TB-500's main edge is dosing convenience (less frequent injections), not stronger healing.

**Why do people say TB-500 when they mean TB4?**
Historical shorthand. "TB-500" became a generic market name for "thymosin β4 product," so the fragment's name got attached to the whole peptide's reputation and data. The names blurred; the molecules did not.

**Can you take TB4 or TB-500 orally?**
There is no evidence for it. Unlike acid-resistant BPC-157, TB4 is not orally bioavailable and has no oral studies, so oral "TB-500" products lack a research basis. Studied routes are topical (skin/eye) and subcutaneous.

**Is TB4 safe?**
Short-course human safety data is reassuring (no toxicities at high IV doses over two weeks), but there is no long-term post-course data, and its repair mechanisms carry a theoretical cancer-promotion concern — rated slightly higher than BPC-157. It is contraindicated in research framing for anyone with a cancer history or precancerous lesion.$IDX$, 8);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$tb4-vs-tb-500__references$IDX$, $IDX$tb4-vs-tb-500$IDX$, $IDX$References$IDX$, $IDX$1. Bock-Marquette, I., et al. (2004). Thymosin beta4 activates integrin-linked kinase and promotes cardiac cell migration, survival and cardiac repair. *Nature*, 432(7016), 466–472. doi:10.1038/nature03000. [PMID 15565145](https://pubmed.ncbi.nlm.nih.gov/15565145/).
2. Philp, D., et al. (2004). Thymosin beta 4 increases hair growth by activation of hair follicle stem cells. *FASEB Journal*, 18(2), 385–387.
3. Goldstein, A. L., Hannappel, E., & Kleinman, H. K. (2005). Thymosin beta4: actin-sequestering protein moonlights to repair injured tissues. *Trends in Molecular Medicine*, 11(9), 421–429.
4. Educational study-synthesis (licensed-MD secondary source), summarising TB4 human trials in chronic skin wounds (phase-2, ~73 patients), corneal/dry-eye healing (phase-3, ~18 patients), and a cardiac stem-cell pilot (~10 patients). *Provenance: educational/anecdote, not primary literature.*

---

*Research and educational use only. This article summarises published and educational sources for informational purposes and is not medical advice. Nothing here is a recommendation to diagnose, treat, cure, or prevent any condition, or to dose any compound. Peptides discussed are not FDA-approved for these uses. Consult a qualified clinician before acting on any health information. Evidence is graded honestly: where data is animal-only or from educational synthesis rather than human clinical trials, it is labelled as such.*$IDX$, 9);
delete from public.guide_products where guide_id=$IDX$tb4-vs-tb-500$IDX$;
insert into public.guide_products (guide_id, product_id) values ($IDX$tb4-vs-tb-500$IDX$, $IDX$tb-500$IDX$) on conflict do nothing;
insert into public.guide_products (guide_id, product_id) values ($IDX$tb4-vs-tb-500$IDX$, $IDX$bpc-157-tb-500$IDX$) on conflict do nothing;
insert into public.guide_products (guide_id, product_id) values ($IDX$tb4-vs-tb-500$IDX$, $IDX$bpc-157$IDX$) on conflict do nothing;

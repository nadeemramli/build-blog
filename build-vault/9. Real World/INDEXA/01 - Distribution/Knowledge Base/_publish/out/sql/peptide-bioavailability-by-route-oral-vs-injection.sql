-- guide: peptide-bioavailability-by-route-oral-vs-injection
insert into public.guides
(id, slug, title, subtitle, health_goal, abstract, published_date, last_updated, read_time,
 references_list, tags, status, author, difficulty_level, research_type, source, published)
values (
 $IDX$peptide-bioavailability-by-route-oral-vs-injection$IDX$, $IDX$peptide-bioavailability-by-route-oral-vs-injection$IDX$, $IDX$Peptide Bioavailability by Route: Oral vs Injection$IDX$, $IDX$Why a peptide's route — subcutaneous, oral, or intranasal — can swing its effective dose 100-fold, with peptide-by-peptide bioavailability numbers.$IDX$,
 NULL, $IDX$Peptide bioavailability — the fraction of a dose that actually reaches systemic circulation — varies so widely by route that an identical molecule can need 100× more drug orally than by injection to produce the same effect. This guide explains why the route changes the effective dose, with peptide-by-peptide numbers for subcutaneous, oral, and intranasal delivery and what it means for reading the research.$IDX$,
 $IDX$2026-06-13$IDX$::date,
 $IDX$2026-06-13$IDX$::date,
 11,
 $IDX$["Sikiric P, Rucman R, Turkovic B, et al. (2020). Novel Cytoprotective Mediator, Stable Gastric Pentadecapeptide BPC 157. Current Pharmaceutical Design.", "Buckley ST, Bækdal TA, Vegge A, et al. (2018). Transcellular stomach absorption of a derivatized glucagon-like peptide-1 receptor agonist. Science Translational Medicine 10:eaar7047.", "Aroda VR, et al. (2019). PIONEER program: efficacy and safety of oral semaglutide in type 2 diabetes. (PIONEER trial program review).", "Crowe TP, Greenlee MHW, Kanthasamy AG, Hsu WH. (2018). Mechanism of intranasal drug delivery directly to the brain. Life Sciences.", "Dhuria SV, Hanson LR, Frey WH. (2010). Intranasal delivery to the central nervous system: mechanisms and experimental considerations. Journal of Pharmaceutical Sciences.", "Erdő F, Bors LA, Farkas D, et al. (2018). Evaluation of intranasal delivery route of drug administration for brain targeting. Brain Research Bulletin.", "Nair AB, Jacob S. (2016). A simple practice guide for dose conversion between animals and human (FDA Kₘ allometric scaling). Journal of Basic and Clinical Pharmacy."]$IDX$::jsonb, $IDX$[]$IDX$::jsonb, NULL,
 $IDX$Indexa Labs Research Team$IDX$,
 $IDX$intermediate$IDX$,
 NULL,
 $IDX${"obsidian_path": "Articles/peptide-bioavailability-by-route-oral-vs-injection.md"}$IDX$::jsonb, false)
on conflict (id) do update set
 slug=excluded.slug, title=excluded.title, subtitle=excluded.subtitle, health_goal=excluded.health_goal,
 abstract=excluded.abstract, published_date=excluded.published_date, last_updated=excluded.last_updated,
 read_time=excluded.read_time, references_list=excluded.references_list, tags=excluded.tags,
 status=excluded.status, author=excluded.author, difficulty_level=excluded.difficulty_level,
 research_type=excluded.research_type, source=excluded.source, published=false, updated_at=now();
delete from public.guide_sections where guide_id=$IDX$peptide-bioavailability-by-route-oral-vs-injection$IDX$;
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$peptide-bioavailability-by-route-oral-vs-injection__what-bioavailability-actually-means$IDX$, $IDX$peptide-bioavailability-by-route-oral-vs-injection$IDX$, $IDX$What "bioavailability" actually means$IDX$, $IDX$Bioavailability (F) is the fraction of an administered dose that reaches systemic circulation in active form. **Intravenous (IV) injection is the reference point at 100%** by definition — the drug is placed directly into the blood. Every other route is scored relative to that. The gap between routes is not a rounding error for peptides; it is the single largest reason a research dose and an "anecdotal human dose" can look so different for the same compound.

Two forces destroy a peptide before it reaches circulation. The first is **enzymatic degradation**: peptides are chains of amino acids held together by peptide bonds, and the body is full of proteases evolved to cut exactly those bonds. The second, for anything swallowed, is **first-pass metabolism and the gut environment** — stomach acid at pH 1–2 plus digestive enzymes that shred most peptides within minutes. A peptide's structure (its size, its resistance to acid, whether it has been chemically modified) decides how much of each force it can withstand.$IDX$, 0);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$peptide-bioavailability-by-route-oral-vs-injection__route-by-route-the-bioavailability-ladder$IDX$, $IDX$peptide-bioavailability-by-route-oral-vs-injection$IDX$, $IDX$Route-by-route: the bioavailability ladder$IDX$, $IDX$Ranked from most to least of the dose that reaches the blood:

| Route | Typical systemic bioavailability | Why |
| --- | --- | --- |
| **Intravenous (IV)** | 100% (reference) | Placed directly in the blood |
| **Subcutaneous (SubQ)** | ~65–100% (often ~70% of IV) | Absorbed from fat layer; minimal first-pass; can form a slow-release depot |
| **Intramuscular (IM)** | High, similar order to SubQ | Faster absorption from vascular muscle |
| **Intraperitoneal (IP)** *(animal studies only)* | ~40% higher than SubQ | Large absorptive surface; **the route most rodent studies use** |
| **Intranasal** | Low systemically, but a **direct nose-to-brain shortcut** | Bypasses the blood-brain barrier for CNS targets |
| **Oral** | Often **<1–5%** (sometimes higher for acid-resistant peptides) | Acid + protease degradation, then hepatic first-pass |
| **Topical** | ~10% or less | Skin barrier; mostly local action |

The practical headline: a peptide with **1% oral bioavailability needs roughly 100× the dose** to match what a subcutaneous injection delivers. That is not a theoretical curiosity — it is exactly the situation with oral semaglutide, below.

This route-adjustment step sits at the core of translating any study into a human-equivalent estimate. For the full allometric-scaling method — including the FDA Kₘ body-surface-area conversion that comes *before* the route adjustment — see our companion guide on [animal-to-human dose conversion for peptides](/blog/how-to-read-peptide-studies-animal-to-human-dose-conversion).$IDX$, 1);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$peptide-bioavailability-by-route-oral-vs-injection__the-animal-study-trap-why-ip-dosing-inflates-the-number$IDX$, $IDX$peptide-bioavailability-by-route-oral-vs-injection$IDX$, $IDX$The animal-study trap: why IP dosing inflates the number$IDX$, $IDX$Almost all peptide efficacy data is generated in rats and mice, and the overwhelming majority of those studies inject **intraperitoneally (IP)** — into the abdominal cavity — because it is fast and reliable in a small animal. IP delivery is roughly **40% more bioavailable than subcutaneous**. So when a paper reports "10 mcg/kg IP," a human injecting the same scaled dose subcutaneously would reach *less* exposure unless that ~40% gap is corrected for (SubQ dose ≈ IP-equivalent × 1.4).

Skip this correction and two errors follow: the animal dose looks directly usable when it is not, and the human "equivalent" comes out too low. This is precisely why our methodology hub insists every animal dose be recorded with its route, not just its milligrams. If you are evaluating a protocol that cites a rodent study, the first question is always *which route* — see [how to read a peptide study](/blog/how-to-read-peptide-studies-animal-to-human-dose-conversion) for the red flags.$IDX$, 2);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$peptide-bioavailability-by-route-oral-vs-injection__why-peptides-resist-the-pill$IDX$, $IDX$peptide-bioavailability-by-route-oral-vs-injection$IDX$, $IDX$Why peptides resist the pill$IDX$, $IDX$The dream of an oral peptide runs into the same wall every time. Swallowed peptides face stomach acid that denatures them and a wall of proteases that cleave their bonds, and whatever survives must still cross the gut wall — a barrier built to admit small nutrients, not large charged molecules — before surviving a first pass through the liver. The net result for most peptides is single-digit-percent or near-zero oral bioavailability.

Drug developers fight back in two ways. **Permeation enhancers and protective co-formulations** (like the SNAC carrier used in oral semaglutide) buffer stomach pH and nudge a sliver of intact peptide across the stomach lining. And **structural redesign** — making the molecule acid-resistant or non-peptide entirely — sidesteps degradation. The trade-off is that even the best of these recovers only a few percent of an injection's efficiency, which is why oral peptides are dosed in much larger amounts and wrapped in strict administration rules.$IDX$, 3);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$peptide-bioavailability-by-route-oral-vs-injection__worked-numbers-how-route-reshapes-the-dose$IDX$, $IDX$peptide-bioavailability-by-route-oral-vs-injection$IDX$, $IDX$Worked numbers: how route reshapes the dose$IDX$, $IDX$These figures are drawn from our peptide notes and physician/study transcripts, with provenance labelled. They are educational estimates for understanding the literature — not dosing directions.

### Semaglutide — the clearest case (clinical data)
[Semaglutide](/products/semaglutide) is a GLP-1 analog engineered for a ~7-day half-life. By **subcutaneous injection its bioavailability is ~89%**. Swallowed unprotected, it is essentially **0%** — destroyed in the gut. Co-formulated with the **SNAC** absorption enhancer, oral bioavailability climbs only to about **0.4–1%** (newer formulations ~1–2%), with high day-to-day variability. The consequence is stark: it takes a **14 mg oral tablet to approximate the effect of roughly 1 mg injected**, and the tablet must be taken fasted, with no more than a few ounces of water and no food for 30+ minutes. The molecule is identical; the route is doing all the work. (See how the receptor side of this works in [how GLP-1 works for weight loss](/blog/how-glp-1-works-for-weight-loss).)

The instructive contrast is **orforglipron**, a *non-peptide* small-molecule GLP-1 agonist that reaches ~79% oral bioavailability with no food or water restrictions — a direct demonstration that the oral problem is a *peptide* problem, not a GLP-1 problem.

### BPC-157 — the acid-resistant exception (preclinical + thin human data)
BPC-157 is unusually rugged because it is a fragment of a naturally gastric-stable protein. Reported bioavailability by route is roughly **SubQ ~35–50%, oral ~20–35% (high for a peptide), topical ~10%**. But the oral fraction comes with a catch: orally, **BPC-157 acts largely locally on the gut rather than systemically.** That makes the oral form a rational choice for gut-localised research questions — IBS, leaky gut, IBD models — and the injectable form the choice for musculoskeletal or systemic targets. This is why our [BPC-157 complete guide](/blog/bpc-157-complete-guide-2026-benefits-dosing) and the [BPC-157 gut-health discussion](/blog/bpc-157-gut-health-leaky-gut-ibs) treat [oral BPC-157 capsules](/products/bpc-capsules) and [subcutaneous BPC-157](/products/bpc-157) as serving different goals, not as interchangeable.

### TB-500 — when oral is simply off the table
[TB-500](/products/tb-500) is **not acid-resistant**, so there is no meaningful oral route; research protocols are subcutaneous, with topical formulations used only for local skin or eye applications. Here the route question answers itself — the molecule cannot survive the gut, so injection is the only systemic option.

### Intranasal peptides — a different kind of "bioavailability"
For CNS-targeted peptides like Selank and Semax, systemic bioavailability is the wrong yardstick. The nasal route exploits a **direct nose-to-brain pathway** along the olfactory and trigeminal nerves that partly bypasses the blood-brain barrier, so a low systemic number can still deliver meaningful drug to the target tissue. That is why [Selank's studied human protocols](/products/selank-nasal-spray) are intranasal (≈900 mcg/day up to ~2,700 mcg/day) rather than injectable. The mechanism and its limits are covered in depth in [intranasal peptide delivery: the nose-to-brain pathway](/blog/intranasal-peptide-delivery-nose-to-brain).$IDX$, 4);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$peptide-bioavailability-by-route-oral-vs-injection__how-to-use-route-information-when-reading-a-protocol$IDX$, $IDX$peptide-bioavailability-by-route-oral-vs-injection$IDX$, $IDX$How to use route information when reading a protocol$IDX$, $IDX$Three working rules fall out of all this. First, **a dose without a route is meaningless** — always pair the number with how it was given before comparing protocols. Second, **never port an oral number to an injection or vice versa** without adjusting for the bioavailability gap; the same milligrams can be a fraction or a multiple of the intended exposure. Third, when a protocol cites an animal study, **check for the IP→SubQ correction** — an uncorrected IP dose systematically understates the human-equivalent.

Route also interacts with half-life and timing: short-acting peptides are often dosed by injection precisely so the pulse lands when it is wanted, while depot-forming SubQ injections trade a sharp peak for sustained exposure. For the safety implications of getting any of this wrong, see the [peptide side effects and safety guide](/blog/peptide-side-effects-safety-guide-2026), and for combining compounds across routes, the [peptide stacking guide](/blog/peptide-stacking-guide-2026-combining-peptides-safely).$IDX$, 5);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$peptide-bioavailability-by-route-oral-vs-injection__faq$IDX$, $IDX$peptide-bioavailability-by-route-oral-vs-injection$IDX$, $IDX$FAQ$IDX$, $IDX$**Why can't most peptides be taken as a pill?**
Stomach acid (pH 1–2) and digestive proteases degrade the peptide bonds within minutes, and the gut wall poorly absorbs large charged molecules. Most peptides end up with single-digit-percent or near-zero oral bioavailability, which is why injection remains the default systemic route.

**Which route gives the highest bioavailability?**
Intravenous, by definition, at 100%. Among self-administered research routes, subcutaneous injection is highest and most predictable — commonly cited at roughly 65–100% depending on the peptide.

**How much more oral drug equals an injection?**
It depends entirely on the peptide's oral bioavailability. For oral semaglutide (~1%), it takes about a 14 mg tablet to approximate ~1 mg injected — roughly a 100-fold difference. For an acid-resistant peptide like BPC-157, the oral-to-injection gap is much smaller.

**Why do so many studies use intraperitoneal (IP) injection?**
IP is fast and reliable in small animals. The catch for readers is that IP is about 40% more bioavailable than subcutaneous, so an IP dose must be adjusted (SubQ ≈ IP-equivalent × 1.4) before it can be translated to a human subcutaneous estimate.

**Is intranasal delivery just low-bioavailability injection?**
No. Nasal delivery uses a partial nose-to-brain pathway that bypasses the blood-brain barrier, so for CNS-targeted peptides a modest systemic number can still deliver useful drug to the brain — a different goal than maximising blood levels.

**Does oral BPC-157 work at all?**
It is unusually acid-resistant (~20–35% oral), but orally it acts largely *locally* on the gut rather than systemically — which is why oral capsules are studied for gut-localised questions and injection for musculoskeletal or systemic targets.$IDX$, 6);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$peptide-bioavailability-by-route-oral-vs-injection__references$IDX$, $IDX$peptide-bioavailability-by-route-oral-vs-injection$IDX$, $IDX$References$IDX$, $IDX$1. Sikiric P, Rucman R, Turkovic B, et al. (2020). Novel Cytoprotective Mediator, Stable Gastric Pentadecapeptide BPC 157. *Current Pharmaceutical Design.* (BPC-157 gastric stability and route behaviour.)
2. Buckley ST, Bækdal TA, Vegge A, et al. (2018). Transcellular stomach absorption of a derivatized GLP-1 receptor agonist. *Science Translational Medicine* 10:eaar7047. (SNAC-enabled oral semaglutide absorption.)
3. Clinical pharmacokinetics of semaglutide — oral vs subcutaneous bioavailability and the PIONEER program. [Review (PMC)](https://pmc.ncbi.nlm.nih.gov/articles/PMC12085783/).
4. Crowe TP, Greenlee MHW, Kanthasamy AG, Hsu WH. (2018). Mechanism of intranasal drug delivery directly to the brain. *Life Sciences.*
5. Dhuria SV, Hanson LR, Frey WH. (2010). Intranasal delivery to the central nervous system: mechanisms and experimental considerations. *Journal of Pharmaceutical Sciences.*
6. Erdő F, Bors LA, Farkas D, et al. (2018). Evaluation of intranasal delivery route of drug administration for brain targeting. *Brain Research Bulletin.*
7. Nair AB, Jacob S. (2016). A simple practice guide for dose conversion between animals and human. *Journal of Basic and Clinical Pharmacy.* (FDA Kₘ allometric scaling underlying the route-adjustment step.)

---

*Research and educational use only. This article describes what has been reported in published research and physician discussion; it is not medical advice and not a dosing recommendation. Peptides discussed are not approved to diagnose, treat, cure, or prevent any disease. Bioavailability figur$IDX$, 7);
delete from public.guide_products where guide_id=$IDX$peptide-bioavailability-by-route-oral-vs-injection$IDX$;
insert into public.guide_products (guide_id, product_id) values ($IDX$peptide-bioavailability-by-route-oral-vs-injection$IDX$, $IDX$bpc-157$IDX$) on conflict do nothing;
insert into public.guide_products (guide_id, product_id) values ($IDX$peptide-bioavailability-by-route-oral-vs-injection$IDX$, $IDX$bpc-capsules$IDX$) on conflict do nothing;
insert into public.guide_products (guide_id, product_id) values ($IDX$peptide-bioavailability-by-route-oral-vs-injection$IDX$, $IDX$semaglutide$IDX$) on conflict do nothing;
insert into public.guide_products (guide_id, product_id) values ($IDX$peptide-bioavailability-by-route-oral-vs-injection$IDX$, $IDX$tb-500$IDX$) on conflict do nothing;
insert into public.guide_products (guide_id, product_id) values ($IDX$peptide-bioavailability-by-route-oral-vs-injection$IDX$, $IDX$selank-nasal-spray$IDX$) on conflict do nothing;
insert into public.guide_products (guide_id, product_id) values ($IDX$peptide-bioavailability-by-route-oral-vs-injection$IDX$, $IDX$mots-c$IDX$) on conflict do nothing;

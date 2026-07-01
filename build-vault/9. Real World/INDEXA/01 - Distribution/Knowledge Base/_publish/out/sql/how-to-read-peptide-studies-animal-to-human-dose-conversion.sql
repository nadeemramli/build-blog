-- guide: how-to-read-peptide-studies-animal-to-human-dose-conversion
insert into public.guides
(id, slug, title, subtitle, health_goal, abstract, published_date, last_updated, read_time,
 references_list, tags, status, author, difficulty_level, research_type, source, published)
values (
 $IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion$IDX$, $IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion$IDX$, $IDX$Animal-to-Human Dose Conversion for Peptides Explained$IDX$, $IDX$How to convert animal peptide doses to a human-equivalent dose using the FDA body-surface-area method — with worked examples and caveats.$IDX$,
 NULL, $IDX$Almost every peptide efficacy study you will read was run in rats or mice, yet the mg/kg number on the page cannot be used directly in a human. This guide walks through animal-to-human dose conversion for peptides — the FDA body-surface-area method, the route adjustment, and the sanity checks — with worked examples for six common peptides.$IDX$,
 $IDX$2026-06-12$IDX$::date,
 $IDX$2026-06-12$IDX$::date,
 9,
 $IDX$["Nair AB, Jacob S (2016). A simple practice guide for dose conversion between animals and human. Journal of Basic and Clinical Pharmacy 7(2):27-31. PMC4804402.", "Reagan-Shaw S, Nihal M, Ahmad N (2008). Dose translation from animal to human studies revisited. FASEB Journal 22(3):659-661. PMID 17942826.", "U.S. Food and Drug Administration (2005). Guidance for Industry: Estimating the Maximum Safe Starting Dose in Initial Clinical Trials for Therapeutics in Adult Healthy Volunteers."]$IDX$::jsonb, $IDX$["dosing", "methodology", "research-literacy"]$IDX$::jsonb, NULL,
 $IDX$Indexa Labs Research Team$IDX$,
 $IDX$intermediate$IDX$,
 NULL,
 $IDX${"obsidian_path": "Articles/how-to-read-peptide-studies-animal-to-human-dose-conversion.md"}$IDX$::jsonb, false)
on conflict (id) do update set
 slug=excluded.slug, title=excluded.title, subtitle=excluded.subtitle, health_goal=excluded.health_goal,
 abstract=excluded.abstract, published_date=excluded.published_date, last_updated=excluded.last_updated,
 read_time=excluded.read_time, references_list=excluded.references_list, tags=excluded.tags,
 status=excluded.status, author=excluded.author, difficulty_level=excluded.difficulty_level,
 research_type=excluded.research_type, source=excluded.source, published=false, updated_at=now();
delete from public.guide_sections where guide_id=$IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion$IDX$;
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion__why-animal-to-human-dose-conversion-isn-t-just-multiplying-mg-kg$IDX$, $IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion$IDX$, $IDX$Why animal-to-human dose conversion isn't just multiplying mg/kg$IDX$, $IDX$The intuitive move — take the rat's mg/kg and apply it to yourself — is wrong, and it is wrong in a specific, predictable direction. Drug exposure does not scale with bodyweight; it scales with **body surface area**. Metabolic rate, cardiac output, and renal clearance all track surface area far more closely than mass across species ([Nair & Jacob, 2016](https://pmc.ncbi.nlm.nih.gov/articles/PMC4804402/)).

A rat has far more surface area per kilogram than a human does, so it burns through a compound faster. To reach the *same internal exposure*, a small animal needs a **higher** mg/kg dose than a human. If you copy the rat's mg/kg straight across, you overshoot — often by six-fold or more. That is the entire reason a formal conversion exists.$IDX$, 0);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion__step-1-allometric-scaling-the-fda-k-method$IDX$, $IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion$IDX$, $IDX$Step 1 — Allometric scaling (the FDA Kₘ method)$IDX$, $IDX$The U.S. FDA recommends a body-surface-area normalization for estimating a human starting dose in first-in-human trials, and the same math lets you read animal studies in reverse ([FDA, 2005](https://www.fda.gov/regulatory-information/search-fda-guidance-documents); [Reagan-Shaw et al., 2008](https://pubmed.ncbi.nlm.nih.gov/17942826/)). Each species gets a **Kₘ factor** — its average bodyweight divided by its surface area:

| Species | Kₘ | Shortcut ×factor → human |
| --- | --- | --- |
| Mouse | 3 | **×0.081** |
| Rat | 6 | **×0.162** |
| Rabbit | 12 | ×0.324 |
| Dog | 20 | ×0.541 |
| Human (~60 kg) | 37 | — |

The formula is:

**HED (mg/kg) = Animal dose (mg/kg) × (Kₘ animal ÷ Kₘ human)**

For a rat that is 6 ÷ 37 ≈ **0.162** — the multiplier you will see again and again in serious peptide write-ups. So a 10 mcg/kg rat dose becomes ~1.62 mcg/kg human-equivalent before any other adjustment. The same logic confirms the widely cited rat-to-human ratio of roughly 1:6.2.$IDX$, 1);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion__step-2-adjust-for-route-and-bioavailability$IDX$, $IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion$IDX$, $IDX$Step 2 — Adjust for route and bioavailability$IDX$, $IDX$Allometric scaling gets you to a human-equivalent *exposure*, but exposure depends on **how** the drug was delivered. Most animal peptide studies inject **intraperitoneally (IP)** — into the abdominal cavity — which is absorbed roughly **40% more completely than a subcutaneous (SubQ) injection**, the route most human research and self-experimentation actually uses.

So to match the IP exposure with a SubQ shot, you scale **up**: **SubQ dose ≈ HED × 1.4**. Other rules of thumb worth carrying: **IV = 100%** bioavailability, **SubQ ≈ 70% of IV**, and **oral varies enormously** — acid-resistant oral BPC-157 lands around half of its SubQ dose, while most other peptides survive the gut far worse and need much more (or a different route entirely). Half-life matters here too: short-acting peptides need their dose split across the day rather than given all at once, a point that drives most real-world [peptide dosing and timing decisions](/blog/peptide-stacking-guide-2026-combining-peptides-safely).$IDX$, 2);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion__step-3-convert-per-kg-to-per-person$IDX$, $IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion$IDX$, $IDX$Step 3 — Convert per-kg to per-person$IDX$, $IDX$Now multiply the route-adjusted mg/kg by a realistic bodyweight — typically **70–80 kg** for an adult. This is the step where an abstract mg/kg figure finally becomes a number you can compare against what the human community actually uses.$IDX$, 3);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion__step-4-sanity-check-and-apply-a-safety-factor$IDX$, $IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion$IDX$, $IDX$Step 4 — Sanity-check and apply a safety factor$IDX$, $IDX$The estimate is a *ceiling for interpretation*, not a target. Two checks keep you honest:

First, drug development routinely divides the modelled human dose by **~10** as a safety margin before the first human is ever dosed. Second, compare your result to **anecdotal human ranges** — which, for many peptides, run *higher* than the strict allometric estimate because tolerance, receptor dynamics, and half-life differ between species. When the two disagree, that disagreement is information, not an error to paper over. The universal rule that falls out of all of this is **start low, titrate slow** — see our [peptide side effects and safety guide](/blog/peptide-side-effects-safety-guide-2026) for why conservative titration matters more than hitting a "correct" number.$IDX$, 4);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion__worked-examples-six-peptides-start-to-finish$IDX$, $IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion$IDX$, $IDX$Worked examples: six peptides, start to finish$IDX$, $IDX$These conversions are derived from primary animal studies and physician deep-dives in our research base. They show how the same four steps produce very different — and sometimes surprising — answers.

| Peptide | Animal dose | Conversion | Human-equivalent (modelled) | Anecdotal human range |
| --- | --- | --- | --- | --- |
| BPC-157 | 10 mcg/kg rat IP | ×0.162 → 1.62, ×1.4 (IP→SubQ) → 2.27 mcg/kg | ~**181 mcg/day** (80 kg) | 250–500 mcg/day SubQ |
| MOTS-C | 0.5 mg/kg/day IP | scaled + route → ~0.048 mg/kg SubQ | ~**3.3 mg/day** (~23 mg/week) | ~5 mg, 3×/week |
| TB-500 / TB4 | 6 mg/kg rat IP | ×0.162 → 0.49, ×1.4 → ~0.69 mg/kg | ~48 mg/day (**impractically high**) → re-anchored to human IV-safety data → ~**500 mcg/day** | 250–500 mcg/day |
| SS-31 | 3 mg/kg mouse | allometric HED | ~**17 mg/day**; a 1 mg/kg study → ~6 mg/day | start 5–10 mg/day |
| Selank | 100 mcg/kg/day | ×0.162 → 16.2 mcg/kg → ~1 mg/day, then ÷10 safety | ~**100 mcg/day** start | 250–900 mcg intranasal |
| GHK-Cu | 0.5 mg/kg EOD IP | allometric + IP→SubQ | ~**0.6–1 mg/day** SubQ | 0.5–2 mg/day |

Two of these are worth dwelling on, because they teach the method better than the clean cases:

**BPC-157** is the textbook example. The rat study used 10 mcg/kg IP; the full conversion lands near 181 mcg/day, and the anecdotal human range (250–500 mcg/day) sits modestly above it — exactly the "humans tend to run a little higher" pattern you should expect. The number is reassuringly sane. For the underlying evidence, see our [BPC-157 complete guide](/blog/bpc-157-complete-guide-2026-benefits-dosing) and the product page for [BPC-157](/products/bpc-157).

**[TB-500 / TB4](/blog/tb-500-thymosin-beta-4-healing-research)** is the cautionary one. Run the raw 6 mg/kg rat dose through the same machinery and you get ~48 mg/day — an absurd figure no one injects. That is not a license to dose to 48 mg; it is a flashing red light that **the animal study used an exposure that does not translate**, and the only defensible human anchor is separate IV-safety data (~5 mcg/kg), which points to ~500 mcg/day. When allometric scaling produces a number that looks insane, the scaling is telling you the truth: that protocol was never meant to map cleanly onto a person. The same skepticism applies to [SS-31](/products/ss-31) at the high end of its mouse studies, to [MOTS-C](/products/mots-c) in metabolic research, and to [GHK-Cu](/products/ghk-cu) and [Selank](/products/selank), where the human-validated routes (topical and intranasal, respectively) differ from the injected animal protocols entirely.$IDX$, 5);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion__a-note-on-provenance-animal-human-evidence$IDX$, $IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion$IDX$, $IDX$A note on provenance: animal ≠ human evidence$IDX$, $IDX$The honest framing of every conversion above is that the *efficacy* data is **animal (preclinical)** and the *human* numbers are **anecdotal or extrapolated**, not validated in controlled trials. Body-surface-area scaling models equivalent exposure; it does not promise equivalent safety, equivalent half-life, or equivalent receptor behavior. A "no observed toxicity" result in a rat is not a human safety clearance. Treat every modelled HED as a way to *read the literature critically* — never as a recommendation.$IDX$, 6);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion__faq$IDX$, $IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion$IDX$, $IDX$FAQ$IDX$, $IDX$**Why multiply a rat dose by 0.162 specifically?**
Because the rat's Kₘ factor is 6 and the human's is 37, and 6 ÷ 37 ≈ 0.162. That ratio converts the rat's mg/kg into a human-equivalent mg/kg on a body-surface-area basis.

**Is the human-equivalent dose a recommended dose?**
No. It is a modelling estimate used to interpret a study and to set a *conservative starting point* in formal drug development (often divided by ~10 first). It is not medical advice or a dosing prescription.

**Why do anecdotal human peptide doses often exceed the calculated HED?**
Differences in half-life, receptor desensitization, and bioavailability between species, plus the fact that community doses are not rigorously validated. When the two diverge, the gap is a prompt to be more cautious, not less.

**Do I need to adjust for the injection route?**
Yes. Most animal studies inject intraperitoneally, which is ~40% more bioavailable than subcutaneous. To match that exposure SubQ, scale the human-equivalent dose up by roughly 1.4×. Oral and intranasal routes change the math far more.

**Does this method work for every peptide?**
The scaling math is general, but the result is only useful when the animal exposure is realistic. When conversion yields an impractical number (as with TB-500), it is a signal to anchor to human safety data instead of the animal dose.$IDX$, 7);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion__references$IDX$, $IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion$IDX$, $IDX$References$IDX$, $IDX$1. Nair AB, Jacob S (2016). *A simple practice guide for dose conversion between animals and human.* Journal of Basic and Clinical Pharmacy 7(2):27-31. [PMC4804402](https://pmc.ncbi.nlm.nih.gov/articles/PMC4804402/)
2. Reagan-Shaw S, Nihal M, Ahmad N (2008). *Dose translation from animal to human studies revisited.* FASEB Journal 22(3):659-661. [PMID 17942826](https://pubmed.ncbi.nlm.nih.gov/17942826/)
3. U.S. Food and Drug Administration (2005). *Guidance for Industry: Estimating the Maximum Safe Starting Dose in Initial Clinical Trials for Therapeutics in Adult Healthy Volunteers.*

---

*Research and educational use only. This article describes how doses were used or modelled in published research and community reports; it is not medical advice and is not a recommendation to use any compound. Conversions are interpretive estimates, not validated human doses. Consult a qualified physician before making any health decision.*$IDX$, 8);
delete from public.guide_products where guide_id=$IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion$IDX$;
insert into public.guide_products (guide_id, product_id) values ($IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion$IDX$, $IDX$bpc-157$IDX$) on conflict do nothing;
insert into public.guide_products (guide_id, product_id) values ($IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion$IDX$, $IDX$tb-500$IDX$) on conflict do nothing;
insert into public.guide_products (guide_id, product_id) values ($IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion$IDX$, $IDX$mots-c$IDX$) on conflict do nothing;
insert into public.guide_products (guide_id, product_id) values ($IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion$IDX$, $IDX$ss-31$IDX$) on conflict do nothing;
insert into public.guide_products (guide_id, product_id) values ($IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion$IDX$, $IDX$selank$IDX$) on conflict do nothing;
insert into public.guide_products (guide_id, product_id) values ($IDX$how-to-read-peptide-studies-animal-to-human-dose-conversion$IDX$, $IDX$ghk-cu$IDX$) on conflict do nothing;

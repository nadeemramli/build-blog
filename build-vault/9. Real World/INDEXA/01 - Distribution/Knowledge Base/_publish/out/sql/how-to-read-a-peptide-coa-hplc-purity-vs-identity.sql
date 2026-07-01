-- guide: how-to-read-a-peptide-coa-hplc-purity-vs-identity
insert into public.guides
(id, slug, title, subtitle, health_goal, abstract, published_date, last_updated, read_time,
 references_list, tags, status, author, difficulty_level, research_type, source, published)
values (
 $IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity$IDX$, $IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity$IDX$, $IDX$How to Read a Peptide COA: Purity vs Identity (2026)$IDX$, $IDX$How to read a peptide COA — what HPLC purity, mass-spec identity, endotoxin and sterility really tell you, and the line that exposes a mislabeled vial.$IDX$,
 NULL, $IDX$A peptide certificate of analysis (COA) answers two separate questions — *is it pure?* and *is it the right peptide?* — and most buyers only check the first. This guide shows you how to read a peptide COA line by line: HPLC purity, mass-spec identity, endotoxin and sterility, net peptide content, and the batch-matching and red-flag checks that separate a real document from a recycled PDF.$IDX$,
 $IDX$2026-06-14$IDX$::date,
 $IDX$2026-06-14$IDX$::date,
 10,
 $IDX$["United States Pharmacopeia. General Chapter <85> Bacterial Endotoxins Test. USP–NF.", "United States Pharmacopeia. General Chapter <71> Sterility Tests. USP–NF.", "United States Pharmacopeia. General Chapter <1503> Quality Attributes of Synthetic Peptide Drug Substances. USP–NF.", "U.S. Food and Drug Administration (2012). Guidance for Industry: Pyrogen and Endotoxins Testing — Questions and Answers.", "Indexa Labs Research Team (2026). BPC-157 deep-dive transcript capture (educational sourcing standard).", "Indexa Labs Research Team (2026). TB4/TB-500 deep-dive transcript capture (identity-vs-purity mislabel note)."]$IDX$::jsonb, $IDX$[]$IDX$::jsonb, NULL,
 $IDX$Indexa Labs Research Team$IDX$,
 $IDX$beginner$IDX$,
 NULL,
 $IDX${"obsidian_path": "Articles/how-to-read-a-peptide-coa-hplc-purity-vs-identity.md"}$IDX$::jsonb, false)
on conflict (id) do update set
 slug=excluded.slug, title=excluded.title, subtitle=excluded.subtitle, health_goal=excluded.health_goal,
 abstract=excluded.abstract, published_date=excluded.published_date, last_updated=excluded.last_updated,
 read_time=excluded.read_time, references_list=excluded.references_list, tags=excluded.tags,
 status=excluded.status, author=excluded.author, difficulty_level=excluded.difficulty_level,
 research_type=excluded.research_type, source=excluded.source, published=false, updated_at=now();
delete from public.guide_sections where guide_id=$IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity$IDX$;
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity__what-a-peptide-coa-actually-is$IDX$, $IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity$IDX$, $IDX$What a peptide COA actually is$IDX$, $IDX$A certificate of analysis is a **batch-specific** test report for one production lot of one peptide. "Batch-specific" is the load-bearing phrase: a COA describes the exact powder a particular vial was filled from, identified by a lot or batch number. A COA from a *different* batch — or a generic marketing PDF with no batch number — tells you nothing about the vial in your hand. The website you bought from reads from a database; the lab that ran the assays is a separate party. The whole point of a third-party COA is that an independent analytical lab, not the seller, signed off on the numbers.

A complete COA proves four things, and they are genuinely independent:

1. **Purity** — what fraction of the material is the intended peptide (HPLC).
2. **Identity** — whether that material *is* the peptide it claims to be (mass spectrometry).
3. **Safety for injection** — that it isn't contaminated with bacterial toxins or live microbes (endotoxin and sterility).
4. **Dose accuracy** — how much actual peptide is in the powder versus salt and water (net peptide content).

Skip any one and you've left a real failure mode unchecked. We'll take them in order.$IDX$, 0);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity__hplc-reading-the-purity-number-and-its-limits$IDX$, $IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity$IDX$, $IDX$HPLC: reading the purity number — and its limits$IDX$, $IDX$High-performance liquid chromatography (HPLC) is the purity test. The sample is pushed through a column that separates its components by how strongly each sticks, and a detector records them as **peaks** on a chromatogram. The target peptide should be one dominant peak; everything else — truncated sequences, deletion impurities, byproducts — shows up as smaller peaks.

Purity is reported as a simple ratio: *(main peak area ÷ total area of all peaks) × 100*. When you read the chromatogram, look for a single tall main peak, a stated **retention time** (in minutes, where the main peak elutes), and small or absent minor peaks. For research-grade peptides, treat **≥95% as the floor, ≥98% as good, and ≥99% as excellent** — the standard our own sourcing notes anchor to is **>99%**.

Here's the limit nobody puts in the headline: **HPLC only measures purity of what it can see, and it does not confirm identity.** A peptide can run as a clean, gorgeous 99% single peak and still be the *wrong* peptide, because a different molecule of similar size and chemistry can elute at a similar time and look identical on the chromatogram. Purity answers "how clean is this?" It cannot answer "is this the molecule on the label?" For that you need the next section — and that gap is exactly where mislabeled product slips through.$IDX$, 1);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity__mass-spec-the-identity-check-that-catches-a-mislabel$IDX$, $IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity$IDX$, $IDX$Mass spec: the identity check that catches a mislabel$IDX$, $IDX$Mass spectrometry (MS, usually LC-MS) is the identity test. It measures the molecular weight of the compound and compares the **observed mass** to the **theoretical mass** for the labeled sequence. If they match within tolerance, you have strong evidence the molecule is what the label says. If the COA shows a purity figure but **no MS data with a theoretical-vs-observed mass**, you have a purity claim and no proof of identity — half a certificate.

Why this matters more than it sounds: in the real world, **mislabeling tends to run in one direction** — a cheaper or simpler molecule sold as a more valuable one. The textbook case is the beta-thymosins. **TB-500 is only the 7-amino-acid actin-binding fragment** of the full 43-amino-acid **TB4 (thymosin β4)** molecule. Almost all the tissue-repair *evidence* is on TB4, so TB4 commands the premium — which means the economic incentive is to sell the short fragment and label it as the full peptide, not the reverse. HPLC purity won't catch that swap; both can run clean. Only the **mass** distinguishes a 7-mer from a 43-mer. (We unpack that specific confusion in [TB4 vs TB-500: why the full peptide beats the fragment](/blog/tb4-vs-tb-500).) The general lesson: **always read the MS section, and always check the masses, not just the purity headline.**$IDX$, 2);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity__endotoxin-and-sterility-the-injectable-only-tests$IDX$, $IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity$IDX$, $IDX$Endotoxin and sterility: the injectable-only tests$IDX$, $IDX$Purity and identity tell you the chemistry is right. They say nothing about whether the powder is *safe to inject* — that's two separate tests, and whether you need them depends entirely on the route.

**Endotoxin (USP <85>).** Endotoxins are fragments of dead Gram-negative bacterial cell walls. They survive sterilization, they're pyrogenic (they cause fevers and worse), and the FDA requires endotoxin testing for injectable products under **USP General Chapter <85>**. The standard method is the **LAL (Limulus Amebocyte Lysate)** assay, reported in endotoxin units per milligram (EU/mg). A COA for an injectable peptide should carry a USP <85> result; a powder can be chemically pure and still be loaded with endotoxin from a dirty synthesis.

**Sterility (USP <71>).** Sterility testing asks whether anything is alive in the vial. The rigorous version is the **14-day USP <71>** method, which screens broadly for bacteria, yeast, and mold — substantially more sensitive than a quick rapid test.

The route-dependence is the practical rule, and it comes straight from how the body handles each delivery path. **Injectables need all four checks** — purity, identity, endotoxin, and sterility — because you're bypassing every barrier. **Oral forms need purity and identity only**, because the gut tolerates the small endotoxin and microbial loads that would be unacceptable in an injection. So an oral peptide COA without USP <85>/<71> isn't necessarily a red flag; an *injectable* peptide COA without them is. If you're unsure which standard applies, our guide to [peptide bioavailability by route](/blog/peptide-bioavailability-by-route-oral-vs-injection) walks through why injectable and oral products face different contamination rules.$IDX$, 3);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity__net-peptide-content-why-99-pure-isn-t-a-full-dose$IDX$, $IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity$IDX$, $IDX$Net peptide content: why "99% pure" isn't a full dose$IDX$, $IDX$This is the section that's missing from most consumer explainers, and it directly affects your dose. **Purity and content are not the same number.** HPLC purity is *what fraction of the peptide material is the right peptide*. **Net peptide content** is *what fraction of the total powder weight is actually peptide at all* — the rest being counterion salt and residual water.

Most RUO peptides come off synthesis as **TFA (trifluoroacetate) salts**, and a typical powder is only **~60–80% peptide by weight**, with the balance being TFA (or acetate) salt plus moisture. The implication: a vial labeled "10 mg" of a 99% *pure* peptide at 75% net content holds about **7.5 mg of actual peptide**. If your protocol assumes the full 10 mg, you're systematically under-dosing by a quarter — and your reconstitution math is off before you draw the first unit. Net peptide content is measured by **amino acid analysis (AAA)**, which quantifies the real peptide by its amino-acid composition. A COA that reports purity but never reports content leaves you guessing at the one number you need to dose accurately. (For why milligrams-on-the-label rarely equal milligrams-in-the-body, see [how to read peptide studies and convert doses](/blog/how-to-read-peptide-studies-animal-to-human-dose-conversion).)$IDX$, 4);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity__batch-specific-or-worthless-lot-matching-and-independent-retesting$IDX$, $IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity$IDX$, $IDX$Batch-specific or worthless: lot matching and independent retesting$IDX$, $IDX$A COA is only evidence for the batch it was run on. Two checks make it real:

- **The batch/lot number on the COA must match the vial.** If the vial has no lot, or the lot doesn't appear on the certificate, the document is decorative.
- **The analysis date and the lab must be identifiable.** A named, independent lab (Janoshik is the commonly referenced third party) and a real date are minimum credibility. "Tested by" with no lab name is not a test.

The gold-standard practice when stakes are high: **buy in bulk from one batch and independently send a vial out for your own HPLC + MS testing.** That converts the supplier's claim into your own evidence, and it's the only way around the fundamental problem that RUO sources are unregulated and purity is otherwise unverifiable batch to batch. Worth stating plainly: a **regulated compounding pharmacy still beats any research-use-only source** on reliability — a third-party COA narrows the gap, it doesn't erase it. This is the trust layer under every protocol; if you're new to peptides, pair it with the [peptide side effects and safety guide](/blog/peptide-side-effects-safety-guide-2026) before sourcing anything.$IDX$, 5);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity__red-flags-how-to-spot-a-fake-or-recycled-coa$IDX$, $IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity$IDX$, $IDX$Red flags: how to spot a fake or recycled COA$IDX$, $IDX$Run a draft COA against this list before you trust it:

- **No batch/lot number, or it doesn't match the vial.** The most common tell of a recycled, one-size-fits-all PDF.
- **Purity figure but no mass-spec section.** A clean peak with no identity proof — you can't rule out a same-size substitute.
- **An injectable with no USP <85> endotoxin or USP <71> sterility result.** Chemistry without safety.
- **No net peptide content / AAA.** Your real dose is unknown.
- **No named lab or analysis date.** Anonymous testing is not testing.
- **A chromatogram image with no axes, no retention time, or numbers that don't reconcile with the stated purity.** Pretty pictures aren't data.
- **The same COA reused across multiple lots or products.** Batch-specific means one document per batch.

Any single item here drops a COA from "proof" to "marketing." Two or more, and the safe assumption is that the document was built to reassure rather than to verify.$IDX$, 6);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity__the-60-second-how-to-read-a-peptide-coa-checklist$IDX$, $IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity$IDX$, $IDX$The 60-second "how to read a peptide COA" checklist$IDX$, $IDX$When a certificate lands in front of you, in order:

1. **Batch number** present and matches the vial.
2. **HPLC purity** ≥98% (ideally >99%), single dominant peak, retention time stated.
3. **Mass spec** present, observed mass matches theoretical for the labeled sequence.
4. **Net peptide content (AAA)** reported — use it to correct your dose.
5. **If injectable:** USP <85> endotoxin *and* USP <71> sterility both present and passing.
6. **Named independent lab** and **analysis date** on the document.

Six lines. If all six clear, the COA is doing its job. If any fail, treat the claim as unproven — not the vial as fine until shown otherwise.$IDX$, 7);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity__faq$IDX$, $IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity$IDX$, $IDX$FAQ$IDX$, $IDX$**What purity should a peptide COA show?**
For research-grade material, ≥95% is the floor, ≥98% is good, and ≥99% is excellent. Below 95%, the impurity fraction (truncated and deletion sequences) gets large enough to matter. But purity is only half the picture — always confirm identity by mass spec too.

**What's the difference between HPLC and mass spectrometry on a COA?**
HPLC measures **purity** — how clean the sample is, as the main-peak percentage. Mass spectrometry confirms **identity** — whether the molecule's measured mass matches the labeled peptide. HPLC can't catch a same-size substitution; MS can. A complete COA has both.

**Does an oral peptide COA need endotoxin and sterility tests?**
No. Endotoxin (USP <85>) and sterility (USP <71>) testing are essential for *injectable* products because they bypass the body's barriers. Oral forms need purity and identity only, since the gut tolerates small endotoxin and microbial loads. An injectable without those two tests is the real red flag.

**Why is my peptide "99% pure" but I seem to be under-dosing?**
Purity ≠ content. Most RUO peptides are TFA salts at ~60–80% net peptide content by weight, the rest being salt and water. A "10 mg" vial at 75% content holds ~7.5 mg of actual peptide. Check the amino-acid-analysis (net content) line and correct your reconstitution accordingly.

**Can a COA be faked?**
Yes — recycled PDFs with no batch number, purity figures with no MS, and anonymous "labs" are common. Match the lot to the vial, require a named third-party lab and date, and for anything high-stakes, send a vial for independent HPLC + MS testing yourself.

**Is a COA from the seller enough?**
It's a necessary minimum, not a guarantee. RUO sources are unregulated, so the best practice is independent retesting of your own batch. A regulated compounding pharmacy remains more reliable than any research-use-only supplier.$IDX$, 8);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity__references$IDX$, $IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity$IDX$, $IDX$References$IDX$, $IDX$1. United States Pharmacopeia. *General Chapter <85> Bacterial Endotoxins Test.* USP–NF. https://www.usp.org/
2. United States Pharmacopeia. *General Chapter <71> Sterility Tests.* USP–NF. https://www.usp.org/
3. United States Pharmacopeia. *General Chapter <1503> Quality Attributes of Synthetic Peptide Drug Substances.* USP–NF.
4. U.S. Food and Drug Administration (2012). *Guidance for Industry: Pyrogen and Endotoxins Testing — Questions and Answers.* https://www.fda.gov/
5. Indexa Labs Research Team (2026). BPC-157 deep-dive transcript capture — sourcing standard (HPLC + mass-spec, USP <85>, USP <71>, batch-specific). *Educational.*
6. Indexa Labs Research Team (2026). TB4/TB-500 deep-dive transcript capture — identity-vs-purity and the one-direction mislabel note. *Educational.*

Related reading: [BPC-157 complete guide (2026)](/blog/bpc-157-complete-guide-2026-benefits-dosing) · [TB4 vs TB-500](/blog/tb4-vs-tb-500) · products: [BPC-157](/products/bpc-157), [TB-500](/products/tb-500), [BPC-157 + TB-500](/products/bpc-157-tb-500).

---

*Research and educational use only. This article summarizes analytical-chemistry and quality-control concepts for evaluating research-grade peptides; it is not medical advice and is not a recommendation to purchase, possess, or administer any substance. Evidence is graded honestly: regulatory and analytical standards (USP, FDA) are cited where applicable, and physician-transcript material is labeled educational. Nothing here describes a product as safe or effective for treating, curing, or preventing any condition.*$IDX$, 9);
delete from public.guide_products where guide_id=$IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity$IDX$;
insert into public.guide_products (guide_id, product_id) values ($IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity$IDX$, $IDX$bpc-157$IDX$) on conflict do nothing;
insert into public.guide_products (guide_id, product_id) values ($IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity$IDX$, $IDX$tb-500$IDX$) on conflict do nothing;
insert into public.guide_products (guide_id, product_id) values ($IDX$how-to-read-a-peptide-coa-hplc-purity-vs-identity$IDX$, $IDX$bpc-157-tb-500$IDX$) on conflict do nothing;

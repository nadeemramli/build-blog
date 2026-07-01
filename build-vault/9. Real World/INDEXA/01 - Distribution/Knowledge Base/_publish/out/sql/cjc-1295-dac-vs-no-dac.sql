-- guide: cjc-1295-dac-vs-no-dac
insert into public.guides
(id, slug, title, subtitle, health_goal, abstract, published_date, last_updated, read_time,
 references_list, tags, status, author, difficulty_level, research_type, source, published)
values (
 $IDX$cjc-1295-dac-vs-no-dac$IDX$, $IDX$cjc-1295-dac-vs-no-dac$IDX$, $IDX$CJC-1295 DAC vs No DAC: The Pulse-Amplitude Problem$IDX$, $IDX$CJC-1295 DAC vs no DAC isn't about dosing convenience — it's two different GH patterns. Why the DAC version's flat elevation works against longevity.$IDX$,
 $IDX$muscle-growth$IDX$, $IDX$CJC-1295 DAC vs no DAC is usually framed as a convenience trade-off — once-weekly versus daily injections. That framing misses the point. The real difference is the *shape* of the growth-hormone signal each one creates, and only one of them matches the pulsatile rhythm that aging actually erodes. This guide explains the pharmacology, the human evidence, and why mechanism-minded researchers treat these as two different compounds.$IDX$,
 $IDX$2026-06-09$IDX$::date,
 $IDX$2026-06-09$IDX$::date,
 11,
 $IDX$["Teichman, S.L. et al. (2006). Prolonged Stimulation of Growth Hormone (GH) and Insulin-Like Growth Factor I Secretion by CJC-1295, a Long-Acting Analog of GH-Releasing Hormone, in Healthy Adults. Journal of Clinical Endocrinology & Metabolism, 91(3), 799-805. doi:10.1210/jc.2005-1536", "Ferdinandi, E.S. / Teichman, S.L. et al. (2006). Pulsatile secretion of growth hormone (GH) persists during continuous stimulation by CJC-1295, a long-acting GH-releasing hormone analog. (PMID 17018654)", "Alba, M. et al. (2006). Once-daily administration of CJC-1295, a long-acting GHRH analog, normalizes growth in the GHRH knockout mouse. American Journal of Physiology-Endocrinology and Metabolism, 291(6), E1290-E1294.", "Ionescu, M. & Frohman, L.A. (2006). Pulsatile Secretion of Growth Hormone (GH) Persists During Continuous Stimulation by a Modified GRF (1-29) Analogue. (Mod GRF 1-29 / CJC-1295 without DAC)", "Veldhuis, J.D. et al. (2012). Pulsatile Growth Hormone Secretion: Clinical Applications. Endocrine Reviews.", "Nass, R. et al. (2008). Growth Hormone Axis and Aging. Best Practice & Research Clinical Endocrinology & Metabolism."]$IDX$::jsonb, $IDX$[]$IDX$::jsonb, NULL,
 $IDX$Indexa Labs Research Team$IDX$,
 $IDX$intermediate$IDX$,
 $IDX$clinical-research$IDX$,
 $IDX${"obsidian_path": "Articles/cjc-1295-dac-vs-no-dac.md"}$IDX$::jsonb, false)
on conflict (id) do update set
 slug=excluded.slug, title=excluded.title, subtitle=excluded.subtitle, health_goal=excluded.health_goal,
 abstract=excluded.abstract, published_date=excluded.published_date, last_updated=excluded.last_updated,
 read_time=excluded.read_time, references_list=excluded.references_list, tags=excluded.tags,
 status=excluded.status, author=excluded.author, difficulty_level=excluded.difficulty_level,
 research_type=excluded.research_type, source=excluded.source, published=false, updated_at=now();
delete from public.guide_sections where guide_id=$IDX$cjc-1295-dac-vs-no-dac$IDX$;
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$cjc-1295-dac-vs-no-dac__tl-dr-what-dac-actually-changes$IDX$, $IDX$cjc-1295-dac-vs-no-dac$IDX$, $IDX$TL;DR: what DAC actually changes$IDX$, $IDX$"DAC" stands for **Drug Affinity Complex** — a maleimidopropionic acid group bolted onto the peptide that lets it bind covalently to albumin in your blood. That single addition is the entire difference:

- **CJC-1295 *with* DAC** binds albumin and circulates for **5.8–8.1 days** (a true half-life, measured in healthy adults). One injection keeps GH and IGF-1 elevated for the better part of a week.
- **CJC-1295 *without* DAC** — properly called **Modified GRF (1-29)**, or Mod GRF 1-29 — has no albumin anchor. Its half-life is roughly **20–50 minutes**. It produces a sharp, short burst of GH and then clears.

A naming trap worth flagging immediately: in the published literature, "CJC-1295" *means the DAC version*. The short-acting one is technically Mod GRF 1-29, even though vendors sell it as "CJC-1295 no DAC." Same backbone, opposite behaviour.$IDX$, 0);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$cjc-1295-dac-vs-no-dac__the-gh-axis-is-pulsatile-and-aging-steals-amplitude-not-baseline$IDX$, $IDX$cjc-1295-dac-vs-no-dac$IDX$, $IDX$The GH axis is pulsatile — and aging steals amplitude, not baseline$IDX$, $IDX$To see why the DAC distinction matters, you have to understand how your body releases GH in the first place. Growth hormone is not secreted at a steady level. It comes out in **pulses** — roughly every two to three hours, with about **93% of daily GH released in those pulses and only ~7% as a low basal trickle**. The largest pulse fires shortly after you fall asleep; in men it can account for 70–85% of the entire day's output.

Here is the fact that reframes the whole debate: **aging lowers the *amplitude* of those pulses, not their frequency and not the baseline.** GH output falls roughly 1% per year after age 30 (a process called somatopause), and it does so by making each pulse smaller — not by raising or lowering the quiet troughs in between (Veldhuis 2012; Nass 2008).

So if the goal is to counter age-related decline, the physiologically sensible move is to **restore pulse height while preserving the troughs**. A short-acting GHRH analog does exactly that: it amplifies the natural pulse — by up to ~2.5× — and then lets GH fall back to baseline. That return to a low trough is not a bug. It is when the AMPK and sirtuin "repair and cleanup" pathways switch on, and when you step out of the mTOR/IGF-1 "growth" state.$IDX$, 1);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$cjc-1295-dac-vs-no-dac__cjc-1295-with-dac-what-the-human-data-actually-show$IDX$, $IDX$cjc-1295-dac-vs-no-dac$IDX$, $IDX$CJC-1295 with DAC: what the human data actually show$IDX$, $IDX$The DAC version is the better-studied of the two, and the evidence is genuinely interesting — it just doesn't say what the marketing implies.

In the landmark human trial, a single subcutaneous injection of CJC-1295 raised mean plasma GH **2- to 10-fold for six or more days** and IGF-1 **1.5- to 3-fold for nine to eleven days**; with repeated weekly or twice-weekly dosing, IGF-1 stayed above baseline for up to 28 days. It was safe and reasonably well tolerated at 30–60 mcg/kg ([Teichman 2006, JCEM](https://doi.org/10.1210/jc.2005-1536)). In a GHRH-knockout mouse, once-daily CJC-1295 normalised growth (Alba 2006) — proof the molecule works as a GHRH agonist.

Now the nuance most comparison articles skip. A companion analysis found that **pulsatile GH secretion persists even during continuous CJC-1295 stimulation** ([PMID 17018654](https://pubmed.ncbi.nlm.nih.gov/17018654/)). In other words, the DAC version does *not* abolish your pulses. What it does is raise the **basal/trough GH roughly 7.5×** so that the pulses now ride on top of a permanently elevated floor. You keep the waves, but the tide never goes out.

That is the problem in one sentence: aging is lost pulse *amplitude*, and the DAC version mostly raises the *baseline* — which is the one thing aging didn't take from you.$IDX$, 2);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$cjc-1295-dac-vs-no-dac__cjc-1295-without-dac-mod-grf-1-29-the-pulsatile-cousin$IDX$, $IDX$cjc-1295-dac-vs-no-dac$IDX$, $IDX$CJC-1295 without DAC (Mod GRF 1-29): the pulsatile cousin$IDX$, $IDX$Mod GRF 1-29 is the short-acting form. Structurally it's the first 29 amino acids of GHRH with **four amino-acid substitutions** that resist enzymatic breakdown and boost potency to roughly **4× that of [sermorelin](/products/sermorelin)** in rodent assays (Ionescu 2006). Because it clears in under an hour, it produces a clean spike-and-return that mimics a natural pulse — exactly the amplitude-restoring profile described above.

The honest catch: **there are no human clinical studies on Mod GRF 1-29 itself.** Its effects are inferred from its structural parents (sermorelin and tesamorelin) and from animal pharmacology. Everything about its real-world dosing comes from physician and bodybuilding anecdote, not trials — so treat any protocol as speculative. In practice it is the GHRH base most often [stacked with ipamorelin](/blog/cjc-1295-ipamorelin-stack-gold-standard-gh-release), because a short-acting GHRH plus a selective GHRP produces a synergistic, still-pulsatile GH release. For a deeper build, see the dedicated [Mod GRF 1-29 protocol guide](/blog/cjc-1295-no-dac-growth-hormone-guide).$IDX$, 3);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$cjc-1295-dac-vs-no-dac__the-pulse-amplitude-problem-stated-plainly$IDX$, $IDX$cjc-1295-dac-vs-no-dac$IDX$, $IDX$The pulse-amplitude problem, stated plainly$IDX$, $IDX$Put the two side by side and the trade-off becomes a physiology question, not a convenience one:

| | **CJC-1295 with DAC** | **CJC-1295 no DAC (Mod GRF 1-29)** |
| --- | --- | --- |
| Half-life | 5.8–8.1 days | ~20–50 min |
| Dosing | ~1–2 mg once weekly | ~100–300 mcg, 1–3×/day |
| GH pattern | Pulses on a raised floor (basal ~7.5×) | Sharp pulse → return to baseline |
| Matches aging deficit? | No — raises baseline, not amplitude | Yes — restores amplitude |
| Human evidence | Small phase-1 PK (Teichman 2006); no outcome trials | None on the compound itself |
| Longevity logic | Persistent GH/IGF-1 keeps you in growth (mTOR) mode | Troughs preserved → repair (AMPK/sirtuin) windows intact |
| Main appeal | Fewest injections | Physiologic signal shape |

The case against the DAC version for health-and-longevity goals isn't that it doesn't raise GH — it clearly does. It's that **never returning to a low trough may be exactly what you don't want.** Chronically elevated GH and IGF-1 keep growth-signalling pathways switched on continuously. Because IGF-1 feeds (though does not by itself cause) existing cancers — epidemiology associates each +38 ng/mL of IGF-1 with roughly an 8–18% higher risk across several common cancers — and because the IGF-1–to–mortality relationship appears U-shaped, "more GH, all the time" is a poor proxy for "healthier." A signal that peaks and recedes is the more conservative choice. None of this is a verdict on any individual; it's the mechanistic reasoning researchers use, and it is exactly the kind of trade-off covered in the broader [peptide safety guide](/blog/peptide-side-effects-safety-guide-2026).$IDX$, 4);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$cjc-1295-dac-vs-no-dac__safety-notes-that-belong-in-the-comparison$IDX$, $IDX$cjc-1295-dac-vs-no-dac$IDX$, $IDX$Safety notes that belong in the comparison$IDX$, $IDX$Two DAC-specific points deserve to be on the table. First, the original **phase-2 trial of the DAC version (in HIV-associated lipodystrophy, ~120 participants) was terminated and never published after a participant death** that an adjudication deemed unrelated and cardiac in nature. That doesn't establish the drug as dangerous, but an unpublished, halted trial is a meaningful information gap. Second, the DAC version is **more prone to fluid retention** than the short-acting forms, a predictable consequence of sustained GH elevation.

The regulatory status of CJC-1295 has also been in flux — it was pulled from US compounding at one point and later reported re-allowed for prescription. Verify current status before assuming availability.$IDX$, 5);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$cjc-1295-dac-vs-no-dac__how-mechanism-minded-researchers-choose$IDX$, $IDX$cjc-1295-dac-vs-no-dac$IDX$, $IDX$How mechanism-minded researchers choose$IDX$, $IDX$Framed as research-use-only reasoning, not medical advice:

- **If the priority is matching natural physiology** (the amplitude-restoration logic above), the short-acting [CJC-1295 without DAC](/products/cjc-1295-no-dac) — ideally on a GHRH-base-plus-GHRP model — is the mechanistically coherent pick, with the loud caveat that it is unproven in humans.
- **If the only goal is minimal injections** and someone accepts the non-physiologic profile, [CJC-1295 with DAC](/products/cjc-1295-dac) exists for that reason. Most researchers prioritising longevity take it off the table.
- **If you want an actually-studied GHRH**, sermorelin and tesamorelin both have human data and a pulsatile profile — frequently a better starting point than either CJC variant for someone new to the GH axis.

On sourcing: because these two products look identical on a label, **demand a certificate of analysis (COA)** that confirms which molecule you actually have — third-party identity and purity testing matter more here than almost anywhere else in the peptide space, precisely because the names are so easily swapped.$IDX$, 6);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$cjc-1295-dac-vs-no-dac__faq$IDX$, $IDX$cjc-1295-dac-vs-no-dac$IDX$, $IDX$FAQ$IDX$, $IDX$**Is CJC-1295 DAC stronger than no DAC?**
It produces a *longer* and higher *baseline* GH elevation, not a bigger pulse. "Stronger" depends on your goal: for sustained IGF-1, DAC does more; for a natural-shaped pulse, the no-DAC form is the better match.

**Why do people say no-DAC is better for anti-aging?**
Because aging reduces GH *pulse amplitude*, not baseline. The short-acting form restores amplitude and lets GH fall back to a trough; the DAC form mainly raises the baseline and keeps you in a continuous growth-signalling state.

**Can you stack CJC-1295 no DAC with ipamorelin?**
Yes — a short-acting GHRH base plus a selective GHRP like ipamorelin is the classic combination, and the two act synergistically while keeping release pulsatile. See the [CJC-1295 + ipamorelin stack](/blog/cjc-1295-ipamorelin-stack-gold-standard-gh-release).

**Is there human research on CJC-1295 no DAC?**
Not on the compound itself. The DAC version has small phase-1 pharmacokinetic data (Teichman 2006); Mod GRF 1-29's effects are inferred from related GHRH analogs and animal work. Treat its protocols as speculative.

**What does "DAC" actually mean?**
Drug Affinity Complex — a chemical group that binds the peptide to albumin in your blood, stretching its half-life from minutes to days.$IDX$, 7);
insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ($IDX$cjc-1295-dac-vs-no-dac__references$IDX$, $IDX$cjc-1295-dac-vs-no-dac$IDX$, $IDX$References$IDX$, $IDX$1. Teichman, S.L. et al. (2006). Prolonged Stimulation of Growth Hormone (GH) and Insulin-Like Growth Factor I Secretion by CJC-1295, a Long-Acting Analog of GH-Releasing Hormone, in Healthy Adults. *J Clin Endocrinol Metab*, 91(3), 799-805. [doi:10.1210/jc.2005-1536](https://doi.org/10.1210/jc.2005-1536)
2. Pulsatile secretion of GH persists during continuous stimulation by CJC-1295, a long-acting GH-releasing hormone analog (2006). [PMID 17018654](https://pubmed.ncbi.nlm.nih.gov/17018654/)
3. Alba, M. et al. (2006). Once-daily administration of CJC-1295 normalizes growth in the GHRH knockout mouse. *Am J Physiol Endocrinol Metab*, 291(6), E1290-E1294.
4. Ionescu, M. & Frohman, L.A. (2006). Modified GRF (1-29): a potent GHRH agonist. (Mod GRF 1-29 / CJC-1295 without DAC)
5. Veldhuis, J.D. et al. (2012). Pulsatile Growth Hormone Secretion: Clinical Applications. *Endocrine Reviews*.
6. Nass, R. et al. (2008). Growth Hormone Axis and Aging. *Best Pract Res Clin Endocrinol Metab*.

---

*Research and educational use only. This article describes what has been reported in laboratory and clinical research and does not constitute medical advice, a treatment recommendation, or personalized dosing guidance. Peptides discussed are not approved for general human use except where noted. Consult a qualified clinician before making any health decision. — Indexa Labs Research Team*$IDX$, 8);
delete from public.guide_products where guide_id=$IDX$cjc-1295-dac-vs-no-dac$IDX$;
insert into public.guide_products (guide_id, product_id) values ($IDX$cjc-1295-dac-vs-no-dac$IDX$, $IDX$cjc-1295-dac$IDX$) on conflict do nothing;
insert into public.guide_products (guide_id, product_id) values ($IDX$cjc-1295-dac-vs-no-dac$IDX$, $IDX$cjc-1295-no-dac$IDX$) on conflict do nothing;
insert into public.guide_products (guide_id, product_id) values ($IDX$cjc-1295-dac-vs-no-dac$IDX$, $IDX$cjc-1295-no-dac-ipamorelin$IDX$) on conflict do nothing;
insert into public.guide_products (guide_id, product_id) values ($IDX$cjc-1295-dac-vs-no-dac$IDX$, $IDX$sermorelin$IDX$) on conflict do nothing;
insert into public.guide_products (guide_id, product_id) values ($IDX$cjc-1295-dac-vs-no-dac$IDX$, $IDX$ipamorelin$IDX$) on conflict do nothing;

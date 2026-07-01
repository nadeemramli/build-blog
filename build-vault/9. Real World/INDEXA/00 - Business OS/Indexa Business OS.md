---
title: "Indexa Business OS"
type: home
date: 2026-06-01
tags: [indexa, business-os, home]
---

# 🧬 Indexa Business OS

The operating system for **indexalabs.com** — a B2C research-grade peptide shop (Malaysia, RM). This vault is built to be run by an **AI agent + you** together: every fast-moving thing (an order, a payment, a stock move, a support chat) is captured as a small Markdown *log note*, and **Obsidian Bases** turn those notes into live tables and dashboards.

> [!abstract] The one-sentence model
> **Distribution** brings demand → **Operation** fulfils it without breaking → **Capital** makes sure every cycle leaves more cash than it consumed.

---

## The 3-Pillar Framework

| Pillar | Owns | Question it answers | Folder |
| --- | --- | --- | --- |
| 🟣 **Distribution** | Marketing, content, leads, sales | *Where does the next ringgit of revenue come from?* | `01 - Distribution` |
| 🟠 **Operation** | Process, workflows, stock, fulfilment, support | *Can we deliver every order, on time, in spec?* | `02 - Operation` |
| 🟢 **Capital** | Bookkeeping, costing, cashflow, planning | *Did the business actually make money — and can it fund the next cycle?* | `03 - Capital` |

The pillars are a loop, not silos. A single sale touches all three:

```
TikTok post (Distribution)
   → Lead → Sales Order (Distribution)
      → Stock reserved + Fulfilment + Courier (Operation)
         → Transaction recorded + COGS + margin (Capital)
            → Cash funds next ad / restock (Capital → Distribution/Operation)
```

---

## How the system is built

**Logs, not documents.** Anything that happens more than once and has a unique ID (a transaction, an order, a stock movement) is a *log note* — a tiny Markdown file whose [frontmatter properties](Data%20Model%20%26%20Conventions.md) carry the data. The body is for notes/context.

**Bases read the logs.** Each `.base` file filters log notes by tag and renders them as tables, with formulas (ROAS, margin %, available stock) computed live. You never maintain a spreadsheet — you add a note and the Base updates.

**One naming + property standard.** All IDs, statuses, and property names are defined once in **[[Data Model & Conventions]]** so the Bases, templates, and the agent all speak the same language.

**The agent operates it.** The **[[Agent Operating Manual]]** tells the AI how to create entries, what to check daily/weekly/monthly, and when to escalate to you.

---

## Start here

- 🎯 **[[Mission & Policies]]** — *read first.* What we maximise, the non-negotiable rules, the growth-stage cash plan. The constitution.
- 🌳 **[[Value Architecture — Driver Tree]]** — how business value breaks down into the levers an agent can pull (interactive version: `Driver Tree (interactive).html`)
- 🤖 **[[Agent Operating Manual]]** — daily / weekly / monthly routines the agent runs
- 🗂️ **[[Data Model & Conventions]]** — IDs, statuses, frontmatter schemas, tags
- 📊 **[[KPI Dashboard]]** — the numbers that matter, live from the Bases
- 🟣 **[[Distribution — Strategy]]**
- 🟠 **[[Operation — Playbook]]**
- 🟢 **[[Capital — Playbook]]**

---

## Tech context (current)

Storefront on Vercel + Cursor build, **Supabase** backend, **Lovable** for the admin dashboard. Channels: Instagram, Threads, X, Telegram (@indexalabs), TikTok, WhatsApp enquiry, email (nadeem@ / support@indexalabs.com). Customer-facing features: product verify, order tracking (→ WhatsApp), COA / test-report pages, membership.

> [!note] This vault vs. the app
> Supabase is the transactional source of truth the *website* runs on. This vault is the **management layer** — where you and the agent plan, log decisions, reconcile, and run the business by the numbers. Records here reference app IDs (order #, txn #) so the two stay linked without duplicating the whole database.

> [!warning] Positioning guardrail
> Indexa sells **research-grade** material. All copy, support, and content stays in *research-use* framing — no human dosing, medical claims, or therapeutic advice. This rule is enforced across Distribution content and Support replies.

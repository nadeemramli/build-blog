---
type: kb-doc
id: supabase-stacks-migration
title: "Supabase — how content reaches the website (+ optional Stacks push)"
research_use_only: true
tags: [kb-doc, supabase, migration]
---

# How the knowledge base reaches the website

## The whole picture (plain version)

```
Obsidian (markdown)  ──push──▶  Supabase (database)  ──reads──▶  indexalabs.com
   you write here                  the "guides" table              the live site
```

- The **website never reads Obsidian.** It reads **Supabase.**
- Your 86 published articles already live in the Supabase `guides` table.
- "Publish an article" = **push that note from Obsidian into `guides`.** That push is called *ingest*.
- Write more articles in Obsidian → push → they appear on the site. The KB and the site grow together. That's the entire model.

## Articles → website (already working)

You confirmed the **`ingest-content` Edge Function** already does Obsidian → `guides`. So for the core goal — write articles, publish them — **nothing new needs building.** Your loop is:

1. Write/edit an article note in `Articles/`.
2. Run your existing ingest-content push.
3. It appears on the site.

> If you ever want, I can document the exact command/trigger you use for that function so it's written down — just say so.

---

## Optional: Stacks (kept, not required)

This is the *only* thing in this folder. It's separate from articles and **you don't need it to publish content** — it's here if you later want to show/sell protocol bundles (fat-loss kit, GH-sleep kit, etc.) on the storefront. Skip it otherwise.

```
_supabase/
  migrations/0001_stacks.sql   # 3 tables: stacks, stack_components, stack_evidence
  export_vault.py              # Stacks/*.md  -> data/stacks.json
  ingest_supabase.mjs          # data/stacks.json -> Supabase
  .env.example                 # SUPABASE_URL + service_role key
  data/stacks.json             # generated (14 stacks, 128 components, 24 evidence)
```

**If/when you want stacks live:**

1. Apply the schema: Supabase → SQL Editor → paste `migrations/0001_stacks.sql` → Run. (Safe to re-run.)
2. Push the data:
   ```bash
   cd _supabase
   pip install pyyaml --break-system-packages
   python3 export_vault.py
   cp .env.example .env          # add your service_role key
   npm i @supabase/supabase-js
   node --env-file=.env ingest_supabase.mjs
   ```

The push auto-links buyable items to your `products` catalog (53 of the components matched real SKUs) and nulls the 5 that don't exist yet. Re-run any time you edit the STACK notes.

> The RAG / vector-search idea was scrapped — none of that is here anymore.

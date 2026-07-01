---
type: kb-doc
id: publishing-articles
title: "Publishing articles: Obsidian → website"
tags: [kb-doc, publishing, supabase]
---

# Publishing articles: Obsidian → website

## The flow

```
Articles/*.md  →  publish_articles.py  →  ingest-content (Edge Function)  →  Supabase `guides` (DRAFT)
   you write          builds payload          holds INGEST_KEY only            published=false
                                                                                      │
                                                          you flip published=true in Supabase Studio
                                                                                      ▼
                                                                              live on indexalabs.com
```

The website reads Supabase, never Obsidian. "Publish" = push a note into the `guides` table, then approve it in Studio. You never touch the database directly or hold the service key.

## Important: the 86 existing articles are already live

Every current `Articles/` note is **already published** in Supabase (it was mirrored from there). You do **not** re-push these. This tool is for **new** articles you write from now on. (Re-pushing an existing one as a draft can flip it back to `published=false` and pull it off the site — so the script never sends anything unless you pass `--post`.)

## One-time setup

Store the key locally so it's never pasted into chat (you likely already have this):

```bash
mkdir -p ~/.indexa
cat > ~/.indexa/ingest.env <<'EOF'
INGEST_URL=https://gqkhhfuafflcfkjczsxg.supabase.co/functions/v1/ingest-content
INGEST_KEY=ik_REPLACE_WITH_YOUR_KEY
EOF
chmod 600 ~/.indexa/ingest.env

pip install pyyaml --break-system-packages   # the script's only dependency
```

Verify the function is up (no key needed):
```bash
curl https://gqkhhfuafflcfkjczsxg.supabase.co/functions/v1/ingest-content
# {"ok": true, "service": "ingest-content"}
```

## Publish a new article

1. Write the note in `Articles/` with frontmatter (see template below).
2. **Dry-run** — build the payload and eyeball it, send nothing:
   ```bash
   cd "_publish"
   python3 publish_articles.py my-new-article.md
   # inspect out/payload.json
   ```
3. **Send as draft:**
   ```bash
   python3 publish_articles.py my-new-article.md --post
   ```
   It prints the function's JSON response (counts + any skipped/errors).
4. **Review → publish:** Supabase **Studio → Table editor → `guides`** → find the row → set `published = true`. Live within ~5 min.

Publish several at once: list multiple filenames, or `--all` for everything in `Articles/`.
Go live immediately (skip the Studio step): add `--publish` to the `--post` command — use sparingly.

## Safe end-to-end test (optional)

To confirm your key works without touching real content, push the throwaway draft from the ingest guide, then delete it in Studio:
```bash
source ~/.indexa/ingest.env
curl -s -X POST "$INGEST_URL" -H "content-type: application/json" -H "x-ingest-key: $INGEST_KEY" -d '{
  "guides":[{"id":"hello-draft","slug":"hello-draft","title":"Hello Draft","abstract":"test",
  "sections":[{"id":"intro","title":"Intro","content":"hi"}]}]
}' | jq .
# check guides table for hello-draft (published=false), then delete the row
```

## New-article frontmatter

`publish_articles.py` reads these keys (each `## heading` in the body becomes a section; the `> **Abstract:**` blockquote becomes the abstract; wikilinks are flattened to plain text):

```markdown
---
type: kb-article
id: ART-my-new-article
db_guide_id: my-new-article-guide      # the guide id in Supabase (omit for a brand-new guide; then `id` is used)
slug: my-new-article
title: "My New Article"
subtitle: "One-line hook"
health_goal: tissue-repair             # must be a known health-goal id, else stored null
read_time: 10
published: 2026-06-02
last_updated: 2026-06-02
products: [bpc-157]                     # relatedProductIds; unknown ids are skipped, not fatal
references_raw: ["Author (Year). Title. Journal."]
tags_raw: [healing]
difficulty_level: intermediate          # optional
research_type: clinical-research        # optional
---

# My New Article
*One-line hook*

> **Abstract:** Two-sentence summary shown on the card and at the top of the guide.

## 1. Overview
Body in Markdown...

## 2. Mechanism
More...
```

## Security

- `INGEST_KEY` grants **content writes only** (no orders/discounts/PII). Keep it in `~/.indexa/ingest.env` (chmod 600) — not in git or chat.
- Rotate it any time: `supabase secrets set INGEST_KEY=ik_$(openssl rand -hex 24)`, then update the local file.
- Everything lands as a draft carrying `source.obsidian_path`, auditable, and invisible until you publish.

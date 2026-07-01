#!/usr/bin/env python3
"""
INDEXA — Publish Obsidian article notes to the website.

Obsidian Articles/*.md  ->  ingest-content Edge Function  ->  Supabase `guides` (draft)
You then approve drafts in Supabase Studio to go live.

SAFE BY DEFAULT: dry-run (builds the JSON, posts nothing). Add --post to send.

Usage:
    python3 publish_articles.py NOTE.md [NOTE2.md ...]   # dry-run one or more notes
    python3 publish_articles.py --all                    # dry-run every Articles/*.md
    python3 publish_articles.py NOTE.md --post           # send as DRAFT (publish=false)
    python3 publish_articles.py NOTE.md --post --publish  # send AND go live (careful)

Auth (only needed with --post): reads INGEST_URL and INGEST_KEY from
~/.indexa/ingest.env  (never printed, never committed).

Mapping: kb-article frontmatter -> guide payload; each "## heading" -> a section.
Wikilinks [[X|alias]] are flattened to plain text (the website isn't Obsidian).
"""
import os, re, sys, json, glob, argparse, urllib.request

try:
    import yaml
except ImportError:
    sys.exit("pip install pyyaml --break-system-packages")

HERE = os.path.dirname(os.path.abspath(__file__))
KB_ROOT = os.path.dirname(HERE)
ARTICLES = os.path.join(KB_ROOT, "Articles")
OUT = os.path.join(HERE, "out"); os.makedirs(OUT, exist_ok=True)

WIKILINK = re.compile(r"\[\[([^\]|]+)\|([^\]]+)\]\]")        # [[X|alias]] -> alias
WIKILINK2 = re.compile(r"\[\[([^\]]+)\]\]")                  # [[X]] -> X
def deobsidian(t):
    t = WIKILINK.sub(r"\2", t)
    t = WIKILINK2.sub(r"\1", t)
    return t

def slugify(s):
    s = re.sub(r"^\s*\d+(\.\d+)*\.?\s*", "", s)              # drop leading "2." / "2.1"
    s = re.sub(r"[^a-z0-9]+", "-", s.lower()).strip("-")
    return s or "section"

def split_note(path):
    raw = open(path, encoding="utf-8").read()
    if raw.startswith("---"):
        end = raw.index("\n---", 3)
        return (yaml.safe_load(raw[3:end]) or {}), raw[end+4:].lstrip("\n")
    return {}, raw

def build_guide(path):
    fm, body = split_note(path)
    # --- abstract: from the "> **Abstract:** ..." blockquote, else subtitle ---
    mab = re.search(r"(?mi)^>\s*\*\*Abstract:\*\*\s*(.+)$", body)
    abstract = (mab.group(1).strip() if mab else str(fm.get("subtitle") or "")).strip()
    # --- sections: everything under each "## heading" ---
    sections, seen = [], set()
    for m in re.finditer(r"(?m)^##\s+(.*)$", body):
        title = m.group(1).strip()
        start = m.end()
        nxt = re.search(r"(?m)^##\s", body[start:])
        content = body[start:start + (nxt.start() if nxt else len(body) - start)].strip()
        sid = slugify(title); n = 1
        while sid in seen: n += 1; sid = f"{slugify(title)}-{n}"
        seen.add(sid)
        sections.append({"id": sid, "title": title, "content": deobsidian(content)})
    # --- id: prefer the existing live guide id ---
    gid = fm.get("db_guide_id") or re.sub(r"^ART-", "", str(fm.get("id") or "")) or fm.get("slug")
    guide = {
        "id": gid,
        "slug": fm.get("slug"),
        "title": str(fm.get("title") or "").strip(),
        "subtitle": str(fm.get("subtitle") or ""),
        "abstract": abstract,
        "healthGoal": fm.get("health_goal"),
        "publishedDate": str(fm.get("published") or "") or None,
        "lastUpdated": str(fm.get("last_updated") or "") or None,
        "readTime": fm.get("read_time"),
        "relatedProductIds": list(fm.get("products") or []),
        "references": list(fm.get("references_raw") or []),
        "tags": list(fm.get("tags_raw") or []),
        "author": fm.get("author") or "Indexa Labs Research Team",
        "sections": sections,
        "source": {"obsidian_path": os.path.relpath(path, KB_ROOT).replace("\\", "/")},
    }
    if fm.get("difficulty_level"): guide["difficultyLevel"] = fm["difficulty_level"]
    if fm.get("research_type"):    guide["researchType"]    = fm["research_type"]
    if fm.get("status"):           guide["status"]          = fm["status"]
    # drop empty/None keys
    return {k: v for k, v in guide.items() if v not in (None, "", [])}, bool(fm.get("db_guide_id"))

def load_env():
    p = os.path.expanduser("~/.indexa/ingest.env")
    if not os.path.exists(p):
        sys.exit(f"Missing {p} (needs INGEST_URL and INGEST_KEY). See the runbook.")
    env = {}
    for line in open(p):
        line = line.strip()
        if line and not line.startswith("#") and "=" in line:
            k, v = line.split("=", 1); env[k.strip()] = v.strip()
    return env

def post(payload):
    env = load_env()
    req = urllib.request.Request(
        env["INGEST_URL"], data=json.dumps(payload).encode(),
        headers={"content-type": "application/json", "x-ingest-key": env["INGEST_KEY"]},
        method="POST")
    with urllib.request.urlopen(req, timeout=60) as r:
        return r.status, json.loads(r.read().decode())

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("notes", nargs="*")
    ap.add_argument("--all", action="store_true", help="all Articles/*.md")
    ap.add_argument("--post", action="store_true", help="actually send (else dry-run)")
    ap.add_argument("--publish", action="store_true", help="publish=true (go live). default draft.")
    args = ap.parse_args()

    paths = sorted(glob.glob(os.path.join(ARTICLES, "*.md"))) if args.all else \
            [p if os.path.isabs(p) else os.path.join(ARTICLES, p) for p in args.notes]
    if not paths:
        sys.exit("Give note filename(s) or --all.")

    guides, existing = [], []
    for p in paths:
        if not os.path.exists(p): sys.exit(f"Not found: {p}")
        g, is_existing = build_guide(p)
        guides.append(g)
        if is_existing: existing.append(g["id"])

    payload = {"publish": bool(args.publish), "guides": guides}
    out_file = os.path.join(OUT, "payload.json")
    json.dump(payload, open(out_file, "w", encoding="utf-8"), ensure_ascii=False, indent=2, default=str)

    print(f"Built {len(guides)} guide(s); publish={payload['publish']}")
    for g in guides:
        print(f"  - {g['id']:42s} {len(g.get('sections', []))} sections  ({g.get('slug')})")
    print(f"  payload -> {out_file}")
    if existing:
        print(f"\n  NOTE: {len(existing)} of these target EXISTING live guide ids "
              f"(db_guide_id).\n  With --post --publish they update in place; with --post alone "
              f"they may revert to DRAFT.\n  IDs: {', '.join(existing[:6])}{' ...' if len(existing)>6 else ''}")

    if not args.post:
        print("\nDRY-RUN — nothing sent. Re-run with --post to send.")
        return
    status, resp = post(payload)
    print(f"\nPOST {status}:")
    print(json.dumps(resp, indent=2)[:1500])

if __name__ == "__main__":
    main()

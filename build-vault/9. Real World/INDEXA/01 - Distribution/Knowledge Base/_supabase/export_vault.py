#!/usr/bin/env python3
"""
INDEXA — Export the Layer-3 Stacks from the Obsidian vault to JSON.

Reads Stacks/*.md and writes data/stacks.json (stacks + components + evidence),
ready for ingest_supabase.mjs to push into the stacks tables.

(Articles are NOT handled here — those already flow Obsidian -> Supabase
 `guides` via the existing ingest-content Edge Function.)

Usage:
    pip install pyyaml --break-system-packages
    python3 export_vault.py            # KB root auto-detected as parent of _supabase/
"""
import os, re, sys, json, glob

try:
    import yaml
except ImportError:
    sys.exit("Missing dependency: pip install pyyaml --break-system-packages")

HERE = os.path.dirname(os.path.abspath(__file__))
KB_ROOT = sys.argv[1] if len(sys.argv) > 1 else os.path.dirname(HERE)
OUT = os.path.join(HERE, "data"); os.makedirs(OUT, exist_ok=True)

WIKILINK = re.compile(r"\[\[([^\]|]+)(?:\|[^\]]+)?\]\]")
def unlink(v):
    if not isinstance(v, str): return None
    m = WIKILINK.search(v)
    return (m.group(1) if m else v).strip()

def split_note(path):
    raw = open(path, encoding="utf-8").read()
    if raw.startswith("---"):
        end = raw.index("\n---", 3)
        return (yaml.safe_load(raw[3:end]) or {}), raw[end+4:].lstrip("\n")
    return {}, raw

def section(body, title):
    m = re.search(rf"(?m)^##\s+{re.escape(title)}\s*$", body)
    if not m: return ""
    start = m.end()
    nxt = re.search(r"(?m)^##\s", body[start:])
    return body[start:start + (nxt.start() if nxt else len(body) - start)].strip()

def note_id(fm, path):
    return str(fm.get("id") or os.path.splitext(os.path.basename(path))[0]).strip()

# peptide/compound note -> catalog product slug (for "shop this stack")
product_map = {}
for folder in ("Peptides", "Compounds"):
    for p in glob.glob(os.path.join(KB_ROOT, folder, "*.md")):
        fm, _ = split_note(p)
        if fm.get("product"): product_map[note_id(fm, p)] = str(fm["product"]).strip()

# paper note -> pmid/url for evidence rows
paper_meta = {}
for p in glob.glob(os.path.join(KB_ROOT, "Papers", "*.md")):
    fm, _ = split_note(p)
    paper_meta[note_id(fm, p)] = {
        "pmid": str(fm.get("pmid")) if fm.get("pmid") else None,
        "url": fm.get("url"), "citation": fm.get("title"),
    }

EV = {"clinical","mixed","anecdotal","theoretical"}
stacks, components, evidence = [], [], []

for p in sorted(glob.glob(os.path.join(KB_ROOT, "Stacks", "*.md"))):
    fm, body = split_note(p)
    nid = note_id(fm, p)                     # 'STACK-fat-loss'
    slug = re.sub(r"^STACK-", "", nid)       # 'fat-loss'
    ev = str(fm.get("evidence") or "").lower()
    stacks.append({
        "id": slug, "name": str(fm.get("title") or slug), "goal": str(fm.get("goal") or ""),
        "summary": section(body, "Why it synergises (three layers)")[:600],
        "evidence_tier": ev if ev in EV else None,
        "why_it_synergises": section(body, "Why it synergises (three layers)"),
        "timing_intake": section(body, "Timing & intake"),
        "cautions": section(body, "Cautions & interactions") or section(body, "Cautions"),
        "evidence_backing": section(body, "Evidence backing"),
        "monitoring": section(body, "Monitoring"),
        "research_use_only": bool(fm.get("research_use_only", True)),
        "source": {"note_id": nid, "vault_path": os.path.relpath(p, KB_ROOT).replace("\\","/")},
        "published": True, "sort_order": 0,
    })
    order = 0
    for field, ctype in (("peptides","peptide"),("compounds","compound"),
                         ("supplements","supplement"),("behaviors","behavior")):
        for v in (fm.get(field) or []):
            ref = unlink(v)
            if not ref: continue
            components.append({
                "stack_id": slug, "component_type": ctype, "ref_id": ref, "display_name": ref,
                "product_id": product_map.get(ref) if ctype in ("peptide","compound") else None,
                "role": "", "dose": None, "timing": None, "intake_notes": None, "sort_order": order,
            }); order += 1
    for i, v in enumerate(fm.get("backed_by") or fm.get("sources") or []):
        ref = unlink(v)
        if not ref: continue
        kind = ("paper" if ref.startswith("PAPER-") else
                "transcript" if ref.startswith("TRANSCRIPT-") else
                "protocol" if ref.startswith("SOURCE-") else "guide")
        meta = paper_meta.get(ref, {})
        evidence.append({"stack_id": slug, "kind": kind, "ref_id": ref,
                         "citation": meta.get("citation") or "", "pmid": meta.get("pmid"),
                         "url": meta.get("url"), "note": "", "sort_order": i})

json.dump({"stacks": stacks, "stack_components": components, "stack_evidence": evidence},
          open(os.path.join(OUT, "stacks.json"), "w", encoding="utf-8"),
          ensure_ascii=False, indent=2, default=str)
print(f"stacks: {len(stacks)}  components: {len(components)}  evidence: {len(evidence)}")
print(f"  components linked to catalog products: {sum(1 for c in components if c['product_id'])}")
print(f"-> wrote {os.path.join(OUT,'stacks.json')}")

import json, os
d=json.load(open('payload.json'))
ALLOWED_RT={'clinical-research','anecdotal','theoretical','protocol-guide'}
ALLOWED_DIFF={'beginner','intermediate','advanced'}

def dq(s):
    # dollar-quote with a tag guaranteed not to appear
    tag="IDX"; 
    i=0
    while f"${tag}$" in (s or ""):
        i+=1; tag=f"IDX{i}"
    return f"${tag}$"+(s or "")+f"${tag}$"

def jlit(obj):
    return dq(json.dumps(obj, ensure_ascii=False))

os.makedirs('sql',exist_ok=True)
manifest=[]
for g in d['guides']:
    gid=g['id']
    rt=g.get('researchType'); rt = rt if rt in ALLOWED_RT else None
    diff=g.get('difficultyLevel'); diff = diff if diff in ALLOWED_DIFF else None
    refs=g.get('references',[]) or []
    tags=g.get('tags',[]) or []
    src=g.get('source',{}) or {}
    prods=g.get('relatedProductIds',[]) or []
    def val(x): return 'NULL' if x is None else (str(x) if isinstance(x,(int,float)) else dq(str(x)))
    sql=[]
    sql.append("-- guide: "+gid)
    sql.append(f"""insert into public.guides
(id, slug, title, subtitle, health_goal, abstract, published_date, last_updated, read_time,
 references_list, tags, status, author, difficulty_level, research_type, source, published)
values (
 {dq(gid)}, {dq(g.get('slug'))}, {dq(g.get('title'))}, {dq(g.get('subtitle') or '')},
 {val(g.get('healthGoal'))}, {dq(g.get('abstract') or '')},
 {('NULL' if not g.get('publishedDate') else dq(g['publishedDate']))}::date,
 {('NULL' if not g.get('lastUpdated') else dq(g['lastUpdated']))}::date,
 {('NULL' if g.get('readTime') is None else int(g['readTime']))},
 {jlit(refs)}::jsonb, {jlit(tags)}::jsonb, NULL,
 {dq(g.get('author') or 'Indexa Labs Research Team')},
 {('NULL' if diff is None else dq(diff))},
 {('NULL' if rt is None else dq(rt))},
 {jlit(src)}::jsonb, false)
on conflict (id) do update set
 slug=excluded.slug, title=excluded.title, subtitle=excluded.subtitle, health_goal=excluded.health_goal,
 abstract=excluded.abstract, published_date=excluded.published_date, last_updated=excluded.last_updated,
 read_time=excluded.read_time, references_list=excluded.references_list, tags=excluded.tags,
 status=excluded.status, author=excluded.author, difficulty_level=excluded.difficulty_level,
 research_type=excluded.research_type, source=excluded.source, published=false, updated_at=now();""")
    # sections: delete then insert
    sql.append(f"delete from public.guide_sections where guide_id={dq(gid)};")
    for i,sec in enumerate(g['sections']):
        secid=f"{gid}__{sec['id']}"
        sql.append(f"""insert into public.guide_sections (id, guide_id, title, content, sort_order)
values ({dq(secid)}, {dq(gid)}, {dq(sec['title'])}, {dq(sec['content'])}, {i});""")
    # guide_products: replace
    sql.append(f"delete from public.guide_products where guide_id={dq(gid)};")
    for p in prods:
        sql.append(f"insert into public.guide_products (guide_id, product_id) values ({dq(gid)}, {dq(p)}) on conflict do nothing;")
    open(f'sql/{gid}.sql','w',encoding='utf-8').write("\n".join(sql)+"\n")
    manifest.append((gid,len(g['sections']),len(prods),rt,diff))

print("Generated per-guide SQL:")
for m in manifest: print(" ",m)

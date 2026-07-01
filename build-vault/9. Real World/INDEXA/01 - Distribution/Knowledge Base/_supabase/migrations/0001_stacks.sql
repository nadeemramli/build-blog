-- ============================================================================
-- INDEXA — Migration 0001: Layer-3 "Stacks" relational schema
-- ----------------------------------------------------------------------------
-- Pushes the Obsidian STACK-* goal-protocol notes to the storefront as
-- queryable, shoppable protocols.
--
-- Mirrors existing conventions in this project:
--   * slug text primary keys (like products.id, guides.id, categories.id)
--   * `source` jsonb provenance column (like products.source / guides.source)
--   * `published` boolean gate (storefront shows only published rows)
--   * sort_order + created_at/updated_at(now())
--   * RLS enabled, anon/authenticated may SELECT only published rows,
--     service_role (ingestion) bypasses RLS automatically.
--
-- Safe to re-run: every object uses IF NOT EXISTS / CREATE OR REPLACE.
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 0. Shared updated_at trigger (self-contained; no extension dependency)
-- ---------------------------------------------------------------------------
create or replace function public.tg_set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

-- ---------------------------------------------------------------------------
-- 1. stacks — one row per STACK-* note
-- ---------------------------------------------------------------------------
create table if not exists public.stacks (
  id                text primary key,                 -- slug, e.g. 'fat-loss' (from STACK-fat-loss)
  name              text not null,                    -- frontmatter `title`
  goal              text not null default '',         -- frontmatter `goal` (banner)
  summary           text not null default '',         -- "Why it synergises" abstract
  health_goal       text references public.health_goals(id) on delete set null,  -- optional link into existing taxonomy
  evidence_tier     text check (evidence_tier in ('clinical','mixed','anecdotal','theoretical')),  -- frontmatter `evidence`
  why_it_synergises text not null default '',          -- 3-layer rationale (markdown)
  timing_intake     text not null default '',          -- "Timing & intake" section
  cautions          text not null default '',          -- "Cautions & interactions" section
  evidence_backing  text not null default '',          -- "Evidence backing" section
  monitoring        text not null default '',          -- "Monitoring" section
  research_use_only boolean not null default true,     -- policy §9
  source            jsonb,                             -- {vault_path, note_id, captured}
  published         boolean not null default false,    -- drafts hidden from storefront
  sort_order        integer not null default 0,
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now()
);
comment on table public.stacks is
  'Layer-3 goal-protocol stacks (fat-loss, gh-sleep, healing, ...). Mirrors Obsidian STACK-* notes. research_use_only by policy; never medical advice.';

drop trigger if exists set_updated_at on public.stacks;
create trigger set_updated_at before update on public.stacks
  for each row execute function public.tg_set_updated_at();

-- ---------------------------------------------------------------------------
-- 2. stack_components — items inside a stack (peptide / compound / supplement / behavior)
--    product_id links buyable items to the catalog for "shop this stack".
-- ---------------------------------------------------------------------------
create table if not exists public.stack_components (
  id             uuid primary key default gen_random_uuid(),
  stack_id       text not null references public.stacks(id) on delete cascade,
  component_type text not null check (component_type in ('peptide','compound','supplement','behavior')),
  ref_id         text not null,                        -- atomic-note id/slug (e.g. 'BPC-157', 'Sauna')
  display_name   text not null,
  product_id     text references public.products(id) on delete set null,  -- nullable: catalog link
  role           text not null default '',             -- why it's in the stack
  dose           text,                                 -- e.g. '250-500 mcg/day SubQ'
  timing         text,                                 -- e.g. 'AM fasted'
  intake_notes   text,                                 -- fasted/fed, absorption, cycling
  sort_order     integer not null default 0,
  created_at     timestamptz not null default now(),
  updated_at     timestamptz not null default now()
);
create index if not exists stack_components_stack_id_idx   on public.stack_components (stack_id);
create index if not exists stack_components_product_id_idx on public.stack_components (product_id);
create index if not exists stack_components_type_idx       on public.stack_components (component_type);
comment on table public.stack_components is
  'Items within a stack. product_id links buyable peptides/compounds to the catalog. Behaviors/supplements without a SKU keep product_id null.';

drop trigger if exists set_updated_at on public.stack_components;
create trigger set_updated_at before update on public.stack_components
  for each row execute function public.tg_set_updated_at();

-- ---------------------------------------------------------------------------
-- 3. stack_evidence — backing for each stack (policy §9: every stack cites a
--    paper, applied-protocol transcript, or guide).
-- ---------------------------------------------------------------------------
create table if not exists public.stack_evidence (
  id         uuid primary key default gen_random_uuid(),
  stack_id   text not null references public.stacks(id) on delete cascade,
  kind       text not null check (kind in ('paper','transcript','protocol','guide')),
  ref_id     text not null,                            -- PAPER-... / TRANSCRIPT-... / guide slug
  citation   text not null default '',
  pmid       text,
  url        text,
  note       text not null default '',                 -- which claim this backs
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);
create index if not exists stack_evidence_stack_id_idx on public.stack_evidence (stack_id);
comment on table public.stack_evidence is
  'Evidence backing per stack. kind=paper|transcript|protocol|guide. Enforces the "cite a paper or applied protocol" policy in data.';

-- ---------------------------------------------------------------------------
-- 4. Row-Level Security — anon/authenticated read published only.
--    service_role (used by the ingestion script) bypasses RLS, so no
--    write policies are needed for the agent pipeline.
-- ---------------------------------------------------------------------------
alter table public.stacks            enable row level security;
alter table public.stack_components  enable row level security;
alter table public.stack_evidence    enable row level security;

drop policy if exists stacks_read_published on public.stacks;
create policy stacks_read_published on public.stacks
  for select to anon, authenticated
  using (published = true);

drop policy if exists stack_components_read_published on public.stack_components;
create policy stack_components_read_published on public.stack_components
  for select to anon, authenticated
  using (exists (select 1 from public.stacks s where s.id = stack_id and s.published));

drop policy if exists stack_evidence_read_published on public.stack_evidence;
create policy stack_evidence_read_published on public.stack_evidence
  for select to anon, authenticated
  using (exists (select 1 from public.stacks s where s.id = stack_id and s.published));

-- ---------------------------------------------------------------------------
-- 5. Convenience view: a stack with its buyable catalog products (for
--    "shop this stack" + cross-sell). Respects RLS of the underlying tables.
-- ---------------------------------------------------------------------------
create or replace view public.stack_products
  with (security_invoker = true) as
  select c.stack_id, c.product_id, c.display_name, c.role, c.dose, c.sort_order
  from public.stack_components c
  where c.product_id is not null;
comment on view public.stack_products is
  'Buyable products referenced by each stack (component_type peptide/compound with a catalog product_id).';

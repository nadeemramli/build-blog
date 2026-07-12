---
draft: false
title: "TRD - 3 (Reference Architecture Research)"
date: "2026-07-12"
tags:
  - bookie
  - research
---

# TRD - 3: Reference Architecture Research

Research for PBK-10. Bookie is a private, local-first personal knowledge library: Tauri desktop app (Rust core + SQLite index), a library folder of EPUB/PDF/markdown files as the source of truth, remote sync later for mobile, Obsidian export, and a knowledge layer (local embeddings, group-scoped RAG chat, MCP server). This note studies the reference systems (Reader/Readwise) and the component landscape, and commits to an architecture at the end.

---

## 1. Reader by Readwise: architecture

### What is publicly known

**Local-first, shared-core, cross-platform.** Readwise describes Reader as having a "local-first, cross-platform architecture enabling blazingly fast interactions and full-text search across all of your devices (even offline)" — a local-first *web* app plus React Native iOS/Android apps and browser extensions ([announcement post](https://blog.readwise.io/readwise-reading-app/)). Their careers page confirms the stack: TypeScript/React on web, React Native on mobile, with a backend that handles "reliable ingestion and sync pipelines" on Postgres ([careers](https://readwise.io/careers/senior-staff-engineer)). So the shape is: **server is the durable source of truth; every client keeps a full local replica of the user's library and syncs continuously**, which is why full-text search works offline. Full engineering details (their sync protocol, local store) are not published.

**Ingestion pipeline.** Everything — web article, PDF, EPUB, newsletter, RSS item, YouTube transcript, Twitter thread — is ingested into "one inbox with consistent annotation tools across all formats" ([readwise.io/read](https://readwise.io/read), [review](https://www.speedreadinglounge.com/readwise-reader-review)). In practice Reader normalizes almost everything (articles, EPUB chapters, newsletters, transcripts) into its own cleaned HTML reading document; parsing of web pages happens server-side when you save a URL, and the browser extension can capture the rendered DOM from your browser for paywalled/JS-heavy pages. The single normalized HTML representation is what makes "consistent annotation across formats" possible.

**PDF is the exception — and the cautionary tale.** Reader's own FAQ says PDFs are rendered by "a specialized service" as a series of page images with a separate "Enhanced text mode" (reflowed plain text). Consequences they document ([PDF FAQ](https://docs.readwise.io/reader/docs/faqs/pdfs)):

- Highlights made in text view **are not visible** in the default PDF view and vice versa — two views means two anchoring coordinate spaces.
- Cross-page highlighting isn't possible without reflow.
- Extracted PDF highlight text contains "random line breaks due to underlying text glitches" that users must clean manually.
- Highlights already embedded in a PDF by other apps can't be imported as first-class highlights.

**Lesson for Bookie:** never split a document into two annotation spaces. Anchor PDF highlights in one canonical space (page + text) and derive both the visual overlay and the extracted text from it.

**Highlight anchoring (inferred + industry standard).** Reader doesn't document its anchoring, but the robust, well-documented industry approach for HTML content is the [W3C Web Annotation Data Model](https://www.w3.org/TR/annotation-model/) multi-selector scheme as implemented by Hypothesis: store a **RangeSelector** (DOM path), a **TextPositionSelector** (char offsets into normalized text), and a **TextQuoteSelector** (exact text + ~32 chars of prefix/suffix context), then re-anchor with a cascade of strategies where each selector "hints" the next, falling back to fuzzy full-text search of the quote ([Hypothesis "Fuzzy Anchoring"](https://web.hypothes.is/blog/fuzzy-anchoring/), [W3C Robust Anchoring slides](https://www.w3.org/2014/04/annotation/slides/RobustAnchoring.pdf)). For EPUB, the standard is [EPUB Canonical Fragment Identifiers (CFI)](https://w3c.github.io/epub-specs/epub33/epubcfi/) — a structural path (spine step + DOM steps + char offset, optionally a range) — which is what epub.js's annotation layer uses ([epub.js annotations](https://deepwiki.com/futurepress/epub.js/5.1-annotations-system)). CFI is precise but brittle: it breaks if the HTML is re-normalized differently, which is why serious systems pair it with a text-quote fallback.

**Position tracking.** Reading position in reflowed formats is a location in the same coordinate space as highlights (Reader shows percentage progress and syncs it across devices); for paged PDF it's a page index. The generalizable design: store position as *(document version, anchor)* using the same anchor machinery as highlights, so position survives re-parsing.

### Recommendation for Bookie

- Copy the **"normalize everything to one clean reading document"** idea: articles, EPUB chapters, and markdown all become the same internal HTML/markdown-backed reading surface with one annotation model. PDFs stay paged but get **one** anchoring space, not two.
- Adopt the **W3C multi-selector + Hypothesis fuzzy re-anchoring** model as the universal highlight format, with format-specific primary selectors (CFI for EPUB, page+quads for PDF) layered on top. Details in §6.
- Bookie's twist vs Reader: Reader's source of truth is their server; Bookie's is the library folder. That removes the hardest part of their architecture (multi-client server sync) for v1 — see §4.

---

## 2. Readwise sync/export model

### Highlights API (ingest side)

The public [Readwise API](https://readwise.io/api_deets) shows how they keep highlight sync sane across dozens of integrations:

- **Idempotent create:** `POST /api/v2/highlights/` deduplicates on the 4-tuple *(title, author, text, source_url)* — resubmitting the same highlight "will do nothing rather than create a duplicate." Updates are done by resubmitting with the same `highlight_url`. Every integration can therefore blindly re-push its full state; the server converges.
- **Cursor-based export:** `GET /api/v2/export/` paginates with `pageCursor`, and incremental sync is `updatedAfter=<ISO 8601>` (+ `includeDeleted`). Recommended client flow: full historical fetch once, then periodic `updatedAfter` polls.
- Rate limits: 240 req/min general, 20 req/min on list endpoints, with `Retry-After` on 429.

### The official Obsidian plugin protocol (export side)

Read from source: [readwiseio/obsidian-readwise](https://github.com/readwiseio/obsidian-readwise) (`src/main.ts`). The protocol is notably **server-rendered and artifact-based**, not a client-side templating engine:

1. **Init:** client calls `GET /api/obsidian/init?parentPageDeleted=...` (Token auth header + a per-install `Obsidian-Client` id). Server responds 201 ("export being built") with a `latest_id` statusID, or 200 ("already up to date").
2. **Server builds the export:** all markdown is rendered *server-side* from the user's Jinja2 templates ([export docs](https://docs.readwise.io/readwise/docs/exporting-highlights/obsidian)); the client never formats highlights.
3. **Poll:** `GET /api/get_export_status?exportStatusId=...` until `taskStatus` = `SUCCESS` (states: PENDING/RECEIVED/STARTED/RETRY), with progress = booksExported/totalBooks.
4. **Download artifacts:** status response lists `artifactIds`; each is fetched via `GET /api/v2/download_artifact/{id}` as a **zip of markdown files**.
5. **Write files with edit protection:** the plugin keeps `booksIDsMap` (vault file path → book id) and compares an **MD5 hash of current file content vs `last_content_hash`** from the server. If the user edited the file locally, the plugin **appends** new highlights instead of overwriting — the documented "append-only, nothing in Obsidian will ever be overwritten" guarantee.
6. **Repair paths:** deleting a file (or wanting a re-render) triggers `POST /api/refresh_book_export` with `userBookIds`/`readerDocumentIds` to queue full re-export of specific books; failures are queued in `failedBooks` for retry; renames just update `booksIDsMap`.
7. **Ack:** `POST /api/obsidian/sync_ack?statusID=...` marks the export delivered so it isn't re-downloaded — classic at-least-once delivery with client acknowledgment.

Sync state on the client is tiny: `lastSavedStatusID`, `currentSyncStatusID`, `isSyncing`, `booksIDsMap`.

### Recommendation for Bookie

- **Steal the export design wholesale** for Bookie → Obsidian export (running locally, no server needed): deterministic file naming + an id→path map, user-editable templates, **content-hash check → append-only when the user has edited the note**, per-book "refresh" to force a clean re-render, and a persisted cursor (`last_export_seq`) so exports are incremental.
- **Steal the ingest design** for Bookie's future sync API and for MCP write access: idempotent upsert keyed on a natural identity (Bookie should use a **highlight UUID** rather than Readwise's fuzzy 4-tuple, since we control both ends), plus `updatedAfter`-style incremental reads with tombstones (`includeDeleted`).

---

## 3. Article scrape-to-markdown

### Landscape

- **[Mozilla Readability](https://github.com/mozilla/readability)** (JS): the battle-tested baseline (Firefox Reader View). Criticized as overly conservative — it can drop useful content — and outputs HTML, leaving markdown conversion (Turndown etc.) to you ([HN discussion](https://news.ycombinator.com/item?id=44067409)).
- **[Defuddle](https://github.com/kepano/defuddle)** (JS, MIT, by Obsidian's Steph Ango; powers **Obsidian Web Clipper**): the current best-in-class for *note-taking-grade* markdown. More forgiving than Readability (multi-pass detection, removes fewer uncertain elements), uses the page's *mobile stylesheet* to find hideable clutter, extracts rich metadata incl. schema.org, and — key differentiator — **standardizes output**: footnotes to a canonical reference format, math to MathML, code blocks with language preserved, callouts to blockquote form, and direct markdown output. Runs in a browser or server-side via JSDOM/linkedom ([repo](https://github.com/kepano/defuddle), [analysis](https://biggo.com/news/202505240122_Defuddle_Web_Content_Extractor)).
- **[Trafilatura](https://trafilatura.readthedocs.io/en/latest/evaluation.html)** (Python): consistently tops extraction benchmarks and does extraction + markdown in one step — the accuracy reference, but a Python dependency doesn't fit a Tauri app.
- **[Monolith](https://github.com/Y2Z/monolith)** (Rust, CLI + library): saves a complete page as a single HTML file with all assets inlined as `data:` URIs. No JS execution (can be fed pre-rendered HTML from a headless browser). This is the *snapshot/archival* tool, not an extractor.
- **Rust extractors:** **[dom_smoothie](https://github.com/niklak/dom_smoothie)** is a faithful Rust port of readability.js (same scoring algorithm) with metadata extraction (JSON-LD, meta tags) and a direct `TextMode::Markdown` output ([how it works](https://webcrawlerapi.com/blog/how-dom-smoozie-rust-mozilla-readability-alternative-works)); [readability-js](https://docs.rs/readability-js/latest/readability_js/) embeds actual Readability.js via an embedded JS engine. For HTML→MD conversion, **htmd** (Turndown-inspired) is the pairing used by tools like [twars-url2md](https://lib.rs/crates/twars-url2md) (monolith for capture + htmd for conversion); [html2md](https://lib.rs/crates/html2md) is the older option. A broad comparison of 13 Rust HTML-processing crates: [emschwartz.me](https://emschwartz.me/comparing-13-rust-crates-for-extracting-text-from-html/).

### The Tauri advantage

A Tauri app *ships a real webview*. That means Bookie doesn't have to choose between "pure Rust" and "best-quality JS extraction":

- **Headless path** (RSS, most articles): `reqwest` fetch → `dom_smoothie` in the Rust core. No JS execution, fast, no webview needed.
- **Rendered-DOM path** (JS-heavy/paywalled pages, "clip current page"): load the page in a (hidden or visible) Tauri webview or capture from a companion browser extension, run **Defuddle** in that JS context (it's built for exactly this), and hand clean markdown + metadata back to Rust over IPC. This is precisely the Obsidian Web Clipper architecture.

### Asset snapshots

Because Bookie's library is a folder of files, the durable artifact should be **markdown + a local asset folder**: after extraction, download every referenced image into `article-slug/assets/` and rewrite links to relative paths (Obsidian-compatible). Optionally also store a monolith-style single-file HTML snapshot next to it as a full-fidelity archive for pages where markdown loses too much.

### Recommendation for Bookie

- Two-lane pipeline: **dom_smoothie (Rust) for headless ingestion; Defuddle-in-webview for interactive clipping**. Both lanes converge on the same output contract: frontmatter (title, author, published, source_url, saved_at) + markdown body + localized assets.
- Use monolith-style full-page snapshots only as an optional "archive copy," not the primary format.

---

## 4. Local-first data layer for Tauri

### Framing: files are the truth, the DB is a cache

Bookie's defining constraint: the library folder (EPUB/PDF/markdown + annotation sidecars) is the source of truth, and SQLite is a **rebuildable index**. This is the inverse of Reader (server truth) and it collapses most of the local-first problem space: anything in the DB can be regenerated by rescanning files, so DB corruption, schema migration, and cross-device consistency all reduce to "re-index."

### Index stack: SQLite + FTS5 + sqlite-vec vs LanceDB

- **[SQLite FTS5](https://www.sqlite.org/fts5.html)** is the obvious full-text layer: mature, single-file, BM25 ranking, prefix queries, external-content tables so the text isn't stored twice.
- **[sqlite-vec](https://github.com/asg017/sqlite-vec)** (successor to sqlite-vss): vector search as a SQLite extension, runs anywhere SQLite does (incl. mobile later). It is **brute-force KNN** — no ANN index — which is a real limitation past ~1M vectors ([comparison](https://shaharia.com/blog/choosing-embeddable-vector-database-go-application/)), and metadata filtering is still maturing ([tracking issue #26](https://github.com/asg017/sqlite-vec/issues/26)); development cadence has been slow (v0.1.x alphas through 2025, [releases](https://github.com/asg017/sqlite-vec/releases)). But scale math for a personal library is decisive: even 5,000 documents × ~100 chunks = 500K vectors is the worst case, and a realistic library is well under 100K — brute force over that in SQLite is milliseconds, and "pragmatic winner when full platform coverage matters" is the consensus for embedded single-user use ([dev.to overview](https://dev.to/aairom/embedded-intelligence-how-sqlite-vec-delivers-fast-local-vector-search-for-ai-3dpb)).
- **[LanceDB](https://cybergarden.au/blog/5-powerful-vector-database-tools-2025)** (embedded mode): Arrow columnar storage, memory-mapped, IVF-PQ ANN, great Rust API (it *is* Rust). Faster at scale and better for multimodal, but it's a second storage engine with its own files, its own consistency story, and no FTS/relational layer — you'd still need SQLite beside it.

**Verdict:** one SQLite file holding relational catalog + FTS5 + sqlite-vec keeps the whole index in a single transactional store with SQL joins across all three (critical for *group-scoped* RAG: `WHERE group_id = ? ` + KNN + BM25 in one query plan). Swap in LanceDB only if vector scale ever demands ANN.

### Sync options for later mobile

Surveyed:

- **Plain file sync** (Syncthing/iCloud Drive/Dropbox): syncs the truth (the files); each device rebuilds its own index. Zero sync-engine code. Conflicts only matter for small mutable files (annotations, positions) — solvable by making those files merge-friendly (see §6).
- **[Turso embedded replicas / offline writes](https://turso.tech/blog/local-first-cloud-connected-sqlite-with-turso-embedded-replicas)**: local SQLite replica synced to a Turso server; the new [Turso Sync](https://turso.tech/blog/sync-benchmark) ships logical CDC changes (row-level, last-push-wins). Server is the source of truth — which contradicts Bookie's files-are-truth model unless the DB stops being a rebuildable cache.
- **[PowerSync](https://docs.powersync.com/usage/use-case-examples/crdts)**: Postgres ↔ local SQLite with server-defined sync rules; excellent for multi-user Postgres-centric apps; heavy for a single-user file library and requires running Postgres + the PowerSync service.
- **CRDT-in-SQLite**: cr-sqlite pioneered it; [sqlite-sync (SQLite AI)](https://github.com/sqliteai/sqlite-sync) is the actively developed take — CRDT columns with deterministic merge, offline-first, syncs to SQLite Cloud/Postgres/Supabase. Genuinely conflict-free, but adds metadata overhead and a big dependency for what is, in Bookie's case, a mostly append-only single-user dataset.

**Key insight:** sync engines exist to reconcile *databases*. Bookie's database is disposable. The only state that truly needs sync is (a) the content files — big, immutable-ish blobs, ideal for file sync — and (b) annotations/reading positions — tiny, and if stored as ID-keyed sidecar files, mergeable with trivial rules (union by highlight UUID, last-write-wins per field on `updated_at`). A CRDT engine is overkill for that; Readwise's cursor + idempotent-upsert API (§2) is the proven lightweight pattern if a server ever enters the picture.

### Recommendation for Bookie

- **Index:** single SQLite DB per library: catalog tables + FTS5 (external-content, chunk-granularity with `doc_id`/`group_id` columns) + sqlite-vec for chunk embeddings. Incremental re-index keyed on file content hash + mtime. The DB file lives *outside* the synced library folder (it's per-device).
- **Sync v1 (desktop ↔ desktop, and even desktop ↔ mobile file access):** plain file sync of the library folder; each device rebuilds its index.
- **Sync v2 (real mobile app):** small self-hosted sync service speaking a Readwise-style protocol — content-addressed blob upload for files, `updatedAfter` cursor + UUID-idempotent upsert + tombstones for annotations. Adopt Turso/PowerSync/CRDTs only if requirements grow into them.

---

## 5. EPUB/PDF text extraction in Rust

### EPUB

- **[rbook](https://github.com/DevinSterling/rbook)**: modern, actively developed, EPUB 2 + 3, typed metadata access (titles, creators, dates, languages, roles/refinements), reading/building/editing. The strongest choice for metadata.
- **[epub](https://lib.rs/crates/epub)** (danigm): the long-standing simple reader — metadata as a HashMap, spine iteration, resource access by id/path. Fine, but metadata is untyped.
- **[epub-parser](https://crates.io/crates/epub-parser)** / [lib-epub](https://crates.io/crates/lib-epub): smaller alternatives (lib-epub notably handles some encrypted resources).

EPUB "text extraction" is really XHTML extraction: walk the spine, parse each chapter's XHTML, and strip to text (via `scraper`/`lol_html`, or `dom_smoothie`'s text mode) while recording per-chapter offsets — those offsets become the FTS/embedding chunk coordinates *and* the text-position component of highlight anchors.

### PDF

- **[pdfium-render](https://github.com/ajrcarey/pdfium-render)** (MIT/Apache wrapper): idiomatic Rust bindings to Pdfium, Chromium's BSD-licensed PDF engine. Chromium-grade robustness on malformed PDFs, page rendering to bitmaps, and — crucial for Bookie — a text API with **character/rect coordinates**, so extraction and highlight-overlay geometry come from the same engine. Cost: you must ship a `libpdfium` binary (~20MB, prebuilts available; static or dynamic linking) ([crate docs](https://crates.io/crates/pdfium-render), [lopdf vs pdfium field report](https://dev.to/hiyoyok/lopdf-vs-pdfium-in-rust-what-i-learned-building-a-pdf-app-233b)).
- **MuPDF bindings (mupdf-rs)**: excellent extraction/rendering quality, but MuPDF is **AGPL** unless you buy a commercial license — a poison pill for a distributable app; avoid.
- **[pdf-extract](https://crates.io/crates/pdf-extract)**: pure Rust, dead simple `extract_text()`; good enough for indexing many PDFs but no layout/coordinates and weaker on malformed files.
- **[lopdf](https://dev.to/hiyoyok/lopdf-vs-pdfium-in-rust-why-i-chose-the-smaller-one-11pa)**: pure Rust low-level object model — right tool for *structural* work (reading/writing annotation objects, merging), wrong tool for text quality.
- **[pdf_oxide](https://crates.io/crates/pdf_oxide)**: new pure-Rust engine claiming 100% pass rate on 3,830 PDFs and ~5× faster extraction than pdf-extract — promising watch-list item, too young to bet on.

Note: PDF text extraction is inherently lossy (hyphenation, column order, headers/footers) — the same "random line breaks" problem Reader admits to ([Reader PDF FAQ](https://docs.readwise.io/reader/docs/faqs/pdfs)). Budget for a text-cleanup pass (dehyphenation, header/footer stripping) between extraction and indexing.

### Recommendation for Bookie

- **EPUB:** `rbook` for metadata + spine; own thin XHTML→text pass for indexing.
- **PDF:** `pdfium-render` as the single PDF engine — rendering in the reader, text+coordinates for indexing and highlight anchoring, one consistent coordinate space. `lopdf` only if/when we write highlights back into PDFs as standard annotations. Keep `pdf-extract` as a zero-binary fallback for a headless CLI indexer.
- **Markdown:** `pulldown-cmark` (CommonMark, used by rustdoc/mdBook) for parsing; markdown files index almost for free.

---

## 6. Recommended architecture

### Highlight anchoring (per format, one envelope)

Every highlight is stored (in the annotation sidecar and DB) as a **W3C Web Annotation-style multi-selector envelope** ([spec](https://www.w3.org/TR/annotation-model/)): `{ format, primary_selector, text_quote: {exact, prefix≈32, suffix≈32}, text_position: {start, end}, content_hash }`, re-anchored Hypothesis-style — try primary, fall back position→quote→fuzzy quote search ([fuzzy anchoring](https://web.hypothes.is/blog/fuzzy-anchoring/)).

- **Markdown/articles:** primary = TextPosition into the normalized file text; the quote selector is the durability layer since users can edit these files (files are truth!). `content_hash` tells us when re-anchoring is needed at all.
- **EPUB:** primary = **EPUB CFI** ([spec](https://w3c.github.io/epub-specs/epub33/epubcfi/)) against our normalized chapter DOM (precise, portable to other CFI-aware readers); fallback = quote+position against extracted chapter text, because CFI breaks if parsing/normalization ever changes.
- **PDF:** primary = **page index + character-range with quad rects from pdfium**; quote selector on the cleaned page text as fallback. One anchoring space only — text view and page view both render from it (the anti-Reader-PDF decision).

*Rationale:* one envelope means the sync layer, Obsidian export, RAG citations, and MCP API never care about format; the quote selector makes every highlight self-describing and survivable across re-parses and even format migrations.

### Article pipeline

`reqwest` fetch → **dom_smoothie** extraction + metadata (headless lane) / **Defuddle in Tauri webview or browser extension** (rendered-DOM lane) → markdown via dom_smoothie's markdown mode or **htmd** → image assets downloaded into a per-article folder with relative links → file written into the library folder with frontmatter; optional monolith single-file HTML archive. *Rationale:* Rust-native default keeps ingestion dependency-free; the webview lane gives Obsidian-Clipper-grade quality exactly where headless fails, at zero extra runtime cost in a Tauri app.

### Index stack

One SQLite database (per device, outside the synced folder): catalog (documents, groups, tags, annotations mirror) + **FTS5** (chunk-level, external-content) + **sqlite-vec** (chunk embeddings). Group-scoped RAG is a single SQL query joining group membership → KNN + BM25 (hybrid). Entire DB rebuildable from the library folder; incremental indexing by content hash. *Rationale:* one transactional store, one query planner, runs on mobile later; personal-library scale never needs ANN, and LanceDB remains the documented escape hatch.

### Sync approach

- **Phase 1:** the library folder (content files + per-document annotation sidecar JSON) syncs via any file syncer (Syncthing/iCloud). Sidecars are merge-friendly: highlights keyed by UUID, LWW per field on `updated_at`, deletions as tombstones — so even a naive conflicted-copy merge is mechanical.
- **Phase 2 (mobile):** small self-hosted service with a Readwise-shaped protocol ([reference](https://readwise.io/api_deets)): content-addressed file upload, `updatedAfter` cursor pulls with tombstones, UUID-idempotent annotation upserts. No CRDT engine unless real concurrent-editing needs appear.
- **Obsidian export:** local implementation of the [official plugin's](https://github.com/readwiseio/obsidian-readwise) contract — id→path map, templated rendering, content-hash + append-only on user-edited notes, per-document refresh, incremental cursor.

### Extraction crates (committed)

| Concern | Choice | Fallback / notes |
|---|---|---|
| EPUB metadata + spine | [rbook](https://github.com/DevinSterling/rbook) | `epub` crate |
| PDF render + text + coords | [pdfium-render](https://github.com/ajrcarey/pdfium-render) (+ shipped libpdfium) | `pdf-extract` (pure Rust, headless); watch `pdf_oxide` |
| PDF annotation write-back | `lopdf` (later) | — |
| Web extraction (headless) | [dom_smoothie](https://github.com/niklak/dom_smoothie) | `readability-js` crate |
| Web extraction (rendered) | [Defuddle](https://github.com/kepano/defuddle) in webview/extension | — |
| HTML → Markdown | dom_smoothie markdown mode / htmd | `html2md` |
| Page archival (optional) | [monolith](https://github.com/Y2Z/monolith) as a library | — |
| Markdown parsing | `pulldown-cmark` | — |

Open item (not researched here): local embedding runtime (fastembed-rs / ort / llama.cpp bindings) — separate spike.

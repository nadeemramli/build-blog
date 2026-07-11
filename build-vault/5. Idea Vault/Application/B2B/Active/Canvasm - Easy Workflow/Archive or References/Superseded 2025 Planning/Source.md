---
draft: true
title: "Source"
date: "2025-08-08"
tags:
archived: true
archived_note: "Competitor-research dump (count.co's view-config format, DB-tier wishlist). Superseded by docs/backlog/data-source-architecture.md and data-source-caveats.md in the repo, which reflect what was actually built (DuckDB WASM, not this tiered DB list). Archived 2026-07-04."
---
Research notes on Source Node data-connection architecture: a Google Sheets OAuth2 connection flow (scopes, access/refresh token storage, `spreadsheet_id` DB schema, "Canvasm (Source Node) - {Project Name} - {Source Node Name}" naming convention, resync flow), a tiered list of "Best Data Sources for Business Architecture" (Tier 1: Snowflake/BigQuery/Redshift/Databricks; Tier 2: PostgreSQL/MySQL/MSSQL; Tier 3: Jira/ServiceNow/LeanIX via CSV export), per-DB integration requirements (credential vault, IP whitelisting, connection pooling, driver/parameter lists), and a pasted copy of count.co's own YAML view-definition schema (name/label/source/fields[*].format etc.) as a reference to potentially imitate.

Reads as an AI-assisted research/brainstorm session, not a finalized spec — no evidence this was implemented as described. See the repo's `docs/backlog/data-source-architecture.md` and `docs/backlog/data-source-caveats.md` for what actually shipped (DuckDB WASM-based data source handling).

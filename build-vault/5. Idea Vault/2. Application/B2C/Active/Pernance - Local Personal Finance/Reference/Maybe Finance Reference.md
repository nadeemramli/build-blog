---
title: Maybe Finance Reference
description: Product, architecture, licensing, and design lessons used to shape Pernance.
created: 2026-07-12
updated: 2026-07-12
source_reviewed: 2026-07-12
status: reference
tags: [pernance, reference, maybe-finance, product-research]
---

# Maybe Finance Reference

Reference repository: https://github.com/maybe-finance/maybe

## What to borrow as product thinking

- A deliberately simple home view answering: how much money is available, whether spending is below income, what was spent recently, and where it went.
- Accounts, transactions, categories, tags, merchants, reusable rules, budgets, reconciliation and net-worth views.
- Transfers as first-class matched objects rather than a junk category. Internal transfers should normally disappear from income/spending totals; debt payments require explicit principal/interest handling.
- One-time expenses as a distinct treatment so they do not distort normal-spending averages.
- Reconciliation as an explicit balance event rather than a fake adjustment expense.
- Import reversibility and idempotency.
- Minimal, calm visual hierarchy rather than a dense executive dashboard.

## What Pernance should improve

- Local desktop by default, not a self-hosted web service.
- Statement import before bank-provider syncing; no bank credentials or provider dependency in the initial product.
- Immutable source evidence, field-level confidence and a visible review queue.
- Separate cash burn from economic consumption and from liquidity.
- Model commitments, income reliability, sinking funds and stock-covered future needs.
- Treat restricted assets, business cash and consumable stock differently from personal liquid cash.
- Export a small accepted summary to the Operating System while keeping raw statements local.
- Behavior insights should support user-designed experiments, not shame, scoring or generic advice.

## Architecture and license boundary

Maybe's maintained-era stack is a Rails/PostgreSQL self-hosted web application, not a direct architecture blueprint for a Rust/Tauri desktop app. The repository was archived in July 2025 and is no longer actively maintained.

Maybe is AGPLv3 and its name/logo are trademarked. Pernance should use the repository for product and interaction research only unless a future decision deliberately reuses code under AGPL obligations. Do not copy branding, logo, protected assets or source code into Pernance by accident.

## Primary sources reviewed

- Repository and license notice: https://github.com/maybe-finance/maybe
- Final release/product reflections: https://github.com/maybe-finance/maybe/releases
- Vision and self-service model: https://github.com/maybe-finance/maybe/wiki/vision

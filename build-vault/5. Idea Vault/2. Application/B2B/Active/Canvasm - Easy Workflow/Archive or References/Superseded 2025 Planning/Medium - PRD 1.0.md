---
draft: false
title: PRD
date: 2025-07-30
tags:
archived: true
archived_note: "Superseded by docs/prd/prd.md in the metrimap repo. Kept for history — richest node-taxonomy detail (dual Practical/Design canvas, node types, edge types) of the three top-level PRDs in this vault. Note: still contains a leftover '# The Metrimap: User Stories' header from the Early-PRD rename to Canvasm. Archived 2026-07-04."
---
# Canvasm

This document outlines the architecture for ==Canvasm==, a visual-first platform designed **to help operator operationalize data within an organization's business architecture.**

Canvasm provides a dynamic canvas where users can build a comprehensive model of their operations. On this canvas, users can:
- **Map business components**, such as processes or value streams.
- **Define and track key metrics** associated with these components.
- **Visualize relationships** between different metrics using dynamic connectors.
- **Manage the underlying data sources** that power these metrics.

This approach allows users to construct a model where a value chain serves as the central spine. Its elements—such as metrics, strategic actions, and business hypotheses—are not just static cards, but richly defined entities with explicit properties and clearly defined relationships.

## 1. Core Functionality & Canvas

**Canvasm** features are organized into two categories: functions that exist outside the main canvas (**Beyond Canvas**) and those that operate directly within it (**Within Canvas**).

At its core, the application is a dynamic, collaborative workspace powered by `Supabase Realtime` for live interaction. This canvas offers a unique dual environment: a "Practical" space for data operations, built on `react-flow`, and a "Design" space for freeform thinking, built on `excalidraw`.
- **Practical Environment**: This is where users operationalize their data. They can connect data sources, transform data, visualize it and pipe it through operative nodes before "using" it in metric nodes.
- **Design Environment**: This is a creative sandbox, offering a full suite of whiteboarding tools for users to draw, brainstorm, and ideate freely.

Node taxonomy:
- **Core:** Value Node, Action Node, Hypothesis Node
- **Artifacts:** Evidence Node (block-based text editor), Metadata Node
- **Data/Metric:** Metric Node, Source Node (SQL/Python transforms)
- **Functional & Utility:** Visualization Node, Operative Node (formula/boolean/conditional/Zapier-like)

Edge taxonomy:
- **Dynamic Edges:** Causal/Deterministic/Probabilistic/Compositional between Metric Cards.
- **Operative Edges:** Pass data between nodes via Operative Nodes (Zapier-like), with a run/execute button.
- **Simple Edges:** Peg/connect (e.g. evidence to a node); used by Core/Value, Work/Action, Ideas/Hypothesis, Metadata nodes.

Beyond Canvas: Homepage (left sidebar with Personal Canvas / Organization Management, right panel gallery/list of canvases), Sidebar navigation, Dashboard, Assets, Source, Canvas Settings. Collaboration: Share (canvas/dashboard/evidence), Comment (pinned/in-property/in-editor with threads), Set Alert, Changelog.

(Full Beyond/Within Canvas page-by-page spec — Homepage, Sidebar, Dashboard, Assets, Source, Canvas Settings, Metric Card attributes, Card Settings tabs, Relationship Sheet, Grouping/Auto-Layout/Toolbar — mirrors Early-PRD.md's structure; see that file for the complete page-level detail, as this doc mostly restates it under the Canvasm name while adding the sections above.)

## Tech Stack for Canvasm

- **Core Framework:** React 19.0 + TypeScript + Vite
	- Front-end:
		- **Practical Canvas:** React Flow with Dagre for auto-layout
		- **Design Canvas:** Excalidraw
		- **UI & Styling:** Radix & Shadcn, Recharts, Tailwind CSS, Post CSS
		- **Component Testing:** Storybook-js
		- **State Management:** XState & Zustand
		- **Text Editor:** EditorJS
	- Back-end:
		- **Data Fetching:** Tanstack/React Query to manage data from Supabase
		- **Schema Management:** Prisma
		- **Data Validation:** Zod
		- **Database:** **Supabase** (using the `supabase-js` client and Database Functions)
		- **Realtime Engine:** Supabase/realtime-js / WebSocket / Automerge WASM
		- **Storing Secrets:** HashiCorp Vault
		- **Computation:**
			- **Client-Side (Light):** Web Workers (`comlink`), `math.js`, `simple-statistics`
			- **Server-Side (Heavy):** Supabase Edge Functions, Temporal
	- Deployment:
		- **Authentication:** Clerk
		- **Hosting/Server:** Vercel
		- **DevOps & CI/CD:** Husky, GitHub Actions, TS-ESLint + Prettier, Snyk & Dependabot
		- **Testing:** Vitest
		- **Build & Bundle Optimization:** `React.lazy()`, rollup-js, `rollup-plugin-visualizer`
	- Post-Deployment: Userback (feedback), PostHog (analytics), BetterStack (monitoring)

Note (as of archiving 2026-07-04): actual repo uses `perfect-freehand` instead of the `@excalidraw/excalidraw` package for whiteboarding, and PostHog/BetterStack/Snyk/HashiCorp Vault/Temporal were not yet integrated per the vault's own `Tasks/Development Backlog by Intake Group.md` (2026-07-04).

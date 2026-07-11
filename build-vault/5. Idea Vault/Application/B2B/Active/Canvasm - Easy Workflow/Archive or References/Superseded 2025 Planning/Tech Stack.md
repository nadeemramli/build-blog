---
draft: true
title: "Tech Stack"
date: "2025-08-10"
tags:
archived: true
archived_note: "Superseded by the repo's real package.json + docs/adr/*. As of archiving (2026-07-04): repo uses perfect-freehand instead of Excalidraw package; HashiCorp Vault/Temporal not confirmed shipped; Snyk/Dependabot/PostHog/BetterStack still not integrated per Tasks/Development Backlog by Intake Group.md. Archived 2026-07-04."
---
This document outlines the technical architecture for ==Canvasm==, a visual-first platform designed **to help operator operationalize data within an organization's business architecture.**

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
			- **Client-Side Computation (Light Computation):** Web Workers (`comlink`), `math.js`, `simple-statistics`
			- **Server-Side Computation (Heavy Computation):** Supabase Edge Functions, Temporal
	- Deployment:
		- **Authentication:** Clerk
		- **Hosting/Server:** Vercel
		- **DevOps & CI/CD:** Husky, GitHub Actions, TS-ESLint + Prettier, Snyk & Dependabot
		- **Testing:** Vitest
		- **Build & Bundle Optimization:** `React.lazy()`, rollup-js, `rollup-plugin-visualizer`
	- Post-Deployment: Userback (feedback), PostHog (analytics), BetterStack (monitoring)

This is our tech stack as of now, are there anything that can make it more robusts.

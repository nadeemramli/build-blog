---
draft: true
title: "Tech Stack"
date: "2025-08-10"
tags: 
---
This document outlines the technical architecture for ==Canvasm==, a visual-first platform designed **to help operator operationalize data within an organization's business architecture.**

Canvasm provides a dynamic canvas where users can build a comprehensive model of their operations. On this canvas, users can:
- **Map business components**, such as processes or value streams.
- **Define and track key metrics** associated with these components.
- **Visualize relationships** between different metrics using dynamic connectors.
- **Manage the underlying data sources** that power these metrics.

This approach allows users to construct a model where a value chain serves as the central spine. Its elements—such as metrics, strategic actions, and business hypotheses—are not just static cards, but richly defined entities with explicit properties and clearly defined relationships.

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
			- **Client-Side Computation (Light Computation):**
			    - **Threading:** **Web Workers** (with `comlink` for easier use)
			    - **Formula Engine:** `math.js`
			    - **Statistics:** `simple-statistics`
			- **Server-Side Computation (Heavy Computation):** 
				- Supabase Edge Functions
				- Temporal
	- Deployment:
		- **Authentication:** Clerk
		- **Hosting/Server** Vercel
		- **DevOps & CI/CD:**
			- **Git Hooks:** Husky
			- **CI/CD:** GitHub Actions
			- **Code Quality:** **Typescript-ESLint** (for linting) & **Prettier** (for formatting)
			- **Security and Dependencies:** Snyk & Dependabot
		- **Testing:** Vitest
		- **Build & Bundle Optimization:**
			- **Code Splitting:** `React.lazy()` for routes
			- **Module Bundler:** rollup-js
			- **Bundle Analysis:** **`rollup-plugin-visualizer`**
	- Post-Deployment
		- **User Feedback:** Userback
		- **Product Analytics:** PostHog
		- **Monitoring & Logging:** BetterStack

This is our tech stack as of now, are there anything that can make it more robusts.
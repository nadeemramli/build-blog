---
title: "Playbook — Website Instrumentation (GTM + GA4 via Stape MCP)"
type: playbook
status: practical
created: 2026-06-05
tags: [tactical, practical, market, distribution, analytics, gtm, ga4, tracking, instrumentation, static]
---
	Z
# Playbook — Website Instrumentation (GTM + GA4 via Stape MCP)

> [!summary]
> A built-and-running playbook that wires a website for full **user-journey measurement**. We set up Stape's MCP servers (GTM + GA4), define an **ideal user-journey benchmark line**, hand the developer a **dataLayer/event spec** to instrument the site, then use the MCP to **one-shot** GTM variables/triggers/tags and the matching GA4 views, custom dimensions, and parameters. The end state is a single overall view of how users actually move through the site. Lives under [[Practical Market]] → [[Distribution]] (the website is the [[Conversion and Engagement#Website|Conversion surface]]).

> [!note] This is a *static* tactic
> Per the [[Static and Dynamic Functions]] lens added to [[Tactical]], website instrumentation is **static plumbing** — stable across businesses, rule-bound, high-leverage to document once and reuse. It belongs near the front of the build queue. (The *interpretation* of the resulting data — CRO calls, funnel strategy — is the dynamic half and stays in [[Theoretical Market]] until proven.)

## Why we do this

You can't optimize [[Distribution]] (acquisition → conversion → retention) without seeing the journey. This playbook turns a blank site into an instrumented one where every meaningful step emits an event, so GA4 can reconstruct the real path against an **ideal path** we defined up front.

## Step 0 — Setup: Stape MCP servers

Install the three Stape MCP servers in the Claude desktop config (**Settings → Developer → Edit Config**), so the agent can build GTM and read/report GA4 directly. Requires Node.js v18+ and a Stape API key (Stape account → Account settings → API Keys → create; copy once).

```json
{
  "mcpServers": {
    "google-tag-manager-mcp-server": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://gtm-mcp.stape.ai/mcp"]
    },
    "stape-mcp-server": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://mcp.stape.ai/mcp",
               "--header", "Authorization: ${your_stape_api_key}"]
    },
    "ga4-mcp-server": {
      "command": "npx",
      "args": ["-y", "mcp-remote@0.1.30", "https://mcp-ga.stape.ai/mcp"]
    }
  }
}
```

Restart Claude, complete the OAuth flow per server (use the Google account with access to the GTM container and GA4 property). EU users add header `X-Stape-Region: EU`. Cache/troubleshoot with `rm -rf ~/.mcp-auth`.

- **GTM MCP** (`gtm-mcp.stape.ai`) — create/get/update accounts, containers, workspaces, environments, tags, triggers, variables, templates, versions, permissions.
- **GA4 MCP** (`mcp-ga.stape.ai`) — run/real-time reports, account summaries, query dimensions & metrics, annotations.
- **Stape MCP** (`mcp.stape.ai`) — manage sGTM containers/zones on Stape (needed for server-side).

## Step 1 — Define the ideal user-journey benchmark

Before touching code, map the **ideal line**: the sequence of steps a user *should* take from landing to the goal (e.g. land → scroll/read → view product → add intent → convert → return). This benchmark is what real journeys get measured against — it tells us which events must exist and which custom dimensions matter. Without it, you instrument blindly.

## Step 2 — Developer spec: maximize dataLayer/event pushes

From the benchmark, produce a **developer specification** (see the INDEXA setup for the worked example of how this is structured). The spec tells the dev to **insert as many `dataLayer.push` events as possible** at every meaningful interaction — each push carrying the parameters we'll later turn into dimensions.

The richer the dataLayer, the more we can do in GTM/GA4 *without* going back to the dev. A spec entry looks like:

```js
// example dataLayer event the dev implements per the spec
dataLayer.push({
  event: "view_article",
  article_id: "peptide-101",
  article_category: "research-compounds",
  journey_stage: "consideration",
  scroll_depth: 50
});
```

The dev's job is purely to **emit the events and parameters**; all tag logic stays in GTM (clean separation = the spec is the only handoff).

## Step 3 — One-shot the GTM container (via MCP)

With the dataLayer landed, use the **GTM MCP** to build the container in one pass:
- **Variables** — dataLayer variables for every parameter (`article_id`, `journey_stage`, `scroll_depth`, …).
- **Triggers** — custom-event triggers keyed to each `event` name.
- **Tags** — GA4 event tags that forward each event + its parameters to the GA4 property.

Because the spec defined everything up front, this is a **one-shot setup** rather than click-by-click GTM work.

## Step 4 — GA4: views, custom dimensions & parameters

The MCP then hands us the **spec to set up GA4**:
- Register **custom dimensions / metrics** for each event parameter (e.g. `journey_stage`, `article_category` as event-scoped dimensions).
- Configure the **reports/views** that expose the funnel and path against the Step-1 ideal line.
- Use the **GA4 MCP** to query and verify the dimensions return data.

## Step 5 — Overall user-journey view

Custom dimensions + parameters in GA4 produce the payoff: an **overall view of the user journey** across the site — where users enter, how far they get along the ideal line, and where they drop. That view feeds [[Conversion and Engagement]] decisions and the [[Governing Artifacts#4. Driver tree / value architecture|driver tree]] conversion KPIs.

```
ideal journey (benchmark)
        │
        ▼
dev spec → maximal dataLayer pushes ──► GTM (vars · triggers · GA4 tags) ──► GA4 (custom dims/params · views)
        (one handoff)                    (one-shot via GTM MCP)              (spec'd, verified via GA4 MCP)
                                                                                   │
                                                                                   ▼
                                                                   overall user-journey view
```

## Why it works (learnings)

- **Spec-first, dev-light.** Front-loading the benchmark + dataLayer spec means the developer touches the site once; everything downstream is config the agent does via MCP.
- **One-shot beats click-ops.** Defining all parameters before building lets the GTM MCP create variables/triggers/tags in a single pass — fast and consistent.
- **Maximal events = future-proof.** Over-instrumenting the dataLayer means new dimensions can be added in GA4 later without another dev cycle.
- **The benchmark is the ruler.** Defining the ideal journey first turns analytics from "vanity numbers" into "distance from the path that converts."

> [!caution] Keep humans on property-level changes
> Treat GA4 property config and GTM publishing as approval-gated even though the build is automated — see [[Part B1 - Automation Decision Matrix#The approval-gate rule]]. The agent prepares; a human publishes.

> [!note] Status
> Built and running. Reference implementation for instrumenting any new site; reuse the Stape config, benchmark→spec→one-shot flow, and GA4 dimension list.

## Related
- [[Practical Market]] — parent domain
- [[Distribution]] · [[Conversion and Engagement]] — the strategy this measures
- [[Static and Dynamic Functions]] — why this is a static, build-first tactic
- [[Governing Artifacts]] — where journey KPIs feed the driver tree
- Sources: [GTM MCP setup](https://stape.io/blog/mcp-server-for-google-tag-manager) · [GA4 MCP setup](https://stape.io/blog/mcp-server-for-google-analytics) · [Stape MCP config](https://stape.io/blog/stape-mcp-server-configuration)

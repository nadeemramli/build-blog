---
draft: false
title: Separating PRDs
date: 2025-02-01
tags:
---
> [!cite] I don't understand, we have PRD, but if we want to build a specific feature we have PRD aswell? Why don't we have like a Startup/Product Development Documentation, then for each feature we have PRD?

------
Great question! Let’s break this down.

The way you structure your product documentation really depends on the complexity of your product, the size of your team, and the tools you’re using. But here’s a framework that might help:

### 1. **Master Product Documentation (or "Startup/Product Development Doc")**

- Think of this as the _source of truth_ for your product strategy. It’s high-level and covers:
    - Your product vision and goals
    - Key metrics (e.g., North Star Metric, OKRs)
    - Roadmap (Now-Next-Later or similar)
    - High-level problem areas you’re tackling
- This document is for _alignment_ across the company—executives, stakeholders, and teams. It’s not meant to go into the weeds of individual features.

### 2. **Feature-Specific PRDs**

- These are more tactical and focus on individual features or initiatives. A good PRD should:
    - Define the problem the feature solves
    - Outline success metrics
    - Include top-level user stories or use cases
    - Link to supporting docs (e.g., technical specs, designs, Jira tickets)
- The audience here is your immediate team—engineering, design, and QA. It’s about giving them the context they need to build the feature effectively.

### Why Separate Them?

- **Clarity**: A single document for everything can get bloated and hard to navigate. By splitting things up, you make it easier for people to find what they need.
- **Audience**: Different people care about different levels of detail. Execs want the big picture, while engineers need specifics.
- **Scalability**: As your product grows, having separate PRDs for features keeps things manageable.

### How to Keep It All Organized

- Use a tool like Notion, Confluence, or Google Docs to create a central hub where everything links together. For example:
    - The master product doc links to individual PRDs.
    - PRDs link to Jira tickets, Figma designs, or technical specs.
- This way, everyone knows where to look without duplicating information.

### A Real-World Example

At Airbnb, we often started with a lightweight "Product Brief" for new features—a one-pager that outlined the problem, the opportunity, and success metrics. If the feature moved forward, we’d evolve it into a full PRD with more details, like user stories and milestones. This approach kept things lean while ensuring we had enough detail when it mattered.
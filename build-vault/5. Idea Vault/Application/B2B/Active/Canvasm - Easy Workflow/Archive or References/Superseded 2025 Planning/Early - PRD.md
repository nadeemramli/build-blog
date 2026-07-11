---
draft: false
title: PRD
date: 2025-07-30
tags:
archived: true
archived_note: "Superseded by docs/prd/prd.md in the metrimap repo. Kept for history — this is the earliest full IA spec, written under the name 'Metrimap' before the vault rebranded to 'Canvasm'. Archived 2026-07-04."
---
# Metrimap

This document outlines the information architecture for the Metrimap tool, a visual-first application for building, managing, and analyzing sophisticated **metric trees** and **business architecture mapping**.

It provides a canvas for users to visually map components of their business and relationships within them. Using Metrimap user able to create cards and connect them, all inside the canvas, the cards then be assign whether it's a business process, or a metrics to be track, or a work/action, or anything stated in our **Card Category.** The tool enables the construction of a comprehensive model where a value chain can act as the spine, and its components **(metrics, actions, hypotheses) are enriched with properties** and explicitly **defined relationships.**

## 1. Core Functionality & Canvas

Metrimap application organized its features into two main categories: functions that exist outside the primary editing canvas ("**Beyond Canvas**") and functions that operate directly within it ("**Within Canvas**").

Essentially, the application's core is a dynamic canvas powered by `react-flow`, designed as an interactive workspace for users to build, navigate, and analyze their business architecture. This canvas is not a static drawing board; it is the environment where a company's "fundamental formula"—the unique way it translates inputs into value—is made visible and tractable.
- **Within Canvas:** 
	- **Node Creation:** Users can populate the canvas by creating **Metric Cards**. These cards are the fundamental building blocks of the model, representing every component of the business system—from high-level `North Star` metrics to granular `Work/Action` items like experiments and initiatives. The process of adding nodes is the first step in translating abstract business concepts into a structured, logical model.
	- **Node Connectivity:** Users can draw directed edges (arrows) between nodes to create **Relationships**. This is a critical function, as these connections represent the logic of the business model. Each edge explicitly defines the relationship between two cards (e.g. `Causal`, `Deterministic`,`Probabilistic`, `Compositional`), turning the canvas from a collection of ideas into a coherent, causal map that can be analyzed and validated.
	- **Interactive Navigation & Manipulation:** The canvas supports fluid interaction to manage complexity:
	    - **Pan & Zoom:** Standard mouse and trackpad controls allow for seamless navigation across large and intricate metric trees, from a high-level overview to a detailed view of a specific "limb" of the map.
	    - **Multi-Select:** Users can select multiple nodes and edges at once to move, delete, or group them, enabling efficient organization and refactoring of the model.
	- **State Management & Persistence:** The canvas is designed as a persistent workspace.
	    - **Auto-Save:** All aspects of the canvas state—including the position, content, and data of every node, and the structure and properties of every relationship—are continuously saved.
	    - **Project Integrity:** This ensures that the user's complex model is preserved between sessions, allowing for iterative development and long-term analysis without loss of work. The canvas becomes a living document that evolves with the business.

### **Part I: "Beyond Canvas" Functions**

These features constitute the application's shell, providing project management, navigation, and high-level reporting capabilities.
#### **1. Homepage**
- The central hub or "mission control" where users manage all their canvas projects.
- Displays each canvas as a card with key metadata: Name, Description, Tags, Last Modified Date, and Collaborators.
- Provides core actions to create a new canvas or to search/filter existing ones.
#### **2. Application Navigation (Sidebar)**
- A persistent, icon-driven sidebar that appears once a user enters a canvas.
- Provides access to all major pages/views for the selected canvas project.
#### **3. Dashboard Page**
- The primary consumption layer, designed for business reviews and performance monitoring.
- Dashboards are dynamically generated from the **"Subflow"** or **"Group"** nodes created on the canvas, ensuring a direct link between the business model's structure and its reporting.
- A dropdown allows users to select which Subflow-based dashboard to view. The dashboard displays the live, interactive Metric Cards from that group.
#### **4. Assets Page (Knowledge Repository)**
- A centralized, table-based view of all components within a canvas, allowing for powerful searching and management.
- It is divided into three tabs:
    - **Metrics (Nodes):** A table of all Metric Cards and their properties.
    - **Relationships (Edges):** A table of all connections, detailing their type, confidence, and evidence count.
    - **Repo:** A master log of all attached evidence (experiments, analyses, notebooks) and events from across the entire canvas.
#### **5. Source Page (Data Governance)**
- A specialized, technical view for managing the data instrumentation pipeline.
- Lists all `Data/Metric` cards and provides fields to track their underlying `Source System`, `Event Name`, `Actor`, `Trigger`, and `Instrumentation Status`.

#### **6. Canvas Settings Page**
- Manages the project-level settings for the current canvas.
- Includes tabs for:
    - **General:** Edit canvas Name, Description, and organizational Labels.
    - **Data:** A master table view of all cards for quick editing access.
    - **Canvas Changelog:** An immutable, reverse-chronological timeline that automatically tracks all significant changes made to the canvas, providing a full audit trail.

### **Part II: "Within Canvas" Functions**

These features are the core tools for building, editing, and analyzing the metric tree directly on the visual canvas.
#### **1. Core Canvas Functionality**
- An interactive canvas powered by `react-flow` that allows for node creation, directed edge connectivity, and pan/zoom navigation.
- The canvas state is persistently saved, ensuring the model is a living, evolving document.
#### **2. The Metric Card (Node Component)**
- The fundamental building block of the map, with dynamic views based on its assigned `Category`.
- Attributes include a Title, Description, a two-layer Category system, user-defined Tags, and optional Causal Factors.
- `Data/Metric` cards have a special view to display quantitative time-series data and trend indicators.
- Includes a hidden "Dimensions" table that can be expanded to classify the metric's properties.
#### **3. The Card Settings (Sheet View)**
- A comprehensive, tab-based side panel for detailed configuration of each Metric Card.
- Tabs include **Details** (chart options), **Source** (defining data as Manual, Calculated, or Random), **Data** (spreadsheet view), **Events** (timeline annotations), **Key Results** (OKRs), **Correlations**, **Comments**, and **Setting** (metadata).
#### **4. The Relationship (Connecting Component)**
- The directed edge between cards, featuring dynamic visuals based on its properties.
- Line style indicates **Confidence Level** (solid for high, dashed for medium, dotted for low).
- Line color indicates **Relationship Type** (e.g., green/red for positive/negative correlations, orange for causal claims).
- Features a **Relationship Sheet (Knowledge Hub)** to attach supporting evidence (analyses, experiments), turning each connection into a repository of institutional knowledge.
#### **5. Canvas Built-in Functions**
- **Grouping/Subflows:** Allows users to group nodes into named containers that provide visual context and power the Dashboard page.
- **Auto-Layout:** Uses the Dagre library to automatically arrange the metric tree in a clean, hierarchical layout.
- **Node Toolbar:** A contextual toolbar for quick actions like Edit, Copy, Collapse, and Delete.
- **Canvas Controls:** A global control panel for zoom functions and a centralized **Date Range Picker** that filters data across all metric cards on the canvas simultaneously.

# Beyond Canvas

## 2. The Homepage: Mission Control

The homepage is the first screen users see and serves as the central hub for all their Metrimap projects. It is designed for organization and quick access.
- **Purpose**: Managing canvases
- **Layout:** A clean, gallery-based grid (show canvas inside for thumbnail) or list view. Each card represents a **Canvas Project**.
- **Canvas Card Content:** Each card on the homepage will display key metadata about the canvas it represents:
    - **Canvas Name:** The primary title of the project (e.g., "SaaSCo Q3 Growth Model").
    - **Description:** A short, one-line summary of the canvas's purpose.
    - **Labels/Tags:** The organizational tags assigned in the canvas settings (e.g., "Marketing," "Finance," "In Progress").
    - **Last Modified Date:** To easily find the most recently worked-on projects.
    - **Team Members/Avatars:** Shows which users are collaborating on that canvas.
- **Core Actions:**
    - **"New Canvas" Button:** The primary call-to-action, allowing users to create a new, blank canvas project.
    - **Search and Filter:** Users can search for canvases by name or filter them by the assigned labels/tags.
- **Interaction:** Clicking on a canvas card navigates the user into the main Metrimap interface for that specific project, at which point the application sidebar appears.


## 3. Application Navigation: The Sidebar (Within Canvas)

There's no sidebar during the home page. Sidebar appears when user open/in a canvas. Once a user selects and enters a specific canvas from the homepage, a persistent sidebar appears on the left, providing access to all the different views and tools for that canvas.
### 3.1. Sidebar Components
- **Sidebar Design:**
	-  **UI:** A simple, icon-driven sidebar, designed to be collapsible to maximize canvas space. Can't be expand (no need for expand).
	- **Behavior:** Fixed
- **Home Icon:**
    - **Function:** Navigates the user back to the homepage where all their canvases are listed.
    - **Behavior:** When on the homepage, the sidebar is not visible.
- **Canvas Icon:**
    - **Function:** The default view. Shows the main canvas for building and editing the metric tree.
- **Dashboard Icon:**
    - **Function:** Navigates to the **Dashboard Page** described above.
- **Assets Icon:**
    - **Function:** Navigates to a centralized repository for all the elements within the current canvas, presented in a filterable, sortable table view. This is the "database" view of the map.
    - **Sub-Views (Tabs within the Assets page):**
        - **Metrics (Nodes):** A table of all Metric Cards, with columns for Title, Category, Owner, etc. Allows for bulk editing and management.
        - **Relationships (Edges):** A table listing every connection, with columns for Source Node, Target Node, Relationship Type, and Confidence Level.
        - **Repo:** A master table of all attached **Evidence Items** (from the Relationship Sheets) and **Events** (from the Card Settings), allowing users to browse all experiments, analyses, and notebooks in one place.
- **Source Icon:**
    - **Function:** Navigates to a dedicated data governance and instrumentation view. This is where the connection to the underlying data systems is managed.
    - **UI:** A table listing all `Data/Metric` cards.
    - **Columns/Features:** `Source System`, `Activity/Trigger`, `Event Tracking Plan`, `Actor` (e.g., Visitor, System), and a `Checklist` column (e.g., Tracked: Yes/No) to manage the instrumentation status.
- **Canvas Setting Icon (at the bottom):**
    - **Function:** Opens the settings page for the entire canvas project.


## 4. Application Navigation Architecture/Pages/Routing within Sidebar

### 4.1. Canvas Route
This will route to Canvas 

### 4.2. The Dashboard Page
This page serves as the primary consumption layer for the metric tree, transforming analytical structures into operational business review tools.

- **Access:** Via the "Dashboard" icon in the main application sidebar.
- **Core Functionality:**
    - **Dashboard Selector:** A dropdown menu, located in the top-left corner of the page, allows users to select which dashboard to view.
    - **Dynamic Population:** The options in the dropdown are automatically populated from the names of the **Group/Subflow** nodes created on the canvas. Selecting a name (e.g., "Customer Acquisition Funnel") renders its corresponding dashboard.
    - **Dashboard Layout:** The dashboard displays all the Metric Cards from the selected Subflow. The cards are arranged in a grid or a user-configurable layout.
    - **Card Consistency:** The cards displayed on the dashboard are the _exact same_ Metric Card components from the canvas, retaining all their data, visual indicators (trends), and interactivity.
- **Strategic Alignment (Business Reviews):**
    - This feature directly enables a more effective business review process.
    - Teams can anchor their review on a specific dashboard (e.g., "Q3 Growth Initiatives").
    - They can immediately identify which metrics are "red" (underperforming) and use the interconnected nature of the map to "drill on the reds," investigating the upstream drivers and downstream impacts without leaving the Metrimap ecosystem.


### 4.3. The Assets Page: The Knowledge Repository
The **Assets** page is the central "library" for the current canvas. It detaches the components from their visual layout and presents them in a structured, data-centric view, allowing for powerful searching, sorting, and management.
- **Purpose:** To provide a comprehensive, searchable inventory of all analytical work and its constituent parts. It answers the question, "Show me everything we know and have done for this model."
- **UI:** A full-page view with three distinct tabs: **Metrics (Nodes)**, **Relationships (Edges)**, and **Repo**.

#### 4.3.a. Metrics (Nodes) Tab
- **View:** A detailed table of every card created on the canvas.
- **Columns:**
    - `Card Title`
    - `Category` (e.g., Data/Metric, Work/Action)
    - `Sub-Category` (e.g., Leading KPI, Experiment)
    - `Owner/Assignee`
    - `Creation Date`
    - `Last Updated`
    - `# of Connections`
    - `Tags`
- **Functionality:**
    - **Sorting & Filtering:** Users can sort by any column and filter by category, owner, or tags.
    - **Bulk Actions:** Potentially allows for selecting multiple cards to apply a tag or assign an owner at once.
    - **Drill-down:** Clicking on a row opens the **Card Settings Sheet** for that specific metric.

#### 4.3.b. Relationships (Edges)**
- **View:** A table of every connection on the canvas, detailing the link between two concepts.
- **Columns:**
    - `Source Node`
    - `Target Node`
    - `Relationship Type` (Causal, Deterministic, etc.)
    - `Confidence Level` (High, Medium, Low)
    - `Weight/Value` (The numerical value, like a correlation coefficient)
    - `Evidence Count` (The number of attached evidence items)
- **Functionality:**
    - Allows users to quickly see all relationships of a certain type or confidence level.
    - Clicking a row opens the **Relationship Sheet (Knowledge Hub)** for that specific connection.

#### 4.3.c Repo Tab
- **View:** A master table that aggregates all **Evidence Items** and **Events** from across the entire canvas. This is the ultimate log of all analytical and operational activity.
- **Columns:**
    - `Title` (of the evidence/event)
    - `Type` (Experiment, Analysis, Event Shock, etc.)
    - `Date`
    - `Owner/Author`
    - `Associated Metric/Relationship` (A link back to the card or edge it belongs to)
    - `Link` (URL to the source artifact)
- **Functionality:** This allows a manager or analyst to ask questions like, "Show me every A/B test we ran in Q2" or "Find all analyses related to user churn," regardless of where they are on the visual map.

### 4.4. The Source Page: Data Governance & Instrumentation

The **Source** page is a specialized, technical view focused on the "first mile" of the data journey: ensuring data is being collected correctly. It acts as a bridge between the conceptual metric and the underlying event tracking system.
- **Purpose:** To manage the instrumentation plan and data governance for all metrics. It answers the question, "For this metric to work, what data do we need, and have we actually tracked it?"
- **UI:** A master table listing every `Data/Metric` card.
- **Columns:**
    - `Metric Name`
    - `Source System`: Where the data originates (e.g., Segment, Mixpanel, Database).
    - `Event Name`: The specific tracked event that powers the metric (e.g., `user_signed_up`).
    - `Actor`: Who performs the action (e.g., `User`, `System`, `Marketing Campaign`).
    - `Trigger`: The action that fires the event (e.g., `clicks_signup_button`).
    - **`Instrumentation Status` (Checklist):** A critical column with statuses like `Planned`, `Instrumented`, `Needs QA`, `Live`. This turns the page into an active project management tool for the data engineering or analytics team.

### 4.5. Canvas Settings Page

This page manages the metadata and data for the entire canvas project.

- **General Tab:**
    - **Name:** The name of the canvas project.
    - **Description:** A high-level description of the canvas's purpose.
    - **Label:** Tags for organizing canvases on the homepage.
- **Data Tab:**
    - **UI:** A master table view showing all cards within the canvas and their key data points, allowing for quick access to Card Settings. 
    - **Interactivity:** Clicking on any row in this table will open the **Card Settings Sheet** for that specific card, allowing for quick, targeted edits without having to find the card on the visual canvas.
- **Canvas Changelog
	- ****Purpose:** To provide a complete, immutable audit trail of all significant changes made to the canvas structure and content. This is crucial for collaboration and for understanding how the model has evolved over time.
	- **UI:** A reverse-chronological timeline view.
	- **Tracked Events:** The changelog automatically records entries for actions such as:
	    - `User A` **created** card `New User Signups`
	    - `User B` **deleted** relationship from `Ad Spend` to `New User Signups`
	    - `User A` **changed confidence** on relationship `Speed to Lead -> Win Rate` from `Low` to `Medium`
	    - `User C` **updated the formula** for card `LTV`
	    - `User B` **created** the subflow group `Retention Analysis`
	- **Functionality:** Each entry in the timeline is timestamped and attributed to a user, providing full transparency and accountability for the model's evolution.


# Within Canvas

## 5. Node Component: The Metric Card

The fundamental building block of a Metrimap is the **Metric Card**. The card's structure and displayed information are dynamic, changing based on the card's assigned `Category`.
### 5.1. Card Views
- **A. Base Card Structure:** The default view for all non-`Data/Metric` cards. It contains the core attributes and actions.
- **B. "Data/Metric" Card View:** An enhanced view activated when the `Data/Metric` category is selected. It prominently displays quantitative data and trend indicators.

#### 5.1.a. Card Attributes
- **Icon**
	- **Generation:** Randomly generated upon card creation to provide quick visual distinction.
- **Title**
    - **Type:** `string`
    - **UI:** Editable text field.
    - **Purpose:** The primary identifier for the node (e.g., "Monthly Recurring Revenue," "New User Signups").
- **Description**
    - **Type:** `string`
    - **UI:** Text area for more detailed notes.
    - **Purpose:** To provide context, definitions, or formulas related to the node.
- **Data & Values (conditional: for data/metric cards)**
	- **Purpose:** To hold and display the quantitative data for the metric.
	- **Data Structure:** An array of objects, where each object represents a time period.
	- **UI:** Displayed prominently on the card as shown in the image.
- **Category (Two-Layer System)**
    - **Purpose:** To structurally define the node's role within the metrics tree, aligning with the systematic process.
    - **UI:** A cascading dropdown menu system.
    - **Layer 1 Options:**
        - **`Core/Value`**: Represents the foundational elements of the value delivery process.
        - **`Data/Metric`**: Represents the quantifiable measures of the business.
        - **`Work/Action`**: Represents the activities and initiatives undertaken by the business.
        - **`Ideas/Hypothesis`**: Represents assumptions, questions, or potential drivers.
        - **`Metadata`**: Represents supplementary information about the system.
    - **Layer 2 Options (Conditional on Layer 1):**
        - If `Core/Value`: `Journey Step`, `Value Chain`, `Critical Path`
        - If `Data/Metric`: `Input Metric`, `Output Metric`, `Leading KPI`, `Lagging KPI`, `Diagnostic Metric`, `North Star Metric`
        - If `Work/Action`: `Experiment`, `BAU (Business as Usual)`, `Initiative`, `Scope/Function`, `Business Driver`
        - If `Ideas/Hypothesis`: `Factor`, `Seller Solution`
- **Dimensions**
    - **Purpose:** To classify the metric based on its nature and primary use case, as defined in the analytics framework.
    - **Available Dimensions:** `Qualitative`, `Quantitative`, `Vanity`, `Actionable`, `Efficiency`, `Effectiveness`, `Strategic`, `Tactical`, `Operational`
- **Causal Factor (Optional)**
    - **Purpose:** To diagnose the source of change in a metric, applying the Metric Drift Framework.
    - **Available Factors:** `Component Drift`, `Temporal Variance`, `Influence Drift`, `Dimension Drift`, `Event Shocks`
- **Tags**
    - **Type:** `string[]`

### 5.3. The "Dimension Slice" Feature (Dimension Drift Analysis)
A card-level action to programmatically decompose a composite metric into constituent parts, with three historical-data disaggregation strategies: Manual Entry, Proportional Split, Forfeit History.

## 6. Card Settings (Sheet View) Architecture

Tabs: **Details | Data | Source | Events | Key Results | Correlations | Comments | Setting**

- **Source Tab:** `Calculated` (formula builder), `Manual` (spreadsheet entry), `Random Data` (placeholder generator).
- **Events Tab:** Timeline annotations for metric drifts, tied to Causal Factors.
- **Key Results Tab:** OKR-style targets.
- **Correlations Tab:** "Compute Correlations" against other cards.
- **Setting Tab:** General/Statistics/Statistic Intervals/Segments sub-navigation.

## 7. Connecting Component: The "Relationship"

Relationship types: `Deterministic`, `Probabilistic`, `Causal`, `Compositional` — visualized via line style (confidence) and color (type). Includes a Relationship Sheet (Knowledge Hub) with an Evidence Repository, a Changelog for Influence Drift analysis, and a Causal Checklist workflow for graduating Probabilistic → Causal relationships.

## 8. Canvas Built-in Function: Grouping, Layout, Toolbar and Control Function

- **Grouping/Subflows:** name a group, drag cards in, group becomes a Dashboard.
- **Auto-Layout:** Dagre.
- **Node Toolbar:** Edit, Copy, Collapse, Delete.
- **Canvas Controls:** zoom, fit-to-view, lock, and a centralized Date Range Picker.

# The Metrimap: User Stories
Full epics covering Project & Canvas Management, Core Model Building, Detailed Metric & Data Configuration, and Knowledge Management & Reporting — see git history of this file for the complete user-story list if needed.

## Tech Stack for Client-Side Computation

Tech stack, tailored for an internal tool with browser-based computation:
- **Core Framework:** React + TypeScript + Vite
- **Canvas:** React Flow with Dagre for auto-layout
- **UI & Styling:** Shadcn, Recharts, Tailwind CSS
- **State Management:** Zustand
- **Data Fetching:** Tanstack/React Query to manage data from Supabase
- **Database:** **Supabase** (using the `supabase-js` client and Database Functions)
- **Client-Side Computation:**
    - **Threading:** **Web Workers** (with `comlink` for easier use)
    - **Formula Engine:** `math.js`
    - **Statistics:** `simple-statistics`
- **Deployment:** Vercel
- **DevOps & CI/CD:**
	- **Git Hooks:** Husky
	- **CI/CD:** GitHub Actions
	- **Code Quality:** **Typescript-ESLint** (for linting) & **Prettier** (for formatting)
- **Testing:** Vitest
- **Build & Bundle Optimization:**
	- **Code Splitting:** `React.lazy()` for routes
	- **Bundle Analysis:** **`rollup-plugin-visualizer`**

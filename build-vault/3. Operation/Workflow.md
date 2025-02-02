---
draft: true
title: Workflow
date: 2025-01-31
tags:
---


https://www.youtube.com/watch?v=OFkVBi_9FPI


First of all we have to understand the flow of creating a new app, and adding a new feature is totally different.

Personally, I believe that when we're creating a new app, our main focus would on defining the app proposition to user (defining features and core functionalities) and aswell creating a good infrastructure (API Design, database schema, etc) for the purpose/mission of the proposition. 

While adding a feature require to touch all of that, however it's different from "Creating" and "Adding". 

Here we want to define, the workflow for each. Let's begin with Creating.

1. Building early PRD through Ideation Process.
2. Building a Complete PRD for Creation.
	1. Documentation(User Experience + Flow + Action) + Technical(Layout + Page + Components) = Diagramming  
3. Drafting early TRD.
4. Completing a TRD. 
5. Foundation Building
	1. (Complete PRD + Complete TRD) / Core Functionalities - (Features + Optional) = Foundation 
	2. [[Musk's Engineering Principle|Implement the simplification process.]]
6. Scaffolding and Early Deployment.
	1. During PRD, you would refine the foundation of the app. Use that to build on bolt.new. Such foundation would be the tech stack, the most important core functionalities (where everything will be built on top of this), the database schema/architecture, back-end deployment.  Our goal here is to "Start with the foundation, and deploy it fast."




product management (prd, wireframe etc) -> design prototype -> builder.io / lovable.dev for fast architecture/foundation of the app -> optimize/review code manually -> launch


New Feature


TRD (Technical Requirement)

The point of TRD is to produce the requirement that is needed to develop the TDD.

Well it's TDD (Technical Design Document) 
You can also work on SDD (System Design Document)



Breakdown

PRD
TRD
Bolt.

PRD should have at least 2 docs:
7. For the overview and core functionalities
8. For the design, future features etc. 

The first one is what we're gonna need to prompt.

After the PRD, next you want to build a TRD.

Within a TRD there should be, a proposition of tech stack, proposition of computation logic, database, deployment strategy. 

TRD should gives a complete understanding of the app scaffolding. 

From TRD and PRD, you can now breakdown the 

User Flow + Data Flow (Schema Design) 

outline how users will interact with an application, detailing the flow, data, and API interactions

9. UI Component (Front-end component) 
10. User Action
11. Trigger and Functionality 
12. Database Interaction (With data consistency)
13. API Design (Considering versioning, security, JSON Schema and JSON Schema Validation)

[API Design + Architecture Statement by Patrick Collison (Stripe CEO)](https://www.youtube.com/shorts/0K4a05y36c4)


```mermaid  
%%{init: {'theme': 'base', 'themeVariables': { 'primaryColor': '#f0f0f0'}}}%%
sequenceDiagram
    participant User
    participant Frontend as Frontend (Next.js)
    participant API as API (Supabase Edge Functions)
    participant Auth as Auth Service
    participant DB as Database (PostgreSQL)
    participant Storage as Supabase Storage

    %% User Registration/Authentication
    User->>Frontend: Clicks "Sign Up/Login"
    Frontend->>Auth: Trigger supabase.auth.signInWithOAuth()
    Auth-->>Frontend: Returns JWT
    Frontend->>API: Store session token in cookies

    %% Book Upload & Profile Creation
    User->>Frontend: Uploads EPUB/PDF (BookUpload.tsx)
    Frontend->>Storage: supabase.storage.upload("epubs/...")
    Storage-->>Frontend: Returns file_path
    Frontend->>API: POST /api/v1/books (JSON Schema Validation)
    API->>DB: INSERT INTO Books (RLS: user_id = auth.uid())
    API->>DB: INSERT INTO BookEvents (event_type: 'added')
    DB-->>API: Commit transaction (Data Consistency)
    API->>EdgeFunction: Trigger cover image extraction
    EdgeFunction->>Storage: Save cover_image_path
    API-->>Frontend: 201 Created (Book Profile Created)

    %% Highlight Creation
    User->>Frontend: Highlights text (Reader.tsx)
    Frontend->>API: POST /api/v1/highlights (Validate tags via JSON Schema)
    API->>DB: INSERT INTO Highlights (RLS enforced)
    API->>DB: INSERT INTO BookEvents (event_type: 'highlighted')
    DB-->>API: Commit transaction
    API-->>Frontend: 200 OK

    %% Dashboard Personalization
    User->>Frontend: Views Dashboard (Dashboard.tsx)
    Frontend->>API: GET /api/v1/stats (JWT in header)
    API->>DB: Query MissionBoard, Goals, reading_trends MV
    DB-->>API: Aggregated stats
    API-->>Frontend: 200 OK (Rendered Activity Feed)

    %% Obsidian Sync
    User->>Frontend: Clicks "Sync with Obsidian"
    Frontend->>API: GET /api/v1/obsidian/highlights (OAuth token)
    API->>DB: SELECT Highlights WHERE user_id = auth.uid()
    API->>EdgeFunction: Format as Markdown
    EdgeFunction->>Obsidian: Push via REST API
    API-->>Frontend: Sync status updated

    %% Security & Validation
    Note over API,DB: JSON Schema Validation <br/> (e.g., Book.metadata structure)
    Note over DB: RLS Policies on ALL Tables <br/> (auth.uid() = user_id)
    Note over API: Versioning: /api/v1/* <br/> Rate Limiting via Redis
```

---
draft: true
title: "Learnhing"
date: "2025-08-05"
tags: 
---
## Workflow
Always create a branch


## Scaffold Up
During early PRD, ensure understand what "system" we need, siloed, so creation of system become direct.
Tag system

use the name system

create metadata, system right away


For improving RLS recursion issue or infinite loop, use advisor, create scripts to tests example of a good tests, policy tests and rls tests



## Incrementality
Husky pre-commit tests, is used to ensure are deployment is consistent, so whenever we change something for an example homepage, despite the changes, the deployment look consistent. The best way is this, when you are happy with the results or development, create a tests as solid as possible, so whenever there's deviation of that consistency, we can handle it.

This is how you achieve incrementality in development.


Typescript + SWC



## Environment
use clerk in the beginning

Authprovider,
supabaseauthprovided
devauthprovider
protectedroute

Better development and production and staging experience

supabase vercel shared preview and production

use vercel dns


error boundary message (for logging)

error boundary 

Important:
1. Ensure our codebase are Development and Deployment friendly. Check docs: Environment Guide.
2. Use tests to ensure our staging is consistent with our previous deployment.
3. On daily basis work on development and staging, deployment let it run (marketing on this).
4. Maintain changelog.




## AI helpers
Understanding

zenAI for playwright testing end to end

devin for codebase, expansion etc, and optimizing

cursor for all coding



## Tech Stack




### Environment and Dependency Consistency

In a collaborative environment, "it works on my machine" is a classic problem. Small differences in Node.js versions or package manager versions can lead to subtle bugs and dependency tree mismatches.

- **Suggestion:** **Enforce a consistent development environment across your team.**
    
- **Tools & Implementation:**
    
    - **`.nvmrc` file:** Create a `.nvmrc` file in your project root containing the specific Node.js version you use (e.g., `20.11.0`). Developers using `nvm` (Node Version Manager) can then just run `nvm use` to automatically switch to the correct version.
        
    - **`package.json` `engines` field:** Add an `engines` field to your `package.json` to specify the required Node.js version. This will cause package managers like `npm` and `pnpm` to produce a warning or error if a developer tries to install dependencies with an incompatible version.
        
    - **`package.json` `packageManager` field:** This is a crucial step. By adding `"packageManager": "pnpm@9.x.x"` (or your chosen manager and version), you ensure every developer uses the exact same package manager, preventing lockfile inconsistencies.

Workflow
### ## Architectural Documentation

Your tech stack choices are excellent, but _why_ were they made? As the team grows or changes, this context is often lost.

- **Suggestion:** **Keep Architectural Decision Records (ADRs).**
    
- **Tool:** Simple **Markdown files** in your Git repository (e.g., in a `/docs/adr` folder).
    
- **Implementation:** An ADR is a short document that captures a single, significant architectural decision. For example, "ADR-001: Use Clerk for Authentication." The file would outline the context, the decision made, and the consequences (positive and negative).
    
- **Benefit:** ADRs provide invaluable context for new team members and serve as a historical record that justifies the structure of your application, preventing churn and redundant discussions in the future.



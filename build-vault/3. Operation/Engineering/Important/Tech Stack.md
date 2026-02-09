---
draft: false
title: Tech Stack
date: 2025-08-05
tags:
---
## Core Platform

Our application is built on a robust, serverless foundation that handles hosting, backend services, and authentication.

- **CI/CD (GitHub):**
	- **Purpose:** Host our codebases
	- **Key Usage:** Everything is here
- **Hosting & Frontend (Vercel):**
    - **Purpose:** Vercel hosts our frontend application (Next.js/React). It provides a seamless Git-based workflow for continuous deployment, automatic SSL, and a global CDN for performance.
    - **Key Usage:** All deployments are triggered by a `git push` to the `main` branch. We rely on Vercel Analytics for initial monitoring of Core Web Vitals and function performance post-deployment.
- **Backend & Database (Supabase):**
    - **Purpose:** Supabase provides our entire backend infrastructure, including a Postgres database, auto-generated APIs, and real-time capabilities. It allows us to build a secure and scalable backend without managing servers.
    - **Key Usage:** The Supabase dashboard is the first place to check for database-specific issues, such as slow-running queries (`pg_stat_statements`) or API usage spikes.
- **Authentication (Clerk):**
    - **Purpose:** Clerk handles all user authentication, session management, and user profiles. It provides a secure, reliable, and feature-rich auth system out of the box.
    - **Key Usage:** We use Clerk's user IDs to tag all user-related data across our observability stack, which is critical for debugging.
- **Payments (Stripe):**
    - **Purpose:** Stripe processes all payments and manages subscriptions.
    - **Key Usage:** Stripe webhooks are critical. Any errors related to payment processing are considered high-priority incidents.
- **User Understanding (PostHog):**
    - **Purpose:** While Highlight provides technical session replays, PostHog is used for higher-level product analytics—understanding user flows, feature adoption, conversion funnels, and retention.
    - **Distinction:** Use PostHog to answer "What features are users engaging with?". Use Highlight to answer "Why did this specific user's session fail?".
- **User Feedback (Userback):**
    - **Purpose:** The primary channel for users to submit structured visual feedback and bug reports.
    - **Workflow:** A ticket in Userback is the starting point for a bug investigation. The user's email and screenshot provide the initial context needed to find their session in Highlight.
- **Feature Flagging (Bucket.co):**
    - **Purpose:** To de-risk deployments. All significant new features are deployed behind a feature flag. This allows for canary releases (releasing to a small subset of users), A/B testing, and provides an instant "kill switch" if a new feature causes problems.
- **Centralized Logging & Observability (Better Stack):**
	- **Purpose:** Better Stack is the **central hub for our application logs and uptime monitoring**. It unifies logs from our Vercel functions and provides real-time alerting and status pages.
	- **Key Usage:**
	    - **Log Management:** All Vercel function logs are sent to Better Stack via a Log Drain. This is our primary tool for debugging backend issues.
	    - **Uptime Monitoring:** We use Better Stack to ping critical endpoints (e.g., login, key API routes).
	    - **Incident Management:** If an alert fires, Better Stack notifies the team via Slack. We use its integrated **Status Page** to communicate with users during outages.



## Standard Operating Procedures (SOPs)

### **SOP 1: Post-Deployment Checklist**

_After every deployment to production:_
1. **Vercel Dashboard:** Monitor the deployment build logs. Once live, watch **Vercel Analytics** for 15 minutes. Look for negative changes in Core Web Vitals or spikes in 4xx/5xx serverless function errors.
2. **Better Stack Dashboard:** Open the "Live Tail" for your Vercel logs. Ensure no new, unexpected errors are flooding in.
3. **Better Stack Uptime:** Check that all uptime monitors are still reporting "Up".
4. **Smoke Test:** Manually perform critical user flows: sign up, log in, and the primary action of the newly deployed feature.
    
### **SOP 2: Investigating a User-Reported Bug**

_When a bug ticket arrives from **Userback**:_
1. **Gather Context:** Note the user's email, the URL they were on, and the description of the problem from the Userback ticket.
2. **Find Backend Activity in Better Stack:**
    - Log in to **Better Stack**.
    - Search the logs using the user's email or another unique identifier (like a `requestId`) from the approximate time the bug occurred. This helps you find the specific Vercel function logs related to their action.
3. **Analyze User Behavior in PostHog:**
    - Log in to **PostHog**.
    - Find the user's profile and watch their session replay to understand the sequence of actions they took leading up to the bug.
4. **Correlate and Identify Root Cause:** Combine the visual user journey from PostHog with the technical logs from Better Stack to understand the root cause.
5. **Create Ticket & Fix:** Create a detailed engineering ticket with links to the PostHog session and relevant Better Stack logs. Deploy a fix.

### **SOP 3: Handling a Live Site Incident**
_When an alert fires from **Better Stack Uptime**:_

1. **Acknowledge & Communicate:**
    - Acknowledge the alert in the designated Slack channel so the team knows who is handling it.
    - Post an initial update to the **Better Stack Status Page**: "We are investigating issues with [affected service]."
2. **Isolate the Cause:**
    - Check the **Better Stack** logs for a sudden spike in a specific error. This is the fastest way to find the cause.
    - Check the **Vercel** and **Supabase** status pages to rule out a platform outage.
3. **Resolve:**
    - **If caused by a recent deployment:** Use **Vercel** to instantly roll back to the previous production deployment.
    - **If caused by a feature flag:** Use **Bucket.co** to disable the problematic feature flag.
4. **Post-Mortem:** Once the issue is resolved and services are stable, update the status page to "Resolved." Document the incident and resolution for future reference.
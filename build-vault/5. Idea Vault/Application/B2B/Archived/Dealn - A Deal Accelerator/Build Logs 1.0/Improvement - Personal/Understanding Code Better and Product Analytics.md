---
draft: true
title: "Understanding Code Better and Product Analytics"
date: "2025-07-23"
tags: 
---

Product Information (to understand how user interact with the app, this data/signal would help us understand more of our app):
1. Posthog (pay as you go but worth it)
2. Sentry (paid but worth it)
3. Bucket.co
4. 


Product Performance:
1. Vercel Speed Insight (free, included premium vercel)
2. Vercel Analytics (pay as you go worth it)


Documentation and Consistency: (Needed but need to do slowly)
1. Storybooks (components)
2. OpenAPI (API documentation)
3. Semantic Releases


CI/CD
1. CircleCI (free)
2. Github Actions
3. Terraform (Infrastructure-as-code for backend documentation)
4. Dependabot
5. CodeQL


Programmer Workflows
1. Husky
2. Code Ethics:
	1. front matter for each code page
	2. comments for each code - explaining what happen


AI Agents:
1. Zencoder + Playwright


# Document a single file
node scripts/add-documentation.js src/components/YourComponent.tsx

# Document all files in a directory
node scripts/add-documentation.js src/components/

# Document all .tsx files in the entire src directory
node scripts/add-documentation.js src/
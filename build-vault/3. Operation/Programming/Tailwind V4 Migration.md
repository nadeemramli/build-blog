---
draft: false
title: Tailwind V4 Migration
date: 2025-03-07
tags:
---
# Tailwind CSS v4 Migration Guide

  

This document outlines the changes made to fix Tailwind CSS v4 configuration in our Next.js monorepo setup.

  

## Changes Required

  

### 1. PostCSS Configuration

  

In Tailwind CSS v4, the PostCSS plugin has been moved to a dedicated package. We updated both admin and frontend apps' `postcss.config.mjs`:

  

```js

/** @type {import('postcss').Config} */

export default {

  plugins: {

    "@tailwindcss/postcss": {},

  },

};

```

  

Key changes:

- Removed `tailwindcss` plugin

- Removed `autoprefixer` (now handled automatically by Tailwind v4)

- Added `@tailwindcss/postcss` as the only plugin

  

### 2. CSS Imports

  

The way Tailwind is imported in CSS files has changed in v4. We updated both apps' `globals.css`:

  

From:

```css

@import "tailwindcss/base";

@import "tailwindcss/utilities";

```

  

To:

```css

@import "tailwindcss";

```

  

Key changes:

- Replaced multiple imports with a single `@import "tailwindcss"`

- No need for separate base/components/utilities imports

  

### 3. Dependencies

  

Make sure your `package.json` has the following versions:

```json

{

  "dependencies": {

    "tailwindcss": "^4.0.9"

  },

  "devDependencies": {

    "@tailwindcss/postcss": "^4.0.9"

  }

}

```

  

## Files Modified

  

1. `/apps/admin/postcss.config.mjs`

2. `/apps/admin/src/app/globals.css`

3. `/apps/frontend/postcss.config.mjs`

4. `/apps/frontend/src/app/globals.css`

  

## Additional Notes

  

- Tailwind CSS v4 now handles vendor prefixing automatically

- The changes need to be applied to all apps in the monorepo that use Tailwind CSS

- Custom utilities can still be defined using `@layer utilities`

- The configuration is now simpler and more streamlined compared to v3



prompt that solves the problem:
Please, how many times do I have to tell you that the tailwind CSS version 4.0.9 is the latest version @https://tailwindcss.com/docs/upgrade-guide read this.

Cursor can actually read document
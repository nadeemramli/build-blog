---
draft: true
title: "PRD"
date: "2025-03-04"
tags: 
---
Important PRD:

### **User Experience (UX) & Design**
- **Mobile-First Design**: Prioritize mobile responsiveness, as most users will likely browse on phones.
- **Intuitive Navigation**:
    - Clear categories (e.g., Men’s/Women’s/Kids, Materials, Price Ranges, Occasions).
    - Advanced filters (price, size, color, brand, fabric type, occasion).
    - Search with autocomplete and typo tolerance (e.g., Elasticsearch or Supabase Full-Text Search).
- **Product Comparison Tool**: Allow side-by-side comparisons of kurtas (price, design, materials).
- **Visual Appeal**:
    - High-quality images with zoom functionality.
    - Consistent branding (colors, fonts) that reflects Malaysian cultural aesthetics.
- **User Accounts**:
    - Wishlists, saved comparisons, and order history (if integrating affiliate purchases).

### **Technical Architecture**
- **Next.js Optimization**:
    - Use Static Site Generation (SSG) or Incremental Static Regeneration (ISR) for fast page loads.
    - Implement lazy loading for images and components.
- **Supabase Setup**:
    - Database schema design for products (brand, price, size, material, SKU), blogs, and user data.
    - Real-time updates for price changes or stock availability (via Supabase Realtime).
    - Secure authentication (OAuth, email/password) with row-level security.
- **APIs & Integrations**:
    - Scrape or partner with brands to aggregate product data (APIs/CSV imports).
    - Affiliate tracking (e.g., Refersion or custom-built with Supabase Edge Functions).
- **Performance**:
    - CDN for static assets (e.g., Vercel’s Edge Network).
    - Optimize image delivery (Next.js Image component).
- **Security**:
    - SSL/TLS encryption.
    - Input validation and rate limiting for APIs.
    - Regular security audits.

### **Content Strategy (CMS Blog)**
- **SEO-Driven Content**:
    - Target keywords like “best kurta Malaysia,” “kurta price comparison,” “how to style kurta.”
    - Localize content (e.g., “Raya kurta trends 2024”).
- **CMS Integration**:
    - Use Sanity.io, Strapi, or Decap CMS for blog management.
    - Optimize URLs, meta tags, and structured data (Schema.org for products/blogs).
- **Content Calendar**:
    - Publish guides, trend reports, brand spotlights, and cultural stories.
    - Encourage user-generated content (e.g., customer photos with hashtags).
- **Internal Linking**:
    - Link blog posts to relevant product pages to boost SEO and engagement.

###  **SEO & Marketing**
- **On-Page SEO**:
    - Optimize product pages with unique titles/descriptions (e.g., “Blue Silk Kurta Malaysia – Price Comparison”).
    - Generate a sitemap.xml and submit to Google Search Console.
- **Off-Page SEO**:
    - Build backlinks via guest posts on Malaysian fashion blogs.
    - Leverage social media (TikTok/Instagram Reels showcasing kurta styles).
- **Paid Ads**:
    - Run Google Ads targeting keywords like “buy kurta online Malaysia.”
    - Retarget users who abandon carts or browse comparisons.

### **Analytics & Iteration**
- **Track Metrics**:
    - User behavior (Hotjar, Google Analytics).
    - Conversion rates for affiliate links.
    - Blog performance (top posts, bounce rate).
- **Feedback Loop**:
    - Add surveys or a rating system to gather user insights.
- **A/B Testing**:
    - Experiment with layouts, CTAs, and filters to optimize conversions.

### **Legal & Compliance**
- **Privacy Policy**:
    - Comply with Malaysia’s PDPA (Personal Data Protection Act).
- **Terms of Service**:
    - Clarify affiliate relationships and data usage.
- **Accessibility**:
    - Follow WCAG guidelines (alt text, keyboard navigation).


### **Scalability & Maintenance**
- **Automate Backups**:
    - Use Supabase’s backup solutions or cron jobs for database dumps.
- **Monitor Uptime**:
    - Tools like UptimeRobot to track server availability.
- **Plan for Growth**:
    - Scale Supabase resources as traffic increases.
    - Add features like AR try-ons or AI recommendations later.
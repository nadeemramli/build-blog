---
draft: true
title: "Operationalize (pricing)"
date: "2025-07-23"
tags: 
---
Looking at your Form Forge Domains B2B SaaS application, you're asking about three key areas: signup notifications, Stripe-based pricing tiers, and pricing recommendations. Let me address each based on your current codebase.

## Signup Notification System 

Your current signup flow is handled in Signup.tsx:95-154 and the authentication system in useAuth.tsx:380-418 .

To add owner notifications, you can implement this in several ways:

### 1. **Database Trigger Approach** 

Add a notification when the onboarding completes in Onboarding.tsx:231-380 . You could insert a notification record or trigger a webhook here.

### 2. **PostHog Integration** 

Since you already have PostHog integrated , you can set up alerts based on signup events tracked in your analytics system .

### 3. **Email Service Integration** 

Add an email notification service call after successful user organization assignment in the onboarding completion flow.

## Stripe Pricing Tiers Implementation 

Based on your current architecture, here's how to implement the pricing tiers:

### Database Schema Changes 

You'll need to add subscription-related tables to track:

- User subscriptions
- Plan limits
- Usage tracking

### Tier Enforcement 

Implement plan limits in your existing components:

1. **Project Creation Limits** - Modify project creation logic to check current plan
2. **Portal Creation Limits** - Add checks in your deal portal creation flow
3. **Analytics Access** - Gate analytics features based on subscription tier

### Integration Points 

- Add Stripe checkout to your settings page referenced in SidebarUserMenu.tsx:341-400
- Implement webhook handlers for Stripe events
- Add subscription status checks throughout your app

## Pricing Recommendations 

Based on your current tech stack and feature set:

### **Free Tier: $0** 

- 3 projects, 3 portals per project
- Basic CRM functionality
- No analytics/reports
- Community support

### **Plus Tier: $29-49/month** 

- 10 active projects
- Unlimited portals
- Analytics and reports
- Workflow automation
- Email support

### **Pro Tier: $99-149/month** 

- Unlimited projects
- Advanced analytics
- Priority support
- Custom integrations
- Advanced workflow features

### **Enterprise: Custom pricing** 

- White-label options
- Custom subdomain management (you already have this infrastructure)
- Dedicated support
- Custom integrations

## Implementation Strategy 

1. **Start with Stripe Products/Prices** - Create your pricing tiers in Stripe dashboard
2. **Add Subscription Management** - Implement subscription CRUD operations
3. **Usage Tracking** - Track project/portal creation against limits
4. **Feature Gating** - Add plan checks throughout your application
5. **Billing UI** - Add subscription management to your settings pages

Your current Supabase + Vercel architecture is well-suited for this implementation, and your existing authentication system provides a solid foundation for user-based billing.

Wiki pages you might want to explore:

- [Authentication System (nadeemramli/form-forge-domains)](https://app.devin.ai/wiki/nadeemramli/form-forge-domains#2.1)
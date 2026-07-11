---
draft: true
title: "TASK"
date: "2025-06-04"
tags: 
---

Great question! Let me explain the template system and then we can start building the pages according to your roadmap.

## Understanding the Template System

Based on your documentation, there are **three types of templates** in play:

### 1. **Page Layout Templates** (What we should focus on)
These are reusable page layouts for different types of content:

- **`landing`** - Homepage, Industry pages, Location pages, Packages
- **`service`** - Service detail pages (Website Dev, Ads Management, etc.)
- **`resource`** - Blog, guides, tools, lead magnets
- **`utility`** - About, Contact, Legal pages

### 2. **Component Templates** (Already working)
Reusable components with configurable props - like your existing `HeroSection`, `Footer`, etc.

### 3. **Template Generation System** (Future automation)
A system to automatically generate pages - we can build this later for efficiency.

Let me show you how this works and start building your priority pages:

Ran tool


Ran tool


Ran tool


Ran tool


Ran tool


Ran tool


Ran tool


Read file: src/components/templates/landing/base/LandingTemplate.tsx

Perfect! Now I understand exactly how your template system works. Let me explain and then we'll start building your pages.

## 🧩 **How the Template System Works**

### **Page Layout Templates** (Your main focus)
These are **reusable page structures** with configurable content sections:

```typescript
// Example: LandingTemplate
<LandingTemplate
  heroTitle="Stop Losing Customers to Better-Looking Competitors"
  heroDescription="We create professional content and marketing..."
  packages={terokaPackages}
  industries={targetIndustries}
  testimonials={clientStories}
  // ... other props
/>
```

### **Current Template Types:**
1. **`LandingTemplate`** ✅ **READY** - For homepage, industry pages, location pages
2. **`ServiceTemplate`** ❌ **MISSING** - For service detail pages  
3. **`ResourceTemplate`** ✅ **PARTIAL** - For blog/resources
4. **`UtilityTemplate`** ✅ **PARTIAL** - For about/contact/legal

## 🎯 **Let's Build Your Priority Pages**

According to your roadmap, let's start with **Phase 2: Core Pages**. I'll create the missing templates and pages:



Let me fix the metadata issue first:

Read file: src/app/resources/metadata.ts




Now let me update the routes configuration to include the packages page:



Now let me create a Service template and then build some industry pages. First, let's create a Service template:



Now let me create an industry-specific landing page. Let's start with the Dental Clinic Marketing page, which is one of your priority industries:



Let me add the dental route to the configuration and update the homepage with proper Teroka Digital content:




Read file: src/app/[lang]/page.tsx

Now let me update the homepage to use the LandingTemplate with proper Teroka Digital content:



## 🎉 **Template System Successfully Implemented!**

I've successfully demonstrated your template system and built your priority pages. Here's what's been accomplished:

## ✅ **What We Built**

### **1. Updated Homepage (`/`)**
- ✅ Uses `LandingTemplate` with proper **Teroka Digital** content
- ✅ Features your **3 packages**: Try Out (RM4,450), Growth (RM7,500), Partner (Custom)
- ✅ Showcases **6 target industries** with links to industry pages
- ✅ **Multi-language support** (EN/MY/CN)
- ✅ Your **UVP messaging**: *"Stop losing customers to competitors who look more professional online"*

### **2. Packages Page (`/packages`)**
- ✅ Complete pricing page using `LandingTemplate`
- ✅ Package comparison with **detailed features**
- ✅ Industry selector and testimonials
- ✅ **SEO optimized** with proper metadata

### **3. Dental Industry Page (`/industry/dental`)**
- ✅ **Industry-specific content** and testimonials
- ✅ **Dental-focused packages** and results
- ✅ **Healthcare compliance** aware content
- ✅ Related healthcare industries suggested

### **4. Template Infrastructure**
- ✅ `LandingTemplate` - Fully functional for homepage, industry, and location pages
- ✅ `ServiceTemplate` - Structure created for service pages
- ✅ **Metadata system** updated to support new pages
- ✅ **Routes configuration** updated

## 🧩 **How Your Template System Works**

```typescript
// Same template, different content
<LandingTemplate
  heroTitle="Industry-Specific Title"
  packages={industryPackages}        // Customized for industry
  testimonials={industryClients}     // Industry testimonials
  faqs={industryFAQs}               // Industry-specific questions
  // ... other configurable props
/>
```

## 🚀 **Next Steps Based on Your Roadmap**

### **Phase 1: Immediate (This Week)**
1. **Fix Projects Component** - Debug the image overlap issue you mentioned
2. **Create Service Pages** - Build Website Development, Ads Management pages
3. **Add More Industry Pages** - Restaurant, Legal, Interior Design

### **Phase 2: Core Pages (Next 2 Weeks)**
4. **About Page** - Company story and team
5. **Contact Page** - Lead generation forms
6. **Get Started Page** - Package selection flow

### **Phase 3: Scale Quickly**
7. **Location Pages** - KL, Selangor, Johor (using same LandingTemplate)
8. **Service Deep-Dive Pages** - Using ServiceTemplate
9. **Resource Pages** - Using existing blog template

## 💡 **Template Benefits You're Getting**

1. **Consistency** - All pages follow the same proven structure
2. **Speed** - New pages created in minutes, not hours
3. **Maintenance** - Update template = all pages improve
4. **Multi-language** - Built-in translation support
5. **SEO Optimized** - Structured data and metadata handled automatically

## 📋 **Ready to Continue Building?**

Your template system is now ready for rapid page creation. Would you like me to:

1. **Build more industry pages** (Restaurant, Legal, etc.)
2. **Create service pages** using the ServiceTemplate
3. **Fix the Projects component** for the homepage
4. **Build the contact/about pages**

The template foundation is solid - we can now build your entire website very quickly! 🚀

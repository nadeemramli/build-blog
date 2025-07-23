---
draft: true
title: "Devin 5h Response (Summary)"
date: "2025-07-22"
tags: 
---
Going back to this: What Needs to Be Built You need to create: Public Portal Viewer Component - A component that fetches portal data by slug and renders the portal content without requiring authentication Public Route - Add a route like /:slug that serves the portal viewer Portal Rendering Logic - Logic to render the portal blocks/pages based on the saved portal structure Subdomain Context - Ensure the portal viewer can determine which organization's portal to serve based on the subdomain And this Corrected Understanding Based on your explanation, the deal portal system works as follows: Multi-Page Portal Structure - Each deal portal can contain multiple pages, where users can choose different page types when creating new pages. DealPortalBuilder.tsx:80-93 Two Main Page Types: Rich Text Editor (Blank Page) - This corresponds to the "blank" page type that uses the blocks system for flexible content creation DealPortalBuilder.tsx:155-161 Document Builder - This corresponds to the "document" page type that provides specialized document generation capabilities like Plutio DealPortalBuilder.tsx:162-167 Project Variables Integration The key insight you've highlighted is the project variables system that automatically populates document data. ProjectVariables.tsx:118-178 This system generates comprehensive context variables from project data including: Project information (name, description, budget, deadline) Company details (name, industry, website, size) Contact information (names, emails, positions) Meeting and conversation statistics Portal metrics Variable Usage in Documents - The variables are accessible using template syntax {{variable.key}} and can be used in portal content creation. ProjectVariables.tsx:556-563 Integration with Portal Builder - The DealPortalBuilder already hooks into the project variables system via useProjectVariables(projectId), making these variables available for document generation. DealPortalBuilder.tsx:222-225 Revised Development Approach With this understanding, the Document Builder page type should: Leverage Project Variables - Automatically populate document templates with project data, eliminating manual data entry Provide Document Templates - Offer pre-built templates for invoices, contracts, proposals that use the variable system Generate Professional Documents - Similar to Plutio's document generation capabilities The business block types you've already defined (proposal, invoice, contract) DealPortalBuilder.tsx:141-146 align perfectly with this document builder vision. This clarification significantly improves the development strategy - the project variables system provides the data foundation needed for sophisticated document generation without manual input. What's our new development plan looks like?

Based on your requirements, here's the comprehensive development plan for building the public portal viewer and enhanced document builder system:

## Development Roadmap 

### Phase 1: Public Portal Infrastructure (Critical Foundation) 

**1. Public Portal Viewer Component**

- Create `src/components/public/PublicPortalViewer.tsx` to fetch and render portal data by slug without authentication
- Implement portal data fetching logic that queries the `deal_portals` table using the slug parameter
- Build rendering system that processes the portal's pages array and renders each page type appropriately

**2. Public Routing System**

- Add public route `/:slug` in alongside existing protected routes
- Implement subdomain detection logic to determine which organization's portal to serve
- Create subdomain context provider to pass organization data to the portal viewer

**3. Portal Rendering Engine**

- Extend the existing `renderBlock` function from DealPortalBuilder.tsx:929-951 to handle public rendering
- Build page navigation system for multi-page portals using the `PortalPage` interface structure
- Implement responsive rendering that works across desktop, tablet, and mobile views

### Phase 2: Document Builder Enhancement 

**4. Document Template System**

- Create document templates for the business block types: `proposal`, `invoice`, `contract`, and `analytics` defined in DealPortalBuilder.tsx:141-146
- Build template engine that processes project variables using the existing context variables from ProjectVariables.tsx:118-178
- Implement variable interpolation system that replaces `{{variable.key}}` syntax with actual values

**5. Enhanced Document Builder Interface**

- Replace the placeholder "Configure Document" button in DealPortalBuilder.tsx:635-647 with a full document builder interface
- Create document type selection (proposal, invoice, contract) with pre-built templates
- Build rich text editor with variable insertion capabilities
- Add PDF generation functionality for document export

### Phase 3: Advanced Features 

**6. Form Builder Integration**

- Implement the form builder for the `"form"` page type currently showing placeholder content
- Create Typeform-style single-page form experience
- Integrate form submissions with the existing project data structure

**7. Workflow and Automation**

- Build the workflow system currently showing "Coming Soon" in DealPortalBuilder.tsx:826-915
- Implement automated document generation triggers
- Add email notifications and approval workflows

## Technical Dependencies 

**Required Installations:**

```
# Rich text editor for document builder  npm install @tiptap/react @tiptap/starter-kit @tiptap/extension-placeholder    # PDF generation  npm install jspdf html2canvas    # Template processing  npm install handlebars    # Form validation enhancement  npm install react-hook-form @hookform/resolvers zod
```

**Environment Setup:**  
The existing setup from covers the basic requirements. Additional configuration needed:

- Subdomain routing configuration in Vercel
- Public API endpoints for portal data fetching
- CORS configuration for cross-origin portal access

## Implementation Priority 

Following the task management structure from task-lists.mdc:22-51 , the development should proceed in this order:

**High Priority (Immediate Impact):**

1. Public Portal Viewer Component - Critical for basic functionality
2. Public Routing System - Required for portal access
3. Subdomain Context Detection - Essential for multi-tenant architecture

**Medium Priority (Next Sprint):**  
4. Document Template System - Core value proposition  
5. Variable Interpolation Engine - Automation foundation  
6. Enhanced Document Builder Interface - User experience improvement

**Low Priority (Future Enhancements):**  
7. Form Builder Integration - Additional page type support  
8. Workflow Automation - Advanced features  
9. Analytics and Tracking - Performance optimization

## Key Integration Points 

The system leverages existing infrastructure:

- **Project Variables System**: DealPortalBuilder.tsx:222-225 already integrates with `useProjectVariables`
- **Portal Management**: ProjectDealportals.tsx:304-306 shows URL generation is already implemented
- **Database Schema**: types.ts:311-370 defines the complete portal data structure

This plan transforms the existing portal builder from an internal tool into a fully functional public portal system with sophisticated document generation capabilities powered by project variables.

Wiki pages you might want to explore:

- [Deal Portal System (nadeemramli/form-forge-domains)](https://app.devin.ai/wiki/nadeemramli/form-forge-domains#5)
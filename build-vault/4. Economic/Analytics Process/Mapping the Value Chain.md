---
draft: true
title: "Mapping the Value Chain"
date: "2025-07-30"
tags: 
---
the next stage is to map the business's core processes and build the foundational data structure.

#### **Section 2.1: Mapping the Value Chain**

The central structure of the entire model is the value chain, which you describe as **"the first steps in what most people call the 'customer journey' which I prefer to call the 'value chain' because the customer must receive some value in every step in order for them to buy your solution."** This value chain represents the critical path through which the business creates, proposes, delivers, captures, and sustains value.
    
- It traces the journey from acquisition to post-service and forms the backbone of the subsequent metrics architecture.
    

The part of the process, which is the 3rd stage of the process is to map the value chain. Mapping the Value Chain: These are the first steps in what most people call the “customer journey” which I prefer to call the “value chain” because the customer must receive some value in every step in order for them to buy your solution.

Here’s the value chain of Chiro-1st as best I understand it. Let’s briefly walk through the steps in order to understand how the customer gets value in each step until they receive the ultimate value: pain relief.
![[Pasted image 20250729153353.png]]
To get to this point, we really have to understand the business model, the value proposition, then do an overview analysis using 12-point framework, with constraints to identify point of interests.

This value chain mapping is simply critical path of the business operation to create, propose, deliver, capture and sustain value, using both customer/market (External) and business/operation (Internal) lens.

Here with context of value chain (internal and external), with constraints and point of interests I can create metrics tree derived from the value chain. Now that I understand the value chain, all you have to do is put some metrics in each step and build your initial metrics tree.

You've confirmed that the TOC constraint analysis provides the initial, high-leverage hypothesis. You then use the Value Chain map, as illustrated in the image, as the foundational structure—the spine—for your entire metrics tree. This tree is not just a list of KPIs; it's a multi-dimensional, causal model where metrics are enriched with properties and their relationships are explicitly defined.


Of course. You've built an excellent foundation by focusing on the value chain as the spine for your metrics tree and integrating it with Theory of Constraints (TOC) analysis. This is a sophisticated and highly effective approach.

To enrich your existing map, let's explore some other powerful concepts. These aren't meant to replace your model but to add layers of depth, providing different lenses to view the same process, which will help you build an even more robust and insightful metrics tree.

Here are several complementary mapping concepts, starting with a deeper dive into the "critical path."

### 1. The "Critical Path" in a Business Process Context

You've correctly identified the connection between your value chain and the "critical path." In its formal project management origins (Critical Path Method - CPM), the critical path is the longest sequence of dependent tasks that determines the minimum time to complete a project.

For your business, we can adapt this concept:

- **Definition:** The **Business Critical Path** is the sequence of essential, non-skippable activities a customer _must_ complete to receive the core value proposition (e.g., pain relief). Any delay or failure on this path directly jeopardizes the final outcome.
- **Application to Chiro-1st:** Your existing chain (`Awareness -> Inquiry -> ... -> Sustained Wellness`) _is_ the critical path from a customer's perspective. The power comes from analyzing it with this lens:
    - **Identify Dependencies:** The patient cannot get a "Treatment Plan" _before_ the "First Visit & Assessment." This seems obvious, but mapping these dependencies is crucial for resource allocation.
    - **Find the Bottleneck (Your TOC Constraint):** The step on the critical path with the least capacity or longest cycle time is your system's constraint. Is it the number of "First Visit" slots available per week? The time it takes to get insurance approval for a "Treatment Plan"? The critical path framework makes it clear that improving a non-bottleneck step (e.g., making your website's 'Awareness' content load 0.1 seconds faster) will have zero impact on the overall throughput of patients achieving "Pain Relief" if your constraint is appointment availability.
        
- **Enrichment:** Ask: "What are the sub-tasks and resources required for each step on this critical path?" For the "First Visit," this includes the chiropractor's time, the room, the check-in staff, the diagnostic equipment, and the payment processing system. A failure in any of these sub-tasks puts the critical path step at risk.
    

---

### 2. Porter's Value Chain Model

This is the classic, foundational concept of a value chain, and it's brilliant for adding the **internal operational lens** you mentioned. While your current map is customer-centric (an "outside-in" view), Porter's model is business-centric (an "inside-out" view). It forces you to map the internal activities that create the value the customer experiences.

Porter splits activities into two categories:

A. Primary Activities (Directly Create Value):

These align closely with your existing customer-facing chain.

- **Inbound Logistics:** How you acquire resources. (e.g., sourcing medical supplies, hiring chiropractors, acquiring diagnostic software).
    
- **Operations:** Transforming inputs into the final service. (This is your core: `First Visit`, `Assessment`, `Report of Findings`, `Treatment Plan Execution`).
    
- **Outbound Logistics:** Delivering the service. (e.g., scheduling follow-ups, providing exercise plans, patient communication).
    
- **Marketing & Sales:** Making customers aware and converting them. (Your `Awareness` and `Inquiry` stages).
    
- **Service:** Post-delivery support. (Your `Sustained Wellness` and `Post-Service` stages).
    

B. Support Activities (Enable Primary Activities):

This is where the real enrichment happens. These are the internal processes that underpin the entire value chain.

- **Firm Infrastructure:** Management, finance, legal, quality management. (e.g., clinic management, billing and insurance processing, regulatory compliance).
    
- **Human Resource Management:** Recruiting, training, and retaining staff (chiropractors, receptionists, etc.).
    
- **Technology Development:** R&D, process automation. (e.g., implementing a new patient management system, investing in new treatment technologies, website development).
    
- **Procurement:** Purchasing of inputs used across the value chain.
    

**How to Integrate:** For each step in your Chiro-1st map, ask: "Which Support Activities are required to make this step happen successfully?"

- _Example:_ The **"First Visit"** step relies on:
    
    - **HRM:** A well-trained chiropractor and receptionist.
        
    - **Technology:** A functioning booking system and diagnostic tools.
        
    - **Infrastructure:** A clean and available treatment room, a system for payment.
        

Mapping these support activities will reveal new areas for metrics that are often leading indicators of problems on the primary value chain. For instance, a drop in "Staff Satisfaction" (HRM metric) could be a leading indicator for an increase in "Patient Wait Times" (Operations metric).

---

### 3. Service Blueprinting

Since Chiro-1st is a service business, a Service Blueprint is arguably one of the most powerful mapping tools you can use. It visualizes the service process from both the customer and business perspectives, explicitly linking them. It perfectly captures your desire for an "internal and external lens" on a single map.

A Service Blueprint has distinct horizontal lanes:
1. **Physical Evidence:** The tangible things the customer sees and interacts with (e.g., the clinic's sign, the website, the treatment room, the bill).
2. **Customer Actions:** The steps the customer takes (Your existing value chain: Visits website, calls to inquire, arrives for appointment, receives treatment).
3. **Line of Interaction**
4. **Frontstage Actions (Onstage):** What the employees do in direct view of the customer (e.g., Receptionist greets patient, Chiropractor performs assessment, Assistant processes payment).
5. **Line of Visibility**
6. **Backstage Actions (Offstage):** What employees do behind the scenes to support the frontstage actions (e.g., Sterilizing equipment, updating patient records in the EMR, preparing the treatment room, coordinating with insurance companies).
7. **Line of Internal Interaction**
8. **Support Processes:** Internal steps or systems that support the employees (e.g., the EMR software itself, the scheduling system, billing software, staff training programs).

**Why this is valuable for you:**
- It explicitly separates what the customer sees from what they don't, helping you identify potential points of failure "backstage" that will eventually impact the "frontstage" customer experience.
- It's perfect for creating metrics. Each lane can have its own set of KPIs.
    - **Frontstage Metric:** Patient Wait Time.
    - **Backstage Metric:** Time to Update Patient Record.
    - **Support Process Metric:** System Uptime %.
- It highlights the "Moments of Truth"—critical frontstage interactions that define the customer's perception of quality.
    
---

### Summary: How to Weave Them Together

You don't need to create four separate, massive diagrams. You can enrich your existing value chain map by layering these concepts.

1. **Start with your current Customer Value Chain.** This remains your spine and your **Critical Path**.
    
2. **Use the Service Blueprint structure** to split each step into "Customer Action," "Frontstage Action," and "Backstage Action." This immediately gives you internal and external views for each stage.
    
3. **Use Porter's Support Activities** as a checklist to identify the underlying resources needed for your backstage actions and support processes. Ask for each step: "What HR, Technology, and Infrastructure is required here?"
    
4. **Build Your Metrics Tree from this Enriched Map.** Now, your top-level nodes are the stages of your value chain (`Awareness`, `Inquiry`, etc.). The next level of branches can be derived from the blueprint:
    
    - `First Visit` (Value Chain Stage)
        
        - `Customer Experience Metrics` (e.g., Net Promoter Score for the visit)
            
        - `Frontstage Performance Metrics` (e.g., On-Time Start Rate, Duration of Visit)
            
        - `Backstage Performance Metrics` (e.g., Time to complete post-visit notes)
            
        - `Support Process Metrics` (e.g., Diagnostic equipment uptime)
            

By integrating these frameworks, you move from a linear path to a rich, multi-dimensional map that shows not just _what_ happens, but _how_ it happens, _who_ makes it happen, and _what systems_ support it all. This provides a far more fertile ground for creating a truly comprehensive and causal metrics tree.


https://www.geeksforgeeks.org/software-engineering/software-engineering-critical-path-method/
https://www.projectmanager.com/guides/critical-path-method
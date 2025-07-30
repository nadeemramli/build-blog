---
draft: true
title: "Optimization Levers"
date: "2025-07-30"
tags: 
---

Understand [[Understanding Scope of Optimization]]

You've described your current approach as ensuring resource utilization and achieving benchmarks through "tinkering." This is a perfect description of an intuitive, manual search for a good solution.

What we can do now is formalize that "tinkering" into a powerful, systematic process. This is the core purpose of

**Optimization Modeling**: to find the provably _best_ possible solution given your goals and limitations. It’s a mathematical framework for making the best possible choice from a set of alternatives.

Let's walk through how this works, connecting it directly to your existing process.

Imagine your "Metric Drift" analysis for the Chiro 1st case study reveals that your LTV/CAC ratio is declining. The root cause is **Dimension Drift**: you are acquiring too many low-value, low-retention patients from one of your marketing channels.

You know the "why." Optimization tells you "what to do." Here is the systematic process for building the prescriptive layer:

### Step 1: Define the Objective Function

First, you must explicitly state the goal you want to achieve in mathematical terms. This is the metric you aim to maximize or minimize. It transforms your business goal into a clear, measurable target.

- **For the Chiro 1st case, your objective might be:**
    
    - `Maximize: Total New Patients`
        
    - `Maximize: Total Expected LTV from New Patients`
        
    - `Minimize: Customer Acquisition Cost (CAC)`
        

Let's choose to **Maximize the total number of new patients who sign up for a full treatment.**

### Step 2: Identify the Decision Variables

Next, identify the levers you can pull—the choices you have direct control over. These are the inputs the model will determine for you.

- **Your decision variables would be your marketing budget allocations:**
    
    - BPPC​: Dollars spent on digital marketing (PPC, SEO).
        
    - BConsultants​: Dollars spent on partnerships with logistics consultants (in a SaaS context) or other referrers.
        
    - BSales​: Dollars spent on the inside sales team.
        

### Step 3: Define the Constraints

No business has unlimited resources. Constraints are the mathematical equations that define the real-world boundaries and rules you must operate within.

- **Your constraints would be:**
    
    - **Budget Constraint:** The total marketing spend must not exceed the available budget. From your case study, let's say the monthly marketing budget is $2,000.
        
        - BPPC​+BConsultants​+BSales​≤2000
            
    - **Capacity Constraint:** The number of new patients cannot exceed the treatment capacity of your doctors and facilities. Let's say your 6 locations can handle a maximum of 150 new patients per month.
        
        - `Total New Patients` ≤150
            

### Step 4: Formulate the Mathematical Relationships

This is the core of the model where you connect your decision variables to your objective. You need to estimate how each dollar spent in a channel translates into new patients. This is often called a "response curve." You can get these numbers from your historical data.

Let's assume you find:

- Every $100 spent on PPC yields 1 new patient. `(New_Patients_PPC = B_PPC / 100)`
    
- Every $200 spent on the Sales team yields 1 new patient. `(New_Patients_Sales = B_Sales / 200)`
    
- Every $50 spent on Consultants yields 1 new patient. `(New_Patients_Consultants = B_Consultants / 50)`
    

Now you can write your full objective function: `Maximize: (B_PPC / 100) + (B_Sales / 200) + (B_Consultants / 50)`

### The Complete Optimization Model

Putting it all together, you have a formal, solvable problem:

**Objective:** `Maximize: (B_PPC / 100) + (B_Sales / 200) + (B_Consultants / 50)`

**Subject to the Constraints:**

1. BPPC​+BConsultants​+BSales​≤2000
    
2. BPPC​≥0, BSales​≥0, BConsultants​≥0
    
3. `(B_PPC / 100) + (B_Sales / 200) + (B_Consultants / 50) \le 150$
    

This is a classic

**Linear Programming** problem. Instead of "tinkering" with different budget numbers, you can feed this model into software (like Excel's Solver, or Python libraries) and it will give you the single best answer. The solution would tell you the

_exact_ dollar amount to allocate to each channel to maximize your new patient intake while respecting your budget and capacity.

This is the prescriptive layer. It transforms your diagnosis into a data-driven, optimal decision. This is a key area we can develop and build out for your "Momentus" framework.
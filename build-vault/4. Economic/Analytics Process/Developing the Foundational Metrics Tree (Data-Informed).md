---
draft: true
title: "Developing the Foundational Metrics Tree (Data-Informed)"
date: "2025-07-30"
tags: 
---

- This stage focuses on building the causal model of metrics.
    
- **Architecture:** The value chain acts as the spine, with branches for different metric types and properties (as we detailed).
    
- **Diagnostic Engine:** The **Metric Drift Framework** (Component, Temporal, Influence, etc.) is the specific tool used here to understand the causal relationships and diagnose _why_ metrics change.
    
#### **Section 2.2: Architecting the Metrics Tree**

The value chain serves as the backbone for a sophisticated metrics tree. Each step in the value chain becomes a primary node from which a rich hierarchy of metrics is branched out.

1. **Metric Branches:** Metrics are categorized to define their role (e.g., Input/Output Metrics, Leading/Lagging KPIs, Diagnostic Metrics, North Star Metric).
2. **Relationship Mapping:** The relationships between metrics are explicitly modeled to create a causal map:
    - **Deterministic:** Formulaic relationships (e.g., `Revenue = Price × Quantity`).
    - **Probabilistic:** Correlational relationships.
    - **Causal:** Direct cause-and-effect links.
    - **Compositional:** Hierarchical relationships where one metric is a component of another.
3. **Metric Classification:** Each metric is assigned properties and dimensions to provide a deeper analytical context, as defined in the following table:


Metrics tree consist of value chain (internal / external) as the journey or steps, which then from here we branch out input metrics, output metrics, leading KPI or lagging KPI, diagnostic metrics, north star metrics. Each metrics then model out, which I also needing to map out possible relationships amongst the metrics, Deterministic (Formulaic) Relationships, Probabilistic (Correlational) Relationships, Causal Relationships, Compositional (Hierarchical) Relationships.

For each metrics you map out, you can assign their properties/dimension like that document these below:

  

Metric CategoryCore Question It AnswersPrimary Use CaseQualitativeWhy is this happening? What is the context?Understanding user sentiment, diagnosing problems, gathering rich feedback.QuantitativeHow much? How many?Objective measurement, statistical analysis, tracking performance at scale.VanityHow can we make ourselves look good?Often used in superficial reporting; should be avoided for decision-making.ActionableWhat decision can we make based on this data?Driving improvements, A/B testing, understanding specific user behaviors.EfficiencyHow well are we using our resources?Optimizing processes, reducing costs, improving productivity.EffectivenessAre we achieving the desired results?Validating strategy, measuring impact, ensuring alignment with goals.StrategicAre we winning in the long term?C-suite reporting, long-range planning, tracking against major objectives.TacticalIs this project or initiative working?Departmental/team-level management, evaluating specific campaigns or strategies.OperationalAre our daily activities running smoothly?Front-line management, real-time monitoring, managing daily workflow.


Metric CategoryCore Question It AnswersPrimary Use Case**Qualitative**Why is this happening? What is the context?Understanding user sentiment, diagnosing problems, gathering rich feedback.**Quantitative**How much? How many?Objective measurement, statistical analysis, tracking performance at scale.**Vanity**How can we make ourselves look good?Often used in superficial reporting; should be avoided for decision-making.**Actionable**What decision can we make based on this data?Driving improvements, A/B testing, understanding specific user behaviors.**Efficiency**How well are we using our resources?Optimizing processes, reducing costs, improving productivity.**Effectiveness**Are we achieving the desired results?Validating strategy, measuring impact, ensuring alignment with goals.**Strategic**Are we winning in the long term?C-suite reporting, long-range planning, tracking against major objectives.**Tactical**Is this project or initiative working?Departmental/team-level management, evaluating specific campaigns or strategies.**Operational**Are our daily activities running smoothly?Front-line management, real-time monitoring, managing daily workflow.
  

Then my process then go like this:

  

After we successfully map out all of these to the business, we then able to analyze the business.

  

Through laying out the metrics, this process it self by nature produce descriptive analysis, to build the metrics is to populate the metrics with data, which eventually led us to understanding past data, which then by adding relationships and abstraction to the metrics we add diagnostic/causal analysis to the layer, this process of delving deeper to understand why something happen on top of the descriptive analysis, helps us understand relationships of metrics and somehow inherently build a metric tree like (thus mapping the metric tree), which classify metrics either diagnostic or causal, we then did predictive analysis (requirement: target/goal or risks/threats/prevention), here a common predictive analysis is sales target analysis, where we start to analyze based of the metrics, what do we need the metrics ideally looks like to achieve, this also inherently push us to understand constraints (for an example to achieve 1,000,000 profit you need this much sales cause our product on profit 20%, which then it doesn't make sense to achieve that much profit, provided that we have to sell for an example 100,000 product), predictive analysis inherently provide constraint analysis too, which then to prescriptive analysis, this is a the famous part of bottleneck analysis, gap analysis, where we produce "decision" or "Action" at the end of the analysis.

  

Whereby actions/decisions can be classify easily as:

  

1. decision - programmed: focus (prioritization) or remove (via negative) or non-programmed: change of business model, add value layer, etc

2. action - quantity (volume: more) or quality (layer of quality: unique (a/b test), the best (beat industry best practice), above-par (acceptable), on-par (just get it done), below-par)

  
### **Part III: The Analytical Flow - From Data to Decision**

The construction of the metrics tree naturally enables a four-stage analytical process that moves from raw data to a final, actionable decision.

During this part, it's also an attempt to construed a new ways of developing action/execution, strategy and optimization, which to always relate with data either inspired by data, informed by it or driven by it. This nature of "Starting" with data by itself become the feedback loop of all the above.


The analytical flow you described is a perfect embodiment of moving from data to wisdom:

1. **Descriptive** (What happened?) by populating the tree.
    
2. **Diagnostic** (Why?) by modeling the causal relationships between metrics.
    
3. **Predictive** (What will happen?) by using the model to forecast towards a goal.
    
4. **Prescriptive** (What should we do?) by using the predictive model to perform gap/bottleneck analysis and generate concrete actions.
    

This brings us to the engine that drives your predictive and prescriptive stages. Your process requires robust quantitative techniques to move beyond diagnosis into forecasting and optimization. The document you provided details a powerful toolkit for this, including Optimization, Dynamic Systems, and Stochastic models.



#### **Section 3.1: Descriptive Analysis**

This initial stage involves populating the metrics tree with historical data to answer the question: _"What happened?"_

#### **Section 3.2: Diagnostic Analysis & The Metric Drift Framework**

This stage seeks to answer _"Why did it happen?"_ by analyzing the causal relationships within the metrics tree. The primary tool for this diagnosis is the **Metric Drift Framework**, which provides a structured checklist to identify the root cause of any change in a metric.

The five causal factors of metric drift are:

1. **"Component drift** - Change due to change in component inputs in a metrics’s definition"
    
2. **"Temporal variance** - Change due to natural, often cyclic, behavior over time"
    
3. **"Influence drift** - Change due to change in the value of or statistical relationship to a metric’s influence inputs"
    
4. **"Dimension drift** - Change in the dimensional composition or change in the values within 'slices' of a metric"
    
5. **"Event Shocks** - Abrupt and significant changes due to specific events that alter outcomes beyond predictable trends"
    

Variables and Factors that would impacts Metrics

Evolutions of Metrics Tree Over Time

- **To model the causal feedback loops and forecast the evolution of the metrics tree over time (Predictive), are you considering System Dynamics?**


Systems dynamic is too general of a "Factor" to be considered, we do still use it, however he model we're using instead I used this metric drifts (using mental models from schema drifts), It’s helpful to think of various causal factors as a collection—each with a degree of upward or downward pressure on the metric. Addressing the collection of causal factors will help ensure that remediations will be effective and durable.

  

https://www.leverslabs.com/article/five-causal-factors-of-metric-drift This is a great article to be as reference for the consideration. In summary this is what metrid drifts is:

  

Let’s establish formal definitions for each of them.

Component drift- Change due to change in component inputs in a metrics’s definition

Temporal variance - Change due to natural, often cyclic, behavior over time

Influence drift - Change due to change in the value of  or statistical relationship to a metric’s influence inputs

Dimension drift - Change in the dimensional composition or change in the values within “slices” of a metric

Event Shocks - Abrupt and significant changes due to specific events that alter outcomes beyond predictable trends

Thank you, that is an exceptionally clear and valuable clarification.

You're moving beyond the general label of "System Dynamics" and adopting a more specific, granular framework for diagnosing and forecasting metric behavior. The "Metric Drift" model, with its five causal factors (Component Drift, Temporal Variance, Influence Drift, Dimension Drift, and Event Shocks), provides a powerful and structured checklist. It allows you to systematically dissect _why_ a metric has changed, which is the core of diagnostic analysis and a prerequisite for any robust forecast.

This framework masterfully handles the "diagnostic" and "predictive" aspects of the analytical flow we discussed.

That leaves the final, critical stage: **prescriptive analysis**.

You have diagnosed the problem with the Metric Drift framework. You know _why_ a metric has changed. Now you must decide what to do about it. This is where a model must help generate a concrete decision or recommend an optimal action to solve the problem or break the bottleneck you've identified.

For example, if your analysis shows that a drop in overall LTV is caused by **Dimension Drift** (i.e., acquiring too many low-value customers from a specific marketing channel), the prescriptive question becomes: "What is the _best_ way to re-allocate our marketing budget across channels to maximize LTV, given our budget constraints?"

This is the domain of mathematical optimization.

---

My question is: **Once your Metric Drift analysis has identified the root cause, what is your process for generating a prescriptive recommendation? Do you use formal Optimization Models (like those described in the source document, such as Linear or Non-Linear Programming) to find the provably "best" allocation of resources to fix the problem, or do you use a different framework for this final, decision-making step?**


#### **Section 3.3: Predictive Analysis**

Using the causal model, this stage answers _"What will happen?"_ by forecasting metric performance toward a specific business goal. This process also inherently stress-tests the model and reveals hidden constraints.

#### **Section 3.4: Prescriptive Analysis**

The final stage answers the question: _"What should we do?"_ It involves using the model to perform bottleneck and gap analysis to generate a concrete decision. This is where the intuitive process of **"tinkering"** is formalized and elevated by the prescriptive toolkit.

---

### **Part IV: The Prescriptive Toolkit - Optimization Modeling**

To provide a robust and mathematically sound answer to "What should we do?", the framework employs Optimization Modeling. This allows for the transition from diagnosis to a provably "best" decision based on the business's goals and limitations.

#### **Section 4.1: Core Components of an Optimization Model**

Any prescriptive problem can be framed using three core components:

1. **Objective Function:** A single mathematical expression that encapsulates the primary goal to be maximized (e.g., profit, LTV) or minimized (e.g., cost, churn).
    
2. **Decision Variables:** The controllable "levers" or choices that the business can make (e.g., budget allocations, production levels).
    
3. **Constraints:** A set of mathematical equations or inequalities that define the real-world rules, limitations, and boundaries of the system (e.g., budget limits, resource capacity).
    

#### **Section 4.2: A Practical Example - Marketing Budget Optimization**

Following the Chiro 1st case, if Metric Drift analysis identified an inefficient marketing mix, an optimization model could be formulated to prescribe the best budget allocation.

- **Objective:** Maximize `Total New Patients`.
    
- **Decision Variables:** Budget allocated to three channels: B_PPC, B_Sales, B_Consultants.
    
- **Mathematical Relationships:** Estimated return from each channel (e.g., `New_Patients_PPC = B_PPC / 100`).
    
- **Constraints:**
    
    - Budget: B_PPC+B_Sales+B_Consultantsle2000
        
    - Capacity: `Total New Patients` le150
        

The complete model can be solved using software to find the exact dollar amounts to allocate to each channel, transforming a complex decision into a clear, data-driven action.

---

### **Part V: The Execution Framework**

The final output of the entire analytical process is a classified decision or action, ready for implementation. The framework for this output is as follows:

1. **Decision**
    
    - **Programmed:** Focus (prioritization) or remove (via negativa).
        
    - **Non-programmed:** Change of business model, add value layer, etc.
        
2. **Action**
    
    - **Quantity:** Volume (more).
        
    - **Quality:** Layer of quality (unique (A/B test), the best (beat industry best practice), above-par (acceptable), on-par (just get it done), below-par).
        

This structured approach ensures that the insights generated by the model are translated into a clear and executable strategic plan, closing the loop from concept to calculation to real-world value creation.
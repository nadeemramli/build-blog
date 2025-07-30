---
draft: true
title: "Challenge  - Cost Management"
date: "2025-07-27"
tags: 
---
https://developers.facebook.com/docs/permissions#a



Using Airbyte OSS with Developers Permission API for sources


I'm glad you loved the last response! That's the perfect follow-up question. Once you've embraced the ELT model, the next step is to master it so it runs as efficiently and cheaply as possible.

You are right to focus on the transformation step, as that's where you have the most control over your computation costs. There are several powerful strategies to ensure this step is lean and cost-effective.

Here's how you save on computation costs during transformation.

### 1. Incremental Models: The #1 Cost Saver 💰

This is the single most important technique. Instead of rebuilding your entire massive tables from scratch every single time, you only process the new or changed data.

- **The Default (Full Refresh):** Imagine you have a `fct_orders` table with 10 million rows. By default, `dbt` will drop this table and rebuild all 10 million rows every day. This is safe but can be slow and costly.
    
- **The Incremental Approach:** You configure your dbt model to be `incremental`. The first time it runs, it builds the full 10 million rows. But the _next_ day, it doesn't touch those old rows. Instead, it looks at the raw source data and asks, "Are there any new orders since the last time I ran?" If there are 5,000 new orders, it processes **only those 5,000 new rows** and appends them to the final table.
    
- **The Result:** Your daily computation time can drop from 30 minutes to 30 seconds. You are paying for seconds of compute time instead of minutes or hours. This is the standard practice for large event tables, order tables, and any data source that grows over time.
    

### 2. Efficient SQL and Model Design ✍️

Not all SQL is created equal. Writing efficient queries is a critical skill for keeping costs down.

- **Filter Early, Filter Often:** Perform your `WHERE` clauses as early as possible in your models, especially in the staging layer. This reduces the amount of data that needs to be carried in memory through subsequent joins and aggregations.
    
- **Avoid "SELECT *":** Only select the columns you actually need. Pulling unnecessary columns into memory, especially large text or JSON fields, increases RAM usage and slows down the process.
    
- **Common Table Expressions (CTEs):** Use `WITH` clauses to break down your logic. This not only makes your code more readable but can also help the query planner execute it more efficiently.
    

### 3. Right-Sizing Your Compute Resources 🖥️

Dagster+ gives you control over the resources allocated to your jobs. Over-provisioning is a common source of wasted money.

- **Start Small:** Configure your Dagster jobs to run on the smallest possible container size.
    
- **Monitor and Adjust:** Observe the resource usage (CPU/RAM) of your jobs in the Dagster UI. If a job consistently takes 10 minutes and only uses 20% of the allocated CPU, you are paying for resources you don't need. If it's slow or failing due to memory errors, you can increase the container size.
    
- **Use Different Resources for Different Jobs:** A simple staging model might only need a small container. A complex machine learning model that also runs in Dagster might require a much larger one. You can configure this on a per-job basis.
    

### 4. Smart Scheduling and Testing 🗓️

Finally, think about _when_ and _how often_ you run your jobs.

- **Challenge Your Schedules:** Does this dashboard _really_ need to be updated every hour? If the business only looks at it once a day, switch to a daily schedule. Running a pipeline 24 times a day instead of once will 24x your compute cost for that job.
    
- **Selective Testing in CI/CD:** In your GitHub Actions workflow, configure `dbt` to only test the models that you have actually changed in a pull request. You don't need to run and test the entire project for every small code change. This keeps your CI/CD pipeline fast and your testing costs low.
    

By implementing these strategies, you get the best of both worlds: the safety and flexibility of the ELT model, combined with the cost-efficiency of a well-optimized, lean data operation.


Related:
[[Solves - Data Insurance]]
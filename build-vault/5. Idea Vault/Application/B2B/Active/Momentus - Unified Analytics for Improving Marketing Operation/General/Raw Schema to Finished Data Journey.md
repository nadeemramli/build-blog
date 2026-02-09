---
draft: true
title: "Raw Schema to Finished Data Journey"
date: "2025-07-27"
tags: 
---
Of course. Let's walk through exactly how you achieve those powerful business outcomes starting from your raw data.

This entire process is the core purpose of **dbt (Data Build Tool)** in your stack.

---

### Clarifying Your dbt Schemas & Workflow

First, let's address your excellent questions about schemas. The standard and best-practice approach is to use three distinct schemas in your data warehouse (MotherDuck):

1. **`raw_data`**: This is the landing zone. Airbyte dumps the raw, untouched data from all your sources here. You **never** modify anything in this schema. It's your auditable source of truth.
    
2. **`staging`**: This is the first layer of transformation. You'll have one staging model for each raw table (e.g., `stg_shopify__orders`, `stg_posthog__events`). The only jobs here are to:
    
    - Rename columns to be consistent (e.g., `order_id` is always `order_id`).
        
    - Cast data types (e.g., change a date string to a `DATE` type).
        
    - Perform very light cleaning (e.g., handle null values).
        
3. **`marts`**: This is the final, business-ready layer. These are the clean tables your BI tool or LLM will connect to. **All the complex modeling like SCV, attribution, and product analysis happens here.** These models often join multiple staging models together to create powerful, unified views.
    

> **Where does identity stitching happen?** The stitching logic is developed in an intermediate `dbt` model that reads from your `staging` tables. The final, stitched tables (like your Single Customer View) are then saved into the **`marts`** schema.

---

### Walkthrough: From Raw Data to Business Objectives

Here’s the step-by-step modeling process using `dbt Core` to achieve your goals.

#### **Goal: Create a Single Customer View (SCV) & Enable User Journey Optimization**

This is about creating one unified profile for each customer and a chronological log of their every interaction.

1. **Identity Resolution (`marts` schema)**:
    
    - You'll build a dbt model called `int_customer_identity_map.sql` (an intermediate model).
        
    - **Logic**: This model's job is to find all the different IDs a single person might have (`email`, PostHog `person_id`, Shopify `customer_id`, anonymous cookies) and map them to one unique `master_customer_id`. It primarily uses the customer's **email address** as the key to stitch these identities together.
        
    - **Example**: It learns that `posthog_person_123` and `shopify_customer_ABC` are both `jane@example.com` and assigns them both the same `master_customer_id`.
        
2. **Unified Event Stream (`marts` schema)**:
    
    - You'll build a final mart table called `fct_customer_events.sql`.
        
    - **Logic**: This model unions together all user-level events from your staging tables (ad clicks, page views, add to carts, purchases). It joins with your identity map to stamp every single event with the correct `master_customer_id`.
        
    - **Outcome**: You now have a single, long table of every touchpoint, in chronological order, for every known customer. This is the foundation for analyzing the **User Journey**.
        
3. **Customer 360 View (`marts` schema)**:
    
    - You'll build a final mart table called `dim_customers.sql`.
        
    - **Logic**: This model has one row per unique customer (`master_customer_id`). It aggregates data from the event stream to calculate key metrics.
        
    - **Outcome**: A clean table with columns like `email`, `first_seen_date`, `first_touch_channel`, `lifetime_value`, `total_orders`, and `60_day_LTV`. This is your SCV and the basis for **Customer Analysis and Cohort Analysis**.
        

#### **Goal: Attribution Modelling & Unified Performance Reports**

This is about understanding marketing performance at an aggregated level.

1. **MMM Input Table (`marts` schema)**:
    
    - You'll build `fct_marketing_mix_daily.sql`.
        
    - **Logic**: This model aggregates data by day. It joins the total daily ad spend from `stg_meta_ads`, `stg_google_ads`, etc., with the total daily revenue from `stg_shopify__orders`.
        
    - **Outcome**: A single, wide table with one row per day and columns for revenue and spend/impressions from each channel. This is the exact input table you'll feed into both Google's **Meridian** and Meta's **Robyn** for comparison.
        
2. **Unified Performance Reports (`marts` schema)**:
    
    - You'll build `fct_ads_performance.sql`.
        
    - **Logic**: This model unions the daily performance data from all your ad platforms into one table with consistent column names like `date`, `channel`, `campaign_name`, `spend`, `impressions`, `clicks`.
        
    - **Outcome**: You can now build a single dashboard in your BI tool to compare marketing performance across all channels without needing to log into each platform.
        

#### **Goal: Operation Analytics (Creative & Product)**

This involves joining performance data with business context.

1. **Creative Analysis**: You'll join your new `fct_ads_performance` table with data from your ad staging tables that contains the `ad_creative_url`, `headline`, and `body_copy`. This allows you to group by creative elements to see what works best.
    
2. **Product Analysis**: You'll create an `fct_sales.sql` model in your `marts` schema by joining your `stg_shopify__orders` and `stg_woocommerce_orders` with your product dimension tables. This gives you SKU-level performance, which you can use to analyze merchandising and inventory strategies.
    

#### **Goal: Ensuring Reliability & Connecting to an LLM**

- **Reliability**: Your stack inherently ensures this. The code for all these dbt models lives in **GitHub**. **GitHub Actions** tests every change, and **Dagster+** ensures the models run in the correct order every time. This creates a stable, testable, and reliable data foundation.
    
- **LLM Exposure (MCP)**: Once your `marts` tables (`dim_customers`, `fct_sales`, etc.) are built and tested, they become a clean, stable "API layer" for your business data. You can give an LLM like ChatGPT or Claude access to query **only these mart tables**. Because the data is well-structured and the column names are clear, the LLM can accurately answer natural language questions, create instant reports, and perform the forecasting and gap analysis you described. The quality of your dbt models directly determines the quality of the LLM's answers.
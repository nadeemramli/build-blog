---
draft: true
title: "Understanding Data Schema"
date: "2025-07-25"
tags: 
---
Type of channel, acquisition metrics

engagement metrics


What motherduck can capture is what we can instrument

so what do we can instrument?

Acquisition wise is 

naming convention = settings = their results/data



# Important
differences from raw data
transformed (for consistency, needing schema here)
label -added


- Revenue
- Profit
- Cost of Delivery (COD) %
- Variable Cost
- COGS

- Sales vs. Target
- Spends vs. Target


- First Order Profitability
	- Waterfall Chart: Revenue - COD - CAC = FOP
- Contribution Margin (CM)
	- Net Revenue - Variable Costs
	- Variable Costs: Includes Payment Processor, Pick/Pack, Fulfillment, COGS, Ad Spend, Return Rate
	- Daily Target and Tracking
	- Primary Goal (Overrides MER, Sales)
- CAC
	- Ad Spend / Total Customer Orders
	- Weighted CAC
- nCAC
	- Ad Spend / New Customer Orders
- LTV-to-CAC Ratio
	- Rarely warrants sacrificing FOP
	- High LTV needed
	- Risks: Cohort Degradation, CAC Degradation, Cost of Capital
- Marketing Efficiency Ratio (MER)
	- Total Sales / Total Ad Spend
	- Blended ROAS / Average Cost of Sales (ACOS)
	- Measures Total Marketing Efficiency
- Acquisition Marketing Efficiency Ratio (aMER)
	- New Customer Revenue / Ad Spend
	- Efficiency of New Customer Acquisition Spending
- AOV
	- Important Daily Metrics
	- Relates to Conversion Rate
	- Modal Order Value (Most Common Order)
- MER-to-R-CAC
	- Check Whatsapp
- First Order Value to New Customer Acquisition Cost (FOV:nCAC) Ratio
	- This ratio compares the value of the first purchase made by a new customer to the cost of acquiring that customer, indicating the effectiveness of customer acquisition strategies.
- Revenue Peaks:
	- This metric identifies months where revenue significantly exceeds the average, highlighting periods of strong performance and potential seasonal trends
- 1-Year LTV:nCAC:
	- This ratio compares the long-term customer value (1-year LTV) to the cost of acquiring that customer, providing a comprehensive view of customer acquisition and retention profitability.
- 60-Day LTV % and 1-Year LTV %:
	- These metrics measure the increase in customer value over different time periods, helping to understand the long-term profitability of customers.

1. ##### 60-Day LTV %
    
    The average % increase in customer value **60 days** after first purchase.

2. ##### 1-Year LTV %
    
    The average % increase in customer value **365 days** after first purchase.

3. ##### FOV:nCAC
    
    The ratio of first-order value to new-customer acquisition costs.

4. ##### 1-Year LTV:nCAC
    
    The ratio of 1-year customer value to new-customer acquisition costs.



- Visitor
- Distribution Channels:
	- This metric tracks the number of revenue sources a brand has, indicating diversification and potential for growth.
- Organic Traffic %:
	- This metric measures the percentage of website traffic coming from organic (unpaid) search results, reflecting the effectiveness of SEO efforts.

- Bounce Rate
- New User
- Returning User Website
- Organic
-  Traffic Mix
- Repeat Rate

- Conversion Rate
- Lifetime Value (LTV)
	- Total Value from Customer (Over Lifetime)
	- Distinction: Value (New) vs. Revenue
	- Contextualize: 60-day, 1-year LTV
	- Cash Multiplier (60-day window)
	- Rule of 30/100 (30% in 60 days, 100% in 1 year)
- Return and Discounts
	- Silent Killers of Profitability
	- Impact Gross Margin
	- Redo (Free Returns Solution)
- Active Customer File
	- Customers purchasing within normal range
	- Predictor of Future Existing Customer Revenue
	- Continuously Adding New Customers is Key
- Cash Conversion Cycles (CCC)
	- Days to Float Inventory Costs
	- Negative CCC: Pay with Sale Proceeds
	- Impacted by Supplier Terms
- First Order Value (FOV) to New CAC
	- Ratio: Average FOV / Average New CAC
	- Break-even on Day 1
	- Clear Signal of Media Buying Efficiency 
- Incremental Marginal Return (IMR)
	- Revenue x Incrementality Factor - COD - Spend / Spend
	- Version of CM with Incrementality
	- Channel Specifics (Meta, Google Non-Brand, Google Branded)
- Operating Expenses (OPEX) %
	- Non-variable Expenses
	- Should be <25% of Revenue
	- Payroll 8-12% of Revenue



Peaks


Goal:
1. Quantity first, more unit of outputs/actions, volumes
2. Diversity
3. Quality


Channel Specifics Metrics

- Acquisition
	- Spending
	- AOV
	- CPM
	- ROAS

- **Facebook/Google:** Metrics like Average Order Value (AOV), Cost Per Mille (CPM), Cost Per Acquisition (CPA), Cost Per Click (CPC), Click-Through Rate (CTR), Conversion Rate (CVR), Revenue, Spend, and Return on Ad Spend (ROAS).
- **Klaviyo:** Metrics like Click-Through Rate (CTR), Conversion Rate (CVR), and Revenue.


###### Metrics Include:

1. Store
    1. Revenue
    2. Spend
    3. MER
    4. aMER
    5. CAC
    6. AOV
2. Facebook / Google
    1. AOV
    2. CPM
    3. CPA
    4. CPC
    5. CTR
    6. CVR
    7. Revenue
    8. Spend
    9. ROAS
3. Klaviyo
    1. CTR
    2. CVR
    3. Revenue


-----



Daily, Weekly Report
1. Total 
- Contribution Margin
- Revenue
- Ad Spend
- MER
- AOV
- Orders



- Daily Management:
	- Plot, Pivot, Profit (P3)
	- Identify Importantly Wrong Quickly 
	- Course Correct (Daily Adjustments)
	- Solve Hundred Dollar Problems (Not Million)

- Growth Strategist Role:
	- Conductor of Revenue
	- Monitor 35+ Metrics Daily
	- Diagnoses Gaps (Volume vs. Efficiency)
- Ad Account Optimization:
	- Increase Volume (Open Cost Caps for High ROAS)
	- Tighten Efficiency (Reduce Cost Caps for Low ROAS)
	- Launch New Campaigns (Not Duplicates)
	- Ensure Creative Volume
- Conversion Rate Optimization
- Inventory Management:
	- Maximize Marginal Value of Every Unit
	- Inventory Health Categories (A,B,C,D based on Days Remaining)
	- Liquidation Strategy (for D-level inventory)
	- Dynamic Pricing (based on inventory value/sales velocity)
- Communication and Alignment:
	- Finance to Marketing Dashboard (CM front and center)
	- Marketing Metrics into Finance Dashboard (P&L Bottom)
	- Goal and Incentives Aligned to Shareholder Value
	- Transparency (P&L, Data Room)




-----


1. Financial Goal (Increase Enterprise Value, Make Profit So Members Rich, Create Sustainable Business to employ great people)
	1. To achieve above you need a predictable and profitable growth. You can only understand this if your have a Forecast.
		1. 

Course Correct on daily basis

Exercise in Execution
Day by day, dollar by dollar
- Operating Infrastructure
	- Optimal internal components
	- Aggressive external components

Market Share - Bets
Profit (improve ergodicity) - Survive




The approach

Figure out the abstraction of optimization
end goal - achieve financial goal
what's that?
then what's that of that?


then layout all the metrics then ask the system, 

from all these sources we ingested can we get the data that would help us get answer to all of these?


Duckweed Brands (Fastest Growing)
1. Fantastic Gross Margin (>70%)
2. Lean OPEX (<15% Revenue)
3. Beneficial Supplier Terms
4. First Order Profitability
5. High Lifetime Value (LTV)
6. Large Organic Demand (>50% Traffic)
7. Revenue Peaks (Four Peaks Theory)
8. Product Differentiation



To Optimize Operation
- Remember 4 quadrant of accounting

----
Without a **centralized, structured, and deduplicated dataset**, marketers are left with fragmented insights, unreliable reporting, and incomplete visibility into performance.

Centralized (done)
Structured (figuring out)
Deduplicated (figuring out)

### Centralized & Standardized Data

- Aggregate **performance, spend, and conversion data** across all marketing channels.
- Ensure **cross-platform consistency** by structuring data into a **single, comprehensive dataset**.
- Free up engineering resources by eliminating the need for **custom data pipelines and manual data reconciliation.**

### A Privacy-First, First-Party Data Strategy

- Capture **granular marketing and conversion data** in a way that is **compliant with evolving privacy regulations**.
- Move beyond third-party cookies and in-platform reporting to build **a reliable, first-party dataset**.
- Strengthen attribution models and measurement methodologies with **clean, user-level insights.**

### Seamless Integration & Data Accessibility

- **Export structured marketing data** directly into data warehouses, BI tools, and analytics platforms.
- Enable easy access through **Google Sheets, scheduled exports, and automated workflows**.
- Unlock deeper insights by **combining marketing performance data with business and financial datasets.**

### A Single, Unified Marketing Dataset

Rockerbox brings together data from across the marketing ecosystem, consolidating:

- **Spend & Performance Metrics** – Impressions, clicks, CPMs, CPA, ROAS, and conversions.
- **Cross-Channel Attribution Data** – Insights into marketing influence at every touchpoint.
- **First-Party, Privacy-Compliant Customer Insights** – User-level engagement data without reliance on third-party cookies.
- **Custom Business Data Inputs** – Promotional periods, competitive landscape, external market factors.


### Why Use MTA?

Rockerbox’s MTA is the core methodology used on top of our Data Foundation to empower our customers to begin to see the full impact of their marketing performance. Rockerbox MTA  goes beyond just tracking conversions—it centralizes user-level and conversion-level data, giving marketers a deep understanding of how each channel, campaign, and touchpoint influences performance. From Multi-Touch Attribution (MTA) to credit distribution reporting, Rockerbox provides key insights that enhance data-driven decision-making.
### MTA: Key Insights

- **New vs. Repeat Customer Insights:** Understand the behaviors of new customers versus loyal repeat buyers.
- **Customizable Attribution Models:** Tailor how credit is distributed across touchpoints based on your business needs.
- **Conversion Funnel Analysis:** Visualize and analyze the full conversion path to identify optimization opportunities.
- **Channel Overlap Insights:** See how different channels work together to influence customer decisions.
- **Visitor Reporting:** Gain detailed insights into new visitors and how they interact with your brand across channels.


### Why Use MMM? 

While Multi-Touch Attribution (MTA) provides valuable, real-time insights into the customer journey, it’s only one piece of the puzzle. The most effective marketing measurement strategies combine multiple approaches to get a complete view of performance. **Marketing Mix Modeling (MMM)** complements MTA by offering a broader perspective, helping you understand the impact of external factors—like seasonality, promotions, and economic shifts—on your overall marketing efforts.

MMM shines when it comes to hard-to-track channels and strategic budget planning. It leverages your historical data to paint a full picture of how various channels and external drivers influence your business outcomes, ensuring you allocate your marketing budget where it will have the most impact. This model empowers marketers to make data-driven decisions that optimize both immediate and long-term marketing effectiveness.
### MMM: Key Features

- Unlock a UI that guides you through making gradual changes to your marketing spend in order to optimize your strategy for the highest returns.
- Explore the efficiency of all your marketing channels through insights into overall spend investments alongside revenue contributions.
- Leverage your own historical data to understand the relationship between your marketing investments (including ad spend and non-spend factors) and bottom-line numbers like revenue and conversions and make predictions going forward.


## Incrementality Testing

Knowing which of your marketing efforts is truly driving incremental growth is essential. With Incrementality Testing, you can go beyond correlation and establish the direct, causal impact of your campaigns. By isolating variables and using control groups, Rockerbox helps you measure the incremental lift generated by each marketing channel or tactic, giving you a clear understanding of which efforts are worth scaling.

### Why Use Testing? 

While MTA and MMM provide valuable insights, neither can definitively prove causality on their own. Testing is the key to understanding the true impact of your marketing by determining how much additional value a specific campaign or channel drives beyond what would have happened without it.

### Testing: Key Features

- **Causal Insights:** Identify which channels and campaigns are truly driving incremental conversions, not just correlations.
- **Optimized Marketing Investments:** Focus your budget on high-impact activities with clear evidence of their contribution to performance.
- **Control Group Analysis:** Compare results between test and control groups to remove the noise of external factors and gain precise measurement.
- **Strategic Validation:** Validate other measurement models (like MTA and MMM) by cross-referencing them with test results for more accurate insights.

## What Can You Discover  
With Rockerbox?

### Impact of views

- Display
- Facebook
- Pinterest
- TikTok

### Marketing path insights

- Full path to purchase
- Highest value
- Fastest to convert

### High-level metrics

- ROAS
- CPA
- Revenue

### Datasets you need

- Advertising performance across your channels
- First-party user-level dataset
- Marketing data in your data warehouse for further analysis

### How to take action

- Granular spend recommendations by channel
- Budget adjustments across your strategy

### Key marketing insights

- Correlation between spend and revenue
- Marketing channel overlap
- New vs returning customer activities

### Hard-to-track channels

- Podcast advertising
- Influencers
- Direct mail
- Linear TV
- And more!


---
#### Built for DTC ECommerce

There’s a simple formula for ecommerce success:

![](https://statlas.io/assets/img/ui/ecommerce-formula.svg)

Unfortunately, the **most crucial metrics** related to these variables **can’t be** tracked by any native ecommerce dashboards … not Shopify, not Facebook, not Google Analytics.

**Until now.**

Statlas unites all your business data across platforms.

Even better, it gives you actionable benchmarks to track growth against similar businesses.

## Visitors

**Understand your traffic** intimately and effortlessly, from channel mix to Facebook efficiency.

**Improve creative performance** by examining your best and worst ads through the lens of AIDA: attention, interest, desire, and action.

Plus, see how your traffic sources **compare to other businesses.**

### Visitors

#### Drive more and higher-quality traffic to your ecommerce site to scale spend profitably.

- **Full-funnel advertising** across PPC and paid social channels, set at the SKU, price point, or offer level to win from the first purchase
- **High-converting creative** rooted in analytics that propels shoppers forward, metric-by-metric
- **Better prospecting margins** by combining intent, post-purchase behavior, and COGS
- **Intelligent email marketing campaigns** that separate customers, visitors, browsers, and cart abandons
- **Influencer marketing** to expand your reach, create hyper-targeted audiences, and content production powerhouses


## Conversion Rate

Site-wide conversions tell you nothing about how your individual channels are performing.

Instead, break down your pages — products, collections, and landers — **by site speed, conversion rate, and real dollars.**

### Conversion Rate

#### Sell more, more often … and increase margin by merchandising your ad account.

- **Ad account merchandising** puts your most-profitable SKUs front and center because onsite CRO only get you so far
- **On-brand ad assets** combined with message mapping brings a cohesive user experience to your ecommerce store
- **Speed and mobile** **optimization** benchmarking across all major platforms including Shopify, Magento and BigCommerce
- **Pricing strategies** and offers to captivate shoppers, lift AOV, and fuel seasonal + evergreen growth

## Lifetime Value

**Get cohort-specific data** organized by time period, seasonality, first-product purchase, discount code, campaigns, channels, and more.

**Unlock your LTV:CAC ratio** through endless variables and elegant simplicity.
### LTV: Cash Multiplier

#### Accelerate your 60-, 90-, or 120-day LTV to fit your cash flow and build your business.

- **Drive lifetime value** by front-loading new customer acquisition with your best first-purchase products
- **Post-purchase funnels** to guide shoppers naturally through upsells, cross-sells, bundles, and gifting
- **Personalize email marketing** and SMS automation to maximize revenue while influencing customer journeys
- **Loyalty, membership, or subscription** programs that compound monthly recurring revenue and deepen your relationships
- **Co-marketing partnerships** around shared audiences for causes, giveaways, and collaborations

## Variable Costs

**Easily determine your business’ profitability.** Use your own method or our four-quarter accounting: (1) cost of delivery, (2) customer acquisition, (3) operational expenses, and (4) profit.

Best of all, **gauge yourself against comparable brands** on everything from fixed costs — like rent — to COGS.
### Variable Costs

#### The least-understood, least-sexy … most-critical element of profitable growth.

If costs increase as orders rise, that’s a variable cost. As opposed to fixed costs — like rent and operational overhead — VCs cover COGS, platform and payment processors, pick-and-pack, fulfillment, and CAC: total spend including agency fees.

The real question is two-fold:

1. **How do you measure and optimize variable costs?**
2. **I thought you did social media marketing. Why would you want to get so intimately involved?**

For the first, we follow a four-quarter accounting matrix. Each represents a portion of your revenue that signals the health of that component as well as areas of opportunity for growth.

###### What about the second question?

Put simply, we got our start as entrepreneurs, growing our own brands from the ground up. We know what it takes to succeed: a deep understanding of the numbers.

The numbers — the real financial position of your business — help us answer questions as varied and specific as:

- Should we expand into Amazon?
- Is search engine optimization really our issue, or should we push into paid search?
- Is our content marketing strategy aligned with our retention goals?
- Is ad spend aligned with inventory constraints?
- Is that upsell-cross sell Shopify app a waste of money?

## Revenue & Profit

**Track critical metrics** like Marketing Efficiency Rating (MER) — total sales divided by total ad spend — to truly measure success.

**Identify your most-profitable channels and campaigns ...** as well as exactly where you need to improve.
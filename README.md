CRM Sales Performance & Strategy Analysis (2017)
📊 Project Overview
This project focuses on analyzing a B2B sales pipeline to uncover regional performance trends, product penetration, and revenue growth. By leveraging advanced SQL techniques, I transformed raw CRM data into actionable insights regarding sales velocity, agent productivity, and market segmentation.

The primary objective was to answer critical business questions:
1. Which regions and agents are driving the highest revenue?
2. How quickly do deals move through our pipeline?
3. What is our Year-to-Date (YTD) and Month-over-Month (MoM) revenue trajectory?
4. Which products dominate the Medical and Technology sectors?

🛠️ Technical Skills Demonstrated
1. Data Aggregation & Views: Creating reusable VIEW objects for modular reporting.
2. Window Functions: Using DENSE_RANK(), SUM() OVER(), and LAG() for cumulative totals, rankings, and growth trends.
3. Common Table Expressions (CTEs): Structuring complex, multi-step calculations for readability.
4.Conditional Logic: Utilizing CASE WHEN, COALESCE, and NULLIF for data cleaning and bucketing.
5.Join Operations: Implementing INNER and LEFT JOIN to combine sales, account, and product data.
6. Pattern Matching: Using LIKE with wildcards and LOWER() for robust, case-insensitive sector analysis.

📈 Key Analyses & Insights
1. Revenue Dynamics (YTD & MoM)
- Daily Running Total: A time-series analysis showing cumulative revenue growth throughout 2017. Used unique tie-breakers to ensure accurate row-by-row accumulation.
- Month-over-Month (MoM) Growth: Calculated percentage changes in revenue to identify seasonal peaks and performance dips.

2. Regional & Agent Performance
- Top 3 Agents per Region: Used DENSE_RANK() partitioned by region to identify the highest-performing staff in each regional office.
- Regional Sales View: Consolidated opportunity data with sales team locations to visualize geographical revenue distribution.

3. Sales Velocity & Market Sentiment
- Deal Velocity Buckets: Classified deals into Fast (<30 days), Medium, and Slow (>90 days) based on the duration from engagement to closing.
-Sector Deep-Dive: Analyzed the "Medical" and "Technology" sectors to identify the top 3 products by deal volume within each industry.

4. Financial Health & Hierarchy
- Price Analysis: Identified high-margin deals where the closing value significantly exceeded the standard sales price.
- Account Hierarchy: Cleaned parent-subsidiary data using COALESCE to distinguish between corporate subsidiaries and independent accounts.

How to Use
1. Database & tables Setup: Import the sales_pipeline, accounts, products, and sales_teams tables.
2. View Creation: Run the "Regional Sales" and "Deal Velocity" scripts to generate reporting views.
3. Analysis: Execute the CTE-based queries to generate performance reports for stakeholders.

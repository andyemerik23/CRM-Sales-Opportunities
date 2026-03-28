# CRM Sales Performance & Strategy Analysis (2017)

![SQL](https://img.shields.io/badge/SQL-Advanced-blue)
![Project Type](https://img.shields.io/badge/Project-Data%20Analysis-green)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

---

## Project Overview
<p align ="justify">
This project focuses on analyzing a B2B sales pipeline to uncover regional performance trends, product penetration, and revenue growth. By leveraging advanced SQL techniques, I transformed raw CRM data into actionable insights regarding sales velocity, agent productivity, and market segmentation.
</p>

<p align ="justify">
The primary objective was to answer critical business questions:

- Which regions and agents are driving the highest revenue?
- How quickly do deals move through our pipeline?
- What is our Year-to-Date (YTD) and Month-over-Month (MoM) revenue trajectory?
- Which products dominate the Medical and Technology sectors?
</p>
---

## Technical Skills Demonstrated
- Data Aggregation & Views: Creating reusable VIEW objects for modular reporting.
- Window Functions: Using DENSE_RANK(), SUM() OVER(), and LAG() for cumulative totals, rankings, and growth trends.
- Common Table Expressions (CTEs): Structuring complex, multi-step calculations for readability.
- Conditional Logic: Utilizing CASE WHEN, COALESCE, and NULLIF for data cleaning and bucketing.
- Join Operations: Implementing INNER and LEFT JOIN to combine sales, account, and product data.
- Pattern Matching: Using LIKE with wildcards and LOWER() for robust, case-insensitive sector analysis.
---

## Key Analyses & Insights

### Revenue Dynamics (YTD & MoM)
- Daily Running Total: A time-series analysis showing cumulative revenue growth throughout 2017. Used unique tie-breakers to ensure accurate row-by-row accumulation.
- Month-over-Month (MoM) Growth: Calculated percentage changes in revenue to identify seasonal peaks and performance dips.

### Regional & Agent Performance
- Top 3 Agents per Region: Used DENSE_RANK() partitioned by region to identify the highest-performing staff in each regional office.
- Regional Sales View: Consolidated opportunity data with sales team locations to visualize geographical revenue distribution.

### Sales Velocity & Market Sentiment
- Deal Velocity Buckets: Classified deals into Fast (<30 days), Medium, and Slow (>90 days) based on the duration from engagement to closing.
- Sector Deep-Dive: Analyzed the "Medical" and "Technology" sectors to identify the top 3 products by deal volume within each industry.

### Financial Health & Hierarchy
- Price Analysis: Identified high-margin deals where the closing value significantly exceeded the standard sales price.
- Account Hierarchy: Cleaned parent-subsidiary data using COALESCE to distinguish between corporate subsidiaries and independent accounts.
---

## How to Use

- Database & tables Setup: Import the sales_pipeline, accounts, products, and sales_teams tables.
- View Creation: Run the "Regional Sales" and "Deal Velocity" scripts to generate reporting views.
- Analysis: Execute the CTE-based queries to generate performance reports for stakeholders.

---

## Project Structure
```text
├── Analysis.sql      # Main SQL queries for analysis and insights
├── README.md         # Project documentation
└── table_setup       # Database schema and table creation
```

## Notes
This project is designed for analytical exploration and business intelligence reporting. It can be extended with visualization tools such as Power BI or Tableau.

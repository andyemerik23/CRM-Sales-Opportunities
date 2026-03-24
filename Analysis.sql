-- reqional sales--
CREATE OR REPLACE VIEW `temp_regional_sales` AS 
select 	
	`sp`.`opportunity_id` AS `opportunity_id`,
	`sp`.`close_value` AS `close_value`,
    `sp`.`deal_stage` AS `deal_stage`,
	`st`.`regional_office` AS `regional_office`,
	`st`.`sales_agent` AS `sales_agent` 
from `sales_pipeline` `sp` 
join `sales_teams` `st` 
	on `sp`.`sales_agent` = `st`.`sales_agent` 
where `sp`.`deal_stage` = 'Won';

SELECT * FROM temp_regional_sales;

-- close value per sector --

CREATE OR REPLACE VIEW close_value_per_sector AS
SELECT 
	acc.sector,
    AVG(sp.close_value) AS avg_close_value,
    COUNT(sp.opportunity_id) AS total_deal
FROM accounts acc
INNER JOIN sales_pipeline sp
ON sp.account=acc.account
WHERE sp.deal_stage="Won"
GROUP BY acc.sector
HAVING COUNT(sp.opportunity_id)>50
ORDER BY avg_close_value DESC;

select * from close_value_per_sector;

-- Deal Velocity Buckets --
CREATE OR REPLACE VIEW Deal_Velocity_Buckets AS
SELECT 
	CASE
		WHEN datediff(sp.close_date,sp.engage_date) < 30 THEN "Fast"
		WHEN datediff(sp.close_date,sp.engage_date) BETWEEN 30 AND 90 THEN "Medium"
		WHEN datediff(sp.close_date,sp.engage_date) > 90 THEN "Slow"
    END AS deal_velocity,
    COUNT(*) AS Won_deal_count
FROM sales_pipeline sp
WHERE deal_stage="Won"
GROUP BY 1;

select * from deal_velocity_buckets;


-- Under price analysis
WITH Price_comparison AS (
SELECT 
	sp.opportunity_id,
    p.product,
    sp.close_value,
    p.sales_price AS sales_price,
    (sp.close_value-p.sales_price) AS earned_profit,
    ROUND(((sp.close_value-p.sales_price)/SUM(CASE WHEN (sp.close_value-p.sales_price) > 0 THEN (sp.close_value-p.sales_price) ELSE 0 END) 
    OVER())*100,3) AS Percentage_of_profit
FROM sales_pipeline sp
JOIN products p
	ON sp.product=p.product
WHERE sp.deal_stage ="Won"
) 

SELECT * FROM Price_comparison
WHERE earned_profit>0 AND percentage_of_profit > 0.3
ORDER BY earned_profit DESC;

-- Top sales agent by region
WITH Sales_performance AS(
	SELECT 
		st.sales_agent,
		st.regional_office as region,
		SUM(sp.close_value) AS total_sales
	FROM sales_pipeline sp 
	JOIN Sales_teams st 
	ON sp.sales_agent=st.sales_agent
	WHERE sp.deal_stage="Won"
    GROUP BY st.sales_agent, st.regional_office
), 
Regional_Rankings AS (
	SELECT 
		sales_agent,
		region,
		total_sales,
		DENSE_RANK () OVER (PARTITION BY region ORDER BY total_sales DESC) AS inregion_rank
	FROM Sales_performance
)

SELECT * FROM Regional_Rankings
Where inregion_rank <= 3
ORDER BY region DESC;

-- Running Revenue total
WITH daily_sales AS (
SELECT 
	close_date,
    close_value,
    opportunity_id
FROM sales_pipeline
WHERE year(close_date) = 2017 AND deal_stage="Won"
)

SELECT 
close_date,
close_value,
sum(close_value) OVER (ORDER BY close_date, opportunity_id) AS ytd_cumulative
FROM daily_sales
ORder BY close_date;

WITh MonthlySums AS (
SELECT 
	MONTH (close_date) AS Month_order,
    sum(close_value) AS total_revenue
FROM sales_pipeline
WHERE YEAR(close_date)= 2017 AND deal_stage = 'Won'
GROUP BY month (close_date)
)

SELECT 
	Month_order,
    total_revenue,
    SUM(total_revenue) OVER (ORDER BY month_order) AS ytd_running_total
FROM MonthlySums;

-- MoM Growth
WITH mom_growth AS (
SELECT  
	month (close_date) AS month_date,
    sum(close_value) AS total_revenue
FROM sales_pipeline
WHERE deal_stage="Won" and year(close_date)= 2017
group by month(close_date)
)

select 
	month_date,
    total_revenue,
    lag(total_revenue) OVER (Order By month_date) AS previous_month,
    total_revenue-lag(total_revenue) OVER (Order By month_date) AS revenue_diff,
    ROUND((total_revenue-lag(total_revenue) OVER (Order By month_date))/(lag(total_revenue) OVER (Order By month_date))*100,2) AS "% growth"
from mom_growth;

-- Parent-Subsidiary Hierarchy
SELECT 
	sp.sales_agent,
    acc.account,
    acc.subsidiary_of,
    Coalesce(NULLIF(acc.subsidiary_of,''), "Independent") as parent_company
FROM accounts acc
LEFT JOIN sales_pipeline sp
ON acc.account=sp.account
Order BY parent_company;

-- TOP Product penetration by sector
WITH SectorProductCount AS (
SELECT
	acc.sector,
    sp.product,
    COUNT(*) AS deal_count
FROM sales_pipeline sp
JOIN accounts acc ON sp.account=acc.account
WHERE sp.deal_stage = 'Won' 
  -- Using LOWER() ensures it catches 'technology', 'Technology', or 'TECHNOLOGY'
  AND (LOWER(acc.sector) LIKE '%medic%'
  OR LOWER(acc.sector) LIKE '%tech%')
GROUP BY acc.sector, sp.product
),
SectorCalculation AS (
SELECT 
	sector,
    product,
    deal_count,
    dense_rank() OVER(PARTITION BY sector ORDER BY deal_count DESC) AS product_rank
FROM SectorProductCount
)

SELECT * FROM SectorCalculation
WHERE product_rank<=3
ORDER BY sector, product_rank;
    
    


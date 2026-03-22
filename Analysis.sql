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
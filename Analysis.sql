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
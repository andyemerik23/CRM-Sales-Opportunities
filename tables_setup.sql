-- Create and use the database
CREATE DATABASE IF NOT EXISTS CRM_Sales_Opportunities;
USE CRM_Sales_Opportunities;

-- -----------------------------------------------------
-- Table: accounts
-- -----------------------------------------------------
DROP TABLE IF EXISTS accounts;
CREATE TABLE `accounts` (
   `account` varchar(255) NOT NULL,
   `sector` text,
   `year_established` int DEFAULT NULL,
   `revenue` double DEFAULT NULL,
   `employees` int DEFAULT NULL,
   `office_location` text,
   `subsidiary_of` text,
   PRIMARY KEY (`account`)
 );


-- -----------------------------------------------------
-- Table: products
-- -----------------------------------------------------
DROP TABLE IF EXISTS products;
CREATE TABLE `products` (
   `product` varchar(255) NOT NULL,
   `series` text,
   `sales_price` int DEFAULT NULL,
   PRIMARY KEY (`product`)
 );

-- -----------------------------------------------------
-- Table: sales_teams
-- -----------------------------------------------------
DROP TABLE IF EXISTS sales_teams;
CREATE TABLE `sales_teams` (
   `sales_agent` varchar(255) NOT NULL,
   `manager` text,
   `regional_office` text,
   PRIMARY KEY (`sales_agent`)
 );


-- -----------------------------------------------------
-- Table: sales_pipeline
-- -----------------------------------------------------
DROP TABLE IF EXISTS sales_pipeline;
CREATE TABLE `sales_pipeline` (
   `opportunity_id` varchar(255) NOT NULL,
   `sales_agent` varchar(255) NOT NULL,
   `product` varchar(255) NOT NULL,
   `account` varchar(255) NOT NULL,
   `deal_stage` text,
   `engage_date` date DEFAULT NULL,
   `close_date` date DEFAULT NULL,
   `close_value` int DEFAULT NULL,
   PRIMARY KEY (`opportunity_id`),
   KEY `fk_pipeline_accounts` (`account`),
   KEY `fk_pipeline_salesagent` (`sales_agent`),
   KEY `fk_pipeline_product` (`product`),
   CONSTRAINT `fk_pipeline_accounts` FOREIGN KEY (`account`) REFERENCES `accounts` (`account`),
   CONSTRAINT `fk_pipeline_product` FOREIGN KEY (`product`) REFERENCES `products` (`product`),
   CONSTRAINT `fk_pipeline_salesagent` FOREIGN KEY (`sales_agent`) REFERENCES `sales_teams` (`sales_agent`)
 );

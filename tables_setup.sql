-- Create and use the database
CREATE DATABASE IF NOT EXISTS CRM_Sales_Opportunities;
USE CRM_Sales_Opportunities;

-- -----------------------------------------------------
-- Table: accounts
-- -----------------------------------------------------
DROP TABLE IF EXISTS accounts;
CREATE TABLE `accounts` (
   `account` text,
   `sector` text,
   `year_established` int DEFAULT NULL,
   `revenue` double DEFAULT NULL,
   `employees` int DEFAULT NULL,
   `office_location` text,
   `subsidiary_of` text
 );

-- -----------------------------------------------------
-- Table: products
-- -----------------------------------------------------
DROP TABLE IF EXISTS products;
CREATE TABLE `products` (
   `product` text,
   `series` text,
   `sales_price` int DEFAULT NULL
 );

-- -----------------------------------------------------
-- Table: sales_pipeline
-- -----------------------------------------------------
DROP TABLE IF EXISTS sales_pipeline;
CREATE TABLE `sales_pipeline` (
   `opportunity_id` text,
   `sales_agent` text,
   `product` text,
   `account` text,
   `deal_stage` text,
   `engage_date` date DEFAULT NULL,
   `close_date` date DEFAULT NULL,
   `close_value` int DEFAULT NULL
 );
-- -----------------------------------------------------
-- Table: sales_teams
-- -----------------------------------------------------
DROP TABLE IF EXISTS sales_teams;
CREATE TABLE `sales_teams` (
   `sales_agent` text,
   `manager` text,
   `regional_office` text
 );
/*
======================================================================================================================
The target database is represented in the gold layer views of the Medallion architecture of the data warehouse
that I created in the project "Data Warehouse SQL Project - Unlocking Data-Driven Insights",
which is the final business-ready data for consumption:

Project Name: Data Warehouse SQL Project - Unlocking Data-Driven Insights.   
GitHub Link: https://github.com/Geoshy/Data_Warehouse_SQL_Project

So, in the exploratory data analysis (EDA) project of the (DataWarehouse) data warehouse
I will query the gold layer views to explore and analyze the data:
======================================================================================================================
*/

USE DataWarehouse;
GO

-- Explore All Object in the Database (DataWarehouse):
SELECT * FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'gold';

-- Explore All Columns in the Database (DataWarehouse):
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'gold';

-- Explore All Columns in the Database (DataWarehouse) of Table (dim_products):
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_SCHEMA = 'gold'
    AND
    TABLE_NAME = 'dim_products'; -- 11 Columns

-- Explore All Columns in the Database (DataWarehouse) of Table (dim_customers):
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_SCHEMA = 'gold'
    AND
    TABLE_NAME = 'dim_customers'; -- 10 Columns

-- Explore All Columns in the Database (DataWarehouse) of Table (fact_sales_details):
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_SCHEMA = 'gold'
    AND
    TABLE_NAME = 'dim_products'; -- 11 Columns

/*
======================================================================================================================
Date Exploration:
    - Indentify the earliest and the latest dates (date boundaries).
    - Which help to understand the scope of the data and timespan, for the target time analysis.
======================================================================================================================
*/

USE DataWarehouse;
GO

-- Explore the date of the first and last order:
-- Explore how many years of sales available in the database:
SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    DATEDIFF(YEAR, MIN(order_date), MAX(order_date)) AS order_range_years,
    DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_range_months
FROM  
    gold.fact_sales_details;

-- Explore the youngest and the oldest customer with their ages:
SELECT
    MIN(birthdate) AS oldest_birthdate,
    DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS age_of_oldest_customer,
    MAX(birthdate) AS youngest_birthdate,
    DATEDIFF(YEAR, MAX(birthdate), GETDATE()) AS age_of_youngest_customer
FROM
    gold.dim_customers;

SELECT
    customer_key,
    customer_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    birthdate,
    DATEDIFF(YEAR, birthdate, GETDATE()) AS age
FROM
    gold.dim_customers
WHERE
    birthdate = (SELECT MIN(birthdate) FROM gold.dim_customers)
    OR
    birthdate = (SELECT MAX(birthdate) FROM gold.dim_customers)
ORDER BY
    birthdate ASC,
    CONCAT(first_name, ' ', last_name) ASC;


/*
============================================================================================================
Measures Exploration:
Calculate the key metric of the business (big numbers), find the highest and lowest level of aggregation.
============================================================================================================
*/

USE DataWarehouse;
GO

-- (1) Find the total sales:
SELECT SUM(sales_amount) AS total_sales
FROM gold.fact_sales_details; -- 29356250.00

-- Find the total sales with money format:
-- First way:
SELECT FORMAT((SUM(sales_amount)), 'N2') AS total_sales
FROM gold.fact_sales_details; -- 29,356,250.00

-- Second way:
SELECT CONVERT(NVARCHAR, CAST(SUM(sales_amount) AS MONEY), 1) AS total_sales
FROM gold.fact_sales_details; -- 29,356,250.00

-- (2) Explore how many items are sold:
SELECT SUM(quantity) AS total_quantity 
FROM gold.fact_sales_details; -- 60423

-- (3) Find the average selling price:
SELECT ROUND(AVG(price), 0) AS average_selling_price
FROM gold.fact_sales_details; -- 486.000000

-- (4) Find the median of selling price:
SELECT
    CASE
        when COUNT(*) % 2 = 0 THEN 'Even Number'
        ELSE 'Uneven Number'
    END AS number_type_check
FROM gold.fact_sales_details; -- Even Number

WITH fact_cte AS (
    SELECT
        *,
        ROW_NUMBER() OVER(ORDER BY price ASC) AS price_ranking,
        COUNT(*) OVER() AS price_count
    FROM gold.fact_sales_details
)
SELECT
    ROUND(AVG(DISTINCT price), 0) AS median_selling_price
FROM
    fact_cte
WHERE
    price = (SELECT price FROM fact_cte WHERE price_ranking = (price_count / 2))
    OR
    price = (SELECT price FROM fact_cte WHERE price_ranking = ((price_count + 2)) / 2); -- 30.000000

-- Create a median_price_view to be easy import the median value in measures key metrics report:
CREATE VIEW median_price_view AS
WITH fact_cte AS (
    SELECT
        *,
        ROW_NUMBER() OVER(ORDER BY price ASC) AS price_ranking,
        COUNT(*) OVER() AS price_count
    FROM gold.fact_sales_details
)
SELECT
    ROUND(AVG(DISTINCT price), 0) AS median_selling_price
FROM
    fact_cte
WHERE
    price = (SELECT price FROM fact_cte WHERE price_ranking = (price_count / 2))
    OR
    price = (SELECT price FROM fact_cte WHERE price_ranking = ((price_count + 2)) / 2); 

-- (5) Find the mode of selling price:
SELECT
    TOP 1 price AS mode_selling_price
FROM (
    SELECT
        price,
        COUNT(*) AS price_frequency
    FROM
        gold.fact_sales_details
    GROUP BY
        price
) AS mode_subquery
ORDER BY
    price_frequency DESC; -- 5.00

-- Create a mode_price_view to be easy import the mode value in measures key metrics report:
CREATE VIEW mode_price_view AS 
SELECT
    TOP 1 price AS mode_selling_price
FROM (
    SELECT
        price,
        COUNT(*) AS price_frequency
    FROM
        gold.fact_sales_details
    GROUP BY
        price
) AS mode_subquery
ORDER BY
    price_frequency DESC;
    
-- (6) Find the total number of orders:
SELECT COUNT(DISTINCT(order_number)) AS orders_count
FROM gold.fact_sales_details; -- 27659

-- (7) Find the total number of products:
SELECT COUNT(DISTINCT(product_id)) AS products_count
FROM gold.dim_products; -- 295

-- (8) Find the total number of customers:
SELECT COUNT(customer_id) AS customers_count
FROM gold.dim_customers; -- 18484

-- (9) Find the total number of customers that has placed an order:
SELECT
    COUNT(customer_key) AS customer_order_count, -- 60398 (Not Make Sense)
    COUNT(DISTINCT customer_key) AS distinct_customer_count -- 18484 (Make Sense) 
FROM
    gold.fact_sales_details; 
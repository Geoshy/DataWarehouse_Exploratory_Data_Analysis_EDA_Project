/*
===============================================================================================================
Ranking Analysis:
    - Order the values of dimensions by measure.
    - Find the top and bottom performers.
    - By ranking the dimension by aggregated measure.
===============================================================================================================
*/

-- (1) Explore the most 5 products that generate the highest revenue:
-- First Way Using Group By With Top 5 SQL Server Keyword:
SELECT
    TOP 5
    p.product_name,
    FORMAT(SUM(fs.sales_amount), 'N2') AS total_sales
FROM  
    gold.fact_sales_details AS fs LEFT JOIN gold.dim_products AS p
    ON fs.product_key = p.product_key
GROUP BY
    p.product_name
ORDER BY
    SUM(fs.sales_amount) DESC;

-- Second Way Using Window Function Dense Rank:
WITH ranking_cte AS (
    SELECT
        p.product_name AS product_name,
        SUM(fs.sales_amount) AS total_sales,
        DENSE_RANK() OVER(ORDER BY SUM(fs.sales_amount) DESC) AS product_rank
    FROM  
        gold.fact_sales_details AS fs LEFT JOIN gold.dim_products AS p
        ON fs.product_key = p.product_key
    GROUP BY
        p.product_name
)
SELECT
    product_name,
    product_rank
FROM
    ranking_cte
WHERE
    product_rank <= 5;

-- (2) Explore the 5 worst-performing products that generate the lowest revenue:
-- First Way Using Group By With Top 5 SQL Server Keyword:
SELECT
    TOP 5
    p.product_name,
    FORMAT(SUM(fs.sales_amount), 'N2') AS total_sales
FROM  
    gold.fact_sales_details AS fs LEFT JOIN gold.dim_products AS p
    ON fs.product_key = p.product_key
GROUP BY
    p.product_name
ORDER BY
    SUM(fs.sales_amount) ASC;

-- Second Way Using Window Function Dense Rank:
WITH ranking_cte AS (
    SELECT
        p.product_name AS product_name,
        SUM(fs.sales_amount) AS total_sales,
        DENSE_RANK() OVER(ORDER BY SUM(fs.sales_amount) ASC) AS product_rank
    FROM  
        gold.fact_sales_details AS fs LEFT JOIN gold.dim_products AS p
        ON fs.product_key = p.product_key
    GROUP BY
        p.product_name
)
SELECT
    product_name,
    product_rank
FROM
    ranking_cte
WHERE
    product_rank <= 5;
    
-- (3) Explore the most 5 sub-categories that generate the highest revenue:
-- First Way Using Group By With Top 5 SQL Server Keyword:
SELECT
    TOP 5
    p.sub_category,
    FORMAT(SUM(fs.sales_amount), 'N2') AS total_sales
FROM  
    gold.fact_sales_details AS fs LEFT JOIN gold.dim_products AS p
    ON fs.product_key = p.product_key
GROUP BY
    p.sub_category
ORDER BY
    SUM(fs.sales_amount) DESC;

-- Second Way Using Window Function Dense Rank:
WITH ranking_cte AS (
    SELECT
        p.sub_category AS sub_category,
        SUM(fs.sales_amount) AS total_sales,
        DENSE_RANK() OVER(ORDER BY SUM(fs.sales_amount) DESC) AS sub_category_rank
    FROM  
        gold.fact_sales_details AS fs LEFT JOIN gold.dim_products AS p
        ON fs.product_key = p.product_key
    GROUP BY
        p.sub_category
)
SELECT
    sub_category,
    sub_category_rank
FROM
    ranking_cte
WHERE
    sub_category_rank <= 5;

-- (4) Explore the 5 worst-performing sub-categories that generate the lowest revenue:
-- First Way Using Group By With Top 5 SQL Server Keyword:
SELECT
    TOP 5
    p.sub_category,
    FORMAT(SUM(fs.sales_amount), 'N2') AS total_sales
FROM  
    gold.fact_sales_details AS fs LEFT JOIN gold.dim_products AS p
    ON fs.product_key = p.product_key
GROUP BY
    p.sub_category
ORDER BY
    SUM(fs.sales_amount) ASC;

-- Second Way Using Window Function Dense Rank:
WITH ranking_cte AS (
    SELECT
        p.sub_category AS sub_category,
        SUM(fs.sales_amount) AS total_sales,
        DENSE_RANK() OVER(ORDER BY SUM(fs.sales_amount) ASC) AS sub_category_rank
    FROM  
        gold.fact_sales_details AS fs LEFT JOIN gold.dim_products AS p
        ON fs.product_key = p.product_key
    GROUP BY
        p.sub_category
)
SELECT
    sub_category,
    sub_category_rank
FROM
    ranking_cte
WHERE
    sub_category_rank <= 5;

-- (5) Explore the top (3) customers with the highest orders placed:
SELECT
    TOP 3
    c.customer_key,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(order_number) AS total_order
FROM 
    gold.fact_sales_details AS fs LEFT JOIN gold.dim_customers AS c
    ON fs.customer_key = c.customer_key
GROUP BY
    c.customer_key,
    CONCAT(c.first_name, ' ', c.last_name)
ORDER BY
    COUNT(order_number) DESC,
    CONCAT(c.first_name, ' ', c.last_name) ASC;

-- (6) Explore the top (3) customers with the lowest orders placed:
SELECT
    TOP 3
    c.customer_key,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(order_number) AS total_order
FROM 
    gold.fact_sales_details AS fs LEFT JOIN gold.dim_customers AS c
    ON fs.customer_key = c.customer_key
GROUP BY
    c.customer_key,
    CONCAT(c.first_name, ' ', c.last_name)
ORDER BY
    COUNT(order_number) ASC,
    CONCAT(c.first_name, ' ', c.last_name) ASC;

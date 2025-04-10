/*
=================================================================================================================================
This SQL script is about generate a measures key metrics report:
    (1) The total sales key metric.
    (2) How many items are sold key metric.
    (3) The average selling price key metric.
    (4) The median selling price key metric.
    (5) The mode selling price key metric.
    (6) The total number of orders.
    (7) The total number of customers.
    (8) The total number of products.
    (9) The total number of customers that has placed an order.
=================================================================================================================================
*/

SELECT 'Total Sales' AS measure_name, FORMAT((SUM(sales_amount)), 'N2') AS measure_value FROM gold.fact_sales_details
UNION ALL
SELECT 'Total Quantity' AS measure_name, CAST(SUM(quantity) AS NVARCHAR) AS measure_value FROM gold.fact_sales_details
UNION ALL
SELECT 'Average Price' AS measure_name, CAST(ROUND(AVG(price), 0) AS NVARCHAR) AS measure_value FROM gold.fact_sales_details
UNION ALL
SELECT 'Median Price' AS measure_name, CAST(median_selling_price AS NVARCHAR) AS measure_value FROM median_price_view
UNION ALL 
SELECT 'Mode Price' AS measure_name, CAST(mode_selling_price AS NVARCHAR) AS measure_value FROM mode_price_view
UNION ALL
SELECT 'Total Orders Count' AS measure_name, CAST(COUNT(DISTINCT(order_number)) AS NVARCHAR) AS measure_value FROM gold.fact_sales_details
UNION ALL 
SELECT 'Total Products Count' AS measure_name, CAST(COUNT(DISTINCT(product_id)) AS NVARCHAR) AS measure_value FROM gold.dim_products
UNION ALL
SELECT 'Total Customers Count' AS measure_name, CAST(COUNT((customer_id)) AS NVARCHAR) AS measure_value FROM gold.dim_customers;

/*
=================================================================================================================================
Create a Stored Procedure for a full measures key metrics report, as:
    - The code can be reused over and over again (like a function in programming) when call to execute. 
    - Which leads to high performance and security.

AS, when you call a stored procedure for the first time, SQL Server creates an execution plan and stores it in the cache.
In the subsequent executions, SQL Server reuses the plan to execute the stored procedure very fast with reliable performance.
=================================================================================================================================
*/

CREATE OR ALTER PROCEDURE measures_key_metrics_sp AS
BEGIN
    DECLARE @sp_start_time DATETIME, @sp_end_time DATETIME;
    BEGIN TRY
        SET @sp_start_time = GETDATE();

        SELECT 'Total Sales' AS measure_name, FORMAT((SUM(sales_amount)), 'N2') AS measure_value FROM gold.fact_sales_details
        UNION ALL
        SELECT 'Total Quantity' AS measure_name, CAST(SUM(quantity) AS NVARCHAR) AS measure_value FROM gold.fact_sales_details
        UNION ALL
        SELECT 'Average Price' AS measure_name, CAST(ROUND(AVG(price), 0) AS NVARCHAR) AS measure_value FROM gold.fact_sales_details
        UNION ALL
        SELECT 'Median Price' AS measure_name, CAST(median_selling_price AS NVARCHAR) AS measure_value FROM median_price_view
        UNION ALL 
        SELECT 'Mode Price' AS measure_name, CAST(mode_selling_price AS NVARCHAR) AS measure_value FROM mode_price_view
        UNION ALL
        SELECT 'Total Orders Count' AS measure_name, CAST(COUNT(DISTINCT(order_number)) AS NVARCHAR) AS measure_value FROM gold.fact_sales_details
        UNION ALL 
        SELECT 'Total Products Count' AS measure_name, CAST(COUNT(DISTINCT(product_id)) AS NVARCHAR) AS measure_value FROM gold.dim_products
        UNION ALL
        SELECT 'Total Customers Count' AS measure_name, CAST(COUNT((customer_id)) AS NVARCHAR(20)) AS measure_value FROM gold.dim_customers;    

        SET @sp_end_time = GETDATE();

        PRINT('-----------------------------');
        PRINT('Total Strored Procedure Load Duration = ' + CAST((DATEDIFF(SECOND, @sp_start_time, @sp_end_time)) AS NVARCHAR))
        PRINT('-----------------------------');

    END TRY
    BEGIN CATCH
        PRINT('Error Message: ' + ERROR_MESSAGE());
		PRINT('Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR(20)));
		PRINT('Error Number ' + CAST(ERROR_NUMBER() AS NVARCHAR(20)));
		PRINT('Error Stored Procedure: ' + ERROR_PROCEDURE());
		PRINT('Error State: ' + CAST(ERROR_STATE() AS NVARCHAR(20)));
		PRINT('Error Severity: ' + CAST(ERROR_SEVERITY() AS NVARCHAR(20)));
    END CATCH
END;

EXEC measures_key_metrics_sp;
/*
-----------------------------
Total Strored Procedure Load Duration = 1
-----------------------------
*/
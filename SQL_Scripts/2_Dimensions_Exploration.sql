/*
======================================================================================================================
Dimensions Exploration:
Indentifying the unique values (or categories) in each dimension, 
it help us recognizing how might be grouped or segmented which is useful later for analysis.
======================================================================================================================
*/

USE DataWarehouse;
GO

-- First Dimension Table "dim_customers":
-- (1) Explore Column "country":
SELECT DISTINCT country
FROM gold.dim_customers;
-- USA
-- N/A
-- Germany
-- Australia
-- United Kingdom
-- Canada
-- France

-- (2) Explore Column "marital_status":
SELECT DISTINCT marital_status
FROM gold.dim_customers;
-- Single
-- Married

-- Column "marital_status" dose not contain null values:
SELECT * 
FROM gold.dim_customers
WHERE marital_status IS NULL; -- 0

-- (3) Explore Column "gender":
SELECT DISTINCT gender
FROM gold.dim_customers;
-- N/A
-- Male
-- Female

-- Second Dimension Table "dim_products":
-- (1) Explore Column "category":
SELECT DISTINCT category 
FROM gold.dim_products;
-- NULL
-- Accessories
-- Bikes
-- Clothing
-- Components

-- There is not matched 7 rows when join product related table in data warehouse foundation:
SELECT * FROM gold.dim_products WHERE category IS NULL; -- 7

-- (2) Explore Column "sub_category":
SELECT DISTINCT sub_category
FROM gold.dim_products; -- 37
-- NULL
-- Bib-Shorts
-- Bike Racks
-- Bike Stands
-- Bottles and Cages
-- Bottom Brackets
-- Brakes
-- Caps
-- Chains
-- Cleaners
-- Cranksets
-- Derailleurs
-- Fenders
-- Forks
-- Gloves
-- Handlebars
-- Headsets
-- Helmets
-- Hydration Packs
-- Jerseys
-- Lights
-- Locks
-- Mountain Bikes
-- Mountain Frames
-- Panniers
-- Pumps
-- Road Bikes
-- Road Frames
-- Saddles
-- Shorts
-- Socks
-- Tights
-- Tires and Tubes
-- Touring Bikes
-- Touring Frames
-- Vests
-- Wheels

SELECT * FROM gold.dim_products WHERE sub_category IS NULL; -- 7
    
-- (3) Explore Column "maintenance":
SELECT DISTINCT maintenance
FROM gold.dim_products;
-- NULL
-- No
-- Yes
SELECT * FROM gold.dim_products WHERE maintenance IS NULL; -- 7

-- (4) Explore Column "product_line":
SELECT DISTINCT product_line
FROM gold.dim_products;
-- Mountain
-- N/A
-- Other Sales
-- Road
-- Touring

-- Explore the whole hierarchy of our products:
SELECT
    category,
    sub_category,
    product_name,
    product_line
FROM
    gold.dim_products
ORDER BY
    1,2,3,4;
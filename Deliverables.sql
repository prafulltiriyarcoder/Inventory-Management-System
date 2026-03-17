----# Advance Data Analysis and Prediciton Using Sql Queries
--Key tasks
--1. Stock Level Calculations
--2. Low Inventory Detection
--3. Inventory Turnover Analysis
--4. KPI's
----i.   Stockout Rates
----ii.  Inventory Age
----iii. Average Stock Levels

---STOCK LEVEL CALCULATIONS
SELECT 
    i.Date,
    i.Store_ID,
    s.Region,
    i.Product_ID,
    p.Category,
    i.Inventory_Level,
    i.Units_Sold,
    i.Units_Ordered
FROM 
    Inventory as i
    JOIN dim_product as p ON i.Product_ID = p.Product_ID
    JOIN dim_region as s ON i.Store_ID = s.Store_ID
	;


----# Finding Products, Stores and Region which experience frequent stockouts. Or Where Demands are High

select * from inventory;

----# Analyzing most demanded products and Category

select *
from inventory 
where inventory_level < demand_forecast 
;

----# Category Wise Divisions
--Insights Obtained
--1. Clothing brings the Most Overordered category,
--2. Store must Overstock clothing Products to Meet Customer Demand.
select category , sum(units_sold) as TotalUnits_sold , sum(units_ordered) as TotalUnits_Ordered , round(Sum(units_sold * price)) as Net_Revenue
from inventory 
where inventory_level < demand_forecast
group by category
order by net_revenue Asc
;

--# Store Wise Analysis
--Insights
--1. Most Frequent Stockout Experienced in S005 stores with total highest Stock_level.
--2. Most Stocked Out Store is S005 North with Highest Demand and Required_StockLevel.
select store_id,region , sum(units_sold) as TotalUnits_sold , sum(units_ordered) as TotalUnits_Ordered, sum(inventory_level) as stock_level, round(sum((demand_forecast-inventory_level)+inventory_level)) as Required_Stocklevel
from inventory
where inventory_level < demand_forecast
group by store_id,region
order by required_stocklevel desc
;

--# Store , Region and Product Wise Analysis
--Insights
--1. Most Stocked Out Products by region and category listed
with cte as 
(select store_id,region ,product_id , Category, sum(units_sold) as TotalUnits_sold , sum(units_ordered) as TotalUnits_Ordered, sum(inventory_level) as stock_level, (round(sum((demand_forecast-inventory_level)+inventory_level))) as Required_Stocklevel
from inventory
where inventory_level < demand_forecast 
group by store_id,region, product_id , Category
order by required_stocklevel desc)
select store_id,region ,product_id , Category , max(stock_level),max(Required_Stocklevel)
from cte
group by store_id,region ,product_id , Category
order by max(Required_Stocklevel) desc 
;
----Least Performing yet overstocked products

select * from inventory;

select *
from inventory 
where inventory_level > demand_forecast 
;


----# Most priced products with Least Demands (--#Pricing Issues)
select *
from inventory 
where inventory_level > demand_forecast and price > competitor_pricing
;

---# Products, stores , by Seasonality Demanded
select store_id,seasonality , sum(units_sold) as TotalUnits_sold , sum(units_ordered) as TotalUnits_Ordered, sum(inventory_level) as stock_level, (round(sum((demand_forecast-inventory_level)+inventory_level))) as Required_Stocklevel
from inventory
where inventory_level < demand_forecast 
group by store_id,seasonality
order by required_stocklevel desc

----# High Cost Competitive and Demanded Products
select product_id, category,price, competitor_pricing
from inventory
where competitor_pricing < price and demand_forecast > inventory_level ;

----# Low Cost Competitive and Demanded Products
select product_id, category,price, competitor_pricing
from inventory
where competitor_pricing > price and demand_forecast > inventory_level ;

----#Most Stockedout Products

select *
from dim_product ;
----# Fast Moving Products Ranked 
select product_id, category, sum(units_sold) as total_StockSold , rank()Over(partition by category order by product_id desc)
from dim_product
where inventory_level < demand_forecast
group by product_id, category
;

----# Slow Moving Products Ranked 
select product_id, category, sum(units_sold) as total_StockSold , rank()Over(partition by category order by product_id desc)
from dim_product
where inventory_level > demand_forecast
group by product_id, category
;

----
select * from inventory;





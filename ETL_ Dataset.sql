---#Creating the base Inventory table and importing data from csv file.
create table inventrory as (
  date                DATE      NOT NULL  REFERENCES dim_date(date),
  store_id            INT       NOT NULL  REFERENCES dim_store(store_id),
  product_id          INT       NOT NULL  REFERENCES dim_product(product_id),
  weather_id          INT       REFERENCES dim_weather(weather_id),
  inventory_level     INT,
  units_sold          INT,
  units_ordered       INT,
  demand_forecast     INT,
  price               NUMERIC(10,2),
  discount            NUMERIC(5,2),
  competitor_pricing  NUMERIC(10,2))
----# Import Values using import function or manually by script. After importing testing out values 
select * from inventory;

----# Creating reference tables based on 
---_# 1. Region 2. Product  3.Discount  4.Seasonaltiy
CREATE TABLE dim_discount (
  discount             INT   PRIMARY KEY
  date                 DATE       PRIMARY KEY,
  holiday_promotion    VARCHAR(50),
  seasonality          VARCHAR(20)
);
CREATE TABLE dim_region (
  store_id   INT   PRIMARY KEY,
  region     VARCHAR(50)
);
CREATE TABLE dim_product (
  product_id INT   PRIMARY KEY,
  category   VARCHAR(50)
);
CREATE TABLE dim_seasonality (
  weather_id         SERIAL    PRIMARY KEY,
  weather_condition  VARCHAR(50)
);
----# Populating tables by importing from inventory table
INSERT INTO dim_discont(discount, date, holiday_promotion, seasonality)
SELECT DISTINCT
  Date,
  Holiday_Promotion,
  Seasonality
FROM inventory;

INSERT INTO dim_region(store_id, region)
SELECT DISTINCT
  Store_ID,
  Region
FROM inventory;

INSERT INTO dim_product(product_id, category)
SELECT DISTINCT
  Product_ID,
  Category
FROM inventory;

INSERT INTO dim_weather(weather_condition)
SELECT DISTINCT
  Weather_Condition
FROM inventory;
----# Extraction , Transform and Load for the given Data_Set Done

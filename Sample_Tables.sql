CREATE TABLE Products (
    Product_ID VARCHAR(50) ,
    Category VARCHAR(100),
    Price DECIMAL(10,2),
    Competitor_Pricing DECIMAL(10,2)
);
CREATE INDEX idx_products_category ON Products (Category);

INSERT INTO Products
SELECT DISTINCT Product_ID, Category, Price, Competitor_Pricing
FROM inventory_sample; 

CREATE TABLE Stores (
    Store_ID VARCHAR(50),
    Region VARCHAR(100)
);
CREATE INDEX idx_stores_region ON Stores (Region);

INSERT INTO Stores
SELECT DISTINCT Store_ID, Region
FROM inventory_sample;

CREATE TABLE External_Factors (
    Date DATE,
    Store_ID VARCHAR(50),
    Product_ID VARCHAR(50),
    Discount DECIMAL(5,2),
    Weather_Condition VARCHAR(50),
    Holiday_Promotion VARCHAR(50),
    Seasonality VARCHAR(50)
);
CREATE INDEX idx_external_factors_date ON External_Factors (Date);
CREATE INDEX idx_external_factors_store_product ON External_Factors (Store_ID, Product_ID);


INSERT INTO External_Factors
SELECT Date, Store_ID, Product_ID, Discount, Weather_Condition, Holiday_Promotion, Seasonality
FROM inventory_sample;
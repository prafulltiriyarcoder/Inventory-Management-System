select * 
from inventory ; 

CREATE TABLE Inventory_Sample (
    Date DATE,
    Store_ID VARCHAR,
    Product_ID VARCHAR,
    Category VARCHAR,
    Region VARCHAR,
    Inventory_Level INT,
    Units_Sold INT,
    Units_Ordered INT,
    Demand_Forecast INT,
    Price DECIMAL(10,2),
    Discount DECIMAL(5,2),
    Weather_Condition VARCHAR,
    Holiday_Promotion VARCHAR,
    Competitor_Pricing DECIMAL(10,2),
    Seasonality VARCHAR,
    PRIMARY KEY (Date, Store_ID, Product_ID)
);


INSERT INTO Inventory_Sample
SELECT *
FROM Inventory
TABLESAMPLE SYSTEM (0.23) 
LIMIT 250;

select * from 
inventory_sample ;
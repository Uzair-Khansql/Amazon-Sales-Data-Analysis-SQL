-- Data Cleaning :-
----------------------------------------------------------------------------------------------------------------------------------------------------
--1. Unnecessary Columns Drop: Dataset mein majood extra ya useless columns (jaise index aur Unnamed: 22) ko table se hamesha ke liye remove kar do.
alter table tblAmazon
drop column [index], [Unnamed: 22]

--2. Missing Values (NULLs) Handle: Amount Column: Jahan orders cancelled hone ki wajah se Amount missing/NULL hai, waha value 0 set karo.
update tblAmazon
set Amount = 0
where Amount is null

--3.Text Columns: Courier Status, fulfilled-by, ship-city, aur ship-state jahan NULL hain, wahan 'Unknown' string set kar do.
update tblAmazon
set [Courier Status] = 'Unknown'
where [Courier Status] is null

update tblAmazon
set [fulfilled-by] = 'Unknown'
where [fulfilled-by] is null

update tblAmazon
set [ship-city] = 'Unknown'
where [ship-city] is null

--4. Date Column ka Data Type Fix : Date column agar text format mein import hua hai, to usko proper DATE
--   data type mein convert karo taake baad mein month/year wise analysis asan ho jaye.
alter table tblAmazon
alter column [Date] date

--5. Duplicate Records Clean : Same Order ID, SKU, Date, aur Amount wali duplicate rows ko identify karke delete karo 
--   taake total sales calculate karte waqt repetition na ho.
DELETE FROM tblAmazon
WHERE [Order ID] NOT IN (
    SELECT MIN([Order ID]) 
    FROM tblAmazon
    GROUP BY [Order ID], [SKU], [Date], [Amount]
)

-- 6. Text Standardization : Status columns (jaise Status, Courier Status) ke andar extra spaces ya 
--    spelling mismatches check karke unhe consistent banao.
UPDATE tblAmazon
SET [Status] = LTRIM(RTRIM([Status])),		-- Remove extra spaces from left to right
[Courier Status] = LTRIM(RTRIM([Courier Status])); -- Remove extra spaces from right to left

select distinct[Status] from tblAmazon		-- checks, the value is consistent or not
select distinct[Courier Status] from tblAmazon  -- checks, the value is consistent or not

-- 7. Data Validation : 
-- Total row count, distinct order count
select COUNT(*) from tblAmazon	-- Total row count
select COUNT(DISTINCT([Order ID])) from tblAmazon -- distinct order count

-- missing values check karke confirm karo ke dataset poori tarah clean aur analysis-ready ho chuka hai.
SELECT 
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN [Order ID] IS NULL THEN 1 ELSE 0 END) AS Null_OrderID,
    SUM(CASE WHEN [Date] IS NULL THEN 1 ELSE 0 END) AS Null_Date,
    SUM(CASE WHEN [Status] IS NULL THEN 1 ELSE 0 END) AS Null_Status,
    SUM(CASE WHEN [Fulfilment] IS NULL THEN 1 ELSE 0 END) AS Null_Fulfilment,
    SUM(CASE WHEN [Sales Channel] IS NULL THEN 1 ELSE 0 END) AS Null_SalesChannel,
    SUM(CASE WHEN [ship-service-level] IS NULL THEN 1 ELSE 0 END) AS Null_ShipServiceLevel,
    SUM(CASE WHEN [Style] IS NULL THEN 1 ELSE 0 END) AS Null_Style,
    SUM(CASE WHEN [SKU] IS NULL THEN 1 ELSE 0 END) AS Null_SKU,
    SUM(CASE WHEN [Category] IS NULL THEN 1 ELSE 0 END) AS Null_Category,
    SUM(CASE WHEN [Size] IS NULL THEN 1 ELSE 0 END) AS Null_Size,
    SUM(CASE WHEN [ASIN] IS NULL THEN 1 ELSE 0 END) AS Null_ASIN,
    SUM(CASE WHEN [Courier Status] IS NULL THEN 1 ELSE 0 END) AS Null_CourierStatus,
    SUM(CASE WHEN [Qty] IS NULL THEN 1 ELSE 0 END) AS Null_Qty,
    SUM(CASE WHEN [currency] IS NULL THEN 1 ELSE 0 END) AS Null_Currency,
    SUM(CASE WHEN [Amount] IS NULL THEN 1 ELSE 0 END) AS Null_Amount,
    SUM(CASE WHEN [ship-city] IS NULL THEN 1 ELSE 0 END) AS Null_ShipCity,
    SUM(CASE WHEN [ship-state] IS NULL THEN 1 ELSE 0 END) AS Null_ShipState,
    SUM(CASE WHEN [ship-postal-code] IS NULL THEN 1 ELSE 0 END) AS Null_ShipPostalCode,
    SUM(CASE WHEN [ship-country] IS NULL THEN 1 ELSE 0 END) AS Null_ShipCountry,
    SUM(CASE WHEN [promotion-ids] IS NULL THEN 1 ELSE 0 END) AS Null_PromotionIDs,
    SUM(CASE WHEN [B2B] IS NULL THEN 1 ELSE 0 END) AS Null_B2B,
    SUM(CASE WHEN [fulfilled-by] IS NULL THEN 1 ELSE 0 END) AS Null_FulfilledBy
FROM tblAmazon

-- Some columns has Null values, lets clean it..
update tblAmazon
set [ship-state] = 'Unknown'
where [ship-state] is null

update tblAmazon
set currency = 'Unknown'
where currency is null

update tblAmazon
set [promotion-ids] = 'Unknown'
where [promotion-ids] is null

update tblAmazon
set [ship-country] = 'Unknown'
where [ship-country] is null

update tblAmazon
set [ship-postal-code] = 0
where [ship-postal-code] is null

----------------------------------------------------------------------------------------------------------------------------------------------------
-- Data Analysis Queries:-
----------------------------------------------------------------------------------------------------------------------------------------------------
-- Total Sales:-
select SUM(Amount) from tblAmazon

-- Top Products:-
select SKU, Category,
SUM(Qty) as 'Total_Quantity_Sold'
from tblAmazon 
group by SKU, Category
order by Total_Quantity_Sold desc

--Order Status:-
select [Status],
COUNT(*) as 'Quantities' 
from tblAmazon
group by [Status]
order by Quantities desc

-- Top Cities:-
select [ship-city],
COUNT(*) as 'Quantities'
from tblAmazon
group by [ship-city]
order by Quantities desc

select * from tblAmazon


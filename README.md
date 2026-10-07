# 🛒 Amazon Sales Data Cleaning & Analysis (SQL)

## 📌 Project Overview
This project focuses on cleaning, validating, and analyzing raw Amazon sales data using **Microsoft SQL Server (SSMS)**. The goal is to transform uncleaned operational data into structured business insights regarding revenue, product performance, order status, and customer geography.

---

## 🛠️ Tech Stack & Tools
* **Database Management System:** Microsoft SQL Server (SSMS)
* **Language:** T-SQL (Transact-SQL)
* **Data Format:** CSV / Excel

---

## 🧹 Key Data Cleaning Steps Performed
1. **Handling Missing Values:** Replaced NULLs and blank values in critical columns.
2. **Data Standardization:** Corrected casing and whitespace inconsistencies in categorical fields.
3. **Data Type Casting:** Ensured numerical and date fields were set to appropriate SQL data types.
4. **Duplicates Removal:** Identified and eliminated duplicate order records.

---

## 📊 Key Business Queries & Insights
### 1. Total Revenue Generated
```sql
SELECT SUM(Amount) AS Total_Revenue 
FROM tblAmazon;

## 2. Top Selling Products & Categories
SELECT 
    SKU, 
    Category,
    SUM(Qty) AS Total_Quantity_Sold
FROM tblAmazon 
GROUP BY SKU, Category
ORDER BY Total_Quantity_Sold DESC;

### 3. Order Status BreakDown
SELECT 
    [Status],
    COUNT(*) AS Quantities 
FROM tblAmazon
GROUP BY [Status]
ORDER BY Quantities DESC;

### 4. Top performing Cities
SELECT 
    [ship-city],
    COUNT(*) AS Total_Orders,
    SUM(Amount) AS Total_Revenue
FROM tblAmazon
GROUP BY [ship-city]
ORDER BY Total_Orders DESC;

### Note: Sample clean dataset (tblAmazon_Cleaned_Sample.csv) is included in this repository. Full dataset available upon request.
```sql
SELECT SUM(Amount) AS Total_Revenue 
FROM tblAmazon;

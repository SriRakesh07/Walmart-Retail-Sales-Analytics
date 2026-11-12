CREATE DATABASE walmart_db;

USE walmart_db;

CREATE TABLE walmart_data (
    Transaction_ID VARCHAR(50) PRIMARY KEY,
    Date DATE,
    Store_ID INT,
    Product_ID INT,
    Customer_ID INT,
    Quantity INT,
    Unit_Price DECIMAL(10,2),
    Discount_Pct DECIMAL(5,2),
    Discount_Amount DECIMAL(10,2),
    Sales DECIMAL(12,2),
    Cost DECIMAL(12,2),
    Profit DECIMAL(12,2),
    Payment_Method VARCHAR(30),
    Promotion_Flag TINYINT,
    Holiday_Flag TINYINT
);

SHOW CREATE TABLE walmart_data;

SELECT COUNT(*) AS total_rows FROM walmart_data;

SELECT*FROM walmart_data
LIMIT 10;

#total sales

SELECT SUM(Sales) AS total_sales
FROM walmart_data;

#Total Profit

SELECT SUM(Profit) AS total_profit
FROM walmart_data;

#Count Total Transactions

SELECT COUNT(*) AS total_transaction
FROM walmart_data;

#Total Sales by Payment Method

SELECT
Payment_Method,
SUM(Sales) AS total_sales
FROM walmart_data
GROUP BY Payment_Method
ORDER BY total_sales DESC;

#Total Profit by Payment Method

SELECT
Payment_Method,
SUM(Profit) AS total_profit
FROM walmart_data
GROUP BY Payment_Method
ORDER BY total_profit DESC;

#Total Sales by Store

SELECT
Store_ID,
SUM(Sales) AS total_sales
FROM walmart_data
GROUP BY Store_ID
ORDER BY total_sales DESC;

#Total Profit by Store.

SELECT
Store_ID,
SUM(Profit) AS total_profit
FROM walmart_data
GROUP BY Store_ID
ORDER BY total_profit DESC;

#Top 10 Products

SELECT
Product_ID,
SUM(Sales) AS Total_sales
FROM walmart_data
GROUP BY Product_ID
ORDER BY Total_sales DESC
LIMIT 10;

#Top 10 Products by Profit

SELECT
Product_ID,
SUM(Profit) AS total_profit
FROM walmart_data
GROUP BY Product_ID
ORDER BY total_profit DESC
LIMIT 10;

#Monthly Sales Trends

SELECT
DATE_FORMAT(`Date`, '%Y-%m') AS sales_month,
SUM(Sales) AS total_sales
FROM walmart_data
GROUP BY sales_month
ORDER BY sales_month;

#Monthly Profit Trends

SELECT
DATE_FORMAT(`Date`, '%Y-%m') AS profit_month,
SUM(Profit) AS total_profit
FROM walmart_data
GROUP BY profit_month
ORDER BY profit_month;

#Sales by Promotion Flag

SELECT
Promotion_Flag,
SUM(Sales) AS total_sales,
COUNT(*) AS total_transactions
FROM walmart_data
GROUP BY Promotion_Flag
ORDER BY total_sales DESC;

#Profit by Promotion Flag

SELECT
Promotion_Flag,
SUM(Profit) AS total_profit,
COUNT(*) AS total_transactions
FROM walmart_data
GROUP BY Promotion_Flag
ORDER BY total_profit DESC;

#Sales by Holiday Flag

SELECT
Holiday_Flag,
SUM(Sales) AS total_sales,
COUNT(*) AS total_transactions
FROM walmart_data
GROUP BY Holiday_Flag
ORDER BY total_sales DESC;

#Profit by Holiday Flag

SELECT
Holiday_Flag,
SUM(Profit) AS total_profit,
COUNT(*) AS total_transactions
FROM walmart_data
GROUP BY Holiday_Flag
ORDER BY total_profit DESC;

#Top 10 Customers by Sales

SELECT 
Customer_ID,
SUM(Sales) AS total_sales,
COUNT(*) AS total_transactions
FROM walmart_data
GROUP BY Customer_ID
ORDER BY total_sales DESC
LIMIT 10;

#Top 10 Products by Quantity Sold

SELECT
Product_ID,
SUM(Quantity) AS total_quantity_sold,
SUM(Sales) AS total_sales
FROM walmart_data
GROUP BY Product_ID
ORDER BY total_quantity_sold DESC
LIMIT 10;

#Average Sales per Transaction

SELECT
ROUND(AVG(Sales),2) AS total_avg_sales
FROM walmart_data;

#Average Profit per Transaction

SELECT
ROUND(AVG(Profit),2) AS total_avg_profit
FROM walmart_data;

#Highest and Lowest Sales Transactions

SELECT
Transaction_ID,
'Date'
Store_ID,
Product_ID,
Sales
FROM walmart_data
ORDER BY Sales DESC
LIMIT 10;

SELECT
Transaction_ID,
'Date'
Store_ID,
Product_ID,
Sales
FROM walmart_data
ORDER BY Sales ASC
LIMIT 10;

#Analyze How Discounts Affect Profit

SELECT 
CASE
WHEN Discount_Pct = 0 THEN 'NO DISCOUNT'
WHEN Discount_Pct <= 10 THEN 'LOW DISCOUNT'
WHEN Discount_Pct <= 25 THEN 'MEDIUM DISCOUNT'
ELSE 'HIGH DISCOUNT'
END AS discount_category,
COUNT(*) AS total_transaction,
ROUND(AVG(Discount_Pct),2) AS AVG_discount_pct,
ROUND(SUM(Sales),2) AS total_sales,
ROUND(SUM(Profit),2) AS total_profit
FROM walmart_data
GROUP BY discount_category
ORDER BY AVG_discount_pct;

#Calculate Overall Profit Margin

SELECT 
ROUND(SUM(Sales),2) AS total_sales,
ROUND(SUM(Profit),2) AS total_profit,
ROUND(SUM(Profit)/NULLIF(SUM(Sales),0)*100,2) AS profit_margin_prc
FROM walmart_data;

#Store Performance Comparison

SELECT
Store_ID,
COUNT(*) AS total_transactions,
ROUND(SUM(Sales),2) AS total_sales,
ROUND(SUM(Profit),2) AS total_profit,
ROUND(SUM(Profit)/NULLIF(SUM(Sales),0)*100,2) AS profit_margin_prc
FROM walmart_data
GROUP BY Store_ID
ORDER BY total_sales DESC;

#Best-Performing Store

SELECT
Store_ID,
ROUND(SUM(Sales), 2) AS total_sales,
ROUND(SUM(Profit), 2) AS total_profit,
ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,2) AS profit_margin_pct
FROM walmart_data
GROUP BY Store_ID
ORDER BY profit_margin_pct DESC
LIMIT 1;

#Final Business Summary

SELECT
COUNT(*) AS total_transactions,
COUNT(DISTINCT Customer_ID) AS unique_customers,
COUNT(DISTINCT Store_ID) AS total_stores,
COUNT(DISTINCT Product_ID) AS unique_products,
ROUND(SUM(Sales), 2) AS total_sales,
ROUND(SUM(Profit), 2) AS total_profit,
ROUND(AVG(Sales), 2) AS avg_sales_per_transaction,
ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,2) AS profit_margin_prc
FROM walmart_data;
















/* Question 20

We learned in Question 19 that the first and most recent OrderDate in the SalesOrderHeader 
table matches the Sales Order Dates in the transactionHistory table (Question 18).

a. Find the other tables and dates that should match the WorkOrder and PurchaseOrder Dates. 
Format these dates as a date in the YYYY-MM-DD format.

b. Do the dates match? Why/Why not?
*/

-- tab from 19
SELECT 
	CAST(MIN(OrderDate) as date) FirstDate,
	CAST(MAX(OrderDate) as date) LastDate
FROM Sales.SalesOrderHeader
 
-- Production.WorkOrder and Production.WorkOrderRouting
SELECT 
	CASt(MIN(StartDate) as date) FirstDate,
	CAST(MAX(EndDate) as date) LastDate
FROM Production.WorkOrder

SELECT 
	CASt(MIN(ActualStartDate) as date) FirstDate,
	CAST(MAX(ActualEndDate) as date) LastDate
FROM Production.WorkOrderRouting

SELECT 
	CAST(MAX(DueDate) as date) LastDate
FROM Production.WorkOrder
/* 
Dates are different because the original table contains data when the transaction was realized, probably when the money
appeared on in the company's accounts. 

In the table Purchasing.ProductVendor there is an column called AverageLeadTime that describes the average span of time (in days) between
placing an order with the vendor and receiving the purchased product.

*/

-- Purchasing.PurchaseOrderHeader.

-- Here the OrderDate tells us when the order was created but not when the money was credited to your account

SELECT
	CAST(MIN(OrderDate) as date) as FirstDate,
	CAST(MAX(OrderDate) as date) as LastDate 
FROM Purchasing.PurchaseOrderHeader
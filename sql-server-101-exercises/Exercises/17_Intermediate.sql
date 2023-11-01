/*

Question 17
We learned in Question 16 that the product table includes a few different type of products - i.e., manufactured vs. purchased.

a. Sum the LineTotal in SalesOrderDetail. Format as currency
b. Sum the LineTotal in SalesOrderDetail by the MakeFlag in the product table. Use a case statement to 
   specify manufactured vs. purchased. Format as currency.
c. Add a count of distinct SalesOrderIDs
d. What is the average LineTotal per SalesOrderID?

*/

-- a.
SELECT 
    FORMAT(SUM(LineTotal), 'C', 'en-US') as Sum
FROM Sales.SalesOrderDetail;

-- b. Sum the LineTotal in SalesOrderDetail by the MakeFlag in the product table. Use a case statement to 
--    specify manufactured vs. purchased. Format as currency.

SELECT
	CASE WHEN p.MakeFlag = 0 THEN 'Purchased' ELSE 'ManufacturedInHouse' END as MakeFlag,
    FORMAT(SUM(s.LineTotal), 'C', 'en-US') as Sum
FROM Sales.SalesOrderDetail as s
INNER JOIN Production.Product as p on p.ProductID = s.ProductID
GROUP BY p.MakeFlag

-- c. Add a count of distinct SalesOrderIDs

SELECT
	CASE WHEN p.MakeFlag = 0 THEN 'Purchased' ELSE 'ManufacturedInHouse' END as MakeFlag,
    FORMAT(SUM(s.LineTotal), 'C', 'en-US') as Sum,
	COUNT(DISTINCT s.SalesOrderID) as SalesID_CNT
FROM Sales.SalesOrderDetail as s
INNER JOIN Production.Product as p on p.ProductID = s.ProductID
GROUP BY p.MakeFlag

-- d. What is the average LineTotal per SalesOrderID?

SELECT 
	SalesOrderId,
	AVG(LineTotal) as AvgLineTotalPerID
FROM Sales.SalesOrderDetail
Group by SalesOrderID

-- or answer from course. It seems they wanted AverageLineTotal for manufactured and not.
SELECT
	CASE WHEN p.MakeFlag = 0 THEN 'Purchased' ELSE 'ManufacturedInHouse' END as MakeFlag,
    FORMAT(SUM(s.LineTotal), 'C0') as Sum,
	COUNT(DISTINCT s.SalesOrderID) as SalesID_CNT,
	AVG(s.LineTotal) as AVG_LINE_TOT,
	FORMAT(SUM(s.LineTotal)/COUNT(DISTINCT s.SalesOrderID), 'C0') as AvgLineTotal -- DISTINCT - important!
FROM Sales.SalesOrderDetail as s
INNER JOIN Production.Product as p on p.ProductID = s.ProductID
GROUP BY p.MakeFlag
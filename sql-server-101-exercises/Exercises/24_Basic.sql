/*Question 24

In this question use SalesOrderID '69411' to determine answer.

a. In the SalesOrderHeader what is the difference between "SubTotal" and "TotalDue"?
b. Which one of these matches the "LineTotal" in the SalesOrderDetail?
c. How is TotalDue calculated in SalesOrderHeader?
d. How is LineTotal calculated in SalesOrderDetail? */

-- a.
SELECT
	TotalDue,
	SubTotal,
	(TotalDue - SubTotal) as Diff
FROM Sales.SalesOrderHeader
WHERE SalesOrderID = '69411'

-- b.
SELECT Sum(LineTotal) FROM Sales.SalesOrderDetail WHERE SalesOrderID = '69411'

-- Answer: SubTotal matches LineTotal

-- c. How is TotalDue calculated in SalesOrderHeader
SELECT
	TotalDue,
	SubTotal,
	(TotalDue - SubTotal) as Diff,
	(SubTotal + TaxAmt + Freight) as TotalDueCalc
FROM Sales.SalesOrderHeader
WHERE SalesOrderID = '69411'
-- SubTotal + TaxAmt + Freight

-- d. How is LineTotal calculated in SalesOrderDetail?
SELECT 
	OrderQty,
	UnitPrice,
	LineTotal,
	(OrderQty * UnitPrice) as LineTotalCalculated
FROM Sales.SalesOrderDetail
-- OrderQty * UnitPrice
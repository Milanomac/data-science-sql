/* Question 28

a. Using Sales.SalesReason pull a distinct list of every sales reason.
b. Add a count of SalesOrderID's to the sales reason.
c. Which Sales Reason is most common? */

-- a.
SELECT DISTINCT ReasonType FROM Sales.SalesReason

-- b.
SELECT SalesOrderID FROM Sales.SalesOrderHeaderSalesReason

SELECT
	ssorsr.SalesOrderID,
	ssr.Name as Reason
FROM Sales.SalesReason as ssr
INNER JOIN Sales.SalesOrderHeaderSalesReason as ssorsr on ssorsr.SalesReasonID = ssr.SalesReasonID

-- c. "Other"
SELECT
	ssr.Name as Reason,
	COUNT(*) as SalesReasonCNT
FROM Sales.SalesReason as ssr
INNER JOIN Sales.SalesOrderHeaderSalesReason as ssorsr on ssorsr.SalesReasonID = ssr.SalesReasonID
GROUP BY ssr.Name
ORDER BY COUNT(*) DESC
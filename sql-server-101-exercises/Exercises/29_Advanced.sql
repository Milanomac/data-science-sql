/* Question 29:

Based on the results in question 28, there are 27,647 rows in the SalesOrderHeaderSalesReason table. 
Which means these 27,647 are assigned to a SalesReason. However, there are 31,465 unique SalesOrderIDs 
in the SalesOrderHeader table. This is due to the fact that a SalesOrder can have zero, one, or multiple 
sales reasons listed. For Example, SalesOrderID 44044 has "Manufacturer" and "Quality" listed as reasons 
why the customer purchased. The most reasons listed for a single SalesOrderID is 3.

Using a CTE (Common Table Expression) find the number of SalesOrderIDs that have zero, one, two, and three sales reasons. */

-- Granularity is 31,465 in SalesOrderHeader table, therefore we need to LEFT JOIN
-- 27,647 rows in the SalesOrderHeaderSalesReason table
SELECT
	COUNT(soh.SalesOrderID) as AfterJoining,
	COUNT(DISTINCT soh.SalesOrderID) as BeforeJoining,
	COUNT(sohsr.SalesOrderID) as OnlyOneReason
FROM Sales.SalesOrderHeader as soh
LEFT JOIN Sales.SalesOrderHeaderSalesReason as sohsr on sohsr.SalesOrderID = soh.SalesOrderID
LEFT JOIN Sales.SalesReason as sr on sr.SalesReasonID = sohsr.SalesReasonID

-- Answer:
WITH CTE AS (
	SELECT
		soh.SalesOrderID,
		COUNT(sohsr.SalesOrderID) as CNT
	FROM Sales.SalesOrderHeader as soh
	LEFT JOIN Sales.SalesOrderHeaderSalesReason as sohsr on sohsr.SalesOrderID = soh.SalesOrderID
	LEFT JOIN Sales.SalesReason as sr on sr.SalesReasonID = sohsr.SalesReasonID
	GROUP BY soh.SalesOrderID)

		SELECT 
			CNT as SalesReasons,
			COUNT(CNT) as ReasonCNT 
		FROM CTE 
		GROUP BY CNT

/* Question 42

Before attempting Question 42 complete Question 41.

Using the results from Question 41 (see below) we are going to update the comment column in SalesOrderHeader. 
The column is currently null. We want the comment in SalesOrderHeader to say:

"[CustomerName] is a(n) [PersonType] and purchased [OrderQty] Product(s) from [SalesPersonName] on [OrderDate]."

a. Using the column elements From Question 41 build a CTE (common table expression) that includes two columns 
   - SalesOrderID and Comment. Here is an example for Customer (BusinessEntityID) 49123:

"Michael Allen is a(n) Store Contact and purchased 72 Product(s) from Jillian Carson on 12/31/2012"

b. Update SalesOrderHeader.Comment using the CTE from part a. Remember there are 31,465 unique SalesOrderID's.*/

-- a.
WITH CTE AS (
	SELECT
		SalesOrderID,
		CONCAT(Name, ' is a(n) ', PersonType, ' and purchased ', ProductQty, ' Product(s) from ', SalesPersonName, ' on ', Date) as Comment
	FROM (
		SELECT 
			soh.SalesOrderID as SalesOrderID,
			CONCAT(p.FirstName, ' ', p.LastName) as Name,
			CASE WHEN p.PersonType = 'IN' THEN 'Customer'
				WHEN p.PersonType = 'SP' THEN 'SalesPerson'
				WHEN p.PersonType ='SC' THEN 'StoreContact'
				WHEN p.PersonType ='EM' THEN 'Employee'
				WHEN p.PersonType ='VC' THEN 'VendorContact'
				WHEN p.PersonType ='GC' THEN 'GeneralContact' END AS PersonType,
			CASE WHEN CONCAT(per.FirstName, ' ', per.LastName) = '' THEN 'No Sales Person' 
				ELSE CONCAT(per.FirstName, ' ', per.LastName) END AS SalesPersonName,
			CAST(soh.OrderDate as date) as Date,
			Sum(OrderQTY) as ProductQty
		FROM Sales.SalesOrderHeader as soh
		INNER JOIN Sales.SalesOrderDetail as sod on soh.SalesOrderID = sod.SalesOrderID
		INNER JOIN Sales.Customer as c on c.CustomerID = soh.CustomerID
		INNER JOIN Person.Person as p on p.BusinessEntityID = c.PersonID
		LEFT JOIN Person.Person as per on per.BusinessEntityID = soh.SalesPersonID
		Group by 
			soh.SalesOrderID,
			CONCAT(p.FirstName,' ',p.LastName),
			p.PersonType,
			OrderDate,
			CONCAT(per.FirstName,' ',per.LastName)
			) as SUBQ
		)
				--SELECT 
					--*
				--FROM CTE
				--WHERE SalesOrderID = 49123


-- b.
--Select Comment FROM Sales.SalesOrderHeader

				Update Sales.SalesOrderHeader
				Set Comment = CTE.Comment
				From Sales.SalesOrderHeader soh
					Inner Join CTE on CTE.SalesOrderID = soh.SalesOrderID 

Select Comment FROM Sales.SalesOrderHeader

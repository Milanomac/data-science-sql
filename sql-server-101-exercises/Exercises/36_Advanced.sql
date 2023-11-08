/* Question 36:

AdventureWorks leadership has asked you to put together a report. Follow the steps below to build the report.

a. Pull a distinct list of every region. Use the SalesTerritory as the region.
b. Add the Sum(TotalDue) to the list of regions
c. Add each customer name. Concatenate First and Last Names
d. Using ROW_NUMBER and a partition rank each customer spending by region. For example, Australia is a region and we want
   to rank each customer by the Sum(TotalDue).*/

-- a. & b.
SELECT 
	st.Name,
	SUM(soh.TotalDue) as TotalDueSum
FROM Sales.SalesTerritory as st
INNER JOIN Sales.SalesOrderHeader as soh on soh.TerritoryID = st.TerritoryID
GROUP BY st.Name

 -- c.
SELECT 
	st.Name as Region,
	SUM(soh.TotalDue) as TotalDueSum,
	CONCAT(p.FirstName, ' ', p.LastName) as Name
FROM Sales.SalesTerritory as st
	Inner Join Sales.SalesOrderHeader soh on soh.TerritoryID = st.TerritoryID
	Inner Join Sales.Customer c on c.CustomerID = soh.CustomerID
	Inner Join Person.Person p on p.BusinessEntityID = c.PersonID
GROUP BY st.Name, CONCAT(p.FirstName, ' ', p.LastName)

-- d.
SELECT 
	st.Name as Region,
	FORMAT(SUM(soh.TotalDue), 'C0')  as TotalDueSum,
	CONCAT(p.FirstName, ' ', p.LastName) as Name,
	ROW_NUMBER() OVER(PARTITION BY st.Name ORDER BY SUM(soh.TotalDue) DESC) as RowNum
FROM Sales.SalesTerritory as st
	Inner Join Sales.SalesOrderHeader soh on soh.TerritoryID = st.TerritoryID
	Inner Join Sales.Customer c on c.CustomerID = soh.CustomerID
	Inner Join Person.Person p on p.BusinessEntityID = c.PersonID
GROUP BY st.Name, CONCAT(p.FirstName, ' ', p.LastName)
ORDER BY 4 ASC, 2 DESC

-- The first 10 rows of the resulting query shows the highest spenders in each region.
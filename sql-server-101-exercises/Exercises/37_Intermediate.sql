/* Question 37:
Complete Question 36 before attempting this question.

In Question 36 the leadership team asked you to build a report. Based on those results the leadership team 
has decided to start a loyalty program and gift the top 25 customers (in terms of totaldue/sales) a free loyalty membership.
Below is the script we wrote in question 36.

a. Limit the results in question 36 to only show the top 25 customers in  each region. There are 10 regions so you should have 250 rows.
b. What is the average TotalDue per Region? Leave the top 25 filter */

-- a.
SELECT 
	RegionName,
	CustomerName,
	TotalDue,
	RowNum
FROM (
		Select 
			distinct st.Name as RegionName
			,Concat(p.FirstName,' ',p.LastName) as CustomerName
			,Format(Sum(TotalDue),'C0') as TotalDue
			,ROW_NUMBER() Over(Partition by st.Name Order by Sum(TotalDue) desc) as RowNum
		From Sales.SalesTerritory st
			Inner Join Sales.SalesOrderHeader soh on soh.TerritoryID = st.TerritoryID
			Inner Join Sales.Customer c on c.CustomerID = soh.CustomerID
			Inner Join Person.Person p on p.BusinessEntityID = c.PersonID
		Group by 
			st.Name
			,Concat(p.FirstName,' ',p.LastName)
			) as Subquery
WHERE RowNum < 26

-- b. What is the average TotalDue per Region? Leave the top 25 filter

SELECT 
	RegionName,
	--CustomerName,
	FORMAT(AVG(TotalDue), 'C0') as AverageTotalDue
	-- RowNum
FROM (
		Select 
			distinct st.Name as RegionName
			,Concat(p.FirstName,' ',p.LastName) as CustomerName
			,Sum(TotalDue) as TotalDue
			,ROW_NUMBER() Over(Partition by st.Name Order by Sum(TotalDue) desc) as RowNum
		From Sales.SalesTerritory st
			Inner Join Sales.SalesOrderHeader soh on soh.TerritoryID = st.TerritoryID
			Inner Join Sales.Customer c on c.CustomerID = soh.CustomerID
			Inner Join Person.Person p on p.BusinessEntityID = c.PersonID
		Group by 
			st.Name
			,Concat(p.FirstName,' ',p.LastName)
			) as Subquery
WHERE RowNum < 26
GROUP BY RegionName
ORDER BY AVG(TotalDue) DESC


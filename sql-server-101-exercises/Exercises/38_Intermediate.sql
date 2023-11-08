/* Question 38

Due to an increase in shipping cost you've been asked to pull a few figures related to the freight column in Sales.SalesOrderHeader

a. How much has AdventureWorks spent on freight in totality?
b. Show how much has been spent on freight by year (ShipDate)
c. Add the average freight per SalesOrderID in each year
d. Add a Cumulative/Running Total sum */

-- a.
SELECT FORMAT(SUM(Freight), 'C0') as TotalSpentOnFreight FROM Sales.SalesOrderHeader

-- b. 
SELECT 
	YEAR(CAST(ShipDate as date)) as Year,
	FORMAT(SUM(Freight), 'C0') as TotalSpentOnFreight 
FROM Sales.SalesOrderHeader
GROUP BY YEAR(CAST(ShipDate as date))

-- c.
SELECT
	YEAR(CAST(ShipDate as date)) as Year,
	FORMAT(SUM(Freight), 'C0') as TotalSpentOnFreight,
	FORMAT(AVG(Freight), 'C0') as AverageFreight 
FROM Sales.SalesOrderHeader
GROUP BY YEAR(CAST(ShipDate as date))

-- d. Hint: Format(Sum(TotalFreight) Over (Order by ShipYear),'C0') as RunningTotal
SELECT
	Year,
	FORMAT(TotalSpentOnFreight, 'C0') as TotalFreight,
	FORMAT(AverageFreight, 'C0') as AverageFreight,
	Format(Sum(TotalSpentOnFreight) Over (Order by Year),'C0') as RunningTotal
	FROM (
		SELECT
			YEAR(CAST(ShipDate as date)) as Year,
			SUM(Freight) as TotalSpentOnFreight,
			AVG(Freight) as AverageFreight 
		FROM Sales.SalesOrderHeader
		GROUP BY YEAR(CAST(ShipDate as date))
		) as Subq
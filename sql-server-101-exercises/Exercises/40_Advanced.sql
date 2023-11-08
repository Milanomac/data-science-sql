/* Question 40

In Question 38 and 39 we analyzed the Freight costs by Year.
In Question 39 we adjusted some of those calculations by accounting for incomplete years. 
In this question we are going to analyze freight costs at the Monthly level.

a. Start by writing a query that shows freight costs by Month (use ShipDate). Be sure to include year. Include
   two Month columns one where month is 1-12 and another with the full month written out (i.e. January)
b. Add an average
c. Add a cumulative sum start with June 2011 and go to July 2014. July 2014 should reconile to the Freight in
   totality ($3,183,430)
d. Add a yearly cumulative Sum, which means every January will start over. */ 

-- a.
SELECT 
	YEAR(ShipDate) as ShipYear,
	MONTH(ShipDate) as ShipMonth,
	DateName(month, DateAdd(month, MONTH(ShipDate), -1 )) as ShipMonthName, 
	Freight
FROM Sales.SalesOrderHeader

-- b.
SELECT 
	YEAR(ShipDate) as ShipYear,
	MONTH(ShipDate) as ShipMonth,
	DateName(month, DateAdd(month, MONTH(ShipDate), -1 )) as ShipMonthName, 
	AVG(Freight) as AvgFreight
FROM Sales.SalesOrderHeader
GROUP BY MONTH(ShipDate), YEAR(ShipDate)
ORDER BY YEAR(ShipDate) ASC, MONTH(ShipDate) ASC

-- c.
SELECT
	ShipYear,
	ShipMonth,
	ShipMonthName,
	AvgFreight,
	Format(Sum(SumFreight) Over (Order by ShipYear, ShipMonth),'C0') as RunningTotal
FROM (
		SELECT 
			YEAR(ShipDate) as ShipYear,
			MONTH(ShipDate) as ShipMonth,
			DateName(month, DateAdd(month, MONTH(ShipDate), -1 )) as ShipMonthName, 
			AVG(Freight) as AvgFreight,
			SUM(Freight) as SumFreight
		FROM Sales.SalesOrderHeader
		GROUP BY MONTH(ShipDate), YEAR(ShipDate)
		) as Subq

-- d. Add a yearly cumulative Sum, which means every January will start over. 

SELECT
	ShipYear,
	ShipMonth,
	ShipMonthName,
	Format(AvgFreight, 'C0') as AvgFreight,
	Format(SumFreight, 'C0') as SumFreight,
	Format(Sum(SumFreight) Over (Partition by ShipYear Order by ShipYear, ShipMonth),'C0') as RunningTotal
FROM (
		SELECT 
			YEAR(ShipDate) as ShipYear,
			MONTH(ShipDate) as ShipMonth,
			DateName(month, DateAdd(month, MONTH(ShipDate), -1 )) as ShipMonthName, 
			AVG(Freight) as AvgFreight,
			SUM(Freight) as SumFreight
		FROM Sales.SalesOrderHeader
		GROUP BY MONTH(ShipDate), YEAR(ShipDate)
		) as Subq
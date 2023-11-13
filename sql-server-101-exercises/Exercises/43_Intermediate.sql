/* Question 43: Intermediate

a. How many Sales people are meeting their YTD Quota? Use an Inner query (subquery) to show a single value meeting this criteria
b. How many Sales People have YTD sales greater than the average Sales Person YTD sales. Also use an Inner Query to
   show a single value of those meeting this criteria. */

-- a.
SELECT 
	COUNT(*) as CNT
FROM Sales.SalesPerson
WHERE SalesYTD >= SalesQuota

Select 
    Count(*) as CNT
From(
     Select * 
     From Sales.SalesPerson
     Where SalesYTD > SalesQuota) a

-- b.
SELECT 
	COUNT(*) as CNT 
FROM Sales.SalesPerson
WHERE SalesYTD > (Select 
					AVG(SalesYTD) as AverageSalesYTD
				  From Sales.SalesPerson)
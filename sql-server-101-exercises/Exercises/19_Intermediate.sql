/* Question 19 

We learned in Question 18 that the most recent SalesOrder transaction occurred on 2014-06-30 and the
First Sales Order transaction occurred on 2011-05-31. Does the SalesOrderHeader table show a similar
Order date for the first and Last Sale? Format as Date

*/

SELECT 
	CAST(MIN(OrderDate) as date) FirstDate,
	CAST(MAX(OrderDate) as date) LastDate
FROM Sales.SalesOrderHeader

-- Answer: Yes, the dates are the same.



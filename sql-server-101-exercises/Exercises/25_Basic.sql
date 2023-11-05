/* Question 25

In general Gross Revenue is calculated by taking the Amount of Sales/Revenue without removing 
the expenses to sell that item. Which also means that in general Net Revenue is the Amount of 
Sales/Revenue after the expenses have been subtracted.

Which product has the best margins? (Highest Net Revenue)*/

-- Product
SELECT 
	Name,
	FORMAT((ListPrice - StandardCost), 'C0') as NetMarginPerProduct
FROM Production.Product
ORDER BY (ListPrice - StandardCost) DESC

-- Sales
SELECT 
	ProductID,
	FORMAT(Sum(LineTotal), 'N2') as OverallNetRevenue
FROM Sales.SalesOrderDetail
--GROUP BY ProductID
GROUP BY ProductID
ORDER BY Sum(LineTotal) DESC

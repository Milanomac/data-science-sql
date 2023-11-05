/* Question 27

We learned in Question 26 that the 8 bicycles that fall under the 19 ProductModelID don't have a discontinued 
date. However, this model hasn't been ordered since  May 29, 2012. The most recent purchase (any item) was June 30, 2014. 
Which means this product either has been discounted and there isn't a discontinued date. Or the product is still 
being sold, but hasn't been purchased in 2 years. Which is it? */

SELECT
	p.Name as ProductName,
	so.Description,
	so.Type,
	CAST(soh.OrderDate as date) as OrderDate
FROM Production.Product as p
INNER JOIN Sales.SpecialOfferProduct as sop on sop.ProductID = p.ProductID
INNER JOIN Sales.SpecialOffer as so on so.SpecialOfferID = sop.SpecialOfferID
INNER JOIN Sales.SalesOrderDetail as sod on sod.ProductID = sop.ProductID
INNER JOIN Sales.SalesOrderHeader as soh on soh.SalesOrderID = sod.SalesOrderID
Where p.ProductModelID = 19 and so.Type = 'Discontinued Product'
ORDER BY soh.OrderDate DESC 

-- Product description tells it's been discontinued, however:

SELECT
	pp.Name,
	SUM(ppi.Quantity) as Inventory,
	Max(SellEndDate) as LastSell
FROM Production.Product as pp
INNER JOIN Production.ProductInventory as ppi on ppi.ProductID = pp.ProductID
WHERE ProductModelID = '19'
Group by pp.Name
ORDER BY Max(SellEndDate)

-- They are in the inventory as well.

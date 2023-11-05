/* Question 26

As we learned in Question 25, the "Mountain-100 Silver" and the "Mountain-100 Black" bicycles have 
the highest margins... meaning the ListPrice to StandardCost ratio is higher than any other product.

a. Within the Production.Product table find a identifier that groups the 8 "Mountain-100" bicycles (4 Silver and 4 Black).
b. How many special offers have been applied to these 8 bicycles? When did the special offer start? When did the 
   special offer end? What was the special offer?
c. Based on the most recent special offer start date is the product actually discontinued? Is the product still sold?
d. When was the last date the product was sold to an actual customer?*/

-- a.
SELECT * FROM Production.Product WHERE Name like '%Mountain-100%'
SELECT * FROM Production.Product WHERE ProductModelID = 19

-- b.
-- 2011-05-31, 2014-05-30, 13
SELECT
	CAST(MIN(so.StartDate) as date) as StartDate,
	CAST(MAX(so.EndDate) as date) as EndDate,
	COUNT(sop.SpecialOfferID) as SpecOffCount 
FROM Production.Product as p
INNER JOIN Sales.SpecialOfferProduct as sop on sop.ProductID = p.ProductID
INNER JOIN Sales.SpecialOffer as so on so.SpecialOfferID = sop.SpecialOfferID
Where ProductModelID = 19 and so.Description NOT LIKE 'No Discount'

SELECT
	so.Description,
	so.Type,
	CAST(so.StartDate as date) as StartDate,
	CAST(so.EndDate as date) as EndDate 
FROM Production.Product as p
INNER JOIN Sales.SpecialOfferProduct as sop on sop.ProductID = p.ProductID
INNER JOIN Sales.SpecialOffer as so on so.SpecialOfferID = sop.SpecialOfferID
Where p.ProductModelID = 19 and so.Description NOT LIKE 'No Discount'

-- c. Type shows it's discontinued
SELECT
	so.Description,
	so.Type,
	CAST(so.EndDate as date) as EndDate 
FROM Production.Product as p
INNER JOIN Sales.SpecialOfferProduct as sop on sop.ProductID = p.ProductID
INNER JOIN Sales.SpecialOffer as so on so.SpecialOfferID = sop.SpecialOfferID
Where p.ProductModelID = 19 and so.Type LIKE '%Discontinued%'
ORDER BY so.StartDate DESC

-- d. When was the last date the product was sold to an actual customer? 2012-05-29
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
Where p.ProductModelID = 19
ORDER BY soh.OrderDate DESC
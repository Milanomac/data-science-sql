/*

Question 16:

a. How many products are sold by AdventureWorks?
b. How many of these products are actively being sold by AdventureWorks?
c. How many of these active products are made in house vs. purchased?

*/

-- a.
SELECT 
	COUNT(DISTINCT ProductID) as SoldProductCount
FROM Production.Product
Where FinishedGoodsFlag = 1

--b. 
SELECT 
	COUNT(DISTINCT ProductID) as ActiveSoldProductCount
FROM Production.Product
WHERE SellEndDate is NULL AND FinishedGoodsFlag = 1

-- c. How many of these active products are made in house vs. purchased?
SELECT
	Count(*) as ProductCount,
	Count(Case When MakeFlag = 0 Then ProductID Else null End) as PurchasedProduct,
	Count(Case When MakeFlag = 1 Then ProductID Else null End) as MadeInHouse
FROM Production.Product
WHERE SellEndDate is NULL AND FinishedGoodsFlag = 1
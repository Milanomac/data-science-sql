/* Question 21:

AdventureWorks works with customers, employees and business partners all over the globe. 
The accounting department needs to be sure they are up-to-date on Country and State tax rates.

a. Pull a list of every country and state in the database.
b. Includes tax rates.
c. There are 181 rows when looking at countries and states, but once you add tax rates the
   number of rows increases to 184. Why is this?
d. Which location has the highest tax rate? */

-- a.
SELECT * FROM Sales.SalesTerritory
SELECT * FROM Person.StateProvince

SELECT 
	DISTINCT st.Name as CountryName,
	sp.Name as ProvinceName
FROM Person.StateProvince as sp
INNER JOIN Sales.SalesTerritory as st on st.TerritoryID = sp.TerritoryID

-- b.
SELECT * FROM Sales.SalesTaxRate
SELECT * FROM Person.StateProvince

SELECT
	st.Name as CountryName,
	sp.Name as ProvinceName,
	strate.TaxRate
FROM Person.StateProvince as sp
INNER JOIN Sales.SalesTerritory as st on st.TerritoryID = sp.TerritoryID
LEFT JOIN Sales.SalesTaxRate as strate on strate.StateProvinceID = sp.StateProvinceID

/* c. The number of rows increases to 184 because some provinces have more 
	  than one Tax Rate applied, i.e Alberta. This can be verified below in TaxName column. */
SELECT
	st.Name as CountryName,
	sp.Name as ProvinceName,
	strate.TaxRate,
	strate.Name as TaxName
FROM Person.StateProvince as sp
INNER JOIN Sales.SalesTerritory as st on st.TerritoryID = sp.TerritoryID
LEFT JOIN Sales.SalesTaxRate as strate on strate.StateProvinceID = sp.StateProvinceID

-- Or course answer: 
Select * from Sales.SalesTaxRate	
Where StateProvinceID in (
	Select 
		sp.StateProvinceID
	From Person.StateProvince sp
	Inner Join Person.CountryRegion cr on cr.CountryRegionCode = sp.CountryRegionCode
	Left Join Sales.SalesTaxRate tr on tr.StateProvinceID = sp.StateProvinceID
	Group by sp.StateProvinceID
	Having count(*) > 1)

-- d. Which location has the highest tax rate? Answer: FRANCE

SELECT
	st.Name as CountryName,
	sp.Name as ProvinceName,
	strate.TaxRate,
	strate.Name as TaxName
FROM Person.StateProvince as sp
INNER JOIN Sales.SalesTerritory as st on st.TerritoryID = sp.TerritoryID
LEFT JOIN Sales.SalesTaxRate as strate on strate.StateProvinceID = sp.StateProvinceID
ORDER BY TaxRate DESC
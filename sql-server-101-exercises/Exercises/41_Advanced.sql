/* Question 41

In this question we are going to build a report that will be used in Question 42 to update a null column in the SalesOrderHeader. 
The results in this question need to include one row per SalesOrderID (31,465 rows). Include the following columns:

a. SalesOrderID
b. Customer Name (include First and Last Names)
c. Person.PersonType (don't use the abbreviations, spell out each PersonType)
d. Sales Person Name (include First and Last Names). If a SalesOrderID doesn't have a Sales person then specify with 'No Sales Person'
e. OrderDate 
f. Amount of Product quantity purchased */

SELECT * FROM Person.Person

SELECT 
	soh.SalesOrderID as SalesOrderID,
	CONCAT(p.FirstName, ' ', p.LastName) as Name,
	CASE WHEN p.PersonType = 'IN' THEN 'Customer'
		WHEN p.PersonType = 'SP' THEN 'SalesPerson'
		WHEN p.PersonType ='SC' THEN 'StoreContact'
		WHEN p.PersonType ='EM' THEN 'Employee'
		WHEN p.PersonType ='VC' THEN 'VendorContact'
		WHEN p.PersonType ='GC' THEN 'GeneralContact' END AS PersonType,
	CASE WHEN CONCAT(per.FirstName, ' ', per.LastName) = '' THEN 'No Sales Person' 
		ELSE CONCAT(per.FirstName, ' ', per.LastName) END AS SalesPersonName,
	CAST(soh.OrderDate as date) as Date,
	Sum(OrderQTY) as ProductQty
FROM Sales.SalesOrderHeader as soh
INNER JOIN Sales.SalesOrderDetail as sod on soh.SalesOrderID = sod.SalesOrderID
INNER JOIN Sales.Customer as c on c.CustomerID = soh.CustomerID
INNER JOIN Person.Person as p on p.BusinessEntityID = c.PersonID
LEFT JOIN Person.Person as per on per.BusinessEntityID = soh.SalesPersonID
Group by 
    soh.SalesOrderID,
	CONCAT(p.FirstName,' ',p.LastName),
    p.PersonType,
    OrderDate,
    CONCAT(per.FirstName,' ',per.LastName)
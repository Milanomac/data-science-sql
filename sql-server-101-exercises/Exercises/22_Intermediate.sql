/* Question 22

The Marketing Department has never ran ads in the United Kingdom and would like you pull 
a list of every individual customer (PersonType = IN) by country.

a. How many individual (retail) customers exist in the person table?
b. Show this breakdown by country
c. What percent of total customers reside in each country. 
   For Example,  if there are 1000 total customers and 200 
   live in the United States then 20% of the customers live in the United States.  */

-- a.
SELECT
	COUNT(DISTINCT BusinessEntityID) as IndividualCustomerCount
FROM Person.Person
WHERE PersonType = 'IN'

-- b. 
SELECT * FROM Person.Person 
WHERE PersonType = 'IN'

SELECT
	cr.Name as CountryName,
	COUNT(p.BusinessEntityID) as BusinessEntityCount
FROM Person.Person as p
INNER JOIN Person.BusinessEntityAddress as bea on bea.BusinessEntityID = p.BusinessEntityID
INNER JOIN Person.Address as a on a.AddressID = bea.AddressID
INNER JOIN Person.StateProvince as sp on sp.StateProvinceID = a.StateProvinceID
INNER JOIN Person.CountryRegion cr on cr.CountryRegionCode = sp.CountryRegionCode
WHERE p.PersonType = 'IN'
GROUP BY cr.Name
ORDER BY COUNT(p.BusinessEntityID) DESC

/*
c. What percent of total customers reside in each country. 
   For Example,  if there are 1000 total customers and 200 
   live in the United States then 20% of the customers live in the United States.*/

SELECT
	cr.Name as CountryName,
	COUNT(p.BusinessEntityID) as BusinessEntityCount,
	FORMAT(COUNT(p.BusinessEntityID) * 1.0 / (SELECT COUNT(BusinessEntityID) FROM Person.Person), 'P') as PercentageBusiness
FROM Person.Person as p
INNER JOIN Person.BusinessEntityAddress as bea on bea.BusinessEntityID = p.BusinessEntityID
INNER JOIN Person.Address as a on a.AddressID = bea.AddressID
INNER JOIN Person.StateProvince as sp on sp.StateProvinceID = a.StateProvinceID
INNER JOIN Person.CountryRegion cr on cr.CountryRegionCode = sp.CountryRegionCode
WHERE p.PersonType = 'IN'
GROUP BY cr.Name
ORDER BY COUNT(p.BusinessEntityID) DESC

-- course answer:
Select 
	cr.Name as Country
	,Format(count(Distinct p.BusinessEntityID),'N0') as CNT
	,Format(Cast(count(Distinct p.BusinessEntityID) as float)/18484,'P') as 'WrongWay'
	,Format(Cast(count(Distinct p.BusinessEntityID) as float)
		/(Select count(BusinessEntityID) 
		  from Person.Person 
		  Where PersonType = 'IN'),'P') as '%ofTotal'
from Person.Person p
	Inner Join Person.BusinessEntityAddress bea on bea.BusinessEntityID = p.BusinessEntityID
	Inner Join Person.Address a on a.AddressID = bea.AddressID
	Inner Join Person.StateProvince sp on sp.StateProvinceID = a.StateProvinceID
	Inner Join Person.CountryRegion cr on cr.CountryRegionCode = sp.CountryRegionCode
Where PersonType = 'IN'
Group by cr.Name
Order by 2 desc
/*

Question 12:
a. What is the name of the CEO? Concatenate first and last name.
b. When did this person start working for AdventureWorks
c. Who reports to the CEO? Includes their names and title

*/

-- a.
SELECT * FROM HumanResources.Employee -- to check ID of the CEO

SELECT 
	CONCAT(FirstName, ' ', MiddleName, '. ', LastName) as CeoFullName
FROM Person.Person
WHERE BusinessEntityID = 1

-- b.
SELECT HireDate 
FROM HumanResources.Employee
WHERE BusinessEntityID = 1

-- c.
SELECT 
	CONCAT(FirstName, ' ', MiddleName, '. ', LastName) as ReportsFullName
FROM Person.Person p
INNER JOIN HumanResources.Employee e on e.BusinessEntityID = p.BusinessEntityID
WHERE OrganizationLevel = 1
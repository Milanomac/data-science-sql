/*

Question 11:
a. How many employees exist in the Database?
b. How many of these employees are active employees?
c. How many Job Titles equal the 'SP' Person type?
d. How many of these employees are sales people?

*/

-- a. 296 employees exist in the database
SELECT COUNT(*)
FROM HumanResources.EmployeeDepartmentHistory

-- b. 290 active employees
SELECT COUNT(*)
FROM HumanResources.Employee

-- c. 4 distinct job titles
SELECT 
	DISTINCT e.JobTitle,
	p.PersonType
FROM HumanResources.Employee as e
INNER JOIN Person.Person as p on p.BusinessEntityID = e.BusinessEntityID
WHERE p.PersonType = 'SP'

-- d. 17 employees are sales people

SELECT 
	e.JobTitle,
	COUNT(p.PersonType) as PersonTypeCount
FROM HumanResources.Employee as e
INNER JOIN Person.Person as p on p.BusinessEntityID = e.BusinessEntityID
WHERE p.PersonType = 'SP'
GROUP BY e.JobTitle


SELECT 
	e.JobTitle,
	p.PersonType
FROM HumanResources.Employee as e
INNER JOIN Person.Person as p on p.BusinessEntityID = e.BusinessEntityID
WHERE p.PersonType = 'SP'
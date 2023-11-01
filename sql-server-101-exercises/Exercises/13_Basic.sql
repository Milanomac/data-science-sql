/* 

Question 13
a. What is the job title for John Evans
b. What department does John Evans work in?

*/

-- a.
SELECT 
	e.JobTitle
FROM Person.Person p
INNER JOIN HumanResources.Employee e on e.BusinessEntityID = p.BusinessEntityID
WHERE FirstName = 'John' and LastName = 'Evans'

-- b.

SELECT
	dep.Name as DepName
FROM Person.Person p
INNER JOIN HumanResources.Employee e on e.BusinessEntityID = p.BusinessEntityID
INNER JOIN HumanResources.EmployeeDepartmentHistory edh on edh.BusinessEntityID = p.BusinessEntityID
INNER JOIN HumanResources.Department as dep on dep.DepartmentID = edh.DepartmentID
WHERE FirstName = 'John' and LastName = 'Evans'
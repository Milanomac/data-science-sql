/* Question 34:

a. Using the RANK function rank the employees in the Employee table by the hiredate. Label the column as 'Seniority'
b. Assuming Today is March 3, 2014, add 3 columns for the number of days, months, and years the employee has been employed. */

-- RANK ( ) OVER ( [ partition_by_clause ] order_by_clause )  

-- a. 
SELECT * FROM HumanResources.Employee

SELECT
	BusinessEntityID,
	LoginID,
	JobTitle,
	HireDate,
	OrganizationLevel,
	RANK() OVER (PARTITION BY OrganizationLevel ORDER BY HireDate ASC) as Seniority -- the lower the number the more senior
FROM HumanResources.Employee
ORDER BY OrganizationLevel ASC

-- b. Assuming Today is March 3, 2014, add 3 columns for the number of days, months, and years the employee has been employed.

SELECT
	BusinessEntityID,
	LoginID,
	JobTitle,
	OrganizationLevel,
	RANK() OVER (ORDER BY HireDate ASC) as Seniority,
	HireDate,
	DATEDIFF(YEAR, HireDate, '2014-03-03') as YearsHired,
	DATEDIFF(MONTH, HireDate, '2014-03-03') as MonthsHired,
	DATEDIFF(DAY, HireDate, '2014-03-03') as DaysHired
FROM HumanResources.Employee
ORDER BY HireDate ASC	
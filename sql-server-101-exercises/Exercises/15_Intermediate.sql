/*

Question 15:
Assume today is August 15, 2014.

a. Calculate the age for every current employee. What is the age of the oldest employee?
b. What is the average age by Organization level? Show answer with a single decimal
c. Use the ceiling function to round up
d. Use the floor function to round down

*/

-- a.

SELECT 
    BirthDate,
    '2014-08-15' as TodayDate,
    DATEDIFF(YEAR, BirthDate, '2014-08-15') as Age
FROM HumanResources.Employee;

-- b. What is the average age by Organization level? Show answer with a single decimal

SELECT 
	OrganizationLevel,
    AVG(DATEDIFF(YEAR, BirthDate, '2014-08-15')) as Age
FROM HumanResources.Employee
GROUP BY OrganizationLevel

-- c. Use the ceiling function to round up

Select 
	OrganizationLevel
	,Avg(cast(DATEDIFF(Year,BirthDate,'2014-08-15') as decimal)) as Age
	,Ceiling(Avg(cast(DATEDIFF(Year,BirthDate,'2014-08-15') as decimal))) as Age
From HumanResources.Employee
Group by OrganizationLevel
Order by 2 desc

-- d. Use the floor function to round down
Select 
	OrganizationLevel
	,Format(Avg(cast(DATEDIFF(Year,BirthDate,'2014-08-15') as decimal)),'N1') as Age
	,Ceiling(Avg(cast(DATEDIFF(Year,BirthDate,'2014-08-15') as decimal))) as Age
	,Floor(Avg(cast(DATEDIFF(Year,BirthDate,'2014-08-15') as decimal))) as Age
From HumanResources.Employee
Group by OrganizationLevel
Order by 2 desc
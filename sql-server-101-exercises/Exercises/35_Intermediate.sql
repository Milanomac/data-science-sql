/* Question 35

Complete question 34 before completing this question.
In Question 34 we add 4 columns to the Employee table - Seniority, DaysEmployed, MonthsEmployed, and YearsEmployed.

Here is the script I wrote as my answer for question 34:

Select 
    Rank() Over (Order by Hiredate asc) as 'Seniority'
    ,DATEDIFF(Day,HireDate,'2014-03-03') as 'DaysEmployed'
    ,DATEDIFF(Month,HireDate,'2014-03-03') as 'MonthsEmployed'
    ,DATEDIFF(Year,HireDate,'2014-03-03') as 'YearsEmployed'
    ,* 
From HumanResources.Employee

a. Using a Select Into Statement put this table into a Temporary Table. Name the table '#Temp1' */

Select
    Rank() Over (Order by Hiredate asc) as 'Seniority'
    ,DATEDIFF(Day,HireDate,'2014-03-03') as 'DaysEmployed'
    ,DATEDIFF(Month,HireDate,'2014-03-03') as 'MonthsEmployed'
    ,DATEDIFF(Year,HireDate,'2014-03-03') as 'YearsEmployed'
    ,* 
INTO AdventureWorks2019.dbo.#Temp1
From HumanResources.Employee 

-- b. Run the statement below:

Select * 
From #Temp1
Where BusinessEntityID in ('288','286')

/*Notice that these two Employees have worked for AdventureWorks for 10 months; however, the YearsEmployed says "1." 
The DateDiff Function in the statement above does simple math:(2014 - 2013 = 1). Update the YearsEmployed
to "0" for these two Employees.*/
    Select * 
    From #Temp1
    Where BusinessEntityID in ('288','286')

UPDATE #Temp1
Set YearsEmployed = '0'
Where BusinessEntityID in ('288','286')

Select * From #Temp1 Where BusinessEntityID in ('288','286')

-- c. Using the Temp table, how many employees have worked for AdventureWorks over 5 years and 6 months?*/
Select 
	COUNT(*) as EmployedOver66Months
From #Temp1
Where MonthsEmployed > 66

/* d. Create a YearsEmployed Grouping like below:
    Employed Less Than 1 Year
	Employed 1-3 Years
	Employed 4-6
	Employed Over 6 Years
Show a count of Employees in each group */
Select 
	CASE WHEN MonthsEmployed < 12 THEN '1year' 
		 WHEN MonthsEmployed BETWEEN 12 AND 36 THEN '1to3years'
		 WHEN MonthsEmployed BETWEEN 36 AND 60 THEN '3to6years'
		 WHEN MonthsEmployed > 60 THEN 'over6years' END AS YearsEmployed,
	COUNT(*) as CountGroup
From #Temp1
GROUP BY CASE WHEN MonthsEmployed < 12 THEN '1year' 
			  WHEN MonthsEmployed BETWEEN 12 AND 36 THEN '1to3years'
			  WHEN MonthsEmployed BETWEEN 36 AND 60 THEN '3to6years'
			  WHEN MonthsEmployed > 60 THEN 'over6years' END
ORDER BY CountGroup DESC

/*e. Show the average VacationHours and SickLeaveHours by the YearsEmployed Group. Which Group has the highest
     average Vacation and SickLeave Hours? */

-- Group over 6 years has the highest acerage vacation hours and Average Sick hours numbers
SELECT * FROM #Temp1

Select 
	CASE WHEN MonthsEmployed < 12 THEN '1year' 
		 WHEN MonthsEmployed BETWEEN 12 AND 36 THEN '1to3years'
		 WHEN MonthsEmployed BETWEEN 36 AND 60 THEN '3to6years'
		 WHEN MonthsEmployed > 60 THEN 'over6years' END AS YearsEmployed,
	COUNT(*) as CountGroup,
	AVG(VacationHours) as AverageVacation,
	AVG(SickLeaveHours) as AverageSick
From #Temp1
GROUP BY CASE WHEN MonthsEmployed < 12 THEN '1year' 
			  WHEN MonthsEmployed BETWEEN 12 AND 36 THEN '1to3years'
			  WHEN MonthsEmployed BETWEEN 36 AND 60 THEN '3to6years'
			  WHEN MonthsEmployed > 60 THEN 'over6years' END
ORDER BY AverageSick DESC
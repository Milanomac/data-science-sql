/* Question 39

In Question 38 we did some simple analysis on Freight costs by year. However, the TotalFreight value could
be skewed by incomplete years. Take the script written in Question 38 (see below) and answer the following questions.

    Select 
    	ShipYear
    	,Format(TotalFreight,'C0') as TotalFreight
    	,Format(AvgFreight,'C0') as AvgFreight
    	,Format(Sum(TotalFreight) Over (Order by ShipYear),'C0') as RunningTotal
    From(
    	Select 
    		Year(ShipDate) as ShipYear
    		,Sum(Freight) as TotalFreight
    		,Avg(Freight) as AvgFreight 
    	From Sales.SalesOrderHeader
    	Group by 
    		Year(ShipDate)) as a

a. How many months were completed in each Year. Obviously a full year has 12 months, but some of these years
   could be partial. Leave all of the columns, just add the count of completed months in each Year.
b. Calculate the average Total Freight by completed month */

--a. & b.
Select 
   	ShipYear,
	MonthCount,
   	Format(TotalFreight,'C0') as TotalFreight,
    Format(AvgFreight,'C0') as AvgFreight,
   	Format(Sum(TotalFreight) Over (Order by ShipYear),'C0') as RunningTotal,
	FORMAT((TotalFreight / MonthCount), 'C0') as TotFreightbyMonth
From(
   	Select 
   		Year(ShipDate) as ShipYear,
		COUNT(DISTINCT Month(ShipDate)) as MonthCount,
   		Sum(Freight) as TotalFreight,
   		Avg(Freight) as AvgFreight 
   	From Sales.SalesOrderHeader
   	GROUP BY YEAR(ShipDate)
	) as Subq

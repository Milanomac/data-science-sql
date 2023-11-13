/* Question 45

In Question 44 we created a stored Procedure called "Sales_Report_YTD." In this question we are going to create the same 
stored procedure with a single parameter. 

In Question 44 when we execute the stored procedure it shows all the sales information for each BusinessEntity. Lets assume this
information is highly sensitive and each sales person should only know their unique BusinessEntityID. Add a parameter that would
require a user to input their BusinessEntityID to view their own personal sale information.

Question 44 results:

    --a. 
    Create Procedure Sales_Report_YTD
        as(
            Select 
    	    BusinessEntityID
    	    ,Format(CommissionPct,'P1') as CommissionPct
    	    ,Format(SalesYTD,'C0') as SalesYTD
    	    ,Commission = Format((CommissionPct * SalesYTD),'C0') 
    	    ,Format(Bonus,'C0') as Bonus
            From Sales.SalesPerson)
    --b. 
    Exec Sales_Report_YTD

a. Create the Stored Procedure with the BusinessEntityID as the single parameter.
b. Execute the Stored Procedure for BussinessEntityID 279
c. Delete the Stored Procedure */

--a.
Create Procedure Sales_Report_YTD
	@BusinessEntityID int
as(
	SELECT 
		BusinessEntityID,
		FORMAT(CommissionPct, 'P1') as CommissionPct,
		FORMAT(SalesYTD, 'C0') as SalesYTD,
		FORMAT((CommissionPct * SalesYTD), 'C0') as Commission,
		FORMAT(Bonus, 'C0') as Bonus
	FROM Sales.SalesPerson
	WHERE BusinessEntityID = @BusinessEntityID
	)

--b.
EXEC Sales_Report_YTD @BusinessEntityID = 279

--c.
DROP PROCEDURE Sales_Report_YTD
/* Question 44

a. Create a stored procedure called "Sales_Report_YTD" without an output parameter that will show the sales people the following information:
    BusinessEntityID
    CommissionPct
    SalesYTD
    Commission
    Bonus
b. Execute the Stored Procedure
c. Delete the Stored Procedure */

-- a.
CREATE PROCEDURE Sales_Report_YTD 
	AS (
		SELECT 
			BusinessEntityID,
			FORMAT(CommissionPct, 'P1') as CommissionPct,
			FORMAT(SalesYTD, 'C0') as SalesYTD,
			FORMAT((CommissionPct * SalesYTD), 'C0') as Commission,
			FORMAT(Bonus, 'C0') as Bonus
		FROM Sales.SalesPerson
		)

-- b.
EXEC Sales_Report_YTD

-- c.
Drop Procedure Sales_Report_YTD

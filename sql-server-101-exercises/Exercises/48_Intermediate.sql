/* Question 48

Before attempting this question complete questions 46 and 47.
a. Write an Alter Statement that will add a column to the Purchasing.Vendor. Name the Column - CreditRatingDesc" (varchar(100) data type).
b. Using the credit rating and a case statement (Question 46 part b)  or a Choose function (Question 46 part c) update "CreditRatingDesc".
    1 = Superior
    2 = Excellent
    3 = Above Average
    4 = Average
    5 = Below Average
c. Drop the "CreditRatingDesc" Column.*/

/*Hint:
a.

    Alter Table TableName
    Add ColumnName datatype
b.
    Update TableName
    Set ColumnName = value
    From TableName
c.
    Alter Table TableName
    Drop Column ColumnName*/

--a.
	Alter Table Purchasing.Vendor
	Add CreditRatingDesc varchar(100)

SELECT * FROM Purchasing.Vendor

--b. 
 Update Purchasing.Vendor
 Set CreditRatingDesc = a.CreditRating
 From Purchasing.Vendor as v 
	INNER JOIN (
			SELECT
				BusinessEntityID,
				CHOOSE(CreditRating, 'Superior','Excellent','Above Average','Average','Below Average') as CreditRating
			FROM Purchasing.Vendor) as a
		ON v.BusinessEntityID = a.BusinessEntityID

SELECT * FROM Purchasing.Vendor

-- c.
Alter Table Purchasing.Vendor
Drop Column CreditRatingDesc
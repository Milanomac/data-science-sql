/* Question 46

In this question we are going to be working with Purchasing.Vendor.

a. Show each credit rating by a count of vendors */
SELECT 
	CreditRating,
	COUNT(*) as CNT
FROM Purchasing.Vendor
GROUP BY CreditRating

/*b. Use a case statement to specify each rating by a count of vendors:
    1 = Superior
    2 = Excellent
    3 = Above Average
    4 = Average
    5 = Below Average*/
SELECT 
	CreditRating,
	CASE WHEN CreditRating = 1 THEN 'Superior'
		 WHEN CreditRating = 2 THEN 'Excellent'
		 WHEN CreditRating = 3 THEN 'Above Average'
		 WHEN CreditRating = 4 THEN 'Average'
		 WHEN CreditRating = 5 THEN 'Below Average' END AS CreditRatingWord,
	COUNT(*) as CNT
FROM Purchasing.Vendor
GROUP BY CreditRating

/*c. Using the Choose Function accomplish the same results as part b (Don't use case statement).
    1 = Superior
    2 = Excellent
    3 = Above Average
    4 = Average
    5 = Below Average*/

SELECT 
	CreditRating,
	CHOOSE(CreditRating, 'Superior','Excellent','Above Average','Average','Below Average') as CreditRatingWord,
	COUNT(*) as CNT
FROM Purchasing.Vendor
GROUP BY CreditRating

/*d. Using a case statement show the PreferredVendorStatus by a count of Vendors. (This might seem redundant, but This
     exercise will help you learn when to use a case statement and when to use the choose function).
    0 = Not Preferred
    1 = Preferred*/

SELECT
	CASE WHEN PreferredVendorStatus = 1 THEN 'Preferred'
		 ELSE 'Not Preferred' END AS PreferredVenStat,
	COUNT(*) as CNT
FROM Purchasing.Vendor
GROUP BY PreferredVendorStatus

/*e. Using the Choose Function accomplish the same results as part d (Don't use case statement).  Why doesn't the Choose Function give the same results as part d? Which is correct?
    0 = Not Preferred
    1 = Preferred */

SELECT
	CHOOSE(PreferredVendorStatus, 'Not Preferred', 'Preferred') as PreferredVendorStatus,
	COUNT(*) as CNT
FROM Purchasing.Vendor
GROUP BY PreferredVendorStatus

-- CASE statement here is the correct one because it implicitly renames the encoded values to text.
-- CHOOSE does not coverted Preferred because it will not recognize encoded 0s as a value. Can't start with 0 to be counted
/* Question 47

Complete Question 46 before attempting this question.
In Question 46 we wrote two scripts that gave the same output/results. One script we used a case statement the other statement 
we used a choose function. In this question we are going to write very similar scripts and it might seem redundant to answer these 
questions but this will help you learn when to use Case, Choose, and IIf. In question 46 we learned that the credit rating has a 
description (i.e. 1 = Superior). However, in this question we are going to assume that AdventureWorks only deems a vendor as "Approved" 
if they have a "Superior" credit rating. If the vendor has any other rating then they are "Not Approved". Credit Rating Grouping:

    1 = Approved
    2 = Not Approved
    3 = Not Approved
    4 = Not Approved
    5 = Not Approved

a. Using a case statement show a count of vendors by "Approved" vs. "Not Approved".
b. Using the Choose function show a count of vendors by "Approved" vs. "Not Approved".
c. Using the IIF function show a count of vendors by "Approved" vs. "Not Approved". */

--a. 
SELECT 
	CASE WHEN CreditRating = 1 THEN 'Approved'
		 ELSE 'Not Approved' END AS CreditRatingWord,
	COUNT(*) as CNT
FROM Purchasing.Vendor
GROUP BY CASE WHEN CreditRating = 1 THEN 'Approved'
		 ELSE 'Not Approved' END

-- b. 
SELECT
	CreditRating,
	COUNT(*) AS CNT
FROM (
		SELECT 
			CHOOSE(CreditRating, 'Approved', 'Not Approved', 'Not Approved', 'Not Approved', 'Not Approved') AS CreditRating
		FROM Purchasing.Vendor
	 ) AS SUB
GROUP BY CreditRating

-- c. Using the IIF function show a count of vendors by "Approved" vs. "Not Approved".
SELECT 
	IIF(CreditRating = 1, 'Approved', 'Not Approved') as CreditRating,
	COUNT(*) as CNT
FROM Purchasing.Vendor
GROUP BY CASE WHEN CreditRating = 1 THEN 'Approved'
		 ELSE 'Not Approved' END

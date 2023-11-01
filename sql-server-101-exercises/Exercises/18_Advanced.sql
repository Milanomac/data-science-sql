/*

Question 18
The AdventureWorks Cyclery database includes historical and present transactions.
a. In the TransactionHistory and TransactionHistoryArchive tables a "W","S", and "P" are used as Transaction types.    
   What do these abbreviations mean?
b. Union TransactionHistory and TransactionHistoryArchive
c. Find the First and Last TransactionDate in the TransactionHistory and TransactionHistoryArchive tables. 
   Use the union written in part b. The current data type for TransactionDate is datetime. Convert or Cast the data type to date.
d. Find the First and Last Date for each transaction type. Use a case statement to specify the transaction types. 

*/

-- a. From documentation PDF: W = WorkOrder, S = SalesOrder, P = PurchaseOrder
-- b. Union TransactionHistory and TransactionHistoryArchive

SELECT * FROM Production.TransactionHistory
UNION 
SELECT * FROM Production.TransactionHistoryArchive

-- c. Find the First and Last TransactionDate in the TransactionHistory and TransactionHistoryArchive tables. 
--    Use the union written in part b. The current data type for TransactionDate is datetime. Convert or Cast the data type to date.

/* my answer (2 sets of results)
SELECT
	CAST(MIN(TransactionDate) as date) as FirstDate,
	CAST(MAX(TransactionDate) as date) as LastDate
FROM Production.TransactionHistory
UNION 
SELECT
	CAST(MIN(TransactionDate) as date) as FirstDate,
	CAST(MAX(TransactionDate) as date) as LastDate
FROM Production.TransactionHistoryArchive */

SELECT
	CAST(MIN(TransactionDate) as date) as FirstDate,
	CAST(MAX(TransactionDate) as date) as LastDate
From(
Select * from Production.TransactionHistoryArchive
Union
Select * from Production.TransactionHistory) a


-- d. Find the First and Last Date for each transaction type. Use a case statement to specify the transaction types.

SELECT
	CAST(MIN(TransactionDate) as date) as FirstDate,
	CAST(MAX(TransactionDate) as date) as LastDate,
	CASE WHEN TransactionType = 'P' THEN 'PurchaseOrder'
		 WHEN TransactionType = 'W' THEN 'WorkOrder'
		 WHEN TransactionType = 'S' THEN 'SalesOrder' END AS TransactionType
FROM (
	SELECT * FROM Production.TransactionHistory 
		UNION
	SELECT * FROM Production.TransactionHistoryArchive) as SUBQUERY
GROUP BY CASE WHEN TransactionType = 'P' THEN 'PurchaseOrder'
		 WHEN TransactionType = 'W' THEN 'WorkOrder'
		 WHEN TransactionType = 'S' THEN 'SalesOrder' END
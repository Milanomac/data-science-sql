/* 

Question 14
a. Which Purchasing vendors have the highest credit rating?
b. Using a case statement replace the 1 and 0 in Vendor.PreferredVendorStatus to "Preferred" vs "Not Preferred."   
How many vendors are considered Preferred?
c. For Active Vendors only, do Preferred vendors have a High or lower average credit rating?
d. How many vendors are active and Not Preferred?

*/

-- a.
SELECT Name, CreditRating 
FROM Purchasing.Vendor
ORDER BY CreditRating DESC

-- b.
SELECT
	BusinessEntityID,
	AccountNumber,
	Name,
	CreditRating,
	CASE WHEN PreferredVendorStatus = 1 THEN 'Preferred' ELSE 'Not Preferred' END AS PreferredVendorStatus,
	ActiveFlag,
	PurchasingWebServiceURL,
	ModifiedDate
FROM Purchasing.Vendor
AS Subquery

SELECT COUNT(*) as PreferredVendorCount
FROM Purchasing.Vendor
WHERE PreferredVendorStatus = 1

-- c. For Active Vendors only, do Preferred vendors have a High or lower average credit rating?

SELECT 
	CASE WHEN PreferredVendorStatus = 1 THEN 'Preferred' ELSE 'Not Preferred' END AS PreferredVendorStatus,
	Avg(Cast(CreditRating as decimal)) as AverageRating -- Changing string to integer
FROM Purchasing.Vendor
WHERE ActiveFlag = 1
GROUP BY PreferredVendorStatus

-- d. How many vendors are active and Not Preferred?

SELECT
	COUNT(*) AS ActiveNPCount
FROM Purchasing.Vendor
WHERE ActiveFlag = 1 and PreferredVendorStatus = 0

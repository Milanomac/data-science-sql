/* Question 49

This Question is precursor to Question 50.
a. Using the INFORMATION_SCHEMA.COLUMNS table find the data type for Vendor.Name
b. Does this data type have an alias? In other words, is it a user defined data type? If so, what is it?
c. Using the INFORMATION_SCHEMA.COLUMNS table show a count of data types by user defined data types. */

SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Vendor' AND COLUMN_NAME = 'Name'

-- nvarchar

-- b.
Select 
	DOMAIN_SCHEMA
	,DOMAIN_NAME
From INFORMATION_SCHEMA.COLUMNS
Where TABLE_NAME = 'Vendor'
	and COLUMN_NAME = 'Name'

-- c.
SELECT COUNT(*) AS CNT,DOMAIN_NAME FROM INFORMATION_SCHEMA.COLUMNS GROUP BY DOMAIN_NAME

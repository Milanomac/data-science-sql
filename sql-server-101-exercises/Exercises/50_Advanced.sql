/* Question 50

Answer Question 49 before attempting this question.
We question 49 we learned there are 6 user defined data types in the AdventureWorks database. In this question we are going
to create a new user defined data type.

a. Using INFORMATION_SCHEMA.COLUMNS write a query that will show every column that has the columnName = Status.  
   What is the data type for these columns?
b. Create a new User defined data type named 'Status." The data type will be tinyint and notice that in the 
   INFORMATION_SCHEMA.COLUMNS table the IS_NULLABLE column says 'No.' This means when you're creating the user
   defined data type be sure to specify Not Null.
c. Write an Alter statement to change the data type on PurchaseOrderHeader.Status from tinyint to the new User Defined 
   data type, status. Did the Domain Name in INFORMATION_SCHEMA.COLUMNS change?
d. Try to Drop the Status User Defined Data Type. You will get an error. Why?
e. Write an Alter Statement to change the data type on PurchaseOrderHeader.Status back to the tinyint
   (don't forget the NOT NULL).
f. Now Drop the Status User Defined Data Type */

-- a.
SELECT 
	TABLE_SCHEMA,
	TABLE_NAME,
	COLUMN_NAME,
	DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'Status'

-- b. 
CREATE Type [Status]
FROM tinyint NOT NULL

-- c.
Alter Table Purchasing.PurchaseOrderHeader
Alter Column [Status] Status

SELECT 
	TABLE_SCHEMA,
	TABLE_NAME,
	COLUMN_NAME,
	DATA_TYPE,
	DOMAIN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'Status'

-- Yes. DOMAIN_NAME changed to 'Status'

-- d.
DROP Type Status
-- Cannot drop type 'Status' because it is being referenced by object 'PurchaseOrderHeader'. There may be other objects that reference this type.

-- e. Write an Alter Statement to change the data type on PurchaseOrderHeader.Status back to the tinyint (don't forget the NOT NULL).
Alter Table Purchasing.PurchaseOrderHeader
Alter Column [Status] tinyint NOT NULL

SELECT 
	TABLE_SCHEMA,
	TABLE_NAME,
	COLUMN_NAME,
	DATA_TYPE,
	DOMAIN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'Status'

-- f. It is not referrenced now, so we can drop it.
Drop Type Status
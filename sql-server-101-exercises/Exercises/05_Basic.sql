/*  a. In this question we are going to put the script written in question 4 into a table. To keep the AdventureWorks 
	database clean create a new database called "Edited_AdventureWorks" (if you haven't already)
*/

CREATE Database Edited_AdventureWorks

/* 
	b. Using a Select Into put the script in question 4 into a table named "Table_Relationships" be sure to put this  
	table in the Edited_AdventureWorks database. Here is the script from question 4:

*/

USE AdventureWorks2019

	SELECT
		O.name as ForeignKeyName, -- FKN is pulled from O because the name in O table already contains all we need
		S1.name as SchemaName,
		T1.name as TableName,
		C1.name as ColumnName,
		S2.name as ReferencedSchema,
		T2.name as ReferencedTable,
		C2.name as ReferencedColumn
	INTO Edited_AdventureWorks.dbo.Table_Relationships
	FROM sys.foreign_key_columns FKC
		INNER JOIN AdventureWorks2019.sys.objects O ON O.object_id = FKC.constraint_object_id -- NOTE: We have FK and PK, but the FK's ID is called 'constraint'
		INNER JOIN AdventureWorks2019.sys.tables T1 ON T1.object_id = FKC.parent_object_id -- T1: parent
		INNER JOIN AdventureWorks2019.sys.tables T2 ON T2.object_id = FKC.referenced_object_id --T2: referenced
		INNER JOIN AdventureWorks2019.sys.columns C1 ON C1.column_id = parent_column_id AND C1.object_id = T1.object_id -- parent
		INNER JOIN AdventureWorks2019.sys.columns C2 ON C2.column_id = referenced_column_id AND C2.object_id = T2.object_id -- referenced
		INNER JOIN AdventureWorks2019.sys.schemas S1 ON T1.schema_id = S1.schema_id -- parent_object_id
		INNER JOIN AdventureWorks2019.sys.schemas S2 ON T2.schema_id = S2.schema_id -- referenced_object_id

USE Edited_AdventureWorks
SELECT * FROM Table_Relationships

/* 
d. In Question 1 we learned that the AdventureWorks database has 90 foreign key constraints; however, Table_Relationships has 91
rows/relationships. Find the foreign key that has been used twice. What does this mean?
*/

--SELECT ForeignKeyName, COUNT(*) AS count
--FROM Table_Relationships
--GROUP BY ForeignKeyName
--HAVING COUNT(*) > 1

SELECT ForeignKeyName, COUNT(*) AS count
FROM Table_Relationships
GROUP BY ForeignKeyName
ORDER BY count DESC;

/* Table Sales.SalesOrderDetail and Sales.SpecialOfferProduct is



e. How many Distinct Foreign Keys include BusinessEntityID as a column or referenced column? 
*/

SELECT COUNT(*)
FROM Edited_AdventureWorks.dbo.Table_Relationships
WHERE ColumnName = 'BusinessEntityID' OR ReferencedColumn = 'BusinessEntityID'

/* 
There are 25 instances where FKs include BusinessEntityID as a column or referenced column
However, not everyting ColumnName BusinessEntityID is linked back to ReferencedColumn ColumnName BusinessEntityID.

Running the query below you can look at row 15 for example. PersonID links to BusinessEntityID
*/

SELECT *
FROM Edited_AdventureWorks.dbo.Table_Relationships
WHERE ColumnName = 'BusinessEntityID' OR ReferencedColumn = 'BusinessEntityID'
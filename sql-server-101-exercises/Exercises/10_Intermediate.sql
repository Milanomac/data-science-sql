/* 

Question 10

One of the most convenient things about the AdventureWorks database is the column "value" (definitions) found in table below.

Select * From sys.extended_properties

a. Write a script that will give you the TableName, ColumnName and each value (definition) where class = 1

b. Find the value (definition) for every Column in the Person table

Hint:
	-object_id = major_id and column_id = minor_id
	-sys.column will need to be joined on both major_id and minor_id

*/

-- a. 

SELECT * from sys.tables

SELECT * from sys.extended_properties

Select
	t.name AS TableName, 
	c.name AS ColumnName,
	ex.value
From sys.extended_properties as ex
INNER JOIN sys.tables t on t.object_id = ex.major_id
INNER JOIN sys.columns c on c.column_id = ex.minor_id AND c.object_id = ex.major_id
WHERE class = 1

-- b.

Select
	t.name AS TableName, 
	c.name AS ColumnName,
	ex.value
From sys.extended_properties as ex
INNER JOIN sys.tables t on t.object_id = ex.major_id
INNER JOIN sys.columns c on c.column_id = ex.minor_id AND c.object_id = ex.major_id
WHERE class = 1 and t.name = 'Person'
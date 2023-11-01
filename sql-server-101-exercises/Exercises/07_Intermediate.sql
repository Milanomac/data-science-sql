/* 
Exercise 7

a. Write a script that you can use to find every column in the database that includes "rate" in the column name.

b. Write a script that you can use to find every table in the database that includes "History" in the table name. 
*/

--a 
Select 
	t.name as TableName
	,c.name as ColumnName
From sys.tables t
Inner Join sys.columns c on t.object_id = c.object_id
Where c.name like '%rate%'
 
--b 
Select 
	t.name as TableName
	,c.name as ColumnName
From sys.tables t
	Inner Join sys.columns c on t.object_id = c.object_id
Where t.name like '%History%'


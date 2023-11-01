USE AdventureWorks2019

-- problem 1

-- Write a SQL Statement that will give you a count of each object type in the AdventureWorks database. Order by count descending.

SELECT type_desc, COUNT(type_desc) as count
FROM sys.objects
GROUP BY type_desc
ORDER BY count DESC

-- problem 2

-- a. Write a SQL Statement that will show a count of schemas, tables, and columns (do not include views) in the AdventureWorks database.
-- hint: use sys.tables to join sys.columns and sys.schemas.

-- option a1
SELECT *
FROM sys.tables

SELECT
	COUNT(DISTINCT s.name) as SchemaName,
	COUNT(DISTINCT t.name) as TableName,
	COUNT(c.name) as ColumnName
FROM sys.tables as t
INNER JOIN sys.columns as c ON c.object_id = t.object_id
INNER JOIN sys.schemas as s ON s.schema_id = t.schema_id

-- option a2
SELECT *
FROM information_schema.columns
SELECT *
FROM information_schema.views

SELECT 
	COUNT(DISTINCT TABLE_SCHEMA) as SchemaCount, 
	COUNT(DISTINCT TABLE_NAME) as TableCount, 
	COUNT(COLUMN_NAME) as ColumnCount
FROM information_schema.columns
WHERE TABLE_NAME NOT IN
     (SELECT DISTINCT TABLE_NAME FROM information_schema.views);

-- b. Write a similar statement as part a but list each schema, table, and column (do not include views). 
-- This table can be used later in the course.

SELECT
	DISTINCT s.name as SchemaName,
	t.name as TableName,
	c.name as ColumnName
FROM sys.tables as t
INNER JOIN sys.columns as c ON c.object_id = t.object_id
INNER JOIN sys.schemas as s ON s.schema_id = t.schema_id
/*

In Question 1 we learned that the AdventureWorks Database has 152 Default Constraints. 
What tables and columns are these constraints on? And what are the default values?

Hint:
    - Join sys.default_constraints to sys.tables, sys.columns, 
	- sys.columns needs to be joined on object_id and column_id

*/

-- Query from question 1

Select type_desc, Count(*) as CNT From sys.objects
Group by type_desc
Order by 2 desc

SELECT * FROM sys.default_constraints
SELECT * FROM sys.tables
where object_id = 2099048
SELECT * FROM sys.columns
SELECT * FROM sys.schemas

-- solution

SELECT
	d.name as DefaultConstraint,
	t.name as TableName,
	c.name as ColumnName,
	s.name as SchemaName,
	d.definition as DefaultDefinition
FROM sys.default_constraints as d
INNER JOIN sys.tables as t on t.object_id = d.parent_object_id
INNER JOIN sys.columns as c on c.column_id = d.parent_column_id and c.object_id = d.parent_object_id
INNER JOIN sys.schemas as s on s.schema_id = d.schema_id
-- b. Using the following tables - sys.check_constraints, sys.tables, and sys.columns to write a query
-- that will give you TableName, ColumnName, CheckConstraintName, and CheckConstraintDefinition

select * from AdventureWorks2019.sys.check_constraints
select * from AdventureWorks2019.sys.tables
select * from AdventureWorks2019.sys.columns 

-- b. hint
	-- tables.object_id = check_constraints.parent_object_id
		-- Use a left join to join sys.columns to sys.check_constraints. (we want all 89 constraints/rows)
		-- sys.columns and sys.check_constraints have to be joined on two columns:
			-- columns.column_id = check_constraints.parent_column_id
			-- columns.object_id = check_constraints.parent_object_id
			
select 
	t.name as TableName,
	c.name as ColumnName,
	ch.name as CheckConstraintName,
	ch.definition as CheckConstraintDefinition
from AdventureWorks2019.sys.check_constraints as ch
left join AdventureWorks2019.sys.columns as c on c.column_id = ch.parent_column_id AND c.object_id  = ch.parent_object_id
inner join AdventureWorks2019.sys.tables as t on t.object_id = ch.parent_object_id

-- c. Create a table named "tbl_CheckConstraint" in the "Edited_AdventureWorks" database with the following  columns and data types: 
-- TableName varchar(100)
-- ColumnName varchar(100)
-- CheckConsraint varchar(250)
-- Definition varchar(500)
-- ConstraintLevel varchar(100)

CREATE TABLE tbl_CheckConstraint (
    TableName varchar(100),
    ColumnName varchar(100),
    CheckConstraint varchar(250),
	Definition varchar(500),
	ConstraintLevel varchar(100)
	);

-- d. Using the query in part b insert the data into "tbl_CheckConstraint" 
		INSERT INTO tbl_CheckConstraint (TableName, ColumnName, CheckConstraint, Definition, ConstraintLevel)
			SELECT
				t.name as TableName,
				c.name as ColumnName,
				ch.name as CheckConstraint,
				ch.definition as Definition,
				NULL as ConstraintLevel
			from AdventureWorks2019.sys.check_constraints as ch
			left join AdventureWorks2019.sys.columns as c on c.column_id = ch.parent_column_id AND c.object_id  = ch.parent_object_id
			inner join AdventureWorks2019.sys.tables as t on t.object_id = ch.parent_object_id

select * from tbl_CheckConstraint

-- DROP TABLE tbl_CheckConstraint; -- (if bad data were inserted)

-- e. Using a case statement write an update statement (update ConstraintLevel) that will 
-- specify whether the constraint is assigned to the column or the table.

UPDATE tbl_CheckConstraint
SET ConstraintLevel = 
	CASE WHEN c.ColumnName IS NULL THEN 'Table' ELSE 'Column' END

select * from tbl_CheckConstraint
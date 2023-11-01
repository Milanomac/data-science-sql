/*  We learned in Question 1 that there are 71 tables in the AdventureWorks Database. We can also see these tables in 
    our entity relationship diagram (ERD). These tables are connected via primary keys and foreign keys. 
	For example, in the Sales.SalesOrderHeader table there  is a foreign key on the CurrencyRateID. 
	This Foreign key is connected to the primary key in the Sales.CurrencyRate  table. Therefore, when we connect 
	these two tables together we will use the CurrencyRateID from both tables. The name of this Foreign Key in the 
	AdventureWorks database is  "FK_SalesOrderHeader_CurrencyRate_CurrencyRateID". We also  know which Schema, Table, 
	and Column join to the referenced Schema, referenced Table, and referenced column.  (See Below)

	- ForeignKeyName: FK_SalesOrderHeader_CurrencyRate_CurrencyRateID
	- SchemaName: Sales
	- TableName: SalesOrderHeader
	- ColumnName: CurrencyRateID
	- ReferencedSchema: Sales
	- ReferencedTable: CurrencyRate
	- ReferencedColumn: CurrencyRateID 
*/

-- all tables needed for merging

select * from sys.foreign_key_columns -- constraint_object_id
select * from sys.objects -- object_id
select * from sys.tables
select * from sys.columns
select * from sys.schemas

SELECT 
	O.name as ForeignKeyName, -- FKN is pulled from O because the name in O table already contains all we need
	S1.name as SchemaName,
	T1.name as TableName,
	C1.name as ColumnName,
	S2.name as ReferencedSchema,
	T2.name as ReferencedTable,
	C2.name as ReferencedColumn
    FROM sys.foreign_key_columns FKC

        INNER JOIN sys.objects O ON O.object_id = FKC.constraint_object_id -- NOTE: We have FK and PK, but the FK's ID is called 'constraint'
        INNER JOIN sys.tables T1 ON T1.object_id = FKC.parent_object_id -- T1: parent
        INNER JOIN sys.tables T2 ON T2.object_id = FKC.referenced_object_id --T2: referenced
        INNER JOIN sys.columns C1 ON C1.column_id = parent_column_id AND C1.object_id = T1.object_id -- parent
        INNER JOIN sys.columns C2 ON C2.column_id = referenced_column_id AND C2.object_id = T2.object_id -- referenced
        INNER JOIN sys.schemas S1 ON T1.schema_id = S1.schema_id -- parent_object_id
        INNER JOIN sys.schemas S2 ON T2.schema_id = S2.schema_id -- referenced_object_id
	WHERE O.name = 'FK_SalesOrderHeader_CurrencyRate_CurrencyRateID'

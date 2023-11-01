/*

Question 9

We know from Question 1 and using the information_schema.view table that there are 20 views 
in the AdventureWorks database. Each one of these views are created from one or more table(s)
in the database. For Example, "vStateProvinceCountryRegion" is a view that was created from 
multiple columns in the StateProvince and CountryRegion tables.

Write a script that will show you each view name and the number of tables used to create the view. 

*/

SELECT * FROM information_schema.view_column_usage

SELECT 
	VIEW_NAME,
	COUNT(DISTINCT TABLE_NAME) AS TABLES_USED
FROM information_schema.view_column_usage
GROUP BY VIEW_NAME


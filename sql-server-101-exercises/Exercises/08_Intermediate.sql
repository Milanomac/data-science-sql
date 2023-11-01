/* 

Question 8

In Question 2 we were introduced to the information_schema schema, specifically the information_schema.columns table.

a. Use this table to get a count of each data type in the AdventureWorks Database (include the view tables). Which data type is used the most?

b. Using a case statement create a data type grouping that summarizes each data type as one of the following Groups:
    -Character
	-Numeric
	-Date
	-Null

Use the following columns to create these groups:
	-Character_Maximum_Length
	-Numeric_Precision
	-DateTime_Precision

For example, when the Character_Maximum_Length is not null then the data type group is "Character." If a row is  
null in all three columns then put it in the "Null" group.

Then give a count of data types in each grouping. The final output will only have two columns - "DataTypeGroup" and "DataTypeCNT."
Lastly, order by count desc


c. What data types are in the "Null" group 

*/


-- a.

SELECT *
FROM information_schema.columns

SELECT 
	DATA_TYPE, 
	COUNT(*) as COUNT
FROM information_schema.columns
GROUP BY DATA_TYPE
ORDER BY COUNT DESC

-- Answer: nvarchar is used the most (268)

--b 

SELECT
    DataTypeGroup,
    COUNT(*) as DataTypeCNT
FROM (
    SELECT
        CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL THEN 'Character'
             WHEN CHARACTER_MAXIMUM_LENGTH IS NULL and NUMERIC_PRECISION IS NULL and DATETIME_PRECISION IS NULL THEN 'Null'
             WHEN DATETIME_PRECISION IS NOT NULL THEN 'Date'
             WHEN NUMERIC_PRECISION IS NOT NULL OR NUMERIC_SCALE IS NOT NULL THEN 'Numeric'
        END as DataTypeGroup
    FROM information_schema.columns
) AS Subquery
GROUP BY DataTypeGroup
ORDER BY DataTypeCNT DESC;

/* Course answer (same results)

Select 
	Case When Character_Maximum_Length is not null then 'Character'
		 When Numeric_Precision is not null then 'Numeric'
		 When Datetime_Precision is not null then 'Date'
		 Else null
		 End as 'DataTypeGroup'
	,Count(*) as CNT
From Information_Schema.Columns
Group by 
	Case When Character_Maximum_Length is not null then 'Character'
		 When Numeric_Precision is not null then 'Numeric'
		 When Datetime_Precision is not null then 'Date'
		 Else null
		 End
Order by count(*) desc
*/

-- c.What data types are in the "Null" group 

USE AdventureWorks2019

-- my answer 
SELECT
	DISTINCT DATA_TYPE,
    CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NULL 
		 and NUMERIC_PRECISION IS NULL 
		 and DATETIME_PRECISION IS NULL THEN 'Null'
         END as NullGroup
FROM information_schema.columns
ORDER BY NullGroup DESC

-- course answer
Select DISTINCT DATA_TYPE 
from Information_Schema.Columns
Where Character_Maximum_Length is null
	and Numeric_Precision is null
	and Datetime_Precision is null
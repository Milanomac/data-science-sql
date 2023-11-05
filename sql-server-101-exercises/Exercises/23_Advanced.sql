/* Question 23

In Question 22 I used an Inner Query as the denominator when calculating the '%ofTotal' (see below). 
Take this query and replace the denomiator with a declare/local variable. Below you will find a 
"Current Query" and a "Desired Query." Write the syntax necessary to make the "Desired Query" Functional.

-- Desired Query:

    Select 
    	cr.Name as Country
    	,Format(count(Distinct p.BusinessEntityID),'N0') as CNT
    	,Format(Cast(count(Distinct p.BusinessEntityID) as float)
    		/
    			@TotalRetailCustomers,'P') as '%ofTotal'
     
    from Person.Person p
    	Inner Join Person.BusinessEntityAddress bea on bea.BusinessEntityID = p.BusinessEntityID
    	Inner Join Person.Address a on a.AddressID = bea.AddressID
    	Inner Join Person.StateProvince sp on sp.StateProvinceID = a.StateProvinceID
    	Inner Join Person.CountryRegion cr on cr.CountryRegionCode = sp.CountryRegionCode
    Where PersonType = 'IN'
    Group by cr.Name
    Order by 2 desc
	
	*/

Declare @TotalRetailCustomers Float = (SELECT 
									   COUNT(BusinessEntityID) 
									   FROM Person.Person
									   WHERE PersonType = 'IN')
	Select 
		cr.Name as Country
		,Format(count(Distinct p.BusinessEntityID),'N0') as CNT
		,Format(Cast(count(Distinct p.BusinessEntityID) as float)
			/
				@TotalRetailCustomers,'P') as '%ofTotal'
 
	from Person.Person p
		Inner Join Person.BusinessEntityAddress bea on bea.BusinessEntityID = p.BusinessEntityID
		Inner Join Person.Address a on a.AddressID = bea.AddressID
		Inner Join Person.StateProvince sp on sp.StateProvinceID = a.StateProvinceID
		Inner Join Person.CountryRegion cr on cr.CountryRegionCode = sp.CountryRegionCode
	Where PersonType = 'IN'
	Group by cr.Name
	Order by 2 desc
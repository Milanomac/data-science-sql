/* Question 30

Assume the sales team wants to reach out to folks who left a review (ProductReview). Is it possible 
to find the customers that left a review in the Person table? 

Make your best attempt at finding these customers. */

SELECT * FROM Production.ProductReview -- 4 reviews
-- cols we can use is ProductID, email and not much more

-- merginig to see the products the 4 people bought
SELECT
	pr.*,
	p.Name
FROM Production.ProductReview as pr
INNER JOIN Production.Product as p on p.ProductID = pr.ProductID

-- searching Person.EmailAddress using email addresses from ProductReview
SELECT *  FROM Person.EmailAddress 
	WHERE EmailAddress in (SELECT EmailAddress FROM Production.ProductReview) -- unfortunately, no results

-- John Smith: BusinessEntityID = 1822 ?
SELECT * FROM Person.Person 
WHERE PersonType = 'IN' AND FirstName LIKE '%John%' AND LastName LIKE '%Smith%'
ORDER BY FirstName DESC

Select * 
From Sales.SalesOrderHeader soh
	Inner Join Person.Person p on p.BusinessEntityID = soh.CustomerID
	Inner Join Sales.SalesOrderDetail sod on sod.SalesOrderID = soh.SalesOrderID
	Inner Join Production.Product pr on pr.ProductID = sod.ProductID
Where FirstName like '%John%' 
	and LastName like '%Smith%' -- but the results are not for socks

-- Laura Norman: BusinessEntityID = 234 ?
Select * From HumanResources.Employee
	Inner Join Person.Person on Person.BusinessEntityID = Employee.BusinessEntityID
Where FirstName like '%Laura%' 
		and LastName like '%Norman%'

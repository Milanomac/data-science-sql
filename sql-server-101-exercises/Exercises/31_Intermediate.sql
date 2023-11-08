/*Question 31:

Ken Sánchez, the CEO of AdventureWorks, has recently changed his email address.
a. What is Ken's current email address?
b. Update his email address to 'Ken.Sánchez@adventure-works.com' */

-- a.
SELECT 
	p.FirstName,
	p.LastName,
	ea.EmailAddress,
	e.JobTitle
FROM Person.EmailAddress as ea
INNER JOIN Person.Person as p on p.BusinessEntityID = ea.BusinessEntityID
INNER JOIN HumanResources.Employee as e on e.BusinessEntityID = ea.BusinessEntityID

-- b. Update his email address to 'Ken.Sánchez@adventure-works.com'

Update Person.EmailAddress
Set EmailAddress = 'ken.sánchez@adventure-works.com'
Where EmailAddress = 'ken0@adventure-works.com'

SELECT * FROM Person.EmailAddress


/*Question 32:

As we learned in Question 31 there are two individuals in the AdventureWorks Database named Ken Sánchez. 
One is the CEO of the Company the other is a retail customer. Lets assume for this question that you used the
following script to update the email address:

	Update Person.EmailAddress
	Set EmailAddress = 'Ken.Sánchez@adventure-works.com'
	Where p.FirstName ='Ken' and p.LastName = 'Sánchez'

The script above is not correct and would update both records. One of which is not the Ken Sánchez we are wanting
to update. In this question we are going to set Ken's (the CEO) email back to the original email (assuming it has
been updated from question 31). Then we are going to use BEGIN TRANSACTION, ROLLBACK, and COMMIT to fix/correct a mistake.*/

-- a. Update Ken's Email Address to the orginial address using the script below:
Update Person.EmailAddress
Set EmailAddress = 'ken0@adventure-works.com'
Where BusinessEntityID = 1

SELECT * FROM Person.EmailAddress

-- b. Check the number of open transactions by running: Select @@TranCount
Select @@TranCount

-- c. Start the transaction with the BEGIN TRAN statement. You can use BEGIN TRANSACTION or
--    BEGIN TRAN. Then check the number of open transactions again.
BEGIN TRAN
Select @@TranCount

-- d. Run our incorrect update statement
Update Person.EmailAddress
Set EmailAddress = 'Ken.Sánchez@adventure-works.com'
From Person.EmailAddress ea
Inner Join Person.Person p on p.BusinessEntityID = ea.BusinessEntityID
Where p.FirstName ='Ken' and p.LastName = 'Sánchez'

Select @@TranCount

-- e. Correct the mistake/error by running the ROLLBACK statement
ROLLBACK

-- f. Check to see if the mistake has been fixed.
Select * From Person.EmailAddress
Where EmailAddress = 'Ken.Sánchez@adventure-works.com'

-- g. Start the transaction, run the correct update statement, COMMIT the transaction
BEGIN TRAN
Update Person.EmailAddress
Set EmailAddress = 'ken.sánchez@adventure-works.com'
Where EmailAddress = 'ken0@adventure-works.com'

COMMIT

-- h. Question 33 we will automate whether the Transaction commits or rollsback. */
SELECT * FROM Person.EmailAddress as ea
Inner Join Person.Person p on p.BusinessEntityID = ea.BusinessEntityID
Where p.FirstName ='Ken' and p.LastName = 'Sánchez'
/* Question 33:

Complete questions 31 and 32 before attempting this question. Before starting this question be sure the email
address for both Ken Sánchez's are updated to their original emails. Run the statements below to be sure: */

Update Person.EmailAddress
Set EmailAddress = 'ken0@adventure-works.com'
Where BusinessEntityID = 1
 
Update Person.EmailAddress
Set EmailAddress = 'ken3@adventure-works.com'
Where BusinessEntityID = 1726

/* In Question 32 we used BEGIN TRAN, ROLLBACK, and COMMIT to be sure that our updates work properly. Write a script
that will commit if the update is correct. If the update is not correct then rollback. For example, If we know how
many rows need to be updated then we can use a @@ROWCOUNT and if that number doesn't meet the condition then rollsback.
If it does meet the condition then it commits.

Use the same update statement used in Question 32 (see below):

Update Person.EmailAddress
Set EmailAddress = 'Ken.Sánchez@adventure-works.com'
Where BusinessEntityID = 1 

**There are many ways to accomplish this. Again, find a solution that works for you.** 

HINT:
1. Begin Tran
2. Update Statement
3. If Condition
4. Rollback
5. Else
6. Commit */

-- Option 1
	BEGIN TRAN

	Update Person.EmailAddress
	Set EmailAddress = 'ken.sánchez@adventure-works.com'
	Where BusinessEntityID = 1 

	IF @@ROWCOUNT != 1 ROLLBACK 
	ELSE COMMIT

-- Option 2
	DECLARE @Rowcount INT =	(SELECT COUNT(*) FROM Person.EmailAddress WHERE BusinessEntityID = 1)

	BEGIN TRAN

	Update Person.EmailAddress
	Set EmailAddress = 'ken.sánchez@adventure-works.com'
	Where BusinessEntityID = @Rowcount 
	
	IF @@ROWCOUNT != 1 ROLLBACK 
	ELSE COMMIT
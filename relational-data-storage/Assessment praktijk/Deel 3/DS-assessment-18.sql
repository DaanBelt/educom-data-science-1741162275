SELECT FirstName, LastName FROM Customer
UNION
SELECT FirstName, LastName FROM Employee
ORDER BY LastName DESC
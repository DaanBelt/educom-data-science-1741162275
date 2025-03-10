SELECT M.LastName, E.LastName
FROM Employee E
JOIN Employee M ON E.ReportsTo = M.EmployeeId
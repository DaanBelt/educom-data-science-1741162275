SELECT CONCAT(C.FirstName, C.LastName, I.InvoiceId)
FROM Customer C
JOIN Invoice I ON C.CustomerId = I.CustomerId
ORDER BY C.FirstName, C.LastName, I.InvoiceId
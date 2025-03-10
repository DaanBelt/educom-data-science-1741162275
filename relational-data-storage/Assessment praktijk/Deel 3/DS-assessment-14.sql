SELECT C.FirstName, C.LastName, C.City, C.Email, COUNT(I.InvoiceId) 
FROM Customer C
JOIN Invoice I ON C.CustomerId = I.CustomerId
GROUP BY C.CustomerId

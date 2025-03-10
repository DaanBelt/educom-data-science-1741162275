SELECT C.CustomerId, C.City, I.BillingCity
FROM Customer C
Join Invoice I ON C.CustomerId = I.CustomerId
WHERE C.City <> I.BillingCity
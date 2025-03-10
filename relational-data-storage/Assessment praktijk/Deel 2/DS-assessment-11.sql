SELECT CustomerId, COUNT(InvoiceId)
FROM Invoice 
GROUP BY CustomerId 
ORDER BY COUNT(InvoiceId) DESC
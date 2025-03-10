SELECT C.City, COUNT(C.CustomerId)
FROM Customer C
GROUP BY C.City
ORDER BY COUNT(C.CustomerId) DESC
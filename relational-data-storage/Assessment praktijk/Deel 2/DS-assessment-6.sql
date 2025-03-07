-- 6. Haal van alle Customers – met alle kolommen – op uit de volgende staten: RJ, DF, AB, BC, CA, WA, NY.
-- Voor welk bedrijf werkt Jack Smith?
SELECT * FROM Customer
WHERE State IN ('RJ', 'DF', 'AB', 'BC', 'CA', 'WA', 'NY')
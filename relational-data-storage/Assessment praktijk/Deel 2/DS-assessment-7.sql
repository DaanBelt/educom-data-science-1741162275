-- 7. Haal van alle Invoices – met alle kolommen – op voor de klanten 56 en 58 met een totaal tussen 1 en 5.
-- Wat is de invoice date van de Invoice met ID 315 ?
SELECT * FROM Invoice
Where CustomerId IN (56, 58) AND Total BETWEEN 1 AND 5
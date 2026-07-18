SELECT k.kunden_id , k.vorname, b.bestell_id, b.status
FROM kunden k
JOIN bestellungen b
ON k.kunden_id = b.kunden_id
WHERE b.status = 'Storniert'
ORDER BY k.kunden_id ASC;


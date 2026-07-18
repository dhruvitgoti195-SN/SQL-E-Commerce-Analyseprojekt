SELECT 
    k.kunden_id,
    k.vorname,
    k.nachname,
    SUM(b.gesamtbetrag) AS max_kauf
FROM kunden AS k
JOIN bestellungen AS b 
    ON k.kunden_id = b.kunden_id
GROUP BY 
    k.kunden_id,
    k.vorname,
    k.nachname
ORDER BY 
    max_kauf DESC;
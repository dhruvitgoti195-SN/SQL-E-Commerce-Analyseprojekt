SELECT 
    k.kunden_id,
    k.vorname,
    ROUND(AVG(b.gesamtbetrag), 2) AS avg_betrag,
    COUNT(b.bestell_id) AS gesamt_anzahl
FROM kunden AS k
JOIN bestellungen AS b 
    ON k.kunden_id = b.kunden_id
GROUP BY 
    k.kunden_id,
    k.vorname
ORDER BY 
    gesamt_anzahl DESC;

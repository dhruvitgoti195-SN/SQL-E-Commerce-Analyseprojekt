SELECT 
    k.stadt,
    SUM(b.gesamtbetrag) AS max_kauf
FROM kunden AS k
JOIN bestellungen AS b 
    ON k.kunden_id = b.kunden_id
GROUP BY 
    k.stadt
ORDER BY 
    max_kauf DESC;
SELECT 
    TO_CHAR(k.registrierungsdatum, 'YYYY-MM') AS cohort_monat,
    TO_CHAR(b.bestelldatum, 'YYYY-MM') AS bestell_monat,
    COUNT(DISTINCT k.kunden_id) AS aktive_kunden,
    SUM(b.gesamtbetrag) AS umsatz
FROM kunden AS k
JOIN bestellungen AS b 
    ON k.kunden_id = b.kunden_id
WHERE b.status = 'Abgeschlossen'
GROUP BY 
    TO_CHAR(k.registrierungsdatum, 'YYYY-MM'),
    TO_CHAR(b.bestelldatum, 'YYYY-MM')
ORDER BY 
    cohort_monat,
    bestell_monat;
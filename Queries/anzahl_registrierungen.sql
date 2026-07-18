SELECT 
    monat,
    anzahl_registrierungen,
    SUM(anzahl_registrierungen) OVER (ORDER BY monat) AS kumuliert
FROM (
    SELECT 
        TO_CHAR(registrierungsdatum, 'YYYY-MM') AS monat,
        COUNT(*) AS anzahl_registrierungen
    FROM kunden
    GROUP BY TO_CHAR(registrierungsdatum, 'YYYY-MM')
) t;
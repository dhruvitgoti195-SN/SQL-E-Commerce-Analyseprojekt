SELECT 
    COALESCE(r.jahr, o.jahr) AS jahr,
    COALESCE(r.quartal, o.quartal) AS quartal,
    COALESCE(r.anzahl_registrierungen, 0) AS registrierungen,
    COALESCE(o.anzahl_bestellungen, 0) AS bestellungen
FROM (
    SELECT 
        EXTRACT(YEAR FROM registrierungsdatum) AS jahr,
        EXTRACT(QUARTER FROM registrierungsdatum) AS quartal,
        COUNT(*) AS anzahl_registrierungen
    FROM kunden
    GROUP BY 
        EXTRACT(YEAR FROM registrierungsdatum),
        EXTRACT(QUARTER FROM registrierungsdatum)
) r
FULL JOIN (
    SELECT 
        EXTRACT(YEAR FROM bestelldatum) AS jahr,
        EXTRACT(QUARTER FROM bestelldatum) AS quartal,
        COUNT(*) AS anzahl_bestellungen
    FROM bestellungen
    GROUP BY 
        EXTRACT(YEAR FROM bestelldatum),
        EXTRACT(QUARTER FROM bestelldatum)
) o
ON r.jahr = o.jahr 
AND r.quartal = o.quartal
ORDER BY jahr, quartal;
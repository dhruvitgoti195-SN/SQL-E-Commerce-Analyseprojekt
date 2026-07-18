SELECT 
    b.gesamtbetrag,
    b.bestell_id,
    z.zahlungsdatum
FROM bestellungen AS b
JOIN zahlungen AS z 
    ON b.bestell_id = z.bestell_id
WHERE z.zahlungsstatus = 'Erfolgreich'
  AND z.zahlungsdatum BETWEEN '2024-03-01' AND '2024-03-31'
ORDER BY z.zahlungsdatum ASC;
-- Total sales of an month 
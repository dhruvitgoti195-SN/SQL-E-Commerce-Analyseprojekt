SELECT *,
    NTILE(5) OVER (ORDER BY recency DESC) AS r_score,
    NTILE(5) OVER (ORDER BY frequency ASC) AS f_score,
    NTILE(5) OVER (ORDER BY monetary ASC) AS m_score
FROM (
    SELECT 
        k.kunden_id,
        CURRENT_DATE - MAX(b.bestelldatum) AS recency,
        COUNT(b.bestell_id) AS frequency,
        SUM(b.gesamtbetrag) AS monetary
    FROM kunden AS k
    JOIN bestellungen AS b 
        ON k.kunden_id = b.kunden_id
    WHERE LOWER(b.status) = 'abgeschlossen'
    GROUP BY k.kunden_id
) AS t;
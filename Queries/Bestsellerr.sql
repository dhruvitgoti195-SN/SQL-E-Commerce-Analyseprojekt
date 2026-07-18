SELECT 
    p.produkt_id,
    p.produktname,
    SUM(pb.menge) AS max_menge
FROM produkte AS p
JOIN bestellpositionen AS pb 
    ON p.produkt_id = pb.produkt_id
GROUP BY 
    p.produkt_id,
    p.produktname
ORDER BY 
    max_menge DESC;
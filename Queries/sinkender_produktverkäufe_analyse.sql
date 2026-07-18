select *
from (
    select 
        produkt_id,
        monat,
        umsatz,
        lag(umsatz) over (partition by produkt_id order by monat) as prev
    from (
        select 
            bp.produkt_id,
            to_char(b.bestelldatum, 'yyyy-mm') as monat,
            sum(bp.menge * bp.einzelpreis) as umsatz
        from bestellpositionen bp
        join bestellungen b 
            on bp.bestell_id = b.bestell_id
        where lower(b.status) = 'abgeschlossen'
        group by bp.produkt_id, monat
    ) x
) y
where umsatz < prev;
### SQL E-Commerce Analyseprojekt



Ich habe ein vollständiges Datenanalyseprojekt mit PostgreSQL und Power BI
aufgebaut – auf einem selbst erstellten deutschen E-Commerce-Datensatz.

#### 

#### Was ich gemacht habe :

Die Daten habe ich komplett selbst mit Python generiert, das Datenbankschema
von Grund auf entworfen, alle SQL-Abfragen selbst geschrieben und am Ende
ein Power BI Dashboard zur Visualisierung gebaut.

Datensatz: 200 Kunden, 800 Bestellungen, 80 Produkte, ca. 1.600 Bestellpositionen,
800 Zahlungen, 300 Bewertungen – alles simulierte deutsche E-Commerce-Daten.



#### Datenbankdesign :

6 Tabellen in PostgreSQL mit Foreign-Key-Constraints entworfen und erstellt:

kunden              (Kundenstammdaten)
produkte            (Produktkatalog)
bestellungen        (Bestellungen mit Status)
bestellpositionen   (einzelne Positionen pro Bestellung)
zahlungen           (Zahlungsdaten)
bewertungen         (Produktbewertungen)

Alle Tabellen sind per FK verknüpft und die Daten wurden per COPY aus CSV geladen.



#### Analysen \& Abfragen :

RFM-Kundensegmentierung
Jeden Kunden nach Recency, Frequency und Monetary bewertet – mit NTILE(5)
als Window-Funktion. Zeigt, welche Kunden am wertvollsten sind.

Kohortenanalyse
Kunden nach Registrierungsmonat gruppiert und ihre Bestellungen über die Zeit
verfolgt – zeigt Wiederkaufverhalten und Umsatzentwicklung je Kohorte.

Sinkende Produktverkäufe
Mit LAG() den Monatsumsatz jedes Produkts mit dem Vormonat verglichen und
Produkte mit Umsatzrückgang herausgefiltert.

Registrierungen vs. Bestellungen pro Quartal
Zwei Unterabfragen per FULL JOIN verknüpft, um neue Kundenanmeldungen mit
Bestellvolumen je Quartal zu vergleichen – fehlende Quartale mit COALESCE aufgefüllt.

Weitere Abfragen: Kundenlebenszeitwert, Monatsumsatz, Umsatz nach Stadt,
Bestseller, kumulierte Registrierungen, stornierte Bestellungen usw.



#### SQL-Kenntnisse :

Window Functions    NTILE(), LAG(), SUM() OVER()
Joins               INNER JOIN, FULL JOIN
Unterabfragen       verschachtelte SELECTs für RFM und Umsatzanalyse
Aggregationen       GROUP BY, COUNT, SUM, AVG, ROUND
Datumsfunktionen    TO\_CHAR(), EXTRACT(), Datumsarithmetik mit CURRENT\_DATE
NULL-Behandlung     COALESCE() für lückenlose Quartalsvergleiche
Filterung           WHERE mit LOWER() für statusunabhängige Vergleiche



#### Python – Datengenerierung:

Vor der eigentlichen SQL-Arbeit habe ich alle Daten mit einem Python-Skript
selbst erzeugt. Genutzt habe ich die Faker-Bibliothek mit deutschem Locale
für realistische Namen, E-Mails und Städte. Kunden, Produkte, Bestellungen,
Positionen, Zahlungen und Bewertungen – alles mit konsistenten IDs und
korrekten Beziehungen zwischen den Tabellen.



#### Power BI Dashboard :

Ein interaktives Power BI Dashboard (SQL Dashboard.pbix) direkt mit
PostgreSQL verbunden. Folgende Seiten und Visuals sind enthalten:

Jährliche Umsatzentwicklung und Zieltracking
Tatsächlichen Jahresumsatz gegen ein definiertes Ziel dargestellt –
zeigt auf einen Blick ob und wie weit das Ziel erreicht wurde.

Quartalsvergleich der Umsätze
Umsätze der einzelnen Quartale nebeneinander verglichen – Wachstum
und Einbrüche lassen sich direkt ablesen.

Lagerbestände
Aktuellen Lagerbestand pro Produkt und Kategorie visualisiert –
hilft Engpässe und Überbestände zu erkennen.

Neue Registrierungen (quartalsweise)
Neukundenentwicklung pro Quartal dargestellt – zeigt ob das
Kundenwachstum konstant, steigend oder rückläufig ist.

Geografische Analyse (Map Visual)
Umsatz und Kundenanzahl auf einer Karte nach deutschen Städten
aufgeteilt – räumliche Verteilung der Kundenbasis sichtbar gemacht.

Zahlungsmethoden Nutzung
Aufgeschlüsselt wie oft Kreditkarte, PayPal, SEPA und
Sofortüberweisung genutzt wurden.

Durchschnittliche Kundenbewertungen nach Kategorien
Mittlere Bewertung pro Produktkategorie verglichen – zeigt welche
Kategorien gut ankommen und wo Verbesserungsbedarf besteht.



#### Tools :

PostgreSQL 18
Python 3 (pandas, numpy, Faker)
Power BI Desktop


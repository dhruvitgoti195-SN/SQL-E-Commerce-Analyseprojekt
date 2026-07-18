CREATE TABLE IF NOT EXISTS kunden (
kunden_id INT PRIMARY KEY UNIQUE,
vorname VARCHAR (30)NOT NULL,
nachname VARCHAR(30) NOT NULL,
email VARCHAR (40) NOT NULL,
stadt VARCHAR (30) NOT NULL,
land VARCHAR (30) NOT NULL,
registrierungsdatum DATE NOT NULL
);

COPY kunden
FROM 'C:\Program Files\PostgreSQL\18\data\SQL\kunden.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);

CREATE TABLE IF NOT EXISTS bestellungen (
    bestell_id INT PRIMARY KEY,
    kunden_id INT NOT NULL,
    bestelldatum DATE NOT NULL,
    gesamtbetrag NUMERIC(10,2),
    status VARCHAR(20),

    CONSTRAINT fk_bestellungen_kunden
        FOREIGN KEY (kunden_id)
        REFERENCES kunden(kunden_id)
);

COPY bestellungen
FROM 'C:\Program Files\PostgreSQL\18\data\SQL\bestellungen.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);

CREATE TABLE IF NOT EXISTS produkte (
    produkt_id INT PRIMARY KEY,
    produktname VARCHAR(20) NOT NULL,
    kategorie VARCHAR(50) NOT NULL,
    preis NUMERIC(10,2),
    lagerbestand INT NOT NULL
);

COPY produkte
FROM 'C:\Program Files\PostgreSQL\18\data\SQL\produkte.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);

CREATE TABLE IF NOT EXISTS bewertungen (
    bewertungs_id INT PRIMARY KEY,
    kunden_id INT NOT NULL,
    produkt_id INT NOT NULL,
    bewertung INT NOT NULL,
    bewertungsdatum DATE NOT NULL,

    CONSTRAINT fk_bewertungen_kunden
        FOREIGN KEY (kunden_id)
        REFERENCES kunden(kunden_id),

    CONSTRAINT fk_bewertungen_produkte
        FOREIGN KEY (produkt_id)
        REFERENCES produkte(produkt_id)
);

COPY bewertungen
FROM 'C:\Program Files\PostgreSQL\18\data\SQL\bewertungen.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);

CREATE TABLE IF NOT EXISTS zahlungen (
    zahlungs_id INT PRIMARY KEY,
    bestell_id INT NOT NULL,
    zahlungsart VARCHAR(30),
    zahlungsdatum DATE NOT NULL,
    zahlungsstatus VARCHAR(30),

    CONSTRAINT fk_zahlungen_bestellungen
        FOREIGN KEY (bestell_id)
        REFERENCES bestellungen(bestell_id)
);

COPY zahlungen
FROM 'C:\Program Files\PostgreSQL\18\data\SQL\zahlungen.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);

CREATE TABLE IF NOT EXISTS bestellpositionen (
    positions_id INT PRIMARY KEY,
    bestell_id INT NOT NULL,
    produkt_id INT NOT NULL,
    menge INT NOT NULL,
    einzelpreis NUMERIC(10,2),

    CONSTRAINT fk_bestellpositionen_bestellungen
        FOREIGN KEY (bestell_id)
        REFERENCES bestellungen(bestell_id),

    CONSTRAINT fk_bestellpositionen_produkte
        FOREIGN KEY (produkt_id)
        REFERENCES produkte(produkt_id)
);

COPY bestellpositionen
FROM 'C:\Program Files\PostgreSQL\18\data\SQL\bestellpositionen.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);
import pandas as pd
import numpy as np
from faker import Faker
import random

fake = Faker("de_DE")

# -------------------------
# KONFIGURATION
# -------------------------
ANZAHL_KUNDEN = 200
ANZAHL_PRODUKTE = 80
ANZAHL_BESTELLUNGEN = 800

staedte = [
    "Berlin", "Hamburg", "München", "Köln", "Frankfurt",
    "Stuttgart", "Düsseldorf", "Leipzig", "Dortmund", "Bremen"
]

kategorien = ["Elektronik", "Kleidung", "Bücher", "Haushalt", "Sport"]

zahlungsarten = ["Kreditkarte", "PayPal", "SEPA", "Sofortüberweisung"]

# -------------------------
# KUNDEN
# -------------------------
kunden = []

for i in range(1, ANZAHL_KUNDEN + 1):
    kunden.append([
        i,
        fake.first_name(),
        fake.last_name(),
        fake.email(),
        random.choice(staedte),
        "Deutschland",
        fake.date_between(start_date="-3y", end_date="today")
    ])

kunden_df = pd.DataFrame(kunden, columns=[
    "kunden_id", "vorname", "nachname",
    "email", "stadt", "land", "registrierungsdatum"
])

# -------------------------
# PRODUKTE
# -------------------------
produkte = []

for i in range(1, ANZAHL_PRODUKTE + 1):
    preis = round(random.uniform(5, 1500), 2)
    produkte.append([
        i,
        fake.word().capitalize(),
        random.choice(kategorien),
        preis,
        random.randint(20, 500)
    ])

produkte_df = pd.DataFrame(produkte, columns=[
    "produkt_id", "produktname", "kategorie",
    "preis", "lagerbestand"
])

# -------------------------
# BESTELLUNGEN + POSITIONEN
# -------------------------
bestellungen = []
bestellpositionen = []
zahlungen = []

positions_id = 1

for i in range(1, ANZAHL_BESTELLUNGEN + 1):

    kunden_id = random.randint(1, ANZAHL_KUNDEN)
    bestelldatum = fake.date_between(start_date="-2y", end_date="today")

    status = random.choices(
        ["Abgeschlossen", "Storniert", "Retourniert"],
        weights=[0.8, 0.1, 0.1]
    )[0]

    gesamtbetrag = 0

    for _ in range(random.randint(1, 4)):
        produkt_id = random.randint(1, ANZAHL_PRODUKTE)
        menge = random.randint(1, 5)

        preis = produkte_df.loc[
            produkte_df.produkt_id == produkt_id, "preis"
        ].values[0]

        gesamtbetrag += menge * preis

        bestellpositionen.append([
            positions_id,
            i,
            produkt_id,
            menge,
            preis
        ])

        positions_id += 1

    bestellungen.append([
        i,
        kunden_id,
        bestelldatum,
        round(gesamtbetrag, 2),
        status
    ])

    zahlungen.append([
        i,
        i,
        random.choice(zahlungsarten),
        bestelldatum,
        "Erfolgreich" if status == "Abgeschlossen" else "Fehlgeschlagen"
    ])

bestellungen_df = pd.DataFrame(bestellungen, columns=[
    "bestell_id", "kunden_id", "bestelldatum",
    "gesamtbetrag", "status"
])

bestellpositionen_df = pd.DataFrame(bestellpositionen, columns=[
    "positions_id", "bestell_id", "produkt_id",
    "menge", "einzelpreis"
])

zahlungen_df = pd.DataFrame(zahlungen, columns=[
    "zahlungs_id", "bestell_id", "zahlungsart",
    "zahlungsdatum", "zahlungsstatus"
])

# -------------------------
# BEWERTUNGEN
# -------------------------
bewertungen = []

for i in range(1, 300):
    bewertungen.append([
        i,
        random.randint(1, ANZAHL_KUNDEN),
        random.randint(1, ANZAHL_PRODUKTE),
        random.randint(1, 5),
        fake.date_between(start_date="-2y", end_date="today")
    ])

bewertungen_df = pd.DataFrame(bewertungen, columns=[
    "bewertungs_id", "kunden_id", "produkt_id",
    "bewertung", "bewertungsdatum"
])

# -------------------------
# CSV EXPORT (UTF-8 für MySQL)
# -------------------------
kunden_df.to_csv("C:\\Users\\sanja\\Desktop\\SQL\\kunden.csv", index=False, encoding="utf-8")
produkte_df.to_csv("C:\\Users\\sanja\\Desktop\\SQL\\produkte.csv", index=False, encoding="utf-8")
bestellungen_df.to_csv("C:\\Users\\sanja\\Desktop\\SQL\\bestellungen.csv", index=False, encoding="utf-8")
bestellpositionen_df.to_csv("C:\\Users\\sanja\\Desktop\\SQL\\bestellpositionen.csv", index=False, encoding="utf-8")
zahlungen_df.to_csv("C:\\Users\\sanja\\Desktop\\SQL\\zahlungen.csv", index=False, encoding="utf-8")
bewertungen_df.to_csv("C:\\Users\\sanja\\Desktop\\SQL\\bewertungen.csv", index=False, encoding="utf-8")

print("SQL Dataset erfolgreich erstellt")

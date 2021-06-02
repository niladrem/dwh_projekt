from bs4 import BeautifulSoup
import requests
import re
import pandas as pd
from datetime import date

mieszkania_url = "https://www.otodom.pl/sprzedaz/mieszkanie/warszawa/?search%5Bregion_id%5D=7&search%5Bsubregion_id%5D=197&search%5Bcity_id%5D=26&page="
pages_range = range(1, 501)
pasek = 'css-18h1kfv ev4i3ak3'
labels = ['Powierzchnia', 'Rynek', 'Piętro', 'Liczba pokoi', 'Materiał budynku', 'Rok budowy', 'Ogrzewanie', 'Stan wykończenia', 'Liczba pięter', 'Rodzaj zabudowy']
label_nulls = ['0', 'nieznany', '0', '0', 'nieznany', '2021', 'nieznane', 'nieznany', '0', 'nieznany']

data = []
for page in pages_range:
    response = requests.get(mieszkania_url + str(page))
    soup = BeautifulSoup(response.content, 'html.parser')
    mieszkania = soup.find_all(class_="offer-item")
    for M in mieszkania[3:]:
        oferta_url = M['data-url']
        subresponse = requests.get(oferta_url)
        oferta = BeautifulSoup(subresponse.content, 'html.parser')
        district = oferta.find(class_="css-1qz7z11")
        if district is None:
            district = "nieznany"
        else:
            district = district.get_text().strip().split(', ')[1]
        vendor = oferta.find(class_="css-1hhugco")
        if vendor is None:
            vendor = "nieznany"
        else:
            vendor = vendor['href']
        price = oferta.find(attrs={'aria-label': 'Cena'})
        if price is None:
            price = '0'
        else:
            price = price.get_text().strip().replace(' ', '').replace('zł', '')
        priceA = oferta.find(attrs={'aria-label': 'Cena za metr kwadratowy'})
        if priceA is None:
            priceA = '0'
        else:
            priceA = priceA.get_text().strip().replace(' ', '').replace('zł/m²', '')
        originalID = M['data-item-id']
        details = ['0 m²', 'nieznany', '0', '0', 'nieznany', '2021', 'nieznane', 'nieznany', '0', 'nieznany']
        for x in range(len(details)):
            det = oferta.find(attrs={'class': pasek, 'aria-label': labels[x]})
            if det is not None:
                details[x] = det.find(class_="css-1ytkscc").get_text().strip()
        pattern = '"dateCreated":"(\d{4}-\d{2}-\d{2})'
        avail = oferta.find(attrs={'class': pasek, 'aria-label': 'Dostępne od'})
        if avail is None:
            try:
                avail = re.search(pattern, oferta.find(attrs={'type': 'application/json'}).contents[0]).groups()[0]
            except:
                continue
        else:
            avail = avail.find(class_="css-1ytkscc").get_text().strip()
        elevator = "no"
        dodatki = oferta.find_all(class_='css-1r5xhnu')
        for d in dodatki:
            if d.get_text().strip()=="winda":
                elevator = "yes"
        snapd = date.today().strftime("%Y-%m-%d")
        data.append({"district": district, "vendor": vendor, "price": price, "pricePerMeter": priceA,
                     "originalFlatId": originalID, "area": details[0][:-3], "market": details[1],
                     "floatFloor": details[2], "roomsNumber": details[3], "buildingMaterial": details[4],
                     "constructionYear": details[5], "heating": details[6], "condition": details[7],
                     "floorsNumber": details[8], "availableDate": avail, "typeOfBuilding": details[9],
                     "elevator": elevator, "snapshotDate": snapd})

data_df = pd.DataFrame(data)
data_df.to_csv('D:\\__DANE\\studia\\bd2\\dwh_projekt\\flatFacts.csv')
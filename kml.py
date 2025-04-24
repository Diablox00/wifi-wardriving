#!/usr/bin/python3
import csv
from xml.dom.minidom import Document
from termcolor import colored

def csv_to_kml(csv_path, kml_path):
    doc = Document()
    kml = doc.createElement("kml")
    kml.setAttribute("xmlns", "http://www.opengis.net/kml/2.2")
    doc.appendChild(kml)
    document = doc.createElement("Document")
    kml.appendChild(document)

    seen_bssids = set()

    with open(csv_path, newline='', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        reader.fieldnames = [h.strip() for h in reader.fieldnames]

        for raw in reader:
            row = {k.strip(): v.strip() for k, v in raw.items()}

            essid      = row.get('ESSID', row.get('SSID', ''))
            bssid      = row.get('BSSID', '')
            power      = row.get('Power', '')
            security   = row.get('Security', '')
            lat        = row.get('Latitude', '')
            lon        = row.get('Longitude', '')
            typ        = row.get('Type', '')
            local_time = row.get('LocalTime', '')

            # Skip if missing or invalid coordinates
            try:
                lat_f = float(lat)
                lon_f = float(lon)
                if lat_f == 0.0 or lon_f == 0.0:
                    continue
            except ValueError:
                continue

            # Skip duplicate BSSIDs
            if bssid in seen_bssids:
                continue
            seen_bssids.add(bssid)

            pm = doc.createElement("Placemark")

            name = doc.createElement("name")
            name.appendChild(doc.createTextNode(essid or bssid))
            pm.appendChild(name)

            desc = doc.createElement("description")
            desc_text = (
                f"ESSID:   {essid}\n"
                f"BSSID:   {bssid}\n"
                f"Power:   {power} dBm\n"
                f"Security:{security}\n"
                f"Type:    {typ}\n"
                f"Logged:  {local_time}"
            )
            desc.appendChild(doc.createTextNode(desc_text))
            pm.appendChild(desc)

            point = doc.createElement("Point")
            coords = doc.createElement("coordinates")
            coords.appendChild(doc.createTextNode(f"{lon},{lat},0"))
            point.appendChild(coords)
            pm.appendChild(point)

            document.appendChild(pm)

    with open(kml_path, "w", encoding='utf-8') as out:
        out.write(doc.toprettyxml(indent="  "))

    print(colored("[+] ✔ Filtered KML written:", "green"), kml_path)
    print(colored("[-_-] Visit Google Earth for Visual Mapping Representation: https://earth.google.com/", "cyan"))

if __name__ == "__main__":
    csv_to_kml(
        "data/wardrive_capture-01.log.csv",
        "wardrive_capture-01.kml"
    )

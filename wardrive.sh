#!/bin/bash

# === CONFIGURATION ===
GPS_DEV="/dev/ttyACM0"
WIRELESS_IFACE="wlan0"
CAPTURE_PREFIX="wardrive_capture"

sudo rm data/*

# === STOP GPS SERVICE IF RUNNING ===
#echo "[-] Stopping gpsd.socket..."
#sudo systemctl stop gpsd.socket

# === START GPSD MANUALLY ===
#echo "[+] Starting gpsd on $GPS_DEV..."
#sudo gpsd $GPS_DEV -F /var/run/gpsd.sock

# === WAIT FOR GPS FIX ===
echo "[*] Waiting for GPS fix..."
timeout 15s cgps -s

# === ENABLE MONITOR MODE ===
echo "[-_-] Putting $WIRELESS_IFACE into monitor mode..."
sudo airmon-ng start $WIRELESS_IFACE

# Extract monitor interface name (usually adds 'mon')
MON_IFACE="${WIRELESS_IFACE}mon"

# Check if the 'data' directory exists
if [ ! -d "data" ]; then
    echo "[*] 'data' directory not found. Creating it..."
    mkdir -p data
fi

# === START AIRODUMP-NG WITH GPS LOGGING ===
echo "[+] Starting airodump-ng with GPS logging..."
sudo airodump-ng "$MON_IFACE" --gpsd -w "data/$CAPTURE_PREFIX"

# === CONVERT GPS FILE TO GPX, KML, AND GEOJSON FORMAT (if it exists) ===
GPS_FILE="data/${CAPTURE_PREFIX}-01.gps"

if [ -f "$GPS_FILE" ]; then
    echo "[+] Found GPS file: $GPS_FILE"
    
    # Convert to GPX (intermediate standard format)
    echo "[+] Converting $GPS_FILE to GPX format..."
    gpsbabel -i nmea -f "$GPS_FILE" -o gpx -F "data/${CAPTURE_PREFIX}.gpx"

    # Convert GPX to KML
    echo "[+] Converting GPX to KML format..."
    gpsbabel -i gpx -f "data/${CAPTURE_PREFIX}.gpx" -o kml -F "data/${CAPTURE_PREFIX}.kml"

    # Convert GPX to GeoJSON
    echo "[+] Converting GPX to GeoJSON format..."
    gpsbabel -i gpx -f "data/${CAPTURE_PREFIX}.gpx" -o geojson -F "data/${CAPTURE_PREFIX}.geojson"

    echo "[+] Conversion completed: KML and GeoJSON saved to data/"

else
    echo "[!] GPS file $GPS_FILE not found — skipping conversion."
fi


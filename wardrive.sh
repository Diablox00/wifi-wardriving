#!/bin/bash

# === CONFIGURATION ===
GPS_DEV="/dev/ttyUSB0"
WIRELESS_IFACE="wlan1"
CAPTURE_PREFIX="wardrive_capture"

# === STOP GPS SERVICE IF RUNNING ===
echo "[-] Stopping gpsd.socket..."
sudo systemctl stop gpsd.socket

# === START GPSD MANUALLY ===
echo "[+] Starting gpsd on $GPS_DEV..."
sudo gpsd $GPS_DEV -F /var/run/gpsd.sock

# === WAIT FOR GPS FIX ===
echo "[*] Waiting for GPS fix... (Ctrl+C to skip)"
timeout 20s cgps -s

# === ENABLE MONITOR MODE ===
echo "[-_-] Putting $WIRELESS_IFACE into monitor mode..."
sudo airmon-ng start $WIRELESS_IFACE

# Extract monitor interface name (usually adds 'mon')
MON_IFACE="${WIRELESS_IFACE}mon"

# === START AIRODUMP-NG WITH GPS LOGGING ===
echo "[+] Starting airodump-ng with GPS logging..."
sudo airodump-ng $MON_IFACE --gpsd -w $CAPTURE_PREFIX

# === CONVERT GPS FILE TO GPX FORMAT (if it exists) ===
GPS_FILE="${CAPTURE_PREFIX}-01.gps"
if [ -f "$GPS_FILE" ]; then
    echo "[+] Converting $GPS_FILE to output.gpx for Wigle or mapping tools..."
    sudo gpsbabel -i nmea -f "$GPS_FILE" -o gpx -F output.gpx
else
    echo "[!] GPS file $GPS_FILE not found — skipping conversion."
fi

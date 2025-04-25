#!/bin/bash

# === CONFIGURATION ===
GPS_DEV="/dev/ttyACM0"
WIRELESS_IFACE="wlan0"
CAPTURE_PREFIX="wardrive_capture"

# === STOP GPS SERVICE IF RUNNING ===
#echo "[-] Stopping gpsd.socket..."
#sudo systemctl stop gpsd.socket

# === START GPSD MANUALLY ===
#echo "[+] Starting gpsd on $GPS_DEV..."
#sudo gpsd $GPS_DEV -F /var/run/gpsd.sock

# === WAIT FOR GPS FIX ===
echo -e "\e[1;33m[*]\e[0m \e[1mWaiting for GPS fix...\e[0m"
timeout 15s cgps -s

# === ENABLE MONITOR MODE ===
echo -e "\e[1;36m[-_-]\e[0m \e[1mPutting \e[32m$WIRELESS_IFACE\e[0m \e[1minto monitor mode...\e[0m"
sudo airmon-ng start $WIRELESS_IFACE

# Extract monitor interface name (usually adds 'mon')
MON_IFACE=$(airmon-ng | grep "$WIRELESS_IFACE" | grep -oP '\w+mon')
echo -e "\e[1;36m[-_-]\e[0m \e[1mMonitor interface is \e[32m$MON_IFACE\e[0m"

sleep 1

# Check if the 'data' directory exists
if [ ! -d "data" ]; then
    echo -e "\e[1;33m[*]\e[0m \e[1m'data' directory not found. Creating it...\e[0m"
    mkdir -p data
    sudo rm data/*
fi

# === START AIRODUMP-NG WITH GPS LOGGING ===
echo -e "\e[1;32m[+]\e[0m \e[1mStarting airodump-ng with GPS logging...\e[0m"
sudo airodump-ng "$MON_IFACE" --gpsd -w "data/$CAPTURE_PREFIX"

sleep 3

echo -e "\e[1;32m[+]\e[0m \e[1mRestoring wlan0mon\e[0m"
sudo airmon-ng stop wlan0mon

echo -e "\e[1;32m[+]\e[0m \e[1mStarting Network Manager\e[0m"
sudo systemctl restart NetworkManager

sleep 5

echo -e "\e[1;31m[-]\e[0m \e[1mConverting Data to KML...\e[0m"
sudo python3 kml.py





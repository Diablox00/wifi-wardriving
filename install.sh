#!/bin/bash

# === Install dependencies for wardrive.sh ===
echo "[+] Installing dependencies for wardrive.sh..."
sudo apt-get install -y aircrack-ng gpsd gpsd-clients gpsbabel -y

# === Instructions for setting variables ===
echo "[+] Use a text editor to edit the wardrive.sh script and set the following variables:"
echo "  - GPS_DEV: The GPS device (e.g., /dev/ttyUSB0)"
echo "  - WIRELESS_IFACE: The wireless interface (e.g., wlan1)"
echo "  - CAPTURE_PREFIX: The prefix for the capture files (e.g., wardrive_capture)"
echo "[+] Make sure to give execute permissions to the script:"

# === Give execute permissions to wardrive.sh ===
echo "[-_-] Giving execute permissions to wardrive.sh..."
chmod +x wardrive.sh

# === How to run the script ===
echo "[+] To run the script, use the following command:"
echo "[+] sudo bash wardrive.sh"

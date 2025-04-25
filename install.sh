#!/bin/bash

# === Install dependencies for wardrive.sh ===
echo "[+] Installing dependencies for wardrive.sh..."
sudo apt-get install aircrack-ng gpsd gpsd-clients gpsbabel python3 -y

# === Instructions for setting variables ===
echo -e "\e[1;34m# === Instructions for setting variables ===\e[0m"
echo -e "\e[1;32m[+]\e[0m \e[1mUse a text editor to edit the \e[4mwardrive.sh\e[24m script and set the following variables:\e[0m"
echo -e "  \e[1;33m- GPS_DEV:\e[0m \e[36mThe GPS device (e.g., /dev/ttyUSB0)\e[0m"
echo -e "  \e[1;33m- WIRELESS_IFACE:\e[0m \e[36mThe wireless interface (e.g., wlan1)\e[0m"
# === Give execute permissions to wardrive.sh ===
echo -e "\e[1;34m# === Give execute permissions to wardrive.sh ===\e[0m"
echo -e "\e[1;36m[-_-]\e[0m \e[1mGiving execute permissions to \e[4mwardrive.sh\e[24m...\e[0m"
chmod +x wardrive.sh

# === How to run the script ===
echo -e "\e[1;34m# === How to run the script ===\e[0m"
echo -e "\e[1;32m[+]\e[0m \e[1mTo run the script, use the following command:\e[0m"
echo -e "\e[1;32m[+]\e[0m \e[1;33msudo bash wardrive.sh\e[0m"

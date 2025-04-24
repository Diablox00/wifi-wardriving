# Wifi Wardriving

This project provides a Bash script for wardriving with a Raspberry Pi 5 or laptop, a G‑Mouse VK‑162 GPS module, and a wireless adapter. It captures WiFi network data with **airodump-ng**, logs GPS coordinates via **gpsd**, and converts them into GPX format for use with mapping tools such as **WiGLE** and **Google Earth**.

## 🚗 Features

- **GPS Logging**: Captures GPS data from a connected GPS device using `gpsd`.
- **Monitor Mode**: Puts the wireless interface into monitor mode to sniff WiFi networks.
- **Automated Capture**: Records WiFi networks alongside GPS coordinates.
- **GPX Conversion**: Converts GPS logs to GPX for easy import into mapping applications.

## 📦 Requirements

Tested on **Kali Linux** (or any Debian-based distribution) running on a Raspberry Pi 5 or a laptop. You will need:

- **GPS Module** (e.g., G‑Mouse VK‑162) connected via USB
- **Wireless Adapter** that supports monitor mode (e.g., Alfa AWUS036ACH)
- **aircrack-ng** suite (`airodump-ng`)
- **gpsd** and **gpsd-clients** for GPS handling
- **gpsbabel** for GPX conversion

## 🔧 Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Diablox00/wifi-wardriving.git
   cd wifi-wardriving
   ```

2. **Install dependencies**:
   ```bash
   sudo bash install.sh
   ```

3. **Configure the script**:
   Open `wardrive.sh` in your preferred editor and set:
   - `GPS_DEV` (e.g., `/dev/ttyUSB0`)
   - `WIRELESS_IFACE` (e.g., `wlan1`)
   - `CAPTURE_PREFIX` (e.g., `wardrive_capture`)

4. **Make the script executable**:
   ```bash
   chmod +x wardrive.sh
   ```

## 📝 Usage

Run the script with superuser privileges:

```bash
sudo bash wardrive.sh
```

The script will:
1. Stop any running `gpsd` service.
2. Start `gpsd` on the specified `GPS_DEV`.
3. Wait for a GPS fix.
4. Enable monitor mode on the wireless interface.
5. Launch `airodump-ng` to capture WiFi data with GPS logging.
6. Convert the GPS log file into GPX format.
7. Cleanup and restore network settings.

### 📁 Output Files

- `wardrive_capture-01.cap` — Captured packet dump
- `wardrive_capture-01.csv` — CSV summary of detected networks
- `wardrive_capture-01.gps` — Raw GPS log (NMEA)
- `wardrive_capture-01.gpx` — GPX file for mapping

## 🌐 Upload to WiGLE

Map your route by uploading the GPX file to WiGLE:

1. Visit [WiGLE Upload](https://wigle.net/upload).
2. Log in to your WiGLE account.
3. Upload `wardrive_capture-01.gpx`.
4. (Optional) Upload the `.csv` or `.netxml` for additional details.

## 🔒 License

This project is released under the **MIT License**. See [LICENSE](LICENSE) for details.

## 💬 Questions

If you encounter any issues or have questions, please open an issue in this repository.

Happy wardriving! 🚗📡


# wifi-wardriving
This project provides a bash script for wardriving with a Raspberry Pi 5 or laptop, G-Mouse VK-162 GPS module, and a wireless adapter. It captures WiFi network data with airodump-ng, logs GPS coordinates, and converts them to GPX format for use with tools like WiGLE and Google Earth.

Got it! Here's an updated `README.md` without the installation steps since the script handles that for the user:

```markdown
# Wardriving with Raspberry Pi 5, Laptop, and GPS

This repository contains a script for performing wardriving using either a **Raspberry Pi 5** or a **laptop**, a **GPS module** (G-Mouse VK-162), and a wireless adapter that supports monitor mode. The script uses `airodump-ng` to capture WiFi networks and logs GPS coordinates for visualization. It is designed to be simple and easy to use for wardriving enthusiasts.

## 🚗 Features

- **GPS Logging**: Uses `gpsd` to get GPS data from a connected GPS device.
- **Monitor Mode**: Switches the wireless interface into monitor mode to capture wireless networks.
- **Automated Capture**: Automatically logs WiFi networks with GPS data.
- **GPX Conversion**: Converts GPS log data into GPX format for use with mapping tools like **WiGLE** and **Google Earth**.

## 📦 Requirements

Before using the script, ensure that your **Raspberry Pi 5** or **laptop** is set up with **Kali Linux** or any Linux distribution supporting the required tools. You will also need the following hardware:

- **GPS Module**: G-Mouse VK-162 (connected via USB)
- **Wireless Adapter**: Any wireless adapter supporting monitor mode (e.g., Alfa AWUS036ACH)
- **Laptop** or **Raspberry Pi 5** with Kali Linux or a similar Linux distribution installed

Additionally, the following software packages are required:

- `aircrack-ng` for capturing and analyzing wireless networks
- `gpsd` and `gpsd-clients` for GPS device management
- `gpsbabel` for converting GPS logs into GPX format

## 🔧 Installation

To install the required dependencies, simply run the provided `install.sh` script:

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/yourusername/wardriving.git
   cd wardriving
   ```

2. Run the `install.sh` script to install necessary dependencies and set permissions:

   ```bash
   sudo bash install.sh
   ```

3. After installing the dependencies, you'll need to edit the `wardrive.sh` script to configure the following variables:
   - `GPS_DEV`: The GPS device (e.g., `/dev/ttyUSB0`)
   - `WIRELESS_IFACE`: The wireless interface (e.g., `wlan1`)
   - `CAPTURE_PREFIX`: The prefix for the capture files (e.g., `wardrive_capture`)

   You can edit these variables using a text editor (e.g., `nano wardrive.sh`).

4. Ensure that the script has execute permissions:

   ```bash
   chmod +x wardrive.sh
   ```

## 📝 Usage

Once everything is set up, you can run the script to start wardriving:

```bash
sudo bash wardrive.sh
```

The script will:
1. Stop the `gpsd` service if running.
2. Start `gpsd` to get GPS data from your GPS device.
3. Wait for GPS to get a fix.
4. Put your wireless interface into monitor mode.
5. Start `airodump-ng` to capture WiFi networks along with GPS data.
6. Convert the GPS log file into GPX format.
7. Stop `airodump-ng` and clean up.

### 📁 Output Files:
- `wardrive_capture-01.cap`: Captured packets.
- `wardrive_capture-01.csv`: Summary of networks.
- `wardrive_capture-01.gps`: GPS log file.
- `output.gpx`: GPX file for use with mapping tools like **WiGLE** or **Google Earth**.

## 🌐 Upload to WiGLE

You can upload your captured GPX data to WiGLE for mapping your wardriving route:

1. Go to [WiGLE Upload](https://wigle.net/upload).
2. Login to your WiGLE account.
3. Upload the `output.gpx` file.
4. Optionally, upload `wardrive_capture-01.csv` or `.netxml` for additional network data.

## 🔒 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 💬 Questions?

If you have any questions or issues, feel free to open an issue in this repository, and I'll get back to you as soon as possible!

---

Happy wardriving! 🚗📡
```




# Printer Configurations

This repository contains configuration files for my 3D printers running Klipper firmware.

## Quick Start

Choose your installation method:
- **[Raspberry Pi Setup](#raspberry-pi-setup)** - Recommended for dedicated printer host
- **[Prind (Docker) Setup](#prind-docker-setup)** - For running on any Linux machine with Docker
- **[Deployment](#deployment)** - Deploy configs to existing installation

---

## Printers

### Ender 3 V2
- **Firmware**: Klipper
- **Interface**: Fluidd
- **Config**: `ender3v2/printer.cfg`
- **Mainboard**: Creality 4.2.2 or 4.2.7 (STM32F103)
- **Serial**: `/dev/ttyPrinter` (udev symlink) or `/dev/serial/by-id/...`

**Hardware:**
- Stock Ender 3 V2 configuration
- 0.4mm nozzle
- Bowden extruder
- Manual bed leveling (bed_screws)

**Performance Upgrades:**
- Max acceleration: 7000 mm/s² (vs 3000 stock)
- Max velocity: 300 mm/s
- Square corner velocity: 5.0 mm/s
- Input shaping: MZV @ 40Hz (both X/Y axes)
- Pressure advance: Ready to tune (currently 0.0)

---

## Raspberry Pi Setup

### Method 1: Pre-built Image (Easiest - Recommended)

**FluiddPi** (ready-to-use image):

1. **Download FluiddPi**
   ```bash
   # Get latest from: https://github.com/fluidd-core/FluiddPi/releases
   ```

2. **Flash to SD card** (8GB+ recommended)
   - Use Raspberry Pi Imager or balenaEtcher
   - Flash the FluiddPi image to SD card

3. **Boot Raspberry Pi**
   - Insert SD card
   - Connect Pi to network (Ethernet or WiFi)
   - Power on
   - Wait 2-3 minutes for first boot

4. **Access Fluidd**
   - Open browser to `http://fluiddpi.local` or `http://<pi-ip-address>`

5. **Flash Klipper to printer MCU**
   ```bash
   # SSH into Pi
   ssh pi@fluiddpi.local  # default password: raspberry
   
   # Configure firmware
   cd ~/klipper
   make menuconfig
   ```
   
   **Settings for Ender 3 V2 (4.2.2/4.2.7 board):**
   - Micro-controller: `STM32`
   - Processor model: `STM32F103`
   - Bootloader offset: `28KiB`
   - Communication: `Serial (on USART1 PA10/PA9)`
   
   ```bash
   make clean
   make
   
   # Flash to printer (connect USB first)
   sudo service klipper stop
   make flash FLASH_DEVICE=/dev/serial/by-id/usb-1a86_USB2.0-Serial-*
   sudo service klipper start
   ```

6. **Deploy configuration**
   ```bash
   # Clone this repo
   cd ~
   git clone <your-repo-url> printer-configs
   
   # Copy config
   cp ~/printer-configs/ender3v2/printer.cfg ~/printer_data/config/printer.cfg
   
   # Restart Klipper
   sudo service klipper restart
   ```

7. **Done!** Access Fluidd and start printing

---

### Method 2: KIAUH (Manual Installation)

**KIAUH** = Klipper Installation And Update Helper

1. **Fresh Raspberry Pi OS**
   - Install Raspberry Pi OS Lite (64-bit recommended)
   - Enable SSH
   - Boot and connect to network

2. **Install KIAUH**
   ```bash
   # SSH into Pi
   ssh pi@<pi-ip>
   
   # Install dependencies
   sudo apt update
   sudo apt install git -y
   
   # Clone KIAUH
   cd ~
   git clone https://github.com/dw-0/kiauh.git
   ```

3. **Run KIAUH**
   ```bash
   ~/kiauh/kiauh.sh
   ```
   
   **Install in order:**
   - [1] Install → Klipper
   - [1] Install → Moonraker
   - [1] Install → Fluidd (or Mainsail)

4. **Flash firmware to printer** (same as Method 1 step 5)

5. **Deploy config** (same as Method 1 step 6)

---

## Prind (Docker) Setup

**Prind** runs Klipper/Moonraker/Fluidd in Docker containers. Works on any Linux machine.

### Requirements
- Docker & Docker Compose
- Linux host (tested on Ubuntu/Debian)
- USB connection to printer

### Installation

1. **Install Docker**
   ```bash
   curl -fsSL https://get.docker.com -o get-docker.sh
   sudo sh get-docker.sh
   sudo usermod -aG docker $USER
   # Log out and back in
   ```

2. **Clone Prind**
   ```bash
   cd ~
   git clone https://github.com/mkuf/prind.git
   cd prind
   ```

3. **Configure**
   ```bash
   # Copy example config
   cp docker-compose.override.yaml.example docker-compose.override.yaml
   
   # Edit if needed (usually works as-is)
   nano docker-compose.override.yaml
   ```

4. **Set up udev rule for stable USB connection**
   ```bash
   # Find your printer's USB ID
   lsusb
   # Look for CH340 or similar
   
   # Create udev rule
   sudo nano /etc/udev/rules.d/99-printer.rules
   ```
   
   Add:
   ```
   SUBSYSTEM=="tty", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", SYMLINK+="ttyPrinter"
   ```
   
   ```bash
   sudo udevadm control --reload-rules
   sudo udevadm trigger
   ```

5. **Start Prind**
   ```bash
   cd ~/prind
   docker compose up -d
   ```

6. **Flash Klipper firmware** (same config as Pi Method 1)
   ```bash
   docker exec -it prind-klipper-1 bash
   cd /opt/klipper
   make menuconfig
   # Configure as above
   make
   make flash FLASH_DEVICE=/dev/ttyPrinter
   exit
   ```

7. **Deploy config**
   ```bash
   # Clone this repo
   cd ~
   git clone <your-repo-url> printer-configs
   
   # Copy config
   cp ~/printer-configs/ender3v2/printer.cfg ~/prind/config/printer.cfg
   
   # Restart Klipper
   docker restart prind-klipper-1
   ```

8. **Access Fluidd**
   - Open browser to `http://localhost` or `http://<host-ip>`

---

## Deployment

### Deploy to Existing Installation

**For Prind:**
```bash
cp ~/printer-configs/ender3v2/printer.cfg ~/prind/config/printer.cfg
docker restart prind-klipper-1
```

**For Raspberry Pi (FluiddPi/KIAUH):**
```bash
cp ~/printer-configs/ender3v2/printer.cfg ~/printer_data/config/printer.cfg
sudo service klipper restart
```

**Via Fluidd UI:**
1. Open Fluidd web interface
2. Go to **Configuration** tab
3. Upload `printer.cfg`
4. Click **Save & Restart**

---

## Troubleshooting

### USB Connection Issues

**Problem**: Klipper connects via USB but disconnects when printer powers on

**Solution**: 5V power conflict between USB and printer PSU

Options:
1. **Power printer on first** before connecting/booting host (quickest)
2. **Tape the 5V pin** on USB cable (cover pin 1 with electrical tape)
3. **Cut red wire** in USB cable (permanent fix)
4. **Use USB isolator** (cleanest, costs $10-20)

### Serial Port Not Found

**Check available ports:**
```bash
ls /dev/serial/by-id/*
```

**Update printer.cfg:**
```ini
[mcu]
serial: /dev/serial/by-id/usb-1a86_USB2.0-Serial-if00-port0
# Or use symlink:
# serial: /dev/ttyPrinter
```

### MCU Firmware Flashing Failed

1. **Enter bootloader mode** - Some boards need a jumper or button press
2. **Try different flash command:**
   ```bash
   # For boards with SD card bootloader:
   make
   # Copy out/klipper.bin to SD card, rename to firmware.bin
   # Insert SD, power on printer
   ```

### Bed Leveling

**Manual leveling workflow:**
```gcode
G28              # Home all axes
BED_SCREWS_ADJUST  # Start bed leveling helper
# Adjust each corner with paper test
ACCEPT           # Move to next corner
# Repeat until all corners are level
```

---

## Calibration & Tuning

### After First Setup

1. **PID Tuning**
   ```gcode
   # Hotend
   PID_CALIBRATE HEATER=extruder TARGET=210
   SAVE_CONFIG
   
   # Bed
   PID_CALIBRATE HEATER=heater_bed TARGET=60
   SAVE_CONFIG
   ```

2. **E-steps Calibration**
   - Mark 120mm of filament from extruder entry
   - Extrude 100mm
   - Measure remaining distance
   - Calculate and update `rotation_distance` in printer.cfg

3. **Pressure Advance Tuning**
   - Generate test pattern: https://www.klipper3d.org/Pressure_Advance.html
   - Update `pressure_advance` value in printer.cfg (typically 0.3-0.9 for Bowden)

4. **Input Shaper Calibration** (optional, requires ADXL345 accelerometer)
   ```gcode
   SHAPER_CALIBRATE
   SAVE_CONFIG
   ```

### Slicer Settings

**OrcaSlicer Profile**: `SPEEED`
- Outer walls: 60 mm/s
- Inner walls: 100 mm/s
- Infill: 150 mm/s
- Travel: 250 mm/s
- Acceleration: 7000 mm/s²

---

## Backup & Version Control

**Save configuration changes:**
```bash
cd ~/printer-configs
cp ~/prind/config/printer.cfg ender3v2/  # Or from ~/printer_data/config/
git add .
git commit -m "Updated acceleration settings"
git push
```

**Restore from backup:**
```bash
cd ~/printer-configs
git pull
# Deploy as above
```

---

## Hardware Notes

### Ender 3 V2 Specifics

- **Mainboard**: 32-bit Creality 4.2.2 or 4.2.7
  - STM32F103 MCU
  - TMC2208 or TMC2209 stepper drivers (silent)
  - 28KiB bootloader offset

- **USB Chip**: CH340 (common source of 5V conflicts)

- **Endstops**: Mechanical switches (normally open)
  - X: PA5
  - Y: PA6  
  - Z: PA7

- **Power**: 24V PSU
  - Bed: 24V 235W
  - Hotend: 24V 40W

---

## Resources

- **Klipper Documentation**: https://www.klipper3d.org/
- **Fluidd**: https://docs.fluidd.xyz/
- **Prind GitHub**: https://github.com/mkuf/prind
- **KIAUH GitHub**: https://github.com/dw-0/kiauh
- **FluiddPi Releases**: https://github.com/fluidd-core/FluiddPi/releases

---

## License

Configuration files in this repository are provided as-is for personal use.

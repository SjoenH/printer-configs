# Printer Configurations

This repository contains configuration files for my 3D printers running Klipper firmware.

## Quick Start

**New to 3D printing?** Check the **[Glossary](#3d-printing-glossary)** below for explanations of common terms and problems.

Choose your installation method:
- **[Raspberry Pi Setup](#raspberry-pi-setup)** - Recommended for dedicated printer host
- **[Prind (Docker) Setup](#prind-docker-setup)** - For running on any Linux machine with Docker
- **[Deployment](#deployment)** - Deploy configs to existing installation
- **[Fire-Safety Enclosure](FIRE-SAFETY-ENCLOSURE.md)** - ⚠️ **For multi-day unattended printing**

---

## 3D Printing Glossary

### Common Terms

#### Hardware Terms
- **Bowden Extruder**: Extruder motor mounted on frame, pushes filament through long tube to hotend. Lighter printhead = faster speeds, but harder to tune retractions.
- **Direct Drive**: Extruder motor mounted directly on printhead. Better control, easier tuning, but heavier = slower speeds.
- **Hotend**: The heated part that melts filament (nozzle + heater block + heat sink).
- **Nozzle**: The brass tip where melted plastic comes out. Common sizes: 0.4mm (standard), 0.6mm (faster), 0.2mm (detail).
- **Heat Break**: The tube separating hot and cold zones in the hotend. Critical for preventing heat creep.
- **PTFE Tube**: Teflon tube that guides filament from extruder to hotend (Bowden) or inside hotend (all-metal vs PTFE-lined).
- **Mainboard/MCU**: The printer's brain - runs Klipper firmware. Ender 3 V2 has STM32F103 chip.

#### Firmware & Software
- **Klipper**: Advanced 3D printer firmware that runs on host computer + printer MCU. This is what we're using.
- **Marlin**: Traditional firmware that runs entirely on printer MCU. Stock Ender 3 V2 firmware.
- **Fluidd/Mainsail**: Web interfaces for Klipper (like OctoPrint but modern).
- **Moonraker**: API server that connects Klipper to web interfaces.
- **OrcaSlicer/PrusaSlicer/Cura**: Software that converts 3D models (STL) into printer instructions (G-code).

#### Motion & Speed Settings
- **Acceleration** (mm/s²): How fast the printer speeds up/slows down. Higher = faster prints but more vibration.
  - Stock Ender 3 V2: 3000 mm/s²
  - Our setup: 7000 mm/s²
  - High-end: 10,000-20,000 mm/s²

- **Velocity/Speed** (mm/s): How fast the printhead moves.
  - Outer walls: 40-80 mm/s (quality)
  - Infill: 150-300 mm/s (speed)
  - Travel moves: 150-300 mm/s

- **Jerk/Square Corner Velocity**: Max speed change without slowing down. Lower = smoother corners, higher = faster prints.

#### Advanced Tuning Features

##### **Pressure Advance** (PA)
**What it is:** Compensates for the delay between extruder pushing filament and plastic coming out the nozzle.

**The problem:** When extruder speeds up, there's a lag before flow increases → under-extrusion at corners. When it slows down, pressure keeps pushing → over-extrusion (bulging corners).

**How it works:** Klipper adjusts extruder speed slightly ahead of time to compensate for pressure buildup in the hotend.

**Values:**
- Bowden extruders: 0.5-1.0 (long tube = more pressure delay)
- Direct drive: 0.0-0.3 (short path = less delay)
- Our current setting: 0.65

**Signs you need to tune it:**
- Bulging corners (PA too low)
- Gaps at corners (PA too high)
- Inconsistent line width

**See:** [TUNING-GUIDE.md](TUNING-GUIDE.md) for calibration procedure.

##### **Input Shaping**
**What it is:** Eliminates ringing/ghosting (wavy lines after sharp corners) by measuring printer's natural vibration frequency and compensating.

**How it works:** Klipper sends micro-vibrations to cancel out the printer's resonance, like noise-cancelling headphones but for motion.

**Types:**
- MZV (our setting): Balanced, good for most printers
- EI: Aggressive ringing reduction
- 2HUMP_EI: Even more aggressive

**Our setup:** MZV @ 40Hz on both X and Y axes

##### **Retraction**
**What it is:** Pulling filament back slightly when moving between printed parts to prevent oozing/stringing.

**Settings:**
- **Distance**: How far to pull back (mm)
  - Bowden: 4-8mm (long tube)
  - Direct drive: 0.5-2mm (short path)
  - Our setting: 6.5mm
  
- **Speed**: How fast to retract (mm/s)
  - Typical: 25-50 mm/s
  - Our setting: 45 mm/s

- **Z-hop**: Lift nozzle during travel moves to avoid hitting print
  - Our setting: 0.2mm

**Signs of bad retraction:**
- Stringing/cobwebbing (not enough retraction)
- Grinding filament (too much retraction)
- Clogs (too much retraction pulls molten plastic into cold zone)

##### **Flow Rate / E-steps**
**What it is:** How much filament the extruder pushes per mm of movement.

**E-steps:** Motor steps per mm of filament. Should be calibrated to actual filament diameter.

**Flow rate:** Percentage multiplier (100% = perfect, 95% = slight under-extrusion).

**Signs of bad calibration:**
- Gaps between lines (under-extrusion)
- Blobby prints (over-extrusion)

---

### Common Print Problems

#### Stringing / Cobwebbing
**What:** Thin plastic strands between printed parts.
**Causes:** 
- Retraction distance too low
- Temperature too high
- Nozzle oozing during travel moves
**Fixes:** Increase retraction, lower temperature 5-10°C, enable Z-hop

#### Ringing / Ghosting
**What:** Wavy ripple pattern after sharp corners.
**Causes:** Printer vibration/resonance at high speeds.
**Fixes:** Input shaping (already enabled), lower acceleration, add dampening feet

#### Layer Shifting
**What:** Print suddenly shifts horizontally mid-print.
**Causes:** 
- Loose belts
- Acceleration too high
- Mechanical collision
**Fixes:** Tighten belts, lower acceleration, check for obstructions

#### Bed Adhesion Issues
**What:** Print doesn't stick to bed or warps/lifts at corners.
**Causes:**
- Bed not level
- Nozzle too far from bed
- Bed too cold
- Dirty bed surface
**Fixes:** 
- Level bed with `BED_SCREWS_ADJUST`
- Lower Z offset (get nozzle closer)
- Increase bed temp 5-10°C
- Clean bed with isopropyl alcohol

#### Under-extrusion
**What:** Gaps in print, weak layers, missing infill.
**Causes:**
- E-steps not calibrated
- Flow rate too low
- Partial clog in nozzle
- Pressure advance too high
**Fixes:** Calibrate E-steps, check for clogs, lower pressure advance

#### Over-extrusion
**What:** Blobby surface, elephant foot, layers squished together.
**Causes:**
- E-steps over-calibrated
- Flow rate too high  
- First layer too close to bed
**Fixes:** Calibrate E-steps, reduce flow rate, raise Z offset

#### Heat Creep
**What:** Filament softening too early in the cold zone, causing jams.
**Causes:**
- Cooling fan failed
- PTFE tube not seated properly (our current situation!)
- Printing too hot
- Ambient temperature too high
**Fixes:** Check hotend fan, reseat PTFE tube properly, lower temp, add enclosure cooling

#### Blobs and Zits
**What:** Random bumps on surface where layer starts/stops.
**Causes:**
- Z-seam placement
- Oozing at layer change
- Pressure not released properly
**Fixes:** Tune pressure advance, adjust retraction, use "aligned" Z-seam placement

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

## Why Klipper?

### Klipper vs Stock Marlin

**Why we chose Klipper for this setup:**

#### Performance Advantages ✅
- **2-3x faster prints** - 7000 mm/s² acceleration vs 3000 stock
- **Input shaping** - Eliminates ringing/ghosting at high speeds
- **Smoother motion** - 32-bit math provides better motion planning
- **Better print quality** - Pressure advance, resonance compensation

#### Workflow Benefits ✅
- **Web interface** - Fluidd provides modern UI vs clunky LCD menus
- **Live config changes** - Edit settings without recompiling/reflashing
- **Remote access** - Control printer from anywhere
- **Powerful macros** - Python-like scripting for automation

#### Trade-offs ⚖️
- **Requires host computer** - Raspberry Pi or always-on server needed
- **More complex setup** - Initial configuration takes 2-4 hours
- **Two systems to maintain** - Printer MCU + host computer
- **USB power conflicts** - Need to power printer first (see troubleshooting)

**Bottom line:** Klipper is worth it for the performance and features, but requires technical comfort with Linux.

**See full comparison:** [Klipper vs Marlin detailed breakdown](#klipper-vs-marlin-detailed-comparison) (bottom of page)

---

## How Klipper Works: Architecture Explained

### Component Overview

Klipper splits the work between two systems:
1. **Host Computer** (Raspberry Pi or Docker server) - Does the complex math
2. **Printer MCU** (mainboard in your printer) - Does the precise motor control

This is different from Marlin, which does everything on the printer's MCU.

### Full System Architecture

```
┌───────────────────────────────────────────────────────────────────┐
│                          YOUR SETUP                               │
│                                                                   │
│  ┌──────────────┐                    ┌──────────────────────┐    │
│  │   Browser    │◄──── Network ─────►│   Home Server        │    │
│  │  (Phone/PC)  │      (WiFi/LAN)    │   (Docker/Prind)     │    │
│  │              │                    │                      │    │
│  │  Fluidd UI   │                    │  ┌───────────────┐   │    │
│  │  - Start/Stop│                    │  │   Fluidd      │   │    │
│  │  - Monitor   │                    │  │   (Web UI)    │   │    │
│  │  - Upload    │                    │  └───────┬───────┘   │    │
│  │    G-code    │                    │          │           │    │
│  └──────────────┘                    │  ┌───────▼───────┐   │    │
│                                       │  │   Moonraker   │   │    │
│                                       │  │  (API Server) │   │    │
│                                       │  └───────┬───────┘   │    │
│                                       │          │           │    │
│                                       │  ┌───────▼───────┐   │    │
│                                       │  │   Klipper     │   │    │
│                                       │  │  (Firmware)   │   │    │
│                                       │  │               │   │    │
│                                       │  │  - G-code     │   │    │
│                                       │  │    parsing    │   │    │
│                                       │  │  - Motion     │   │    │
│                                       │  │    planning   │   │    │
│                                       │  │  - Input      │   │    │
│                                       │  │    shaping    │   │    │
│                                       │  │  - Pressure   │   │    │
│                                       │  │    advance    │   │    │
│                                       │  └───────┬───────┘   │    │
│                                       └──────────┼───────────┘    │
│                                                  │                │
│                                          USB Cable (Serial)       │
│                                                  │                │
│                              ┌───────────────────▼─────────────┐  │
│                              │   Ender 3 V2 Mainboard          │  │
│                              │   (STM32F103 MCU)               │  │
│                              │                                 │  │
│                              │  Klipper MCU Firmware           │  │
│                              │  - Receives motion commands     │  │
│                              │  - Controls stepper drivers     │  │
│                              │  - Reads sensors (temps, etc.)  │  │
│                              │  - Sends status back to host    │  │
│                              └─────┬─────┬──────┬──────┬───────┘  │
│                                    │     │      │      │          │
│                       ┌────────────┘     │      │      └──────┐   │
│                       │                  │      │             │   │
│                ┌──────▼───────┐   ┌──────▼──────▼──────┐   ┌──▼──▼──┐
│                │   Steppers   │   │    Heaters          │   │ Sensors│
│                │              │   │                     │   │        │
│                │  X, Y, Z     │   │  - Hotend (220°C)   │   │ - Temps│
│                │  Extruder    │   │  - Bed (60°C)       │   │ - Stops│
│                └──────────────┘   └─────────────────────┘   └────────┘
└───────────────────────────────────────────────────────────────────┘
```

### Data Flow: From Click to Movement

```
1. User clicks "Start Print" in browser
   │
   ▼
2. Fluidd sends command to Moonraker API
   │
   ▼
3. Moonraker passes to Klipper
   │
   ▼
4. Klipper reads G-code file
   │
   ▼
5. Klipper processes commands:
   - Parses: "G1 X100 Y100 F3000"
   - Calculates: Motion path, acceleration curve
   - Applies: Input shaping, pressure advance
   - Plans: Optimal step timing for smooth motion
   │
   ▼
6. Klipper sends pre-calculated step commands to MCU
   │
   ▼
7. MCU executes steps with precise timing:
   - Step X motor: 400 steps
   - Step Y motor: 400 steps
   - Adjust extruder: 15 steps (with pressure advance)
   │
   ▼
8. Motors move, print head travels to X100 Y100
   │
   ▼
9. MCU sends status back to Klipper
   │
   ▼
10. Browser shows updated position in real-time
```

### Component Deep Dive

#### **Fluidd (Web Interface)**
- **What it does**: Pretty web UI you interact with
- **Runs on**: Host computer (Pi/Docker)
- **Access**: Browser at `http://fluiddpi.local` or `http://<server-ip>:4408` (Prind)
- **Features**:
  - Upload and start prints
  - Live camera feed
  - Temperature graphs
  - Macro buttons (START_PRINT, BED_SCREWS_ADJUST, etc.)
  - Config file editor
  - Console for manual commands

#### **Moonraker (API Server)**
- **What it does**: Translates between Fluidd and Klipper
- **Runs on**: Host computer (same as Klipper)
- **Also handles**:
  - File uploads
  - Webcam streaming
  - Update management
  - Power control (if configured)
  - History and statistics

#### **Klipper (The Brain)**
- **What it does**: All the smart motion planning
- **Runs on**: Host computer (Python process)
- **Responsibilities**:
  - Parse G-code into motion commands
  - Calculate acceleration curves
  - Apply input shaping (cancel vibrations)
  - Apply pressure advance (smooth extrusion)
  - Temperature PID control
  - Macro execution
  - Safety checks (temperature limits, position limits)
- **Why it's fast**: Uses 32-bit floating point math on powerful host CPU instead of limited 8/32-bit MCU

#### **Klipper MCU Firmware**
- **What it does**: Precise, real-time step execution
- **Runs on**: Printer mainboard (STM32F103 in Ender 3 V2)
- **Responsibilities**:
  - Receive step commands from host Klipper
  - Generate step pulses at exact microsecond timing
  - Read temperature sensors
  - Monitor endstops
  - Control heaters (on/off based on Klipper's PID calculations)
  - Send status updates back to host
- **Why it's simple**: Only does timing-critical tasks, no complex math

### Communication Protocol

```
Host Klipper ←────── USB Serial (115200 baud) ─────→ Printer MCU
             
Commands sent (examples):
  → "queue_step oid=5 interval=2000 count=400 add=0"
  → "set_digital_out pin=PA1 value=1"  (turn on heater)
  → "get_temperature sensor=0"

Responses received:
  ← "temperature sensor=0 value=22.5"
  ← "endstop_state oid=3 triggered=1"
```

### Comparison: Klipper vs Marlin Architecture

```
┌──────────────────── KLIPPER ──────────────────────┐
│                                                    │
│  Host Computer (Powerful CPU)                     │
│  ├─ Complex math (motion planning)                │
│  ├─ Input shaping calculations                    │
│  ├─ Pressure advance                              │
│  ├─ G-code parsing                                │
│  └─ Web interface                                 │
│       │                                            │
│       │ USB (Simple step commands)                │
│       ▼                                            │
│  Printer MCU (Fast, precise timing)               │
│  ├─ Execute steps                                 │
│  ├─ Read sensors                                  │
│  └─ Send status                                   │
└────────────────────────────────────────────────────┘

┌──────────────────── MARLIN ───────────────────────┐
│                                                    │
│  Printer MCU (Limited 8/32-bit CPU)               │
│  ├─ G-code parsing                                │
│  ├─ Motion planning (limited by CPU speed)        │
│  ├─ Step execution                                │
│  ├─ Sensor reading                                │
│  ├─ LCD interface                                 │
│  └─ SD card management                            │
│                                                    │
│  Everything happens here!                         │
│  (Slower but self-contained)                      │
└────────────────────────────────────────────────────┘
```

### Why This Architecture is Faster

1. **Better CPU**: Raspberry Pi (1.5GHz quad-core) vs STM32 (72MHz single-core)
2. **Lookahead**: Klipper can plan 100+ moves ahead, Marlin limited by RAM
3. **Math precision**: 64-bit float on Pi vs 32-bit on MCU = smoother curves
4. **Input shaping**: Requires fast Fourier transforms - too heavy for MCU
5. **No LCD overhead**: MCU just does motion, no screen updates

### Your Specific Setup (Prind Docker)

```
┌──────────────────────────────────────────────────────┐
│  Home Server (Linux)                                 │
│                                                       │
│  Docker Network                                      │
│  ├─ Container: fluidd (port 4408)                   │
│  ├─ Container: moonraker (port 7125)                │
│  └─ Container: klipper                              │
│       │                                              │
│       └─ Mapped device: /dev/ttyPrinter ──┐         │
│                                             │         │
└─────────────────────────────────────────────┼────────┘
                                              │
                        USB Cable ────────────┘
                                              │
                            ┌─────────────────▼────────┐
                            │  Ender 3 V2              │
                            │  (Must power on FIRST)   │
                            └──────────────────────────┘
```

**Important**: Your USB power conflict means the printer must be powered on **before** starting Docker containers or booting the server. Otherwise the MCU doesn't enumerate properly on `/dev/ttyPrinter`.

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

## Camera Setup for Prind

### Overview

Prind supports webcam streaming through the `ustreamer` service. This allows you to monitor your prints remotely through the Fluidd web interface.

### Supported Cameras

- **USB Webcams** (Logitech C270, C920, generic UVC cameras)
- **Raspberry Pi Camera Module** (if running on Pi)
- **Most V4L2-compatible cameras**

### Step-by-Step Setup

#### 1. Connect Camera

**USB Webcam:**
```bash
# Plug in USB camera to your server

# Verify camera is detected
ls /dev/video*
# Should show: /dev/video0 (or video1, video2, etc.)

# Check camera details
v4l2-ctl --list-devices
# Look for your camera name
```

**Expected output:**
```
UVC Camera (046d:0825): /dev/video0
    /dev/video0
    /dev/video1
```

#### 2. Find Camera Device Path

```bash
# List video devices with details
v4l2-ctl --list-formats-ext -d /dev/video0

# Test camera works
ffmpeg -f v4l2 -i /dev/video0 -frames:v 1 /tmp/test.jpg
# Check /tmp/test.jpg to verify image
```

#### 3. Configure Prind for Camera

**Edit `docker-compose.override.yaml`:**

```bash
cd ~/prind
nano docker-compose.override.yaml
```

**Add/modify the `ustreamer` service:**

```yaml
services:
  ustreamer:
    devices:
      - /dev/video0:/dev/webcam  # Map your camera device
    environment:
      USTREAMER_DEVICE: /dev/webcam
      USTREAMER_RESOLUTION: 1280x720  # Adjust for your camera
      USTREAMER_FRAMERATE: 15         # Lower = less CPU usage
      USTREAMER_FORMAT: MJPEG          # MJPEG or YUYV
      USTREAMER_ENCODER: HW            # HW or CPU (HW faster if supported)
```

**Common resolutions:**
- `640x480` - Low quality, fast
- `1280x720` - Good balance (recommended)
- `1920x1080` - High quality, more CPU usage

**Common framerates:**
- `10` - Smooth enough for monitoring
- `15` - Recommended
- `30` - Very smooth but high CPU usage

#### 4. Update Prind Containers

**⚠️ IMPORTANT: This will restart containers - don't do during a print!**

```bash
cd ~/prind
docker compose down
docker compose up -d
```

**Or, if you just want to restart ustreamer without affecting the print:**
```bash
docker compose restart ustreamer
```

#### 5. Verify Camera Stream

**Check ustreamer logs:**
```bash
docker logs prind-ustreamer-1
```

**Should see:**
```
-- Listening HTTP on [0.0.0.0]:8080
-- Device: /dev/webcam
-- Format: MJPEG
-- Resolution: 1280x720
```

**Test stream in browser:**
```
http://<server-ip>:8080/stream
```

You should see your camera feed.

#### 6. Configure Fluidd to Show Camera

**In Fluidd web interface:**

1. Click hamburger menu (☰) → **Settings**
2. Go to **Cameras** section
3. Click **+ Add Camera**
4. Configure:
   - **Name**: `Printer Camera` (or whatever you want)
   - **URL**: `http://<server-ip>:8080/stream`
   - **Type**: `MJPEG Stream`
   - **Flip Horizontal**: ☐ (check if image is mirrored)
   - **Flip Vertical**: ☐ (check if upside down)
5. Click **Save**

**For local access (same machine):**
```
URL: http://localhost:8080/stream
```

**For remote access:**
```
URL: http://<your-server-ip>:8080/stream
```

#### 7. Position Camera

**Mounting tips:**
- Mount above and slightly behind printer bed
- Angle down at 30-45° to see nozzle and print
- Keep lens clean (plastic dust accumulates fast!)
- Avoid direct LED light glare into lens

### Troubleshooting

#### Camera Not Detected

```bash
# Check if device exists
ls -la /dev/video*

# Check permissions
groups $USER
# Should include 'video' group

# If not, add user to video group
sudo usermod -aG video $USER
# Then log out and back in
```

#### Stream Not Working

```bash
# Check ustreamer is running
docker ps | grep ustreamer

# Check ustreamer logs for errors
docker logs prind-ustreamer-1 --tail 50

# Restart ustreamer only
docker compose restart ustreamer
```

#### "Device or resource busy" Error

Another program is using the camera:
```bash
# Find what's using it
sudo lsof /dev/video0

# Kill the process (replace PID)
kill <PID>

# Or restart ustreamer
docker compose restart ustreamer
```

#### Low Framerate / Lag

```yaml
# In docker-compose.override.yaml, reduce quality:
environment:
  USTREAMER_RESOLUTION: 640x480   # Lower resolution
  USTREAMER_FRAMERATE: 10         # Lower FPS
  USTREAMER_ENCODER: HW           # Use hardware encoding if available
```

#### Camera Works But No Image in Fluidd

- Check Fluidd camera URL matches: `http://<server-ip>:8080/stream`
- Try accessing stream directly in browser first
- Check browser console (F12) for CORS or connection errors
- If accessing remotely, ensure port 8080 is not blocked by firewall

### Advanced: Multiple Cameras

**Edit `docker-compose.override.yaml`:**

```yaml
services:
  ustreamer:
    devices:
      - /dev/video0:/dev/webcam0
      - /dev/video1:/dev/webcam1
    environment:
      # Primary camera config...
```

Then configure Fluidd with multiple camera URLs:
- Camera 1: `http://<server-ip>:8080/stream`
- Camera 2: You'll need to run a second ustreamer instance on different port

### Performance Tips

1. **Lower resolution for faster streaming**: 640x480 is usually enough
2. **Reduce framerate**: 10-15 FPS is fine for monitoring prints
3. **Use hardware encoding** if your camera/server supports it
4. **Disable camera during critical operations**: If print quality issues, try disabling stream temporarily

### Camera Recommendations (Norwegian Market)

Budget picks already listed in fire-safety doc:
- **TP-Link Tapo C200**: 350-450 kr (Elkjøp, Komplett)
- **Xiaomi Mi Home Camera**: 350-450 kr (Komplett)

These work with Prind if you can access their RTSP stream, but simple USB webcams are easier.

**USB Webcams (easier with Prind):**
- **Logitech C270**: 300-400 kr (Komplett, Elkjøp)
- **Logitech C920**: 600-800 kr (better quality)
- **Generic USB camera**: 100-200 kr (AliExpress, works fine)

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

## Support Material Optimization

### Why You're Getting Too Much Support

**Common causes:**
1. **Overhang threshold too conservative** (default 45°, try 50-55°)
2. **Support Z-distance too small** (makes supports stick too much)
3. **Auto-support generating everywhere** (use manual/paint-on instead)
4. **Tree supports not enabled** (organic supports use less material)
5. **Model orientation not optimized** (rotating model can eliminate supports)

### Tips to Minimize Supports

#### 1. Orient Your Model Better

**Golden rule:** Minimize overhangs > 45°

```
BAD (needs lots of support):        GOOD (minimal/no support):
     ___                                  ___________
    /   \                                |           |
   /     \                               |           |
  /_______\                              |___________|
  
  Pyramid on point                      Pyramid on base
```

**In OrcaSlicer:**
- Right-click model → **Place on face** (try different faces)
- Use **Lay flat** to automatically find best orientation
- Sometimes rotating 45° or 90° eliminates all supports

#### 2. Adjust Overhang Threshold

**OrcaSlicer:** 
- **Support** tab → **Support overhang threshold**: `50°` or `55°` (default is usually 45°)
- PLA can print up to 50-55° overhang without support if well-tuned
- Test with a [overhang test model](https://www.thingiverse.com/thing:2975429) to find your limit

#### 3. Use Tree Supports (Organic)

**OrcaSlicer:**
- **Support** → **Type**: `Tree (auto)` or `Tree (slim)`
- Tree supports use **50-70% less material**
- Easier to remove
- Less contact with model = cleaner finish

**Settings:**
- **Branch angle**: 40-50° (higher = less supports, might fail)
- **Branch distance**: 3-5mm
- **Tip diameter**: 0.8-1.2mm (smaller = easier removal)

#### 4. Paint-On Supports (Manual)

Instead of auto-generating everywhere:

**OrcaSlicer:**
1. **Support** → **Type**: `Support` (not auto)
2. Click **Paint-on supports** tool (paintbrush icon)
3. Manually paint ONLY where you need support
4. **Ctrl+Click** to remove painted areas (eraser mode)

**Advantages:**
- Only support critical overhangs
- Leave small overhangs unsupported (they might bridge fine)
- Much less material waste

#### 5. Support Z-Gap (Make Supports Easier to Remove)

**OrcaSlicer:**
- **Support** → **Support-object Z gap**: `0.2mm` (increase from default 0.15mm)
- Higher = easier removal, but less stable support
- For PLA: 0.2-0.25mm is good balance

#### 6. Support Interface Layers

**OrcaSlicer:**
- **Support** → **Support interface layers**: `2-3`
- **Interface pattern**: `Rectilinear` or `Grid`
- Creates a "roof" between support and model
- Much cleaner surface when removed

#### 7. Use Built-in Bridges (No Support Needed)

PLA can bridge up to **20-30mm** if settings are right:

**OrcaSlicer Bridge Settings:**
- **Bridge flow**: `0.95` (slightly under-extrude for tight lines)
- **Bridge speed**: `25-40 mm/s` (slower = better bridges)
- **Bridge fan speed**: `100%` (cool filament fast)

Test if your model's overhangs are actually bridges (supported on both ends).

#### 8. Split Model to Avoid Supports

If model has one problematic area:
- Split model in CAD or slicer
- Print parts separately in optimal orientation
- Glue together after (super glue or epoxy)

**In OrcaSlicer:**
- Right-click model → **Split** → **Split to parts**

### Support Material Settings Reference

**Minimal support (risky but clean):**
```
Type: Tree (slim)
Overhang threshold: 55°
Z gap: 0.25mm
Pattern: Grid
Density: 10%
Interface layers: 3
```

**Safe support (more material but reliable):**
```
Type: Tree (auto)
Overhang threshold: 45°
Z gap: 0.2mm
Pattern: Grid
Density: 15%
Interface layers: 2
```

**Manual control (recommended):**
```
Type: Normal (not auto)
Use Paint-on tool
Z gap: 0.2mm
Interface layers: 3
Only paint critical areas
```

### Quick Checklist Before Slicing

- [ ] **Rotate model** to minimize overhangs
- [ ] **Check overhang angle** (50-55° often works without support)
- [ ] **Try tree supports** instead of normal
- [ ] **Use paint-on** for precise control
- [ ] **Increase Z-gap** to 0.2-0.25mm for easier removal
- [ ] **Enable interface layers** for cleaner surface
- [ ] **Consider splitting** model if one area is problematic

### Testing Your Printer's Limits

Print these calibration models to find your limits:

1. **Overhang test**: https://www.thingiverse.com/thing:2975429
   - Find max angle without support (usually 50-55° for PLA)
   
2. **Bridging test**: https://www.thingiverse.com/thing:476845
   - Find max bridge distance (usually 20-30mm for PLA)

3. **Support torture test**: https://www.thingiverse.com/thing:2656594
   - Test support removal difficulty with your settings

### Example: Reducing Support by 80%

**Before (auto-support):**
- Support material: 15g
- Print time: +2 hours
- Hard to remove, damages surface

**After (optimized):**
- Rotate model 90°
- Tree supports only on critical areas
- Z-gap: 0.25mm
- Support material: 3g
- Print time: +20 minutes
- Easy removal, clean surface

---

## Changing Default Support Settings in OrcaSlicer

### Method 1: In the UI (Recommended)

**Set better defaults for your SPEEED profile:**

1. **Open OrcaSlicer**
2. Select your **SPEEED** profile (top right dropdown)
3. Click **Support** tab on the right panel
4. Adjust these settings:

**Recommended defaults:**
```
Support Type: Tree (auto)              ← Much less material
Overhang threshold: 50°                ← PLA can handle this
Support on build plate only: ON        ← Skip interior supports
Tree branch angle: 45°                 ← Good balance
Tree branch distance: 4mm              ← Spacing between branches
```

**For easier removal:**
```
Support-object Z gap: 0.20mm           ← Easier to remove
Support-object XY gap: 0.60mm          ← Side clearance
Interface layers: 3                    ← Cleaner surface
Interface pattern: Rectilinear         ← Strong but easy removal
```

5. **Save to profile**:
   - Click the **floppy disk icon** at the top
   - Or: **File** → **Save Project**
   - Settings are now your new defaults

### Method 2: Edit Profile JSON Directly

**Add to your SPEEED profile:**

```bash
# Backup first
cp ~/.config/OrcaSlicer/user/default/process/SPEEED.json ~/.config/OrcaSlicer/user/default/process/SPEEED.json.backup

# Edit profile
nano ~/.config/OrcaSlicer/user/default/process/SPEEED.json
```

**Add these lines inside the JSON (after existing settings):**

```json
{
    "from": "User",
    "inherits": "0.20mm Standard @Creality Ender3V2",
    "name": "SPEEED",
    
    // ... your existing speed/acceleration settings ...
    
    // Add these support settings:
    "support_type": "tree(auto)",
    "support_threshold_angle": "50",
    "support_on_build_plate_only": "1",
    "support_object_xy_distance": "0.6",
    "support_top_z_distance": "0.2",
    "support_bottom_z_distance": "0.2",
    "support_interface_top_layers": "3",
    "support_interface_bottom_layers": "2",
    "support_interface_pattern": "rectilinear",
    "support_interface_spacing": "0.2",
    "support_base_pattern": "rectilinear",
    "support_base_pattern_spacing": "2.5",
    "tree_support_branch_angle": "45",
    "tree_support_branch_distance": "4",
    "tree_support_branch_diameter": "2",
    "independent_support_layer_height": "0"
}
```

**Restart OrcaSlicer** to load changes.

### Method 3: Create a "Minimal Supports" Preset

**Instead of changing SPEEED, create a new profile:**

1. In OrcaSlicer, click **Process** dropdown (top right)
2. Click **+ Add** or duplicate SPEEED
3. Name it: `SPEEED - Minimal Supports`
4. Adjust support settings as above
5. Save

**Now you have two options:**
- `SPEEED` - Original settings
- `SPEEED - Minimal Supports` - Tree supports, 50° threshold, easy removal

### Verify Your Settings

**After changing defaults, slice a test model:**

1. Load a model with overhangs
2. Click **Slice Plate**
3. Check preview:
   - **Layer view**: See support structure
   - **Color by feature type**: Highlight supports
   - **Info panel (right)**: Check support material weight

**Compare before/after:**
- Original: ~15g supports
- Tree + 50° threshold: ~3-5g supports

### Key Settings Explained

| Setting | Default | Recommended | Effect |
|---------|---------|-------------|--------|
| **Support type** | Normal | Tree (auto) | 50-70% less material |
| **Overhang threshold** | 45° | 50-55° | Less supports, PLA can handle it |
| **Build plate only** | OFF | ON | No interior supports (faster removal) |
| **Z gap** | 0.15mm | 0.20-0.25mm | Easier removal, cleaner surface |
| **Interface layers** | 1 | 3 | Much cleaner bottom surface |
| **Branch angle** | 40° | 45° | Balance between stability and material |

### Backup Your Profile

**Save to Git:**

```bash
cd ~/printer-configs

# Create slicer-profiles directory
mkdir -p slicer-profiles

# Copy your profile
cp ~/.config/OrcaSlicer/user/default/process/SPEEED.json slicer-profiles/

# Commit
git add slicer-profiles/
git commit -m "Add SPEEED profile with optimized support settings"
git push
```

**Restore later:**

```bash
cp ~/printer-configs/slicer-profiles/SPEEED.json ~/.config/OrcaSlicer/user/default/process/
```

### Per-Model Override (Don't Change Defaults)

**If you just want to adjust one print without changing defaults:**

1. Load model
2. Adjust support settings in right panel
3. Slice
4. Settings only apply to current project, not saved to profile

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

## Safety & Advanced Topics

### Multi-Day Unattended Printing

**⚠️ See [FIRE-SAFETY-ENCLOSURE.md](FIRE-SAFETY-ENCLOSURE.md)** for comprehensive guide on:
- Building a fire-resistant printer enclosure
- Remote monitoring with cameras
- Automatic power cutoff with Matter/Zigbee smart plugs
- Smoke detection and alerting
- Home Assistant automations
- Risk mitigation strategies

**Cost:** €410-560 | **Build Time:** 1-2 days | **Skill Level:** Intermediate

### Important Safety Notes

- **Never leave printer unattended without proper safety measures**
- Overnight printing while home is generally safe with basic precautions
- Multi-day printing while away requires significant safety infrastructure
- Always have working smoke detectors and fire extinguisher
- Check your insurance policy regarding unattended manufacturing equipment

---

## Klipper vs Marlin Detailed Comparison

### Performance

| Feature | Klipper (This Setup) | Stock Marlin |
|---------|---------------------|--------------|
| Max Acceleration | 7000 mm/s² | 3000 mm/s² |
| Input Shaping | ✅ Built-in (MZV @ 40Hz) | ❌ Not available |
| Pressure Advance | ✅ Superior algorithm | ⚠️ Basic Linear Advance |
| Motion Planning | 32-bit floating point | 8/32-bit integer (board dependent) |
| Print Speed | Up to 300 mm/s smoothly | ~100-150 mm/s practical limit |
| Quality at Speed | Excellent with tuning | Good at lower speeds |

### Configuration & Workflow

| Aspect | Klipper | Marlin |
|--------|---------|--------|
| **Config Changes** | Edit text file → restart (30 sec) | Edit code → compile → flash (5-10 min) |
| **Interface** | Modern web UI (Fluidd/Mainsail) | LCD screen with button navigation |
| **Remote Access** | Built-in via web browser | Requires OctoPrint (+Pi anyway) |
| **Live Tuning** | Adjust values during print | Must stop, reflash, restart |
| **Macro Language** | Jinja2 templates (powerful) | G-code only (limited) |
| **Bed Mesh** | Advanced algorithms, unlimited points | Basic, limited by RAM |

### Features Comparison

**Klipper Advantages:**
- ✅ Input shaping (eliminates ringing)
- ✅ Resonance testing & auto-tuning
- ✅ Multi-MCU support (add toolboards easily)
- ✅ Pressure advance (better than Linear Advance)
- ✅ Advanced kinematics (easy to switch printer types)
- ✅ Real-time graphs & monitoring
- ✅ G-code preview with toolpath visualization
- ✅ Automatic firmware updates via web UI
- ✅ Temperature curves & PID auto-tune
- ✅ Flexible pin configuration

**Marlin Advantages:**
- ✅ Standalone operation (no host needed)
- ✅ Print from SD card without network
- ✅ Full LCD control (all features accessible)
- ✅ Single point of failure (just the printer)
- ✅ Works offline always
- ✅ Simpler troubleshooting
- ✅ Huge pre-made config library
- ✅ No USB power conflicts

### System Architecture

**Klipper:**
```
Internet → Host Computer (Pi/Docker) → Printer MCU → Hardware
           ↑                           ↑
        Web Browser                USB Connection
        (Fluidd UI)
```

**Marlin:**
```
SD Card → Printer MCU → Hardware
          ↑
    LCD Screen Control
```

### Setup Complexity

**Klipper Initial Setup:**
1. Install host software (Pi/Docker) - 30-60 min
2. Compile & flash MCU firmware - 15-30 min
3. Configure printer.cfg - 1-2 hours
4. Calibration & tuning - 1-2 hours
**Total: 3-5 hours**

**Marlin Initial Setup:**
1. Download pre-configured firmware - 5 min
2. Flash to printer - 5 min
3. Basic calibration - 30 min
**Total: 40 minutes**

### Cost Comparison

| Component | Klipper | Marlin |
|-----------|---------|--------|
| **Printer** | €200-300 (Ender 3 V2) | €200-300 (Ender 3 V2) |
| **Host Computer** | €40-100 (Raspberry Pi) | €0 (not needed) |
| **Power Consumption** | +5-10W (host 24/7) | 0W extra |
| **Networking** | Required (WiFi/Ethernet) | Optional |
| **Total Setup Cost** | +€40-100 | €0 |

### Real-World Speed Comparison

**Benchy (3DBenchy test print):**
- **Stock Marlin:** 3-4 hours (conservative speeds)
- **Klipper (tuned):** 1.5-2 hours (high speeds with input shaping)
- **Klipper (speed profile):** 45-60 min (pushing limits)

**Quality:**
- Marlin at slow speeds: Excellent
- Klipper at medium speeds: Excellent  
- Klipper at high speeds: Good (with proper tuning)

### Reliability & Maintenance

**Klipper:**
- ⚠️ Two systems to maintain (host + printer)
- ⚠️ USB connection can be finicky (power conflicts)
- ⚠️ Network issues affect access (but print continues)
- ⚠️ Host failure = printer unusable until fixed
- ✅ Easy software updates via web UI
- ✅ Config backups are simple text files

**Marlin:**
- ✅ Single, self-contained system
- ✅ Very reliable once configured
- ✅ No network dependencies
- ✅ Works even if everything else fails
- ⚠️ Updates require reflashing
- ⚠️ Config backup = save compiled .hex file

### Use Cases

**Choose Klipper if you:**
- Want maximum print speed and quality
- Are comfortable with Linux/command line
- Have a Raspberry Pi or server running 24/7
- Print frequently and want remote monitoring
- Like tinkering and optimization
- Need advanced features (multi-extruder, custom kinematics)
- Want to run multiple printers from one host

**Choose Marlin if you:**
- Want simple, plug-and-play printing
- Don't want to manage a separate computer
- Print occasionally/casually
- Prefer standalone operation
- Need to print in locations without network
- Are new to 3D printing
- Value simplicity over features

### Migration Path

**Marlin → Klipper (What we did):**
1. Keep Marlin as backup (save firmware)
2. Set up Klipper on separate host
3. Test with simple prints
4. Gradually increase speeds as you tune
5. Can revert to Marlin in 5 minutes if needed

**Klipper → Marlin (If needed):**
1. Download latest Marlin for your board
2. Flash via SD card or USB
3. Configure via LCD or recompile
4. Lose: Speed, web UI, remote access
5. Gain: Standalone operation, simplicity

### Our Experience

**Why we use Klipper on this Ender 3 V2:**

✅ **Print times cut in half** - 7000 mm/s² acceleration vs 3000 stock
✅ **Better quality** - Input shaping eliminates ringing at high speeds
✅ **Remote monitoring** - Check prints from anywhere via Fluidd
✅ **Easy tuning** - Live config changes without reflashing
✅ **Future-proof** - Easy to add upgrades (BLTouch, toolboard, etc.)

**Trade-offs we accepted:**

⚠️ **More complex setup** - Initial 3-4 hour investment in configuration
⚠️ **USB power issues** - Need to power printer on first (documented)
⚠️ **Host dependency** - Running Prind in Docker on home server
⚠️ **Two systems to maintain** - But both are stable once configured

**Verdict:** Worth it for the performance gains, but not for everyone.

### Common Myths

**"Klipper is only for advanced users"**
- Partly true: Setup requires technical knowledge
- False: Once configured, operation is actually easier than Marlin
- FluiddPi/MainsailOS make installation much simpler

**"Marlin is outdated"**
- False: Marlin is actively developed and very capable
- True: Klipper has architectural advantages for performance
- Both are excellent, just different philosophies

**"Klipper is unreliable"**
- False: Very stable when properly configured
- True: More points of failure (host + USB + network)
- Mitigation: Proper setup eliminates most issues

**"You need a Pi for Klipper"**
- False: Can run on any Linux computer (we use Docker)
- True: Pi is most common and well-documented
- Alternatives: Old laptop, NAS, server, even Android

---

## Recommended Resources

### Official Documentation

- **Klipper Documentation**: https://www.klipper3d.org/
  - **Config Reference**: https://www.klipper3d.org/Config_Reference.html - Complete reference for all config options
  - **Pressure Advance Guide**: https://www.klipper3d.org/Pressure_Advance.html - Official calibration procedure
  - **Resonance Compensation**: https://www.klipper3d.org/Resonance_Compensation.html - Input shaping details
  - **G-Codes**: https://www.klipper3d.org/G-Codes.html - All available commands and macros
  
- **Klipper GitHub**: https://github.com/Klipper3d/klipper
  - **Example Configs**: https://github.com/Klipper3d/klipper/tree/master/config
  - Look for `printer-creality-ender3-v2-2020.cfg` for stock reference

- **Fluidd Documentation**: https://docs.fluidd.xyz/
- **Prind (Docker Setup)**: https://github.com/mkuf/prind
- **KIAUH (Klipper Install Script)**: https://github.com/dw-0/kiauh
- **FluiddPi Releases**: https://github.com/fluidd-core/FluiddPi/releases

### Calibration & Tuning Guides (HIGHLY RECOMMENDED)

- **Ellis' Print Tuning Guide**: https://ellis3dp.com/Print-Tuning-Guide/
  - **⭐ BEST comprehensive tuning guide** - Start here!
  - Covers pressure advance, flow rate, retraction, temperature
  - Step-by-step with detailed pictures and explanations
  - Voron-focused but applies to all Klipper printers
  - **Specific sections to read**:
    - Pressure Advance tuning
    - Extrusion multiplier (flow) calibration
    - Temperature tuning
    
- **Teaching Tech Calibration**: https://teachingtechyt.github.io/calibration.html
  - Interactive calibration website
  - Generates test models for download
  - Great for E-steps, flow, temperature towers, retraction tests

### Community Forums & Support

- **Klipper Discourse Forum**: https://klipper.discourse.group/
  - Official community forum - very helpful for technical questions
  - **Search before posting** - many questions already answered
  - Great for troubleshooting and advanced discussions
  
- **Reddit Communities**:
  - **r/klippers**: https://reddit.com/r/klippers - Klipper-specific community
  - **r/ender3v2**: https://reddit.com/r/ender3v2 - Ender 3 V2 specific (all firmware)
  - Good for troubleshooting, upgrade recommendations, print quality discussions
  
- **Discord Servers**:
  - **Klipper Discord**: https://discord.klipper3d.org/ - Real-time help and discussion
  - **Voron Discord**: https://discord.gg/voron - Advanced Klipper users (very helpful even for non-Voron printers)

### Norwegian Communities

- **Facebook Groups**:
  - "3D-printing Norge" - Norwegian 3D printing community
  - Good for local supplier recommendations, finding used parts
  - Share experiences with Norwegian retailers (Komplett, Proshop, etc.)

### Config Examples & Macros

- **Rootiest Zippy Config**: https://github.com/rootiest/zippy-klipper_config
  - Large collection of well-documented macros
  - Excellent START_PRINT, END_PRINT examples
  - Many useful features to adapt for your setup
  
- **GitHub Search**: Search "ender 3 v2 klipper config"
  - Many users share their complete configs
  - Look for repos with similar hardware (mainboard version, extruder type)

### YouTube Channels

- **Teaching Tech** - Excellent calibration tutorials, clear explanations
- **NERO 3D** - Klipper-specific tutorials, beginner-friendly
- **Ellis (Ellis3dp)** - Advanced Klipper content, highly technical
- **Made with Layers** - Voron/Klipper focused, high-quality content

### What to Focus On First (For Your Setup)

1. **Ellis' Pressure Advance Section** - You just set PA to 0.65, verify it's correct
2. **Ellis' Extrusion Multiplier** - Calibrate flow rate for accurate extrusion
3. **Teaching Tech Retraction Test** - Fine-tune your 6.5mm retraction setting
4. **Temperature Tuning** - Find optimal temp for your specific PLA brand (currently 220°C)
5. **Join Klipper Discourse** - For when you have specific questions

---

## License

Configuration files in this repository are provided as-is for personal use.

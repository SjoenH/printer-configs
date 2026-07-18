# Printer Configurations

This repository contains configuration files for my 3D printers.

## Printers

### Ender 3 V2
- **Firmware**: Klipper
- **Interface**: Fluidd via Prind (Docker)
- **Config**: `ender3v2/printer.cfg`
- **Mainboard**: 4.2.2 or 4.2.7
- **Modifications**:
  - Running Klipper with upgraded acceleration (7000 mm/s²)
  - Input shaping enabled (MZV @ 40Hz)
  - Pressure advance configured
  - Manual bed leveling with bed_screws

## Setup

### Current Hardware
- Ender 3 V2 with stock configuration
- 0.4mm nozzle
- Bowden extruder

### Performance Settings
- Max acceleration: 7000 mm/s²
- Max velocity: 300 mm/s
- Square corner velocity: 5.0 mm/s
- Input shaper: MZV type, 40Hz on both axes

### OrcaSlicer Profile
- Profile name: SPEEED
- Located in: `~/.config/OrcaSlicer/user/default/process/`

## Deployment

To deploy configuration to printer:
```bash
cp ender3v2/printer.cfg ~/prind/config/printer.cfg
# Then restart Klipper via Fluidd
```

## Notes

- USB 5V conflict: Power printer on first before connecting USB
- Position_min set to -5.0 for Z-height adjustment during bed leveling

# Print Quality Tuning Guide

Guide for tuning your Ender 3 V2 Klipper setup for optimal print quality.

---

## Temperature Tuning

### Your Filament: PLA (190-220°C range)

**Symptoms & Solutions:**

| Issue | Likely Cause | Solution |
|-------|--------------|----------|
| **Stringing** | Too hot | Lower temp by 5°C (try 205-210°C) |
| **Oozing/blobs** | Too hot | Lower temp by 5-10°C |
| **Under-extrusion** | Too cold | Raise temp by 5°C |
| **Poor layer adhesion** | Too cold | Raise temp by 5-10°C |
| **Rough surface** | Too hot | Lower temp by 5°C |

**Recommended Starting Points:**
- **PLA:** 210°C nozzle, 60°C bed
- **PETG:** 235°C nozzle, 80°C bed
- **ABS:** 245°C nozzle, 100°C bed

### Temperature Tower Test

Print a temperature tower to find your filament's sweet spot:

1. Download: https://www.thingiverse.com/thing:2729076
2. Slice with temperature changes every 10mm height
3. Print: 220°C → 190°C in 5° steps
4. Examine each section for best quality
5. Use that temperature for future prints

**What to look for:**
- Clean bridges and overhangs
- No stringing between towers
- Good layer adhesion (can't pull apart easily)
- Smooth surface finish

---

## Retraction Settings (Anti-Stringing)

**Current Settings (Bowden Extruder):**
- Retraction distance: **6.5mm**
- Retraction speed: **45mm/s**
- Deretraction speed: **30mm/s**
- Z-hop: **0.2mm**
- Minimum travel: **2mm**

### Retraction Tuning

**If you still have stringing:**

1. **Increase retraction distance** (0.5mm increments)
   - Try: 6.5mm → 7.0mm → 7.5mm
   - Max for Bowden: ~8mm (more can cause clogs)

2. **Increase retraction speed**
   - Try: 45mm/s → 50mm/s → 60mm/s
   - Faster = less ooze time

3. **Increase Z-hop** (for really bad stringing)
   - Try: 0.2mm → 0.4mm
   - Nozzle lifts during travel moves

**If you have under-extrusion after retraction:**

1. **Decrease retraction distance**
   - Try: 6.5mm → 6.0mm → 5.5mm

2. **Increase deretraction speed**
   - Try: 30mm/s → 40mm/s

### Retraction Test

Print a retraction test:
- https://www.thingiverse.com/thing:909901
- Prints two towers with long travels between
- Adjust retraction until no strings

---

## Pressure Advance (Klipper Feature)

**What it does:** Compensates for pressure buildup in the nozzle, improving corners and reducing oozing.

**Current Setting:** `pressure_advance: 0.65`

This is a starting point for Bowden extruders. Optimal range: **0.4-0.9** for Bowden.

### Symptoms of Wrong Pressure Advance:

| Too Low (< 0.4) | Too High (> 1.0) |
|-----------------|------------------|
| Bulging corners | Starved corners |
| Oozing after moves | Gaps after direction changes |
| Stringing | Under-extrusion on perimeters |

### Pressure Advance Calibration

**Method 1: Visual Test (Quick)**

1. Print this test: https://www.klipper3d.org/Pressure_Advance.html
2. Generates squares with different PA values
3. Find the value with sharpest corners, no bulging
4. Update in printer.cfg

**Method 2: Klipper Tuning Pattern**

```gcode
SET_VELOCITY_LIMIT SQUARE_CORNER_VELOCITY=1 ACCEL=500
TUNING_TOWER COMMAND=SET_PRESSURE_ADVANCE PARAMETER=ADVANCE START=0 FACTOR=.005
```

Then print a simple square/calibration cube.

**Method 3: Manual Tuning**

Try these values and compare print quality:

```gcode
SET_PRESSURE_ADVANCE ADVANCE=0.4  # Test print
SET_PRESSURE_ADVANCE ADVANCE=0.5  # Test print
SET_PRESSURE_ADVANCE ADVANCE=0.65 # Current (test print)
SET_PRESSURE_ADVANCE ADVANCE=0.8  # Test print
```

When you find the best value:

```ini
# In printer.cfg [extruder] section:
pressure_advance: 0.65  # Your tuned value
```

---

## Flow Rate / E-steps Calibration

**What it does:** Ensures the printer extrudes the exact amount of filament requested.

**Current Setting:** `rotation_distance: 34.406`

### Symptoms of Wrong Flow:

| Under-Extrusion | Over-Extrusion |
|-----------------|----------------|
| Gaps between perimeters | Perimeters touch/overlap |
| Weak top layers | Bumpy, rough surface |
| Stringy, thin walls | Thick, blobby walls |

### E-steps Calibration (Precise Method)

1. **Mark 120mm from extruder entry**
   - Use marker on filament
   - Measure from where it enters extruder

2. **Heat nozzle to printing temp**
   ```gcode
   M104 S210
   ```

3. **Extrude 100mm**
   ```gcode
   G91
   G1 E100 F100
   ```

4. **Measure remaining distance**
   - Should be 20mm from entry point
   - If more than 20mm: Under-extruding
   - If less than 20mm: Over-extruding

5. **Calculate new rotation_distance**
   ```
   new_rotation_distance = old_rotation_distance * (100 / actual_extruded)
   ```
   
   Example:
   - Old: 34.406
   - Extruded: 95mm (so 5mm short of 100mm)
   - New: 34.406 * (100/95) = 36.217

6. **Update printer.cfg**
   ```ini
   rotation_distance: 36.217  # Your calculated value
   ```

7. **Restart Klipper and retest**

### Flow Rate Fine-Tuning (After E-steps)

If E-steps are calibrated but prints still look wrong:

**In OrcaSlicer:**
- Filament Settings → Advanced → Flow ratio
- Default: 1.0 (100%)
- Under-extruding: Try 1.02-1.05 (102-105%)
- Over-extruding: Try 0.95-0.98 (95-98%)

Print a single-wall cube and measure with calipers:
- Walls should be exactly nozzle width (0.4mm)
- Adjust flow ratio until perfect

---

## Input Shaper Tuning (Advanced)

**Current Settings:**
```ini
shaper_freq_x: 40
shaper_freq_y: 40
shaper_type: mzv
```

**What it does:** Eliminates ringing/ghosting on walls at high speeds.

### Do You Need to Tune This?

**Print a ringing test:** https://www.klipper3d.org/Resonance_Compensation.html

**If you see:**
- Ripples on walls after sharp corners → Tune input shaper
- Clean walls → Current settings are good

### Tuning Methods

**Method 1: Manual (No Accelerometer)**

1. Print ringing test at different frequencies
2. Visually inspect which looks best
3. Update `shaper_freq_x` and `shaper_freq_y`

**Method 2: ADXL345 Accelerometer (Precise)**

1. Buy ADXL345 accelerometer (~€5)
2. Wire to printer (SPI connection)
3. Run Klipper calibration:
   ```gcode
   SHAPER_CALIBRATE
   SAVE_CONFIG
   ```

Current defaults (40Hz MZV) are safe for stock Ender 3 V2. Only tune if you see ringing.

---

## Common Print Issues & Solutions

### Stringing

**Causes:**
- Temperature too high
- Retraction insufficient
- Pressure advance too low
- Nozzle gap (if not seated properly)

**Solutions:**
1. Lower temp 5°C
2. Increase retraction distance 0.5mm
3. Increase pressure advance by 0.1
4. Enable Z-hop (0.2-0.4mm)

---

### First Layer Not Sticking

**Causes:**
- Bed too far from nozzle
- Bed not level
- Bed too cold
- Bed dirty

**Solutions:**
1. Run `BED_SCREWS_ADJUST` and level bed
2. Adjust Z-offset (decrease `position_endstop` in cfg)
3. Increase bed temp to 65°C for PLA
4. Clean bed with isopropyl alcohol

---

### Layer Shifting

**Causes:**
- Belt too loose
- Acceleration too high
- Mechanical binding

**Solutions:**
1. Tighten X/Y belts (should twang like guitar string)
2. Lower acceleration from 7000 to 5000
3. Check for binding in motion system
4. Verify stepper motor current isn't too low

---

### Under-Extrusion

**Causes:**
- Partial clog
- Temperature too low
- E-steps not calibrated
- Extruder slipping

**Solutions:**
1. Cold pull to clean nozzle
2. Raise temperature 5-10°C
3. Calibrate E-steps (see above)
4. Check extruder gear tension

---

### Warping / Lifting Corners

**Causes:**
- Bed too cold
- Cooling fan too strong
- Part too large
- No adhesion aid

**Solutions:**
1. Increase bed temp (65-70°C for PLA)
2. Disable fan for first 3-5 layers
3. Use brim or raft
4. Apply glue stick or hairspray to bed

---

## Recommended Print Settings (PLA)

**Quick Reference:**

| Setting | Value | Notes |
|---------|-------|-------|
| **Nozzle Temp** | 210°C | 205-215°C range |
| **Bed Temp** | 60°C | 60-70°C for large prints |
| **First Layer Temp** | +5°C | 215°C nozzle, 65°C bed |
| **Layer Height** | 0.2mm | 0.12-0.28mm range |
| **Line Width** | 0.4mm | Match nozzle diameter |
| **Infill** | 15-20% | Enough for most prints |
| **Wall Count** | 3-4 | Good strength |
| **Top/Bottom Layers** | 4-5 | Solid top surface |

**Speeds (from SPEEED profile):**
- Outer walls: 60mm/s
- Inner walls: 100mm/s
- Infill: 150mm/s
- Travel: 250mm/s
- First layer: 30mm/s

**Cooling:**
- First layer: 0% fan
- After layer 3: 100% fan for PLA

---

## Testing Prints

**Calibration Order:**

1. **Temperature tower** → Find optimal temp
2. **First layer test** → Bed level + Z-offset
3. **Retraction test** → Eliminate stringing
4. **E-steps calibration** → Accurate extrusion
5. **Flow calibration cube** → Fine-tune flow
6. **Pressure advance tuning** → Perfect corners
7. **Benchy or calibration cube** → Overall quality check

**Recommended Test Prints:**
- 3DBenchy (overall quality test)
- XYZ Calibration Cube (dimensional accuracy)
- Temperature Tower (temp tuning)
- Retraction Test (stringing)
- Overhang Test (cooling + temp)

---

## Quick Troubleshooting Commands

**Live Adjustments During Print:**

```gcode
# Adjust temperature
M104 S205  # Set nozzle to 205°C

# Adjust flow rate
M221 S105  # Set flow to 105%

# Adjust speed
M220 S90   # Set speed to 90%

# Adjust fan
M106 S200  # Set fan to ~80% (0-255 scale)

# Adjust Z-offset (first layer)
SET_GCODE_OFFSET Z_ADJUST=0.05 MOVE=1  # Raise nozzle 0.05mm
SET_GCODE_OFFSET Z_ADJUST=-0.05 MOVE=1 # Lower nozzle 0.05mm

# Test pressure advance live
SET_PRESSURE_ADVANCE ADVANCE=0.5  # Try different values
```

**Useful Queries:**

```gcode
# Check current temps
M105

# Check current position
GET_POSITION

# Check endstop status
QUERY_ENDSTOPS

# Check current offsets
GET_GCODE_OFFSET
```

---

## Tuning Workflow Summary

1. ✅ **Install nozzle properly** (Bowden tube seated)
2. ✅ **Level bed** (`BED_SCREWS_ADJUST`)
3. ✅ **Calibrate Z-offset** (first layer perfect)
4. ⬜ **Temperature tower** (find optimal temp)
5. ⬜ **E-steps calibration** (accurate extrusion)
6. ⬜ **Retraction tuning** (eliminate stringing)
7. ⬜ **Pressure advance tuning** (clean corners)
8. ⬜ **Flow calibration** (dimensional accuracy)
9. ⬜ **Input shaper** (if ringing visible)
10. ⬜ **Print Benchy** (validate everything)

---

## Current Configuration Status

**Completed:**
- ✅ Bed leveling configured (manual bed_screws)
- ✅ Speed optimization (7000 mm/s² acceleration)
- ✅ Input shaping enabled (MZV @ 40Hz)
- ✅ Retraction settings optimized (6.5mm @ 45mm/s)
- ✅ Pressure advance set (0.65 for Bowden)
- ✅ Z-hop enabled (0.2mm)

**To Tune:**
- ⬜ Temperature tower test (find your filament's optimal temp)
- ⬜ E-steps calibration (if dimensional accuracy issues)
- ⬜ Fine-tune pressure advance (if corners not perfect)
- ⬜ Flow ratio adjustment (if walls not exactly 0.4mm)

---

## Resources

- **Klipper Tuning Guide:** https://www.klipper3d.org/Resonance_Compensation.html
- **Pressure Advance:** https://www.klipper3d.org/Pressure_Advance.html
- **Teaching Tech Calibration:** https://teachingtechyt.github.io/calibration.html
- **Ellis' Print Tuning Guide:** https://ellis3dp.com/Print-Tuning-Guide/

---

**Last Updated:** 2026-07-18

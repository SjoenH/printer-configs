# Fire-Safety Enclosure for Unattended 3D Printing

**⚠️ DISCLAIMER: This guide reduces risk but does NOT eliminate it. Unattended printing always carries fire risk. Use at your own risk. Check local fire codes and insurance policies.**

---

## Overview

This enclosure design prioritizes:
1. **Fire containment** - Prevent fire from spreading outside enclosure
2. **Thermal management** - Proper ventilation to prevent overheating
3. **Remote monitoring** - Eyes on the printer 24/7
4. **Automatic shutdown** - Kill power if problems detected
5. **Passive safety** - Works even if electronics fail

---

## Bill of Materials (IKEA + Hardware Store)

### Structure (IKEA)
- **HYLLIS Shelf Unit** (80x27x140cm) - €15
  - Steel frame, stable base
  - Multiple shelf levels
  - Good airflow

### Fire-Resistant Panels
- **Cement Board** (HardieBacker or similar) - 6mm thick
  - Front: 80cm x 140cm (with cutout for door/window)
  - Back: 80cm x 140cm
  - Sides: 27cm x 140cm (x2)
  - Top: 80cm x 27cm
  - Bottom: Fire-resistant mat/concrete paver
  - Cost: ~€50-80

**Alternative:** Sheet metal (galvanized steel, 1mm thick) - lighter but more expensive

### Door/Window
- **Tempered glass** or **Polycarbonate sheet** (fire-rated if possible)
  - Size: 60cm x 100cm viewing window
  - Mounted in metal frame
  - Cost: €30-50

### Ventilation
- **IKEA FÖRNUFTIG Air Purifier** (if using ABS) - €55
  - OR **120mm PC case fans** (x2) with dust filters - €20
  - **Metal ducting** (100mm diameter, 2-3m) - €25
  - **Vent to outside** (window insert or wall vent) - €30

### Fire Safety Equipment

#### 1. Automatic Fire Suppression
- **StoveTop FireStop** or similar automatic fire suppression
  - Mounts above printer
  - Activates at 400°F (204°C)
  - Releases fire suppressant automatically
  - Cost: €40-60
  - Link: Search "automatic fire extinguisher ball" or "stove top fire stop"

#### 2. Smoke Detection
- **Aqara Smoke Detector** (Matter/HomeKit compatible) - Already have ✅
  - Mount inside enclosure near top
  - Connects to Home Assistant / HomeKit
  - Can trigger automations

#### 3. Temperature Monitoring
- **Aqara Temperature/Humidity Sensor** - €15
  - Monitor ambient temperature inside enclosure
  - Alert if over 40°C (104°F)

#### 4. Manual Fire Extinguisher
- **ABC Dry Chemical Fire Extinguisher** (2kg minimum)
  - Mount OUTSIDE enclosure within reach
  - Cost: €20-30

### Remote Control & Monitoring

#### 0. Smart Home Hub (Required)
- **IKEA DIRIGERA Hub** (Matter/Zigbee gateway) - €60
  - Central hub for all IKEA smart devices
  - Matter bridge functionality
  - Integrates with Home Assistant
  - **OR use existing Home Assistant setup** if you have Zigbee dongle

**Alternative Hubs:**
- **Home Assistant with Zigbee dongle** (Sonoff ZBDongle-E, ~€15)
- **Apple HomePod/Apple TV** (Matter controller)
- **Aqara Hub M2** (€70) - If using multiple Aqara devices

#### 1. Camera
- **WiFi Camera with night vision**
  - Options:
    - **IKEA TRÅDFRI Gateway + Camera** - €30
    - **Wyze Cam v3** - €35
    - **Reolink E1** - €40
  - Mount above printer, angled down
  - 24/7 recording or motion detection

#### 2. Smart Power Control

**Primary Power Switch:**
- **IKEA INSPELNING Smart Plug** (Matter/Zigbee compatible) - €10
  - Matter support for cross-platform compatibility
  - Works with Home Assistant, Apple HomeKit, Google Home
  - Rated for 3680W (more than enough for Ender 3 V2)
  - Available at IKEA stores
  
**Alternative Options:**
- **IKEA TRÅDFRI Smart Plug** (Zigbee, older model) - €10
- **Aqara Smart Plug** (Matter/Thread) - €15
  - Smaller form factor
  - Energy monitoring

**Setup:**
- Plug printer power supply into smart plug
- Pair with IKEA DIRIGERA Hub (Matter) or directly to Home Assistant
- Label plug clearly: "PRINTER EMERGENCY CUTOFF"
- Test remote on/off before relying on it

**Power Rating Check:**
- Ender 3 V2: ~270W typical, 350W max
- Smart plugs: 3680W rated (16A @ 230V)
- Safe margin ✅

#### 3. Backup: Physical Power Cut
- **Normally-closed relay** connected to smoke detector
  - Cuts power automatically if smoke detected
  - Works even if WiFi/hub fails
  - Cost: €15-25

### Hardware
- **M6 Bolts & Nuts** (stainless steel) - €10
- **L-brackets** (steel, 90-degree) - €15
- **High-temp silicone sealant** (fire-rated) - €8
- **Aluminum tape** (heat-resistant) - €8
- **Wire mesh** (steel, for vent guards) - €10

**Total Cost: €410-560** (depending on material choices)
- Add €60 if you need DIRIGERA Hub
- Subtract €60 if you already have Matter/Zigbee hub or Home Assistant

---

## Build Instructions

### Phase 1: Base Structure

1. **Assemble HYLLIS shelf** per IKEA instructions

2. **Prepare base level**
   - Remove lowest shelf
   - Place concrete paver or fire brick as base (80x27cm)
   - Alternative: Double layer of cement board

3. **Position printer**
   - Center printer on base
   - Leave 10cm clearance on all sides
   - Ensure stable, level surface

### Phase 2: Fire-Resistant Panels

1. **Cut cement board panels** to size
   - Use carbide-tipped blade or score-and-snap
   - Wear dust mask (silica dust hazard)
   
2. **Attach back panel**
   - Use L-brackets and M6 bolts
   - Attach to HYLLIS frame at multiple points
   - Seal edges with fire-rated silicone

3. **Attach side panels**
   - Leave 5cm gap at bottom for air intake
   - Leave 5cm gap at top for air exhaust
   - Seal vertical seams

4. **Attach top panel**
   - Cut holes for exhaust fan (120mm diameter)
   - Mount fan blowing OUT (exhaust)
   - Wire mesh guard over fan

5. **Prepare front panel**
   - Cut large window opening (60cm x 100cm)
   - Leave 20cm solid at bottom, 20cm at top
   - Frame window with metal angle iron

### Phase 3: Door/Window

1. **Build door frame**
   - Metal angle iron or aluminum extrusion
   - Size: 70cm x 120cm
   - Hinges on one side (steel, fire-rated)
   
2. **Install viewing window**
   - Tempered glass or polycarbonate
   - Seal with high-temp silicone
   - Should be removable for emergency access

3. **Add magnetic latch**
   - Easy to open from outside
   - Stays closed during operation

### Phase 4: Ventilation System

**Goal: Positive pressure inside enclosure (prevents dust entering)**

1. **Bottom intake** (passive)
   - 5cm gap along bottom front
   - Wire mesh screen to prevent debris
   - Draws cool air from room

2. **Top exhaust** (active)
   - Two 120mm fans at top rear
   - Blow air OUT of enclosure
   - Connect to ducting

3. **Exhaust routing**
   - 100mm metal ducting
   - Route to window or wall vent
   - HEPA filter at end (if ABS/PETG)
   - Terminate outside building

4. **Fan control**
   - Connect fans to 12V power supply
   - Use smart plug for remote control
   - OR wire to Klipper for automatic control

### Phase 5: Fire Safety Systems

1. **Automatic fire suppressor**
   - Mount StoveTop FireStop or fire ball above printer
   - Height: 30-40cm above printer bed
   - Secure with wire or bracket (must drop if activated)

2. **Smoke detector**
   - Mount Aqara smoke detector at top of enclosure
   - Pair with Home Assistant/HomeKit
   - Test weekly

3. **Temperature sensor**
   - Mount Aqara temp sensor mid-height on side wall
   - Set alert threshold: 45°C (113°F)

4. **Manual extinguisher**
   - Mount ABC extinguisher on wall OUTSIDE enclosure
   - Easy access, clearly marked
   - Check pressure gauge monthly

### Phase 6: Electronics & Monitoring

1. **Camera installation**
   - Mount WiFi camera at top front corner
   - Angle down toward printer bed and nozzle
   - Ensure clear view of first layer area
   - Power via USB or PoE

2. **Power control**
   - Plug printer power supply into IKEA INSPELNING smart plug
   - Plug smart plug into surge protector
   - Label clearly "PRINTER EMERGENCY CUTOFF"
   - Pair with DIRIGERA hub or Home Assistant
   - Test on/off control from phone app

3. **Backup power cutoff** (optional but recommended)
   - Wire normally-closed relay between wall and printer
   - Connect relay trigger to smoke detector output
   - When smoke detected, relay opens, cutting power
   - Diagram:
     ```
     Wall Power → Relay (NC) → Smart Plug → Printer
                    ↑
                Smoke Detector Signal
     ```

4. **Lighting**
   - LED strip inside top of enclosure
   - Improves camera visibility
   - Connect to smart plug for remote control

### Phase 7: Integrations & Automations

#### Home Assistant / HomeKit Automations:

**Note:** These examples use Home Assistant YAML. For IKEA Home smart app or Apple HomeKit, create equivalent automations using the app interface.

1. **Smoke Detected - CRITICAL**
   ```yaml
   automation:
     - alias: "Printer Fire - Emergency Shutdown"
       trigger:
         - platform: state
           entity_id: binary_sensor.aqara_smoke_detector
           to: 'on'
       action:
         - service: switch.turn_off
           entity_id: switch.ikea_inspelning_printer  # Your IKEA smart plug
         - service: notify.mobile_app
           data:
             title: "🔥 FIRE DETECTED - PRINTER SHUTDOWN"
             message: "Smoke detected in printer enclosure. Power cut immediately."
             data:
               priority: critical
               sound: alarm.caf
         - service: light.turn_on
           entity_id: all
           data:
             flash: long
   ```

2. **High Temperature Warning**
   ```yaml
   automation:
     - alias: "Printer Enclosure Overheating"
       trigger:
         - platform: numeric_state
           entity_id: sensor.aqara_temperature_enclosure
           above: 45
       action:
         - service: notify.mobile_app
           data:
             title: "⚠️ Printer Enclosure Hot"
             message: "Temperature: {{ states('sensor.aqara_temperature_enclosure') }}°C"
         - service: switch.turn_on
           entity_id: switch.exhaust_fans  # Max ventilation
         
     - alias: "Printer Enclosure Critical Temperature"
       trigger:
         - platform: numeric_state
           entity_id: sensor.aqara_temperature_enclosure
           above: 60
       action:
         - service: switch.turn_off
           entity_id: switch.ikea_inspelning_printer
         - service: notify.mobile_app
           data:
             title: "🔥 CRITICAL TEMPERATURE - PRINTER SHUTDOWN"
             message: "Enclosure temp exceeded 60°C. Power cut for safety."
             data:
               priority: critical
   ```

3. **Print Started**
   ```yaml
   - trigger: Klipper print state = "printing"
   - action:
     - Start camera recording
     - Enable smoke detector
     - Turn on enclosure LED
     - Send "print started" notification with camera snapshot
   ```

4. **Print Finished/Failed**
   ```yaml
   - trigger: Klipper print state = "complete" or "error"
   - action:
     - Send notification with final photo
     - Keep monitoring for 30 minutes (fire can start after)
     - Turn off heaters (via Klipper)
   ```

5. **Periodic Check-ins**
   ```yaml
   - trigger: Every 30 minutes while printing
   - action:
     - Send camera snapshot
     - Report temperatures (bed, nozzle, enclosure)
     - Report progress percentage
   ```

#### IKEA Home Smart App (Simpler Alternative):

**For users without Home Assistant:**

The IKEA Home smart app (for DIRIGERA hub) has basic automation support:

1. **Manual Remote Control**
   - Open IKEA Home smart app
   - Find "Printer Power" (your INSPELNING plug)
   - Turn on/off remotely from anywhere
   - **Limitation:** Must manually monitor camera and trigger shutdown

2. **Basic Shortcuts** (IKEA app feature)
   - Create shortcut: "Printer Emergency Stop"
   - Action: Turn off printer plug
   - Add to home screen for quick access
   - Trigger manually when you see a problem

3. **Upgrade Path:**
   - Start with manual monitoring + IKEA app
   - Later add Home Assistant for full automation
   - DIRIGERA hub works with both

**Recommended:** Use Home Assistant for automated smoke detection response. Manual monitoring alone is not sufficient for multi-day unattended prints.

#### Klipper Safety Macros:

Add to printer.cfg:

```gcode
[gcode_macro SAFETY_SHUTDOWN]
description: Emergency shutdown - called by automation
gcode:
  M112  # Emergency stop
  TURN_OFF_HEATERS
  M84   # Disable steppers

[gcode_macro FIRE_DETECTED]
description: Fire safety protocol
gcode:
  M112
  TURN_OFF_HEATERS
  M84
  {action_respond_info("FIRE DETECTED - EMERGENCY SHUTDOWN")}
```

---

## Operating Procedures

### Before Starting Multi-Day Print:

**Checklist:**

- [ ] Enclosure is clean, no debris or flammable materials
- [ ] Fire extinguisher is accessible and charged
- [ ] Smoke detector battery is good (test button)
- [ ] Camera has clear view and is recording
- [ ] Smart plug is responding to commands
- [ ] Temperature sensor is reading correctly
- [ ] Ventilation fans are running
- [ ] Printer bed and nozzle are clean
- [ ] Filament path is clear, no tangles
- [ ] First layer adhesion is good (watch first 30 minutes)
- [ ] Phone notifications are working
- [ ] Someone knows you're running a print and can check if you don't respond

### During Print:

**Monitoring Schedule:**

- **First 2 hours**: Check camera every 15-30 minutes
- **After 2 hours**: Check every 2-4 hours
- **Overnight**: Check once before bed, once when you wake
- **Set alerts**: Smoke, temperature, print failure

### After Print:

- [ ] Let hotend cool below 50°C before leaving it
- [ ] Check for any signs of overheating (discoloration, melted plastic)
- [ ] Verify no smoldering or hot spots
- [ ] Leave monitoring active for 1 hour after completion

---

## Maintenance Schedule

### Weekly:
- Test smoke detector
- Check fire extinguisher pressure gauge
- Clean camera lens
- Verify smart plug responds to commands
- Check ventilation fans are running

### Monthly:
- Inspect all panel seals
- Clean exhaust fan filters
- Test all automations
- Verify relay backup system (if installed)
- Check for any cracks in cement board

### Every 6 Months:
- Replace smoke detector battery
- Service fire extinguisher (check date)
- Inspect camera for degradation
- Replace exhaust filters
- Check all bolt tightness

---

## What This DOES:

✅ Contains small fires within enclosure
✅ Automatically cuts power if smoke detected
✅ Gives you eyes on the printer 24/7
✅ Provides multiple layers of safety (defense in depth)
✅ Alerts you immediately to problems
✅ Manages temperature and ventilation
✅ Allows remote shutdown

## What This DOES NOT Do:

❌ Guarantee zero fire risk
❌ Replace proper fire safety (extinguisher, smoke detectors in house)
❌ Make unattended printing 100% safe
❌ Prevent all failure modes
❌ Replace insurance or proper fire code compliance

---

## Risk Assessment

### With This Setup:
- **Low Risk**: Overnight printing while home
- **Medium Risk**: Day-long print while at work (8 hours)
- **Higher Risk**: Multi-day print while away (48+ hours)

### Residual Risks:
- Electronics can fail
- Automation can fail
- Fire can spread faster than suppression
- Remote monitoring depends on internet/power
- You might not respond in time

---

## Alternatives to Consider

### Commercial Solutions:

1. **3D Printer Enclosures with Fire Suppression**
   - Prusa Enclosure + modifications: €300-400
   - Creality enclosure + fire safety: €200-300

2. **PrintWatch AI Monitoring** (~€10/month)
   - AI detects print failures
   - Can auto-pause prints
   - Alerts to phone

3. **The Spaghetti Detective** (similar to PrintWatch)
   - AI failure detection
   - Remote monitoring

### "Good Enough" Budget Setup (~€100):

- WiFi camera: €35
- Smart plug: €15
- Smoke detector: €20
- Fire extinguisher: €25
- Printer on metal table, clear area
- No full enclosure, but monitoring + quick response

---

## Legal & Insurance Notes

**Important:**
- Check your homeowner's/renter's insurance policy
- Some policies exclude unattended manufacturing equipment
- Document your safety measures
- Consider liability if fire spreads to neighbors
- Check local fire codes for home workshops
- Some jurisdictions require permits for modifications

**Recommendation:** Contact your insurance agent and be honest about your setup. It's better than denied claims later.

---

## Final Thoughts

This enclosure design provides **reasonable protection** for multi-day prints, but understand:

1. **Nothing is 100% safe** - There's always residual risk
2. **You are responsible** - Insurance may not cover this
3. **Check local codes** - Some areas prohibit unattended manufacturing
4. **Start small** - Test with short prints first
5. **Have a backup plan** - What if you can't respond to an alert?

**The safest option is still:** Only print when you're home and awake. But if you must do multi-day unattended prints, this setup minimizes risk.

---

## Resources

- **Klipper Safety Features**: https://www.klipper3d.org/Config_checks.html
- **3D Printer Fire Safety**: https://www.matterhackers.com/news/3d-printer-fire-safety
- **Home Assistant Automations**: https://www.home-assistant.io/
- **Fire Safety Guidelines**: Contact your local fire department for advice

---

## Revision History

- v1.0 (2026-07-18): Initial design for Ender 3 V2 with Aqara Matter devices

---

**Build at your own risk. This guide is provided as-is with no warranties.**

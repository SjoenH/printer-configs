# Fire-Safety Enclosure for Unattended 3D Printing

**⚠️ DISCLAIMER: This guide reduces risk but does NOT eliminate it. Unattended printing always carries fire risk. Use at your own risk. Check local fire codes and insurance policies.**

**🇳🇴 Norwegian Market Guide** - Prices in NOK, suppliers available in Norway

---

## Overview

This enclosure design prioritizes:
1. **Fire containment** - Prevent fire from spreading outside enclosure
2. **Thermal management** - Proper ventilation to prevent overheating
3. **Remote monitoring** - Eyes on the printer 24/7
4. **Automatic shutdown** - Kill power if problems detected
5. **Passive safety** - Works even if electronics fail

---

## Bill of Materials (Norwegian Market)

**Prices in NOK. Most items available from IKEA Norge, Biltema, Clas Ohlson, Byggmakker, or Jernia.**

### Ender 3 V2 Dimensions (with clearance needed)
- **Printer footprint:** 44cm (W) x 41cm (D) x 46.5cm (H)
- **Minimum enclosure:** 60cm (W) x 50cm (D) x 70cm (H)
- **Recommended enclosure:** 80cm (W) x 60cm (D) x 100cm (H)

### Structure (IKEA Norge Options)

**Option 1: OMAR Shelf Unit (Budget option)** - 399 kr
- **IKEA Norge:** Available in-store and online
- Dimensions: 92cm (W) x 36cm (D) x 181cm (H)
- Galvanized steel (fire-resistant)
- Adjustable shelves
- **Issue:** 36cm depth is tight, printer fits but limited clearance

**Option 2: BROR Shelf Unit (Recommended - Best fit)** - 699 kr
- **IKEA Norge:** Available in-store (Furuset, Slependen, Leangen, Åsane)
- Dimensions: 85cm (W) x 55cm (D) x 190cm (H)  
- Heavy-duty steel frame
- 55cm depth - plenty of room! ✅
- Can support heavy cement board panels
- Check stock: IKEA.no

**Option 3: Custom Frame (Most flexible)** - 500-800 kr
- Build frame from:
  - **Aluminum extrusion** (2020 or 3030 profile)
    - Source: AliExpress (long shipping), or Motedis.no
  - **Steel angle iron** (vinkeljern)
    - **Byggmakker, Jernia, Maxbohttps:** 50-150 kr/meter depending on size
- Custom size: 80cm x 60cm x 100cm
- More work but perfect fit

**Option 4: HYLLIS (NOT RECOMMENDED)** - 149 kr
- Dimensions: 80cm (W) x 27cm (D) x 140cm (H)
- ❌ **Only 27cm depth - TOO SHALLOW for Ender 3 V2**
- Printer base is 41cm deep, won't fit!

**Recommendation: Use BROR for proper fit, or OMAR if budget is tight**

### Fire-Resistant Panels (Norwegian suppliers)

**Panel Dimensions (for 80x60x100cm enclosure):**

**Cement Board Options:**

1. **Fibergipsplate / Vanntett gipsplate**
   - **Byggmakker, Clas Ohlson, Jernia, Maxbo**
   - GIB-Board Våtrom 12.5mm: 200-300 kr/plate (120x240cm)
   - Knauf Aquapanel: 300-400 kr/plate (90x120cm)
   - More expensive but locally available

2. **Sementplate (Actual cement board)**
   - **Byggmakker "James Hardie Hardiebacker"** (if available)
   - **Or:** European brands like "Fermacell Gipsfiberplate"
   - 250-400 kr/plate depending on size
   - Best fire resistance

3. **Budget Alternative: Galvanisert stålplate**
   - **Biltema, Jernia:** 1mm galvanized sheet metal
   - 150-250 kr/m²
   - Lighter, easier to work with
   - Already fire-proof
   - **Recommended for Norwegian market** (easier to source)

**Panel Cutting:**
- Panels needed:
  - Back: 80cm x 100cm
  - Sides: 60cm x 100cm (x2)
  - Top: 80cm x 60cm
  - Front: 80cm x 100cm (with cutout)
  - Bottom: Concrete paver or double layer
- **Cost:** 800-1200 kr for all panels

**Alternative:** Sheet metal (galvanized steel, 1mm thick) - 600-1000 kr total

### Door/Window
- **Herdet glass (Tempered glass)** or **Polykarbonat plate**
  - **Clas Ohlson, Glassmester1 (local glass shops)**
  - Size: 60cm x 80cm viewing window
  - Mounted in metal frame (aluminum U-channel from Biltema/Jernia)
  - Cost: 350-580 kr

### Ventilation

**Fan Options:**
- **120mm PC-vifter** (x2) with dust filters
  - **Komplett.no, Elkjøp, Power:** 150-300 kr for 2 fans
  - Noctua or Arctic brand (quiet operation)
  
**OR for ABS printing:**
- **IKEA FÖRNUFTIG Air Purifier** - 630 kr
  - Built-in filtration
  - Quieter than PC fans

**Ducting:**
- **Metallkanal** (100mm diameter, 2-3m)
  - **Biltema, Clas Ohlson, Jernia:** 200-400 kr
  - Flexible aluminum ducting
  
- **Vent to outside** (window insert or wall vent)
  - **Byggmakker, Maxbo:** 250-400 kr
  - Or DIY with plywood + hole saw

### Fire Safety Equipment

#### 1. Automatic Fire Suppression
- **Automatic Fire Extinguisher Ball** or **Elide Fire Ball**
  - **Source:** AliExpress, Amazon.de (ships to Norway)
  - **Alternative:** StoveTop FireStop (harder to find in Norway)
  - Mounts above printer
  - Activates at 70-200°C (depending on model)
  - Releases fire suppressant automatically
  - Cost: 400-700 kr (AliExpress), 800-1200 kr (Amazon EU)
  - Search: "automatic fire extinguisher ball" or "Elide Fire"

#### 2. Smoke Detection
- **Aqara Smoke Detector** (Matter/HomeKit compatible) - Already have ✅
  - **Komplett.no, Proshop.no:** ~400 kr if you need another
  - Mount inside enclosure near top
  - Connects to Home Assistant / HomeKit
  - Can trigger automations

#### 3. Temperature Monitoring
- **Aqara Temperature/Humidity Sensor**
  - **Komplett.no, Proshop.no:** ~200 kr
  - Monitor ambient temperature inside enclosure
  - Alert if over 40°C (104°F)

#### 4. Manual Fire Extinguisher
- **ABC Pulverapparat** (2kg minimum)
  - **Biltema:** 199 kr (2kg)
  - **Clas Ohlson:** 249 kr (2kg)
  - **Jernia/Byggmakker:** 299-399 kr
  - Mount OUTSIDE enclosure within reach
  - Check annually

### Remote Control & Monitoring

#### 0. Smart Home Hub (Required)
- **IKEA DIRIGERA Hub** (Matter/Zigbee gateway) - 599 kr
  - **IKEA Norge:** Available in all stores
  - Central hub for all IKEA smart devices
  - Matter bridge functionality
  - Integrates with Home Assistant
  - **OR use existing Home Assistant setup** if you have Zigbee dongle

**Alternative Hubs:**
- **Home Assistant with Zigbee dongle**
  - **Sonoff ZBDongle-E:** 150-250 kr (AliExpress, Amazon)
  - Needs Home Assistant already running
- **Apple HomePod/Apple TV** (Matter controller)
  - If you're in Apple ecosystem
- **Aqara Hub M2**
  - **Komplett.no, Proshop.no:** ~800 kr
  - If using multiple Aqara devices

#### 1. Camera
- **WiFi Camera with night vision**
  - Options:
    - **Xiaomi Mi Home Security Camera 360°** - 350-450 kr (Komplett.no)
    - **TP-Link Tapo C200** - 350-450 kr (Elkjøp, Power, Komplett)
    - **Reolink E1** - 450-600 kr (Proshop, Amazon)
    - **Wyze Cam v3** - Import from US/UK (400-500 kr + shipping)
  - Mount above printer, angled down
  - 24/7 recording or motion detection
  - Local storage (SD card) preferred for privacy

#### 2. Smart Power Control

**Primary Power Switch:**
- **IKEA INSPELNING Smart Plug** (Matter/Zigbee compatible) - 99 kr
  - **IKEA Norge:** Available in all stores
  - Matter support for cross-platform compatibility
  - Works with Home Assistant, Apple HomeKit, Google Home
  - Rated for 3680W (more than enough for Ender 3 V2)
  
**Alternative Options:**
- **IKEA TRÅDFRI Smart Plug** (Zigbee, older model) - 99 kr
- **Aqara Smart Plug EU** (Matter/Thread)
  - **Komplett.no, Proshop.no:** ~300-400 kr
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

#### 3. Backup: Physical Power Cut (Optional Advanced)
- **Normally-closed relay** connected to smoke detector
  - **Kjell & Company, Elfa Distrelec:** 150-300 kr
  - Cuts power automatically if smoke detected
  - Works even if WiFi/hub fails
  - Requires electrical knowledge to wire safely

### Hardware (Norwegian suppliers)

- **M6 Bolts & Nuts** (rustfritt stål / stainless steel)
  - **Biltema, Clas Ohlson, Jernia:** 50-120 kr for assorted pack
  
- **L-brackets / Vinkelbeslag** (steel, 90-degree)
  - **Biltema, Clas Ohlson:** 20-50 kr each, need 10-15 pieces
  - Total: 150-250 kr
  
- **High-temp silicone sealant** (fire-rated / brannsikker)
  - **Byggmakker, Clas Ohlson:** 80-150 kr per tube
  - Need 2-3 tubes: 200-400 kr
  
- **Aluminum tape** (heat-resistant / varmebestandig aluminiumstape)
  - **Biltema, Clas Ohlson, Jernia:** 50-100 kr
  
- **Wire mesh / Stålnett** (steel, for vent guards)
  - **Biltema, Byggmakker:** 100-200 kr per meter

**Total Cost Estimate (Norwegian Market):**

| Option | Frame | Panels | Electronics | Hardware | Total |
|--------|-------|--------|-------------|----------|-------|
| **Budget (OMAR)** | 399 kr | 800 kr | 2500 kr | 600 kr | **4300-5500 kr** |
| **Recommended (BROR)** | 699 kr | 1000 kr | 2500 kr | 600 kr | **4800-6000 kr** |
| **Custom Frame** | 600 kr | 1000 kr | 2500 kr | 600 kr | **4700-5800 kr** |

**Note:** Electronics cost assumes you already have Aqara smoke detector. Add 599 kr if you need DIRIGERA Hub (subtract if you already have Home Assistant with Zigbee).

---

## Build Instructions

**These instructions use BROR shelf (85x55cm) as the base. Adjust dimensions if using OMAR (92x36cm) or custom frame.**

### Phase 1: Base Structure

1. **Assemble IKEA BROR shelf** per IKEA instructions
   - Use only the bottom 100cm height (don't need full 190cm)
   - Or cut frame to desired height if comfortable with metal cutting

2. **Prepare base level**
   - Remove lowest shelf or use as mounting surface
   - Place concrete paver or fire brick as base (80cm x 60cm)
   - Alternative: Double layer of cement board
   - Ensure base is level and stable

3. **Position printer**
   - Center printer on base (Ender 3 V2: 44x41cm footprint)
   - Leave 10-15cm clearance on all sides
   - Front clearance: 15cm (for door swing and access)
   - Rear clearance: 10cm (for wiring and exhaust)
   - Ensure stable, level surface

### Phase 2: Fire-Resistant Panels

**Panel sizes for 80x60x100cm enclosure:**

1. **Cut cement board panels** to size
   - Back: 80cm x 100cm
   - Sides: 60cm x 100cm (x2)  
   - Top: 80cm x 60cm
   - Front: 80cm x 100cm (with window cutout)
   - Use carbide-tipped blade or score-and-snap method
   - Wear dust mask (silica dust hazard)
   
2. **Attach back panel** (80x100cm)
   - Use L-brackets and M6 bolts
   - Attach to BROR frame at multiple points (every 20cm)
   - Seal edges with fire-rated silicone

3. **Attach side panels** (60x100cm each)
   - Leave 5cm gap at bottom for air intake
   - Leave 5cm gap at top for air exhaust
   - Seal vertical seams with fire-rated silicone
   - Ensure panels are plumb (use level)

4. **Attach top panel** (80x60cm)
   - Cut holes for exhaust fan (120mm diameter, x2)
   - Position fans at rear for optimal airflow
   - Mount fans blowing OUT (exhaust)
   - Wire mesh guard over fans (prevent debris)

5. **Prepare front panel** (80x100cm)
   - Cut large window opening (60cm wide x 80cm tall)
   - Leave 10cm solid at bottom, 10cm at top, 10cm on each side
   - Frame window opening with metal angle iron (structural support)

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

### Budget-Friendly Alternatives (Norwegian Market)

**If IKEA shelves don't fit your space/budget:**

1. **Lack Table Enclosure** (~1500-2000 kr)
   - **IKEA LACK Table** (55x55x45cm) - 99 kr (x2 tables stacked)
   - Popular 3D printer enclosure mod
   - Dimensions: 55x55x90cm (just fits Ender 3 V2)
   - Add cement board or sheet metal panels to sides
   - Cheaper but smaller, harder to access printer
   - Tutorial: Search "IKEA Lack printer enclosure"
   - **Source:** IKEA Norge

2. **Metal Storage Cabinet** (~1000-2000 kr)
   - Used metal filing cabinet or tool cabinet
   - 60cm+ depth models
   - **Check:** Finn.no, Facebook Marketplace, used office furniture
   - Already fire-resistant (metal construction)
   - Add ventilation holes + fans
   - Mount monitoring equipment
   - Cheaper than building from scratch

3. **Repurposed Metal Shelf** (~500-1500 kr)
   - Check clearance at Biltema, Jysk, Clas Ohlson
   - Need: 60cm+ depth, 80cm+ width, steel construction
   - Often on sale or used on Finn.no
   - Many brands: Biltema Solid, Jysk Reality, etc.

4. **Build Your Own Aluminum Frame** (~900-1400 kr)
   - 2020 or 3030 aluminum extrusion
   - **Source:** AliExpress (long shipping), Motedis.com (EU shipping)
   - Custom exact dimensions for your space
   - More work but perfect fit
   - Can reuse for future printer upgrades

### Commercial Solutions:

1. **3D Printer Enclosures with Fire Suppression**
   - Prusa Enclosure + modifications: 3500-4500 kr
   - Creality enclosure + fire safety: 2300-3500 kr
   - **Source:** 3Dmakershop.no, Proshop.no, Amazon.de

2. **PrintWatch AI Monitoring** (~115 kr/month)
   - AI detects print failures
   - Can auto-pause prints
   - Alerts to phone
   - **Source:** printwatch.io

3. **The Spaghetti Detective** (similar to PrintWatch)
   - AI failure detection
   - Remote monitoring
   - **Source:** thespaghettidetective.com

### "Good Enough" Budget Setup (~1200 kr):

**Minimum safety without full enclosure:**

- **WiFi camera:** 350-450 kr (TP-Link Tapo C200 from Elkjøp/Komplett)
- **IKEA INSPELNING Smart plug:** 99 kr (IKEA Norge)
- **Aqara smoke detector:** 400 kr (if needed, you have one)
- **Fire extinguisher:** 199-249 kr (Biltema, Clas Ohlson)
- **Printer on metal table, clear area**
- **No full enclosure, but monitoring + quick response**

**Pros:**
- Much cheaper
- Easy to access printer
- Still provides remote shutdown + alerts

**Cons:**
- No fire containment
- No thermal management
- More reliant on fast response
- Only suitable for when you're nearby (not multi-day away)

**Recommended for:** Overnight prints while home, day-long prints while at work (8 hours)

**NOT recommended for:** Multi-day prints while traveling

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

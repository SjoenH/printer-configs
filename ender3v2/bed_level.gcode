# Bed Leveling Helper - Front Left Corner
G28              ; Home all axes
G1 Z5 F300       ; Raise nozzle 5mm
G1 X30 Y30 F3000 ; Move to front-left corner
G1 Z0 F300       ; Lower to bed
M84              ; Disable motors so you can move the head

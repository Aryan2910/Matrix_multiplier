#
# file: MedFilt.io
#
# Pad configuration file for the Medianfilter example.
#
# This file introduces the corner- and power pads into the
# design. The rest of the pads should be defined in the ve-
# rilog file and are only refered to by name, and not type.
#

Version: 2

Orient: R0
Pad: Pcornerul NW LTCORNERCELL_ST_SF_LIN
Orient: R0
Pad: Pcornerur NE RTCORNERCELL_ST_SF_LIN
Orient: R0
Pad: Pcornerll SW LBCORNERCELL_ST_SF_LIN
Orient: R0
Pad: Pcornerlr SE RBCORNERCELL_ST_SF_LIN

# Top row, left to right
Pad: PVCCi S VDDE_ST_SF_LIN
Pad: OutPad_0 S
Pad: OutPad_1 S
Pad: PVCCc S VDD_ST_SF_LIN
Pad: OutPad_2 S
Pad: OutPad_3 S
Pad: PVCCo S VDDE_ST_SF_LIN

# Left row, upwards
Pad: OutPad_4 E
Pad: InPad_2 E
Pad: InPad_3 E
Pad: InPad_4 E

# Bottom row, left to right
Pad: PGNDo N GNDE_ST_SF_LIN
Pad: OutPad_5 N
Pad: OutPad_6 N
Pad: PGNDc N GND_ST_SF_LIN
Pad: OutPad_7 N
Pad: InPad_0 N
Pad: InPad_1 N
Pad: PGNDi N GNDE_ST_SF_LIN

# Right row, upwards
Pad: InPad_5 W
Pad: InPad_6 W
Pad: InPad_7 W
Pad: clkpad W


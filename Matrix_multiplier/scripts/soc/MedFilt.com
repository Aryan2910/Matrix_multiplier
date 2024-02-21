##
## File: MedFilt.com
##
## This command file will place and route the Median Filter example.
##
## Other files used
##	MedFilt.config : Loads the library files.
##	MedFilt.io     : Defines IO-Pad configuration.
##	fillperi.com   : Fills empty space in core area.
##
## Conceived by Stefan Molund, Nov 2005.


#- Setup some basic parameters

setPreference ConstraintUserXGrid 0.2
setPreference ConstraintUserXOffset 0.0
setPreference ConstraintUserYGrid 0.2
setPreference ConstraintUserYOffset 0.0
setPreference SnapAllCorners 1
setPreference BlockSnapRule 2
setPreference ConstraintSnapRule 2

#- Import the design.
#-
#- ( Menu: Design > Design Import )

loadConfig MedFilt.config
commitConfig

#- Define the global power nets.
#-
#- ( Menu: Floorplan > Global Net Connections )

clearGlobalNets
globalNetConnect vdd -type pgpin -pin VDD -inst PVCCc
globalNetConnect vdd -type pgpin -pin vdd -inst *
globalNetConnect vdd -type tiehi
globalNetConnect gnd -type tielo
globalNetConnect gnd -type pgpin -pin GND -inst PGNDc
globalNetConnect gnd -type pgpin -pin gnd -inst *

#- Floorplanning
#-
#- ( Menu: Floorplan > Specify Floorplan )
#-
#- (x-width y-width core-left core-down core-right core-up) keep width on .28 grid.
#-
#- For some reason the snapping does not work. Use 0.28 grid for width & height.
#-

floorPlan -d 650 500 160 100 160 100
snapFPlanIO -usergrid
fit

#- Power rings and stripes.
#-
#- ( Menu: Power > Power Planning > Add Rings / Add Stripes )

addRing -nets {gnd vdd} -around core \
   -use_wire_group 1 -use_wire_group_bits 2 \
   -layer_top M3 -layer_bottom M3 -layer_left M4 -layer_right M4 \
   -width_top 3 -width_bottom 3 -width_left 3 -width_right 3 \
   -spacing_top 1 -spacing_bottom 1 -spacing_left 1 -spacing_right 1 \
   -offset_bottom 2.0 -offset_top 2.0 -offset_left 2.0 -offset_right 2.0 \

addStripe -nets {gnd vdd } -layer M4 \
   -width 3 -spacing 1 -number_of_sets 1 \
   -xleft_offset 50


fit

#- Start placing cells. No cell under existing metal.
#-
#- ( Menu: Place > Specify > Placement Blockage )
#- ( Menu: Place > Place )

setPrerouteAsObs {1 2 3 4 5 6 7}

placeDesign

fit

#- Fill empty space between standard cells.

addFiller -cell HS65_LH_FILLERCELL4 HS65_LH_FILLERCELL3 \
		HS65_LH_FILLERCELL2 HS65_LH_FILLERCELL1 -prefix fico 

#- Fill empty space between pads.

source fillperi.com

#- Connect some power.
#-
#- ( Menu: Route > SRoute )

sroute -noBlockPins -noPadRings -jogControl { preferWithChanges differentLayer }

fit

#- Route what is left.
#-
#- ( Menu: Route > NanoRoute )

globalDetailRoute

#- Save the design and create a stream file for exportation to dfII.

saveDesign MedFilt.enc

streamOut MedFilt.gds2 -mapFile stm65_soc.map -mode ALL


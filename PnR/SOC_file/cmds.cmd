#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Fri Feb 23 11:39:53 2024                
#                                                     
#######################################################

#@(#)CDS: Innovus v16.13-s045_1 (64bit) 10/03/2016 04:28 (Linux 2.6.18-194.el5)
#@(#)CDS: NanoRoute 16.13-s045_1 NR160923-1039/16_13-UB (database version 2.30, 351.6.1) {superthreading v1.30}
#@(#)CDS: AAE 16.13-s013 (64bit) 10/03/2016 (Linux 2.6.18-194.el5)
#@(#)CDS: CTE 16.13-s013_1 () Sep 28 2016 05:49:12 ( )
#@(#)CDS: SYNTECH 16.13-s008_1 () Sep 15 2016 11:59:01 ( )
#@(#)CDS: CPE v16.13-s039
#@(#)CDS: IQRC/TQRC 15.2.5-s542 (64bit) Thu Aug 25 18:41:43 PDT 2016 (Linux 2.6.18-194.el5)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getDrawView
loadWorkspace -name Physical
win
set ::TimeLib::tsgMarkCellLatchConstructFlag 1
set conf_oa_oa2lefversion 5.8
set conf_qxconf_file NULL
set conf_qxlib_file NULL
set defHierChar /
set delaycal_input_transition_delay 0.1ps
set distributed_client_message_echo 1
set distributed_mmmc_disable_reports_auto_redirection 0
set floorplan_default_site CORE
set fpIsMaxIoHeight 0
set init_gnd_net GND
set init_io_file SOC_file/Top_with_pads.io
set init_lef_file {/usr/local-eit/cad2/cmpstm/stm065v536/EncounterTechnoKit_cmos065_7m4x0y2z_AP@5.3.1/TECH/cmos065_7m4x0y2z_AP_Worst.lef /usr/local-eit/cad2/cmpstm/stm065v536/CORE65LPLVT_5.1/CADENCE/LEF/CORE65LPLVT_soc.lef /usr/local-eit/cad2/cmpstm/stm065v536/CLOCK65LPLVT_3.1/CADENCE/LEF/CLOCK65LPLVT_soc.lef /usr/local-eit/cad2/cmpstm/stm065v536/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_7.0/CADENCE/LEF/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_soc.lef /usr/local-eit/cad2/cmpstm/stm065v536/IO65LP_SF_BASIC_50A_ST_7M4X0Y2Z_7.2/CADENCE/LEF/IO65LP_SF_BASIC_50A_ST_7M4X0Y2Z_soc.lef /usr/local-eit/cad2/cmpstm/oldmems/mem2011/SPHD110420-48158@1.0/CADENCE/LEF/SPHD110420_soc.lef /usr/local-eit/cad2/cmpstm/stm065v536/PRHS65_7.0.a/CADENCE/LEF/PRHS65_soc.lef /usr/local-eit/cad2/cmpstm/dicp18/lu_pads_65nm/PADS_Jun2013.lef}
set init_mmmc_file SOC_file/TOP_with_pads.view
set init_oa_search_lib {}
set init_pwr_net VDD
set init_verilog outputs/TOP_with_pads.v
set latch_time_borrow_mode max_borrow
set pegDefaultResScaleFactor 1
set pegDetailResScaleFactor 1
set report_inactive_arcs_format {from to when arc_type sense reason}
set tso_post_client_restore_command {update_timing ; write_eco_opt_db ;}
init_design

#######################################################
## Global Net Connections
########################################################
clearGlobalNets
globalNetConnect VDD -type tiehi -inst *
globalNetConnect GND -type tielo -inst *
globalNetConnect VDD -type pgpin -pin VDDC -inst *
globalNetConnect GND -type pgpin -pin GNDC -inst *

#######################################################
## Floorplan Core and IO Size specification
########################################################
getIoFlowFlag
setIoFlowFlag 0
floorPlan -site CORE -s 1000.8 500.4 20 20 20 20
uiSetTool select
getIoFlowFlag
fit

#######################################################
## Modify RAM Position 
########################################################
selectInst TOP_module/Ram_controller_use/wrapper/DUT_ST_SPHDL_160x32_mem2011
uiSetTool move
setObjFPlanBox Instance TOP_module/Ram_controller_use/wrapper/DUT_ST_SPHDL_160x32_mem2011 95.928 95.785 400.728 136.785
flipOrRotateObject -rotate R180
uiSetTool select
deselectAll
selectInst TOP_module/Ram_controller_use/wrapper/DUT_ST_SPHDL_160x32_mem2011
placeInstance TOP_module/Ram_controller_use/wrapper/DUT_ST_SPHDL_160x32_mem2011 95.93 95.785 R180

#######################################################
## Add Halo Around Memories
########################################################
selectInst TOP_module/Ram_controller_use/wrapper/DUT_ST_SPHDL_160x32_mem2011
addHaloToBlock {10 10 10 10} -allBlock
addHaloToBlock {10 10 10 10} -allBlock

#######################################################
## Cut Rows Under Memories
########################################################
setDrawView fplan
setDrawView place
cutRow -selected
cutRow -selected
uiSetTool move

#######################################################
## Add Power Rings
########################################################

set sprCreateIeRingNets {}
set sprCreateIeRingLayers {}
set sprCreateIeRingWidth 1.0
set sprCreateIeRingSpacing 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer AP -type core_rings -jog_distance 0.4 -threshold 0.4 -nets {GND VDD} -follow core -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2

#######################################################
## Add Block Ring Aroud memory block
########################################################

selectInst TOP_module/Ram_controller_use/wrapper/DUT_ST_SPHDL_160x32_mem2011
addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer AP -around selected -jog_distance 0.4 -threshold 0.4 -type block_rings -nets {GND VDD} -follow core -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2
deselectAll

#######################################################
## Add Strips
########################################################

set sprCreateIeStripeNets {}
set sprCreateIeStripeLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeSpacing 2.0
set sprCreateIeStripeThreshold 1.0

##Vertical

addStripe -skip_via_on_wire_shape Noshape -block_ring_top_layer_limit M1 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit M1 -set_to_set_distance 100 -skip_via_on_pin Standardcell -stacked_via_top_layer AP -padcore_ring_top_layer_limit M1 -spacing 2 -merge_stripes_value 2.5 -layer M4 -block_ring_bottom_layer_limit M1 -stop_x 0 -stop_y 0 -width 2 -area {} -nets {GND VDD} -start_x 0 -stacked_via_bottom_layer M1 -start_y 0

##Horizontal

addStripe -skip_via_on_wire_shape Noshape -block_ring_top_layer_limit M1 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit M1 -set_to_set_distance 100 -skip_via_on_pin Standardcell -stacked_via_top_layer AP -padcore_ring_top_layer_limit M1 -spacing 2 -merge_stripes_value 2.5 -direction horizontal -layer M3 -block_ring_bottom_layer_limit M1 -stop_x 0 -stop_y 0 -width 2 -area {} -nets {GND VDD} -start_x 0 -stacked_via_bottom_layer M1 -start_y 0

#######################################################
## Add Well Taps
########################################################

addWellTap -cell HS65_LH_FILLERSNPWPFP4 -cellInterval 25 -prefix WELLTAP


#######################################################
## Placement Blockage
########################################################


setPlaceMode -prerouteAsObs {1 2 3 4 5 6 7 8}

########################################################
## Placement- Standard cells with Memories
########################################################

setPlaceMode -ignoreScan false
setPlaceMode -fp false
placeDesign

placeDesign -incremental

setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -preCTS

#######################################################
## Clock Synthesis
########################################################

##Setting Properties

set_ccopt_property inverter_cells { HS65_LL_CNIVX10 HS65_LL_CNIVX103 HS65_LL_CNIVX124
HS65_LL_CNIVX14 HS65_LL_CNIVX17 HS65_LL_CNIVX21 HS65_LL_CNIVX24
HS65_LL_CNIVX27 HS65_LL_CNIVX3 HS65_LL_CNIVX31 HS65_LL_CNIVX34 HS65_LL_CNIVX38
HS65_LL_CNIVX41 HS65_LL_CNIVX45 HS65_LL_CNIVX48 HS65_LL_CNIVX52 HS65_LL_CNIVX55
HS65_LL_CNIVX58 HS65_LL_CNIVX62 HS65_LL_CNIVX7 HS65_LL_CNIVX82}

set_ccopt_property buffer_cells {HS65_LL_CNBFX10 HS65_LL_CNBFX103 HS65_LL_CNBFX124
HS65_LL_CNBFX14 HS65_LL_CNBFX17 HS65_LL_CNBFX21 HS65_LL_CNBFX24
HS65_LL_CNBFX27 HS65_LL_CNBFX31 HS65_LL_CNBFX34 HS65_LL_CNBFX38
HS65_LL_CNBFX38_0 HS65_LL_CNBFX38_1 HS65_LL_CNBFX38_10 HS65_LL_CNBFX38_11
HS65_LL_CNBFX38_12 HS65_LL_CNBFX38_13 HS65_LL_CNBFX38_14 HS65_LL_CNBFX38_15
HS65_LL_CNBFX38_16 HS65_LL_CNBFX38_17 HS65_LL_CNBFX38_18
HS65_LL_CNBFX38_19 HS65_LL_CNBFX38_2 HS65_LL_CNBFX38_20 HS65_LL_CNBFX38_21
HS65_LL_CNBFX38_22 HS65_LL_CNBFX38_23 HS65_LL_CNBFX38_3 HS65_LL_CNBFX38_4
HS65_LL_CNBFX38_5 HS65_LL_CNBFX38_6 HS65_LL_CNBFX38_7 HS65_LL_CNBFX38_8
HS65_LL_CNBFX38_9 HS65_LL_CNBFX41 HS65_LL_CNBFX45 HS65_LL_CNBFX48
HS65_LL_CNBFX52 HS65_LL_CNBFX55 HS65_LL_CNBFX58 HS65_LL_CNBFX62 HS65_LL_CNBFX82 }

create_ccopt_clock_tree_spec -file ./ccopt.spec
ccopt_check_and_flatten_ilms_no_restore
create_ccopt_clock_tree -name clk -source clk_in -no_skew_group
set_ccopt_property target_max_trans_sdc -delay_corner SS -late -clock_tree clk 0.200
set_ccopt_property source_latency -delay_corner SS -late -rise -clock_tree clk 0.500
set_ccopt_property source_latency -delay_corner SS -late -fall -clock_tree clk 0.500
set_ccopt_property source_latency -delay_corner FF -late -rise -clock_tree clk 0.500
set_ccopt_property source_latency -delay_corner FF -late -fall -clock_tree clk 0.500
set_ccopt_property clock_period -pin clk_in 10
create_ccopt_skew_group -name clk/Clock_constraints -sources clk_in -auto_sinks
set_ccopt_property include_source_latency -skew_group clk/Clock_constraints true
set_ccopt_property target_insertion_delay -skew_group clk/Clock_constraints 1.000
set_ccopt_property extracted_from_clock_name -skew_group clk/Clock_constraints clk
set_ccopt_property extracted_from_constraint_mode_name -skew_group clk/Clock_constraints Clock_constraints
set_ccopt_property extracted_from_delay_corners -skew_group clk/Clock_constraints {SS FF}
check_ccopt_clock_tree_convergence
get_ccopt_property auto_design_state_for_ilms
ccopt_design
setOptMode -reset
setOptMode -holdFixingCells { HS65_LL_DLYIC2X7 HS65_LL_DLYIC2X9 HS65_LL_DLYIC4X4 HS65_LL_DLYIC4X7
HS65_LL_DLYIC4X9 HS65_LL_DLYIC6X4 HS65_LL_DLYIC6X7 HS65_LL_DLYIC6X9 }

setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postCTS -incr
optDesign -postCTS -hold
report_ccopt_clock_trees -filename ./clktree_ccopt.rpt
report_ccopt_skew_groups -filename ./skewgrp.rpt
report_ccopt_worst_chain -filename ./worst_chain_ccopt.rpt

deleteTrialRoute

#######################################################
## ADD 1um spacing
########################################################

##TOP

##uiSetTool select
selectInst PcornerUL
selectInst VDD1
selectInst {IN_PADS[0].IN_PAD}
selectInst {IN_PADS[1].IN_PAD}
selectInst {IN_PADS[2].IN_PAD}
selectInst {IN_PADS[3].IN_PAD}
selectInst {IN_PADS[4].IN_PAD}
selectInst {IN_PADS[5].IN_PAD}
selectInst VDD2
spaceObject -fixSide left -space 71

## BOTTOM

deselectAll
selectInst PcornerLL
selectInst GND1
selectInst {OUT_PADS[5].OUT_PAD}
selectInst {OUT_PADS[6].OUT_PAD}
selectInst {OUT_PADS[7].OUT_PAD}
selectInst {OUT_PADS[8].OUT_PAD}
selectInst write_done_pad
selectInst fini_pad
selectInst GND2
spaceObject -fixSide left -space 71

## LEFT

deselectAll
selectInst PcornerLL
selectInst {OUT_PADS[4].OUT_PAD}
selectInst {OUT_PADS[3].OUT_PAD}
selectInst {OUT_PADS[2].OUT_PAD}
selectInst {OUT_PADS[1].OUT_PAD}
selectInst {OUT_PADS[0].OUT_PAD}
spaceObject -fixSide bottom -space 48

## RIGHT

deselectAll
selectInst PcornerLR
selectInst rst_pad
selectInst ready_pad
selectInst clk_pad
selectInst {IN_PADS[7].IN_PAD}
selectInst {IN_PADS[6].IN_PAD}
spaceObject -fixSide bottom -space 48

#######################################################
## ADD IO FILLERS
########################################################

addIoFiller -cell PADSPACE_74x1u -prefix IO_FILLER -side n
addIoFiller -cell PADSPACE_74x1u -prefix IO_FILLER -side s
addIoFiller -cell PADSPACE_74x4u -prefix IO_FILLER -side w
addIoFiller -cell PADSPACE_74x4u -prefix IO_FILLER -side e
fit

#######################################################
## Routing
########################################################

sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { M1(1) AP(8) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { M1(1) AP(8) } -nets { GND VDD } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { M1(1) AP(8) }

## Nano-Route

setNanoRouteMode -quiet -timingEngine {}
setNanoRouteMode -quiet -routeWithSiPostRouteFix 0
setNanoRouteMode -quiet -drouteStartIteration default
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven false
setNanoRouteMode -quiet -routeWithSiDriven false
routeDesign -globalDetail

#######################################################
## Add Fillers
########################################################

addFiller -cell HS65_GL_FILLERPFP4 HS65_GL_FILLERPFP3 HS65_GL_FILLERPFP2 HS65_GL_FILLERPFP1 -prefix FILLER -markFixed

setAnalysisMode -analysisType onChipVariation

## Post Route Optimization
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postRoute
setOptMode -fixCap false -fixTran false -fixFanoutLoad false
optDesign -postRoute -hold
setOptMode -fixCap false -fixTran false -fixFanoutLoad false
optDesign -postRoute -hold
setOptMode -fixCap false -fixTran false -fixFanoutLoad false
optDesign -postRoute -hold




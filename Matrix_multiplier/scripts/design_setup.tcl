# Change this variable to top entity of your own design
set DESIGN TOP_with_pads 

# Change this variable to the RTL path of your own design
set RTL "/h/dk/f/ar4013si-s/ICP_VP1/Matrix_multiplier_work4/Matrix_multiplier_work4.srcs/sources_1/new"

set_attribute script_search_path {/h/dk/f/ar4013si-s/ICP_VP1/Matrix_multiplier_work4/scripts} /

set_attribute init_hdl_search_path $RTL /

set_attribute init_lib_search_path { \
/usr/local-eit/cad2/cmpstm/stm065v536/CORE65LPLVT_5.1/libs \
/usr/local-eit/cad2/cmpstm/stm065v536/CLOCK65LPLVT_3.1/libs \
/usr/local-eit/cad2/cmpstm/oldmems/mem2011/SPHD110420-48158@1.0/libs \
/usr/local-eit/cad2/cmpstm/dicp18/lu_pads_65nm \
} /

set_attribute library { \
CLOCK65LPLVT_nom_1.20V_25C.lib \
CORE65LPLVT_nom_1.20V_25C.lib \
SPHD110420_nom_1.20V_25C.lib \
Pads_Oct2012.lib} /

# put all your design files here
set DESIGN_FILES "${RTL}/sram_wrapper.vhd ${RTL}/Controller.vhd ${RTL}/Multiplier_unit.vhd  ${RTL}/RAM_controller.vhd  ${RTL}/TOP.vhd ${RTL}/ROM.vhd ${RTL}/TOP_with_pads.vhd"


set SYN_EFF medium 
set MAP_EFF medium 
set OPT_EFF medium 

set_attribute syn_generic_effort ${SYN_EFF}
set_attribute syn_map_effort ${MAP_EFF}
set_attribute syn_opt_effort ${OPT_EFF}
set_attribute information_level 5; # Up to maximum 9

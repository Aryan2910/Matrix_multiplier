#
# Simple command file for ModelSim
#

onerror continue
project close
project new . demomf

project addfile vhdl/ff.vhd
project addfile vhdl/sub.vhd
project addfile vhdl/mux2.vhd
project addfile vhdl/median_logic.vhd
project addfile vhdl/medianfilter_P.vhd
project addfile vhdl/clockgenerator.vhd
project addfile vhdl/file_read.vhd
project addfile vhdl/medianfilter_behavioral.vhd
project addfile vhdl/medianfilter_tb.vhd

project compileall

vsim work.cfg_medianfilter_tb

add wave sim/:medianfilter_tb:clock
add wave -radix hex sim/:medianfilter_tb:inputbus
add wave -radix hex sim/:medianfilter_tb:outputbus
add wave -radix hex sim/:medianfilter_tb:outputbus2

run 1000ns


version: 3

Orient: R270
Pad: PcornerLL SW PADSPACE_C_74x74u_CH
Orient: R0x3
Pad: PcornerLR SE PADSPACE_C_74x74u_CH
Orient: R90
Pad: PcornerUR NE PADSPACE_C_74x74u_CH
Orient: R180
Pad: PcornerUL NW PADSPACE_C_74x74u_CH

# # ------------------------------------------------ #
# # NORTH
# # ------------------------------------------------ #
Pad: VDD1    		N CPAD_S_74x50u_VDD
Pad: IN_PADS[0].IN_PAD 	N CPAD_S_74x50u_IN
Pad: IN_PADS[1].IN_PAD  N CPAD_S_74x50u_IN
Pad: IN_PADS[2].IN_PAD  N CPAD_S_74x50u_IN
Pad: IN_PADS[3].IN_PAD  N CPAD_S_74x50u_IN
Pad: IN_PADS[4].IN_PAD 	N CPAD_S_74x50u_IN
Pad: IN_PADS[5].IN_PAD  N CPAD_S_74x50u_IN
Pad: VDD2   		N CPAD_S_74x50u_VDD
# # ------------------------------------------------ #
# # EAST 
# # ------------------------------------------------ #
Pad: rst_pad		E CPAD_S_74x50u_IN
Pad: ready_pad  	E CPAD_S_74x50u_IN
Pad: clk_pad 		E CPAD_S_74x50u_IN
Pad: IN_PADS[7].IN_PAD  E CPAD_S_74x50u_IN
Pad: IN_PADS[6].IN_PAD 	E CPAD_S_74x50u_IN
# # ------------------------------------------------ #
# # SOUTH
# # ------------------------------------------------ #
Pad: GND1 		 S CPAD_S_74x50u_GND
Pad: OUT_PADS[5].OUT_PAD S CPAD_S_74x50u_OUT
Pad: OUT_PADS[6].OUT_PAD S CPAD_S_74x50u_OUT
Pad: OUT_PADS[7].OUT_PAD S CPAD_S_74x50u_OUT
Pad: OUT_PADS[8].OUT_PAD S CPAD_S_74x50u_OUT
Pad: write_done_pad	 S CPAD_S_74x50u_OUT
Pad: fini_pad  		 S CPAD_S_74x50u_OUT
Pad: GND2   		 S CPAD_S_74x50u_GND
# # ------------------------------------------------ #
# # WEST 
# # ------------------------------------------------ #
Pad: OUT_PADS[4].OUT_PAD W CPAD_S_74x50u_OUT
Pad: OUT_PADS[3].OUT_PAD W CPAD_S_74x50u_OUT
Pad: OUT_PADS[2].OUT_PAD W CPAD_S_74x50u_OUT
Pad: OUT_PADS[1].OUT_PAD W CPAD_S_74x50u_OUT
Pad: OUT_PADS[0].OUT_PAD W CPAD_S_74x50u_OUT

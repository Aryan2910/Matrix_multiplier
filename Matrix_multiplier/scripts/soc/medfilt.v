
module SUB_N8_0_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] DIFF;
  input CI;
  output CO;
  wire   \carry[8] , \B_not[8] , n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11,
         n12, n13, n14, n15, n16, n17, n18, n19, n20, n21;

  HS65_LHS_XOR3X2 U2_8 ( .A(A[8]), .B(\B_not[8] ), .C(\carry[8] ), .Z(DIFF[8])
         );
  HS65_LH_OAI12X2 U1 ( .A(n1), .B(n2), .C(n3), .Z(\carry[8] ) );
  HS65_LH_AO12X4 U2 ( .A(n2), .B(n1), .C(B[8]), .Z(n3) );
  HS65_LH_IVX2 U3 ( .A(A[8]), .Z(n2) );
  HS65_LH_CBI4I6X2 U4 ( .A(n4), .B(A[6]), .C(n5), .D(n6), .Z(n1) );
  HS65_LH_AND2X4 U5 ( .A(A[6]), .B(n4), .Z(n6) );
  HS65_LH_IVX2 U6 ( .A(B[6]), .Z(n5) );
  HS65_LH_CBI4I1X3 U7 ( .A(n7), .B(n8), .C(B[5]), .D(n9), .Z(n4) );
  HS65_LH_OR2X4 U8 ( .A(n7), .B(n8), .Z(n9) );
  HS65_LH_IVX2 U9 ( .A(A[5]), .Z(n8) );
  HS65_LH_CBI4I6X2 U10 ( .A(n10), .B(A[4]), .C(n11), .D(n12), .Z(n7) );
  HS65_LH_AND2X4 U11 ( .A(A[4]), .B(n10), .Z(n12) );
  HS65_LH_IVX2 U12 ( .A(B[4]), .Z(n11) );
  HS65_LH_CBI4I1X3 U13 ( .A(n13), .B(n14), .C(B[3]), .D(n15), .Z(n10) );
  HS65_LH_OR2X4 U14 ( .A(n13), .B(n14), .Z(n15) );
  HS65_LH_IVX2 U15 ( .A(A[3]), .Z(n14) );
  HS65_LH_CBI4I6X2 U16 ( .A(n16), .B(A[2]), .C(n17), .D(n18), .Z(n13) );
  HS65_LH_AND2X4 U17 ( .A(A[2]), .B(n16), .Z(n18) );
  HS65_LH_IVX2 U18 ( .A(B[2]), .Z(n17) );
  HS65_LH_CBI4I1X3 U19 ( .A(n19), .B(n20), .C(B[1]), .D(n21), .Z(n16) );
  HS65_LH_OR2X4 U20 ( .A(n19), .B(n20), .Z(n21) );
  HS65_LH_IVX2 U21 ( .A(A[1]), .Z(n20) );
  HS65_LH_NOR2AX3 U22 ( .A(B[0]), .B(A[0]), .Z(n19) );
  HS65_LH_IVX2 U23 ( .A(B[8]), .Z(\B_not[8] ) );
endmodule


module SUB_N8_2_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] DIFF;
  input CI;
  output CO;
  wire   \carry[8] , \B_not[8] , n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11,
         n12, n13, n14, n15, n16, n17, n18, n19, n20, n21;

  HS65_LHS_XOR3X2 U2_8 ( .A(A[8]), .B(\B_not[8] ), .C(\carry[8] ), .Z(DIFF[8])
         );
  HS65_LH_OAI12X2 U1 ( .A(n1), .B(n2), .C(n3), .Z(\carry[8] ) );
  HS65_LH_AO12X4 U2 ( .A(n2), .B(n1), .C(B[8]), .Z(n3) );
  HS65_LH_IVX2 U3 ( .A(A[8]), .Z(n2) );
  HS65_LH_CBI4I6X2 U4 ( .A(n4), .B(A[6]), .C(n5), .D(n6), .Z(n1) );
  HS65_LH_AND2X4 U5 ( .A(A[6]), .B(n4), .Z(n6) );
  HS65_LH_IVX2 U6 ( .A(B[6]), .Z(n5) );
  HS65_LH_CBI4I1X3 U7 ( .A(n7), .B(n8), .C(B[5]), .D(n9), .Z(n4) );
  HS65_LH_OR2X4 U8 ( .A(n7), .B(n8), .Z(n9) );
  HS65_LH_IVX2 U9 ( .A(A[5]), .Z(n8) );
  HS65_LH_CBI4I6X2 U10 ( .A(n10), .B(A[4]), .C(n11), .D(n12), .Z(n7) );
  HS65_LH_AND2X4 U11 ( .A(A[4]), .B(n10), .Z(n12) );
  HS65_LH_IVX2 U12 ( .A(B[4]), .Z(n11) );
  HS65_LH_CBI4I1X3 U13 ( .A(n13), .B(n14), .C(B[3]), .D(n15), .Z(n10) );
  HS65_LH_OR2X4 U14 ( .A(n13), .B(n14), .Z(n15) );
  HS65_LH_IVX2 U15 ( .A(A[3]), .Z(n14) );
  HS65_LH_CBI4I6X2 U16 ( .A(n16), .B(A[2]), .C(n17), .D(n18), .Z(n13) );
  HS65_LH_AND2X4 U17 ( .A(A[2]), .B(n16), .Z(n18) );
  HS65_LH_IVX2 U18 ( .A(B[2]), .Z(n17) );
  HS65_LH_CBI4I1X3 U19 ( .A(n19), .B(n20), .C(B[1]), .D(n21), .Z(n16) );
  HS65_LH_OR2X4 U20 ( .A(n19), .B(n20), .Z(n21) );
  HS65_LH_IVX2 U21 ( .A(A[1]), .Z(n20) );
  HS65_LH_NOR2AX3 U22 ( .A(B[0]), .B(A[0]), .Z(n19) );
  HS65_LH_IVX2 U23 ( .A(B[8]), .Z(\B_not[8] ) );
endmodule


module SUB_N8_1_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] DIFF;
  input CI;
  output CO;
  wire   \carry[8] , \B_not[8] , n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11,
         n12, n13, n14, n15, n16, n17, n18, n19, n20, n21;

  HS65_LHS_XOR3X2 U2_8 ( .A(A[8]), .B(\B_not[8] ), .C(\carry[8] ), .Z(DIFF[8])
         );
  HS65_LH_OAI12X2 U1 ( .A(n1), .B(n2), .C(n3), .Z(\carry[8] ) );
  HS65_LH_AO12X4 U2 ( .A(n2), .B(n1), .C(B[8]), .Z(n3) );
  HS65_LH_IVX2 U3 ( .A(A[8]), .Z(n2) );
  HS65_LH_CBI4I6X2 U4 ( .A(n4), .B(A[6]), .C(n5), .D(n6), .Z(n1) );
  HS65_LH_AND2X4 U5 ( .A(A[6]), .B(n4), .Z(n6) );
  HS65_LH_IVX2 U6 ( .A(B[6]), .Z(n5) );
  HS65_LH_CBI4I1X3 U7 ( .A(n7), .B(n8), .C(B[5]), .D(n9), .Z(n4) );
  HS65_LH_OR2X4 U8 ( .A(n7), .B(n8), .Z(n9) );
  HS65_LH_IVX2 U9 ( .A(A[5]), .Z(n8) );
  HS65_LH_CBI4I6X2 U10 ( .A(n10), .B(A[4]), .C(n11), .D(n12), .Z(n7) );
  HS65_LH_AND2X4 U11 ( .A(A[4]), .B(n10), .Z(n12) );
  HS65_LH_IVX2 U12 ( .A(B[4]), .Z(n11) );
  HS65_LH_CBI4I1X3 U13 ( .A(n13), .B(n14), .C(B[3]), .D(n15), .Z(n10) );
  HS65_LH_OR2X4 U14 ( .A(n13), .B(n14), .Z(n15) );
  HS65_LH_IVX2 U15 ( .A(A[3]), .Z(n14) );
  HS65_LH_CBI4I6X2 U16 ( .A(n16), .B(A[2]), .C(n17), .D(n18), .Z(n13) );
  HS65_LH_AND2X4 U17 ( .A(A[2]), .B(n16), .Z(n18) );
  HS65_LH_IVX2 U18 ( .A(B[2]), .Z(n17) );
  HS65_LH_CBI4I1X3 U19 ( .A(n19), .B(n20), .C(B[1]), .D(n21), .Z(n16) );
  HS65_LH_OR2X4 U20 ( .A(n19), .B(n20), .Z(n21) );
  HS65_LH_IVX2 U21 ( .A(A[1]), .Z(n20) );
  HS65_LH_NOR2AX3 U22 ( .A(B[0]), .B(A[0]), .Z(n19) );
  HS65_LH_IVX2 U23 ( .A(B[8]), .Z(\B_not[8] ) );
endmodule


module SUB_N8_2 ( POS, NEG, Q );
  input [7:0] POS;
  input [7:0] NEG;
  output [8:0] Q;


  SUB_N8_2_DW01_sub_0 sub_26 ( .A({POS[7], POS}), .B({NEG[7], NEG}), .CI(1'b0), 
        .DIFF(Q) );
endmodule


module SUB_N8_1 ( POS, NEG, Q );
  input [7:0] POS;
  input [7:0] NEG;
  output [8:0] Q;


  SUB_N8_1_DW01_sub_0 sub_26 ( .A({POS[7], POS}), .B({NEG[7], NEG}), .CI(1'b0), 
        .DIFF(Q) );
endmodule


module MUX2_N8_1 ( IN0, IN1, Q, SEL );
  input [7:0] IN0;
  input [7:0] IN1;
  output [7:0] Q;
  input SEL;
  wire   n1;

  HS65_LH_IVX9 U1 ( .A(SEL), .Z(n1) );
  HS65_LH_AO22X9 U2 ( .A(IN1[0]), .B(SEL), .C(IN0[0]), .D(n1), .Z(Q[0]) );
  HS65_LH_AO22X9 U3 ( .A(IN1[1]), .B(SEL), .C(IN0[1]), .D(n1), .Z(Q[1]) );
  HS65_LH_AO22X9 U4 ( .A(IN1[2]), .B(SEL), .C(IN0[2]), .D(n1), .Z(Q[2]) );
  HS65_LH_AO22X9 U5 ( .A(IN1[3]), .B(SEL), .C(IN0[3]), .D(n1), .Z(Q[3]) );
  HS65_LH_AO22X9 U6 ( .A(IN1[4]), .B(SEL), .C(IN0[4]), .D(n1), .Z(Q[4]) );
  HS65_LH_AO22X9 U7 ( .A(IN1[5]), .B(SEL), .C(IN0[5]), .D(n1), .Z(Q[5]) );
  HS65_LH_AO22X9 U8 ( .A(IN1[6]), .B(SEL), .C(IN0[6]), .D(n1), .Z(Q[6]) );
  HS65_LH_AO22X9 U9 ( .A(SEL), .B(IN1[7]), .C(IN0[7]), .D(n1), .Z(Q[7]) );
endmodule


module FF_N8_3 ( D, Q, clk );
  input [7:0] D;
  output [7:0] Q;
  input clk;


  HS65_LH_DFPQX9 \Q_reg[7]  ( .D(D[7]), .CP(clk), .Q(Q[7]) );
  HS65_LH_DFPQX9 \Q_reg[6]  ( .D(D[6]), .CP(clk), .Q(Q[6]) );
  HS65_LH_DFPQX9 \Q_reg[5]  ( .D(D[5]), .CP(clk), .Q(Q[5]) );
  HS65_LH_DFPQX9 \Q_reg[4]  ( .D(D[4]), .CP(clk), .Q(Q[4]) );
  HS65_LH_DFPQX9 \Q_reg[3]  ( .D(D[3]), .CP(clk), .Q(Q[3]) );
  HS65_LH_DFPQX9 \Q_reg[2]  ( .D(D[2]), .CP(clk), .Q(Q[2]) );
  HS65_LH_DFPQX9 \Q_reg[1]  ( .D(D[1]), .CP(clk), .Q(Q[1]) );
  HS65_LH_DFPQX9 \Q_reg[0]  ( .D(D[0]), .CP(clk), .Q(Q[0]) );
endmodule


module FF_N8_2 ( D, Q, clk );
  input [7:0] D;
  output [7:0] Q;
  input clk;


  HS65_LH_DFPQX9 \Q_reg[7]  ( .D(D[7]), .CP(clk), .Q(Q[7]) );
  HS65_LH_DFPQX9 \Q_reg[6]  ( .D(D[6]), .CP(clk), .Q(Q[6]) );
  HS65_LH_DFPQX9 \Q_reg[5]  ( .D(D[5]), .CP(clk), .Q(Q[5]) );
  HS65_LH_DFPQX9 \Q_reg[4]  ( .D(D[4]), .CP(clk), .Q(Q[4]) );
  HS65_LH_DFPQX9 \Q_reg[3]  ( .D(D[3]), .CP(clk), .Q(Q[3]) );
  HS65_LH_DFPQX9 \Q_reg[2]  ( .D(D[2]), .CP(clk), .Q(Q[2]) );
  HS65_LH_DFPQX9 \Q_reg[1]  ( .D(D[1]), .CP(clk), .Q(Q[1]) );
  HS65_LH_DFPQX9 \Q_reg[0]  ( .D(D[0]), .CP(clk), .Q(Q[0]) );
endmodule


module FF_N8_1 ( D, Q, clk );
  input [7:0] D;
  output [7:0] Q;
  input clk;


  HS65_LH_DFPQX9 \Q_reg[7]  ( .D(D[7]), .CP(clk), .Q(Q[7]) );
  HS65_LH_DFPQX9 \Q_reg[6]  ( .D(D[6]), .CP(clk), .Q(Q[6]) );
  HS65_LH_DFPQX9 \Q_reg[5]  ( .D(D[5]), .CP(clk), .Q(Q[5]) );
  HS65_LH_DFPQX9 \Q_reg[4]  ( .D(D[4]), .CP(clk), .Q(Q[4]) );
  HS65_LH_DFPQX9 \Q_reg[3]  ( .D(D[3]), .CP(clk), .Q(Q[3]) );
  HS65_LH_DFPQX9 \Q_reg[2]  ( .D(D[2]), .CP(clk), .Q(Q[2]) );
  HS65_LH_DFPQX9 \Q_reg[1]  ( .D(D[1]), .CP(clk), .Q(Q[1]) );
  HS65_LH_DFPQX9 \Q_reg[0]  ( .D(D[0]), .CP(clk), .Q(Q[0]) );
endmodule


module MEDIAN_LOGIC ( a, b, c, q, w );
  input a, b, c;
  output q, w;
  wire   N10, n5, n6, n7, n8, n9;
  assign w = N10;

  HS65_LH_OAI33X3 U3 ( .A(n8), .B(b), .C(n7), .D(n9), .E(c), .F(a), .Z(N10) );
  HS65_LH_IVX9 U4 ( .A(c), .Z(n8) );
  HS65_LH_IVX9 U5 ( .A(b), .Z(n9) );
  HS65_LH_NOR2X6 U6 ( .A(n5), .B(n6), .Z(q) );
  HS65_LHS_XOR2X6 U7 ( .A(c), .B(b), .Z(n6) );
  HS65_LHS_XOR2X6 U8 ( .A(n7), .B(b), .Z(n5) );
  HS65_LH_IVX9 U9 ( .A(a), .Z(n7) );
endmodule


module SUB_N8_0 ( POS, NEG, Q );
  input [7:0] POS;
  input [7:0] NEG;
  output [8:0] Q;


  SUB_N8_0_DW01_sub_0 sub_26 ( .A({POS[7], POS}), .B({NEG[7], NEG}), .CI(1'b0), 
        .DIFF(Q) );
endmodule


module MUX2_N8_0 ( IN0, IN1, Q, SEL );
  input [7:0] IN0;
  input [7:0] IN1;
  output [7:0] Q;
  input SEL;
  wire   n3;

  HS65_LH_IVX9 U1 ( .A(SEL), .Z(n3) );
  HS65_LH_AO22X9 U2 ( .A(IN1[0]), .B(SEL), .C(IN0[0]), .D(n3), .Z(Q[0]) );
  HS65_LH_AO22X9 U3 ( .A(IN1[1]), .B(SEL), .C(IN0[1]), .D(n3), .Z(Q[1]) );
  HS65_LH_AO22X9 U4 ( .A(IN1[2]), .B(SEL), .C(IN0[2]), .D(n3), .Z(Q[2]) );
  HS65_LH_AO22X9 U5 ( .A(IN1[3]), .B(SEL), .C(IN0[3]), .D(n3), .Z(Q[3]) );
  HS65_LH_AO22X9 U6 ( .A(IN1[4]), .B(SEL), .C(IN0[4]), .D(n3), .Z(Q[4]) );
  HS65_LH_AO22X9 U7 ( .A(IN1[5]), .B(SEL), .C(IN0[5]), .D(n3), .Z(Q[5]) );
  HS65_LH_AO22X9 U8 ( .A(IN1[6]), .B(SEL), .C(IN0[6]), .D(n3), .Z(Q[6]) );
  HS65_LH_AO22X9 U9 ( .A(SEL), .B(IN1[7]), .C(IN0[7]), .D(n3), .Z(Q[7]) );
endmodule


module FF_N8_0 ( D, Q, clk );
  input [7:0] D;
  output [7:0] Q;
  input clk;


  HS65_LH_DFPQX9 \Q_reg[7]  ( .D(D[7]), .CP(clk), .Q(Q[7]) );
  HS65_LH_DFPQX9 \Q_reg[6]  ( .D(D[6]), .CP(clk), .Q(Q[6]) );
  HS65_LH_DFPQX9 \Q_reg[5]  ( .D(D[5]), .CP(clk), .Q(Q[5]) );
  HS65_LH_DFPQX9 \Q_reg[4]  ( .D(D[4]), .CP(clk), .Q(Q[4]) );
  HS65_LH_DFPQX9 \Q_reg[3]  ( .D(D[3]), .CP(clk), .Q(Q[3]) );
  HS65_LH_DFPQX9 \Q_reg[2]  ( .D(D[2]), .CP(clk), .Q(Q[2]) );
  HS65_LH_DFPQX9 \Q_reg[1]  ( .D(D[1]), .CP(clk), .Q(Q[1]) );
  HS65_LH_DFPQX9 \Q_reg[0]  ( .D(D[0]), .CP(clk), .Q(Q[0]) );
endmodule


module MEDIANFILTER_N8 ( INP, UTP, clk );
  inout [7:0] INP;
  inout [7:0] UTP;
  inout clk;
  wire   clki, q, w, \aa[8] , \bb[8] , \cc[8] ;
  wire   [7:0] INPi;
  wire   [7:0] UTPi;
  wire   [7:0] inp1;
  wire   [7:0] inp2;
  wire   [7:0] inp3;
  wire   [7:0] mux0;
  wire   [7:0] utp0;
  tri   [7:0] INP;
  tri   [7:0] UTP;
  tri   clk;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, 
        SYNOPSYS_UNCONNECTED__8, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, 
        SYNOPSYS_UNCONNECTED__12, SYNOPSYS_UNCONNECTED__13, 
        SYNOPSYS_UNCONNECTED__14, SYNOPSYS_UNCONNECTED__15, 
        SYNOPSYS_UNCONNECTED__16, SYNOPSYS_UNCONNECTED__17, 
        SYNOPSYS_UNCONNECTED__18, SYNOPSYS_UNCONNECTED__19, 
        SYNOPSYS_UNCONNECTED__20, SYNOPSYS_UNCONNECTED__21, 
        SYNOPSYS_UNCONNECTED__22, SYNOPSYS_UNCONNECTED__23;

  BD2SCARUDQP_1V8_SF_LIN InPad_0 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), 
        .TEN(1'b1), .IO(INP[0]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0), .ZI(
        INPi[0]) );
  BD2SCARUDQP_1V8_SF_LIN InPad_1 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), 
        .TEN(1'b1), .IO(INP[1]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0), .ZI(
        INPi[1]) );
  BD2SCARUDQP_1V8_SF_LIN InPad_2 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), 
        .TEN(1'b1), .IO(INP[2]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0), .ZI(
        INPi[2]) );
  BD2SCARUDQP_1V8_SF_LIN InPad_3 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), 
        .TEN(1'b1), .IO(INP[3]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0), .ZI(
        INPi[3]) );
  BD2SCARUDQP_1V8_SF_LIN InPad_4 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), 
        .TEN(1'b1), .IO(INP[4]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0), .ZI(
        INPi[4]) );
  BD2SCARUDQP_1V8_SF_LIN InPad_5 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), 
        .TEN(1'b1), .IO(INP[5]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0), .ZI(
        INPi[5]) );
  BD2SCARUDQP_1V8_SF_LIN InPad_6 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), 
        .TEN(1'b1), .IO(INP[6]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0), .ZI(
        INPi[6]) );
  BD2SCARUDQP_1V8_SF_LIN InPad_7 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), 
        .TEN(1'b1), .IO(INP[7]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0), .ZI(
        INPi[7]) );
  BD2SCARUDQP_1V8_SF_LIN clkpad ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), 
        .TEN(1'b1), .IO(clk), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0), .ZI(clki)
         );
  BD2SCARUDQP_1V8_SF_LIN OutPad_0 ( .A(UTPi[0]), .TA(1'b0), .TM(1'b0), .EN(
        1'b0), .TEN(1'b0), .IO(UTP[0]), .HYST(1'b0), .PDN(1'b1), .PUN(1'b1) );
  BD2SCARUDQP_1V8_SF_LIN OutPad_1 ( .A(UTPi[1]), .TA(1'b0), .TM(1'b0), .EN(
        1'b0), .TEN(1'b0), .IO(UTP[1]), .HYST(1'b0), .PDN(1'b1), .PUN(1'b1) );
  BD2SCARUDQP_1V8_SF_LIN OutPad_2 ( .A(UTPi[2]), .TA(1'b0), .TM(1'b0), .EN(
        1'b0), .TEN(1'b0), .IO(UTP[2]), .HYST(1'b0), .PDN(1'b1), .PUN(1'b1) );
  BD2SCARUDQP_1V8_SF_LIN OutPad_3 ( .A(UTPi[3]), .TA(1'b0), .TM(1'b0), .EN(
        1'b0), .TEN(1'b0), .IO(UTP[3]), .HYST(1'b0), .PDN(1'b1), .PUN(1'b1) );
  BD2SCARUDQP_1V8_SF_LIN OutPad_4 ( .A(UTPi[4]), .TA(1'b0), .TM(1'b0), .EN(
        1'b0), .TEN(1'b0), .IO(UTP[4]), .HYST(1'b0), .PDN(1'b1), .PUN(1'b1) );
  BD2SCARUDQP_1V8_SF_LIN OutPad_5 ( .A(UTPi[5]), .TA(1'b0), .TM(1'b0), .EN(
        1'b0), .TEN(1'b0), .IO(UTP[5]), .HYST(1'b0), .PDN(1'b1), .PUN(1'b1) );
  BD2SCARUDQP_1V8_SF_LIN OutPad_6 ( .A(UTPi[6]), .TA(1'b0), .TM(1'b0), .EN(
        1'b0), .TEN(1'b0), .IO(UTP[6]), .HYST(1'b0), .PDN(1'b1), .PUN(1'b1) );
  BD2SCARUDQP_1V8_SF_LIN OutPad_7 ( .A(UTPi[7]), .TA(1'b0), .TM(1'b0), .EN(
        1'b0), .TEN(1'b0), .IO(UTP[7]), .HYST(1'b0), .PDN(1'b1), .PUN(1'b1) );
  FF_N8_0 FF_0 ( .D(INPi), .Q(inp1), .clk(clki) );
  FF_N8_3 FF_1 ( .D(inp1), .Q(inp2), .clk(clki) );
  FF_N8_2 FF_2 ( .D(inp2), .Q(inp3), .clk(clki) );
  MUX2_N8_0 MUX2_0 ( .IN0(inp1), .IN1(inp2), .Q(mux0), .SEL(q) );
  MUX2_N8_1 MUX2_1 ( .IN0(mux0), .IN1(inp3), .Q(utp0), .SEL(w) );
  FF_N8_1 FF_3 ( .D(utp0), .Q(UTPi), .clk(clki) );
  SUB_N8_0 SUB_0 ( .POS(inp3), .NEG(inp1), .Q({\aa[8] , 
        SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7}) );
  SUB_N8_2 SUB_1 ( .POS(inp1), .NEG(inp2), .Q({\bb[8] , 
        SYNOPSYS_UNCONNECTED__8, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, 
        SYNOPSYS_UNCONNECTED__12, SYNOPSYS_UNCONNECTED__13, 
        SYNOPSYS_UNCONNECTED__14, SYNOPSYS_UNCONNECTED__15}) );
  SUB_N8_1 SUB_2 ( .POS(inp2), .NEG(inp3), .Q({\cc[8] , 
        SYNOPSYS_UNCONNECTED__16, SYNOPSYS_UNCONNECTED__17, 
        SYNOPSYS_UNCONNECTED__18, SYNOPSYS_UNCONNECTED__19, 
        SYNOPSYS_UNCONNECTED__20, SYNOPSYS_UNCONNECTED__21, 
        SYNOPSYS_UNCONNECTED__22, SYNOPSYS_UNCONNECTED__23}) );
  MEDIAN_LOGIC LOGIC ( .a(\aa[8] ), .b(\bb[8] ), .c(\cc[8] ), .q(q), .w(w) );
endmodule


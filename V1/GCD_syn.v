/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : U-2022.12
// Date      : Tue Jun  2 10:18:47 2026
/////////////////////////////////////////////////////////////


module Controller ( start, C_1, C_2, rst_n, clk, load_A, load_B, load_R, 
        M2_sel, M3_sel, done, M1_sel, alu_sel );
  output [1:0] M1_sel;
  output [2:0] alu_sel;
  input start, C_1, C_2, rst_n, clk;
  output load_A, load_B, load_R, M2_sel, M3_sel, done;
  wire   load_R, n6, n7, n8, n9, n10, M2_sel, n2, n3, n4, n5;
  wire   [2:0] Next_State;
  assign M3_sel = load_R;
  assign M1_sel[1] = M2_sel;

  DFFRQX4 \Current_State_reg[1]  ( .D(Next_State[1]), .CK(clk), .RN(rst_n), 
        .Q(alu_sel[1]) );
  DFFRQX4 \Current_State_reg[0]  ( .D(Next_State[0]), .CK(clk), .RN(rst_n), 
        .Q(alu_sel[0]) );
  DFFRQX2 \Current_State_reg[2]  ( .D(Next_State[2]), .CK(clk), .RN(rst_n), 
        .Q(alu_sel[2]) );
  NOR2X2 U3 ( .A(n8), .B(n3), .Y(load_R) );
  INVX4 U4 ( .A(n7), .Y(M2_sel) );
  OAI21BX1 U5 ( .A0(n6), .A1(n3), .B0N(load_R), .Y(Next_State[2]) );
  NOR3X1 U6 ( .A(n3), .B(n4), .C(n5), .Y(done) );
  OAI222X1 U7 ( .A0(C_2), .A1(n8), .B0(C_1), .B1(n6), .C0(alu_sel[0]), .C1(n10), .Y(Next_State[0]) );
  NOR3X1 U8 ( .A(alu_sel[1]), .B(start), .C(alu_sel[2]), .Y(n10) );
  INVX2 U9 ( .A(alu_sel[0]), .Y(n3) );
  NAND2X2 U10 ( .A(alu_sel[2]), .B(n4), .Y(n8) );
  INVX2 U11 ( .A(alu_sel[1]), .Y(n4) );
  NAND3X2 U12 ( .A(alu_sel[1]), .B(n3), .C(alu_sel[2]), .Y(n7) );
  NOR3X2 U13 ( .A(alu_sel[1]), .B(alu_sel[2]), .C(n3), .Y(M1_sel[0]) );
  OAI211XL U14 ( .A0(alu_sel[0]), .A1(n8), .B0(n7), .C0(n2), .Y(load_A) );
  INVX2 U15 ( .A(M1_sel[0]), .Y(n2) );
  OAI21X1 U16 ( .A0(alu_sel[0]), .A1(n6), .B0(n7), .Y(load_B) );
  NAND2X2 U17 ( .A(alu_sel[1]), .B(n5), .Y(n6) );
  INVX2 U18 ( .A(alu_sel[2]), .Y(n5) );
  OAI21X1 U19 ( .A0(alu_sel[0]), .A1(n5), .B0(n9), .Y(Next_State[1]) );
  XOR2X1 U20 ( .A(n4), .B(alu_sel[0]), .Y(n9) );
endmodule


module Register_0 ( D, reset, clk, load, Q );
  input [7:0] D;
  output [7:0] Q;
  input reset, clk, load;
  wire   n2, n3, n4, n5, n6, n7, n8, n9, n1, n10;

  DFFRQX4 \Q_reg[7]  ( .D(n9), .CK(clk), .RN(reset), .Q(Q[7]) );
  DFFRQX4 \Q_reg[6]  ( .D(n8), .CK(clk), .RN(reset), .Q(Q[6]) );
  DFFRQX4 \Q_reg[5]  ( .D(n7), .CK(clk), .RN(reset), .Q(Q[5]) );
  DFFRQX4 \Q_reg[4]  ( .D(n6), .CK(clk), .RN(reset), .Q(Q[4]) );
  DFFRQX4 \Q_reg[3]  ( .D(n5), .CK(clk), .RN(reset), .Q(Q[3]) );
  DFFRQX4 \Q_reg[1]  ( .D(n3), .CK(clk), .RN(reset), .Q(Q[1]) );
  DFFRQX4 \Q_reg[2]  ( .D(n4), .CK(clk), .RN(reset), .Q(Q[2]) );
  DFFRQX4 \Q_reg[0]  ( .D(n2), .CK(clk), .RN(reset), .Q(Q[0]) );
  BUFX2 U2 ( .A(load), .Y(n1) );
  INVX2 U3 ( .A(n1), .Y(n10) );
  AO22X2 U4 ( .A0(Q[7]), .A1(n10), .B0(D[7]), .B1(n1), .Y(n9) );
  AO22X2 U5 ( .A0(Q[6]), .A1(n10), .B0(D[6]), .B1(n1), .Y(n8) );
  AO22X2 U6 ( .A0(Q[5]), .A1(n10), .B0(D[5]), .B1(n1), .Y(n7) );
  AO22X2 U7 ( .A0(Q[4]), .A1(n10), .B0(D[4]), .B1(n1), .Y(n6) );
  AO22X2 U8 ( .A0(Q[3]), .A1(n10), .B0(D[3]), .B1(n1), .Y(n5) );
  AO22X2 U9 ( .A0(Q[2]), .A1(n10), .B0(D[2]), .B1(n1), .Y(n4) );
  AO22X2 U10 ( .A0(Q[0]), .A1(n10), .B0(n1), .B1(D[0]), .Y(n2) );
  AO22X2 U11 ( .A0(Q[1]), .A1(n10), .B0(D[1]), .B1(n1), .Y(n3) );
endmodule


module Register_2 ( D, reset, clk, load, Q );
  input [7:0] D;
  output [7:0] Q;
  input reset, clk, load;
  wire   n1, n10, n11, n12, n13, n14, n15, n16, n17, n18;

  DFFRQX2 \Q_reg[7]  ( .D(n11), .CK(clk), .RN(reset), .Q(Q[7]) );
  DFFRQX2 \Q_reg[6]  ( .D(n12), .CK(clk), .RN(reset), .Q(Q[6]) );
  DFFRQX2 \Q_reg[5]  ( .D(n13), .CK(clk), .RN(reset), .Q(Q[5]) );
  DFFRQX2 \Q_reg[4]  ( .D(n14), .CK(clk), .RN(reset), .Q(Q[4]) );
  DFFRQX2 \Q_reg[3]  ( .D(n15), .CK(clk), .RN(reset), .Q(Q[3]) );
  DFFRQX2 \Q_reg[1]  ( .D(n17), .CK(clk), .RN(reset), .Q(Q[1]) );
  DFFRQX2 \Q_reg[2]  ( .D(n16), .CK(clk), .RN(reset), .Q(Q[2]) );
  DFFRQX2 \Q_reg[0]  ( .D(n18), .CK(clk), .RN(reset), .Q(Q[0]) );
  BUFX2 U2 ( .A(load), .Y(n1) );
  INVX2 U3 ( .A(n1), .Y(n10) );
  AO22X2 U4 ( .A0(Q[0]), .A1(n10), .B0(n1), .B1(D[0]), .Y(n18) );
  AO22X2 U5 ( .A0(Q[7]), .A1(n10), .B0(D[7]), .B1(n1), .Y(n11) );
  AO22X2 U6 ( .A0(Q[1]), .A1(n10), .B0(D[1]), .B1(n1), .Y(n17) );
  AO22X2 U7 ( .A0(Q[2]), .A1(n10), .B0(D[2]), .B1(n1), .Y(n16) );
  AO22X2 U8 ( .A0(Q[3]), .A1(n10), .B0(D[3]), .B1(n1), .Y(n15) );
  AO22X2 U9 ( .A0(Q[4]), .A1(n10), .B0(D[4]), .B1(n1), .Y(n14) );
  AO22X2 U10 ( .A0(Q[5]), .A1(n10), .B0(D[5]), .B1(n1), .Y(n13) );
  AO22X2 U11 ( .A0(Q[6]), .A1(n10), .B0(D[6]), .B1(n1), .Y(n12) );
endmodule


module Register_1 ( D, reset, clk, load, Q );
  input [7:0] D;
  output [7:0] Q;
  input reset, clk, load;
  wire   n1, n10, n11, n12, n13, n14, n15, n16, n17, n18;

  DFFRQX2 \Q_reg[6]  ( .D(n12), .CK(clk), .RN(reset), .Q(Q[6]) );
  DFFRQX2 \Q_reg[5]  ( .D(n13), .CK(clk), .RN(reset), .Q(Q[5]) );
  DFFRQX2 \Q_reg[4]  ( .D(n14), .CK(clk), .RN(reset), .Q(Q[4]) );
  DFFRQX2 \Q_reg[3]  ( .D(n15), .CK(clk), .RN(reset), .Q(Q[3]) );
  DFFRQX2 \Q_reg[2]  ( .D(n16), .CK(clk), .RN(reset), .Q(Q[2]) );
  DFFRQX2 \Q_reg[1]  ( .D(n17), .CK(clk), .RN(reset), .Q(Q[1]) );
  DFFRQX2 \Q_reg[0]  ( .D(n18), .CK(clk), .RN(reset), .Q(Q[0]) );
  DFFRQX2 \Q_reg[7]  ( .D(n11), .CK(clk), .RN(reset), .Q(Q[7]) );
  INVX2 U2 ( .A(n1), .Y(n10) );
  BUFX2 U3 ( .A(load), .Y(n1) );
  AO22X2 U4 ( .A0(Q[1]), .A1(n10), .B0(D[1]), .B1(n1), .Y(n17) );
  AO22X2 U5 ( .A0(Q[0]), .A1(n10), .B0(n1), .B1(D[0]), .Y(n18) );
  AO22X2 U6 ( .A0(Q[6]), .A1(n10), .B0(D[6]), .B1(n1), .Y(n12) );
  AO22X2 U7 ( .A0(Q[4]), .A1(n10), .B0(D[4]), .B1(n1), .Y(n14) );
  AO22X2 U8 ( .A0(Q[2]), .A1(n10), .B0(D[2]), .B1(n1), .Y(n16) );
  AO22X2 U9 ( .A0(Q[3]), .A1(n10), .B0(D[3]), .B1(n1), .Y(n15) );
  AO22X2 U10 ( .A0(Q[5]), .A1(n10), .B0(D[5]), .B1(n1), .Y(n13) );
  AO22X2 U11 ( .A0(Q[7]), .A1(n10), .B0(D[7]), .B1(n1), .Y(n11) );
endmodule


module MUX3 ( A, B, C, S, Y );
  input [7:0] A;
  input [7:0] B;
  input [7:0] C;
  input [1:0] S;
  output [7:0] Y;
  wire   n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n1;

  XNOR2X4 U18 ( .A(S[0]), .B(S[1]), .Y(n4) );
  AND2X2 U1 ( .A(S[1]), .B(n1), .Y(n5) );
  NOR2X4 U2 ( .A(n1), .B(S[1]), .Y(n2) );
  INVX2 U3 ( .A(S[0]), .Y(n1) );
  OAI2BB1X1 U4 ( .A0N(B[7]), .A1N(n2), .B0(n3), .Y(Y[7]) );
  AOI22XL U5 ( .A0(A[7]), .A1(n4), .B0(C[7]), .B1(n5), .Y(n3) );
  OAI2BB1X1 U6 ( .A0N(B[6]), .A1N(n2), .B0(n6), .Y(Y[6]) );
  AOI22XL U7 ( .A0(A[6]), .A1(n4), .B0(C[6]), .B1(n5), .Y(n6) );
  OAI2BB1X1 U8 ( .A0N(B[5]), .A1N(n2), .B0(n7), .Y(Y[5]) );
  AOI22XL U9 ( .A0(A[5]), .A1(n4), .B0(C[5]), .B1(n5), .Y(n7) );
  OAI2BB1X1 U10 ( .A0N(B[4]), .A1N(n2), .B0(n8), .Y(Y[4]) );
  AOI22XL U11 ( .A0(A[4]), .A1(n4), .B0(C[4]), .B1(n5), .Y(n8) );
  OAI2BB1X1 U12 ( .A0N(B[3]), .A1N(n2), .B0(n9), .Y(Y[3]) );
  AOI22XL U13 ( .A0(A[3]), .A1(n4), .B0(C[3]), .B1(n5), .Y(n9) );
  OAI2BB1X1 U14 ( .A0N(B[2]), .A1N(n2), .B0(n10), .Y(Y[2]) );
  AOI22XL U15 ( .A0(A[2]), .A1(n4), .B0(C[2]), .B1(n5), .Y(n10) );
  OAI2BB1X1 U16 ( .A0N(B[0]), .A1N(n2), .B0(n12), .Y(Y[0]) );
  AOI22XL U17 ( .A0(A[0]), .A1(n4), .B0(C[0]), .B1(n5), .Y(n12) );
  OAI2BB1X1 U19 ( .A0N(B[1]), .A1N(n2), .B0(n11), .Y(Y[1]) );
  AOI22XL U20 ( .A0(A[1]), .A1(n4), .B0(C[1]), .B1(n5), .Y(n11) );
endmodule


module MUX2_0 ( A, B, S, Y );
  input [7:0] A;
  input [7:0] B;
  output [7:0] Y;
  input S;
  wire   n1;

  INVX2 U1 ( .A(S), .Y(n1) );
  AO22X2 U2 ( .A0(B[0]), .A1(S), .B0(A[0]), .B1(n1), .Y(Y[0]) );
  AO22X2 U3 ( .A0(S), .A1(B[7]), .B0(A[7]), .B1(n1), .Y(Y[7]) );
  AO22X2 U4 ( .A0(B[1]), .A1(S), .B0(A[1]), .B1(n1), .Y(Y[1]) );
  AO22X2 U5 ( .A0(B[2]), .A1(S), .B0(A[2]), .B1(n1), .Y(Y[2]) );
  AO22X2 U6 ( .A0(B[3]), .A1(S), .B0(A[3]), .B1(n1), .Y(Y[3]) );
  AO22X2 U7 ( .A0(B[4]), .A1(S), .B0(A[4]), .B1(n1), .Y(Y[4]) );
  AO22X2 U8 ( .A0(B[5]), .A1(S), .B0(A[5]), .B1(n1), .Y(Y[5]) );
  AO22X2 U9 ( .A0(B[6]), .A1(S), .B0(A[6]), .B1(n1), .Y(Y[6]) );
endmodule


module MUX2_1 ( A, B, S, Y );
  input [7:0] A;
  input [7:0] B;
  output [7:0] Y;
  input S;
  wire   n1, n2;

  INVX2 U1 ( .A(n1), .Y(n2) );
  BUFX2 U2 ( .A(S), .Y(n1) );
  AO22X2 U3 ( .A0(B[0]), .A1(n1), .B0(A[0]), .B1(n2), .Y(Y[0]) );
  AO22X2 U4 ( .A0(B[2]), .A1(n1), .B0(A[2]), .B1(n2), .Y(Y[2]) );
  AO22X2 U5 ( .A0(B[1]), .A1(n1), .B0(A[1]), .B1(n2), .Y(Y[1]) );
  AO22X2 U6 ( .A0(B[3]), .A1(n1), .B0(A[3]), .B1(n2), .Y(Y[3]) );
  AO22X2 U7 ( .A0(B[4]), .A1(n1), .B0(A[4]), .B1(n2), .Y(Y[4]) );
  AO22X2 U8 ( .A0(B[5]), .A1(n1), .B0(A[5]), .B1(n2), .Y(Y[5]) );
  AO22X2 U9 ( .A0(B[6]), .A1(n1), .B0(A[6]), .B1(n2), .Y(Y[6]) );
  AO22X2 U10 ( .A0(n1), .A1(B[7]), .B0(A[7]), .B1(n2), .Y(Y[7]) );
endmodule


module ALU_DW01_inc_0 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;

  wire   [7:2] carry;

  ADDHX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHX1 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[7]), .B(A[7]), .Y(SUM[7]) );
endmodule


module ALU_DW01_add_0 ( A, B, CI, SUM, CO );
  input [7:0] A;
  input [7:0] B;
  output [7:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [7:1] carry;

  ADDFX1 U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  ADDFX1 U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFX1 U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFX1 U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFX1 U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFX1 U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  XOR3XL U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .Y(SUM[7]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module ALU_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [7:0] A;
  input [7:0] B;
  output [7:0] DIFF;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7;
  wire   [8:0] carry;

  ADDFX1 U2_6 ( .A(A[6]), .B(n1), .CI(carry[6]), .CO(carry[7]), .S(DIFF[6]) );
  ADDFX1 U2_5 ( .A(A[5]), .B(n2), .CI(carry[5]), .CO(carry[6]), .S(DIFF[5]) );
  ADDFX1 U2_4 ( .A(A[4]), .B(n3), .CI(carry[4]), .CO(carry[5]), .S(DIFF[4]) );
  ADDFX1 U2_3 ( .A(A[3]), .B(n4), .CI(carry[3]), .CO(carry[4]), .S(DIFF[3]) );
  ADDFX1 U2_2 ( .A(A[2]), .B(n5), .CI(carry[2]), .CO(carry[3]), .S(DIFF[2]) );
  ADDFX1 U2_1 ( .A(A[1]), .B(n6), .CI(carry[1]), .CO(carry[2]), .S(DIFF[1]) );
  XNOR3XL U1 ( .A(A[7]), .B(B[7]), .C(carry[7]), .Y(DIFF[7]) );
  INVX2 U2 ( .A(B[0]), .Y(n7) );
  INVX2 U3 ( .A(B[1]), .Y(n6) );
  OR2X2 U4 ( .A(A[0]), .B(n7), .Y(carry[1]) );
  INVX2 U5 ( .A(B[2]), .Y(n5) );
  INVX2 U6 ( .A(B[3]), .Y(n4) );
  INVX2 U7 ( .A(B[4]), .Y(n3) );
  INVX2 U8 ( .A(B[5]), .Y(n2) );
  INVX2 U9 ( .A(B[6]), .Y(n1) );
  XNOR2X1 U10 ( .A(n7), .B(A[0]), .Y(DIFF[0]) );
endmodule


module ALU ( A, B, sel, F );
  input [7:0] A;
  input [7:0] B;
  input [2:0] sel;
  output [7:0] F;
  wire   N63, N64, N65, N66, N67, N68, N69, N70, N71, N72, N73, N74, N75, N76,
         N77, N78, N79, N80, N81, N82, N83, N84, N85, N86, N87, N88, N89, N90,
         N91, N92, N93, N94, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36,
         n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50,
         n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64,
         n65, n1, n2, n3, n4, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n66, n67;

  ALU_DW01_inc_0 add_172 ( .A(A), .SUM({N94, N93, N92, N91, N90, N89, N88, N87}) );
  ALU_DW01_add_0 add_170 ( .A(A), .B(B), .CI(1'b0), .SUM({N78, N77, N76, N75, 
        N74, N73, N72, N71}) );
  ALU_DW01_sub_0 sub_169 ( .A(A), .B(B), .CI(1'b0), .DIFF({N70, N69, N68, N67, 
        N66, N65, N64, N63}) );
  NOR3X6 U4 ( .A(n25), .B(sel[1]), .C(n67), .Y(n31) );
  NOR3X6 U5 ( .A(sel[1]), .B(sel[2]), .C(sel[0]), .Y(n30) );
  AOI222XL U6 ( .A0(n30), .A1(n18), .B0(N78), .B1(n31), .C0(N70), .C1(n32), 
        .Y(n29) );
  BUFX2 U7 ( .A(n33), .Y(n1) );
  NAND2X2 U8 ( .A(sel[0]), .B(n67), .Y(n35) );
  AOI222XL U9 ( .A0(n30), .A1(N79), .B0(N71), .B1(n31), .C0(N63), .C1(n32), 
        .Y(n64) );
  AOI222XL U10 ( .A0(n30), .A1(n19), .B0(N77), .B1(n31), .C0(N69), .C1(n32), 
        .Y(n40) );
  AOI222XL U11 ( .A0(n30), .A1(n20), .B0(N76), .B1(n31), .C0(N68), .C1(n32), 
        .Y(n44) );
  AOI222XL U12 ( .A0(n30), .A1(n21), .B0(N75), .B1(n31), .C0(N67), .C1(n32), 
        .Y(n48) );
  AOI222XL U13 ( .A0(n30), .A1(n22), .B0(N74), .B1(n31), .C0(N66), .C1(n32), 
        .Y(n52) );
  AOI222XL U14 ( .A0(n30), .A1(n24), .B0(N72), .B1(n31), .C0(N64), .C1(n32), 
        .Y(n60) );
  AOI222XL U15 ( .A0(n30), .A1(n23), .B0(N73), .B1(n31), .C0(N65), .C1(n32), 
        .Y(n56) );
  NOR3X6 U16 ( .A(n25), .B(n66), .C(n67), .Y(n36) );
  INVX2 U17 ( .A(n1), .Y(n26) );
  AOI22XL U18 ( .A0(N94), .A1(n36), .B0(N86), .B1(n37), .Y(n27) );
  INVX2 U19 ( .A(A[0]), .Y(N79) );
  NAND3XL U20 ( .A(n27), .B(n28), .C(n29), .Y(F[7]) );
  AOI22XL U21 ( .A0(N93), .A1(n36), .B0(N85), .B1(n37), .Y(n38) );
  NAND3XL U22 ( .A(n38), .B(n39), .C(n40), .Y(F[6]) );
  AOI22XL U23 ( .A0(N92), .A1(n36), .B0(N84), .B1(n37), .Y(n42) );
  NAND3XL U24 ( .A(n42), .B(n43), .C(n44), .Y(F[5]) );
  AOI22XL U25 ( .A0(N91), .A1(n36), .B0(N83), .B1(n37), .Y(n46) );
  NAND3XL U26 ( .A(n46), .B(n47), .C(n48), .Y(F[4]) );
  AOI22XL U27 ( .A0(N90), .A1(n36), .B0(N82), .B1(n37), .Y(n50) );
  NAND3XL U28 ( .A(n50), .B(n51), .C(n52), .Y(F[3]) );
  AOI22XL U29 ( .A0(N89), .A1(n36), .B0(N81), .B1(n37), .Y(n54) );
  NAND3XL U30 ( .A(n54), .B(n55), .C(n56), .Y(F[2]) );
  NAND3XL U31 ( .A(n62), .B(n63), .C(n64), .Y(F[0]) );
  NAND3XL U32 ( .A(n58), .B(n59), .C(n60), .Y(F[1]) );
  NOR3X6 U33 ( .A(sel[0]), .B(sel[1]), .C(n67), .Y(n32) );
  INVX2 U34 ( .A(sel[2]), .Y(n67) );
  AOI22XL U35 ( .A0(N88), .A1(n36), .B0(N80), .B1(n37), .Y(n58) );
  NOR3X6 U36 ( .A(n66), .B(sel[0]), .C(n67), .Y(n37) );
  AOI22XL U37 ( .A0(N87), .A1(n36), .B0(N79), .B1(n37), .Y(n62) );
  AOI32XL U38 ( .A0(n1), .A1(n17), .A2(A[0]), .B0(B[0]), .B1(n65), .Y(n63) );
  INVX2 U39 ( .A(B[0]), .Y(n17) );
  OAI22X1 U40 ( .A0(n35), .A1(N79), .B0(A[0]), .B1(n26), .Y(n65) );
  INVX2 U41 ( .A(sel[1]), .Y(n66) );
  NOR2X2 U42 ( .A(n66), .B(sel[2]), .Y(n33) );
  INVX2 U43 ( .A(sel[0]), .Y(n25) );
  AOI32XL U44 ( .A0(n1), .A1(n16), .A2(A[1]), .B0(B[1]), .B1(n61), .Y(n59) );
  INVX2 U45 ( .A(B[1]), .Y(n16) );
  OAI22X1 U46 ( .A0(n35), .A1(n24), .B0(A[1]), .B1(n26), .Y(n61) );
  AOI32XL U47 ( .A0(n1), .A1(n11), .A2(A[6]), .B0(B[6]), .B1(n41), .Y(n39) );
  INVX2 U48 ( .A(B[6]), .Y(n11) );
  OAI22X1 U49 ( .A0(n35), .A1(n19), .B0(A[6]), .B1(n26), .Y(n41) );
  AOI32XL U50 ( .A0(n1), .A1(n13), .A2(A[4]), .B0(B[4]), .B1(n49), .Y(n47) );
  INVX2 U51 ( .A(B[4]), .Y(n13) );
  OAI22X1 U52 ( .A0(n35), .A1(n21), .B0(A[4]), .B1(n26), .Y(n49) );
  AOI32XL U53 ( .A0(n1), .A1(n15), .A2(A[2]), .B0(B[2]), .B1(n57), .Y(n55) );
  INVX2 U54 ( .A(B[2]), .Y(n15) );
  OAI22X1 U55 ( .A0(n35), .A1(n23), .B0(A[2]), .B1(n26), .Y(n57) );
  AOI32XL U56 ( .A0(n1), .A1(n14), .A2(A[3]), .B0(B[3]), .B1(n53), .Y(n51) );
  INVX2 U57 ( .A(B[3]), .Y(n14) );
  OAI22X1 U58 ( .A0(n35), .A1(n22), .B0(A[3]), .B1(n26), .Y(n53) );
  AOI32XL U59 ( .A0(n1), .A1(n12), .A2(A[5]), .B0(B[5]), .B1(n45), .Y(n43) );
  INVX2 U60 ( .A(B[5]), .Y(n12) );
  OAI22X1 U61 ( .A0(n35), .A1(n20), .B0(A[5]), .B1(n26), .Y(n45) );
  AOI32XL U62 ( .A0(n1), .A1(n10), .A2(A[7]), .B0(B[7]), .B1(n34), .Y(n28) );
  INVX2 U63 ( .A(B[7]), .Y(n10) );
  OAI22X1 U64 ( .A0(n18), .A1(n35), .B0(A[7]), .B1(n26), .Y(n34) );
  INVX2 U65 ( .A(A[1]), .Y(n24) );
  INVX2 U66 ( .A(A[6]), .Y(n19) );
  INVX2 U67 ( .A(A[4]), .Y(n21) );
  INVX2 U68 ( .A(A[2]), .Y(n23) );
  INVX2 U69 ( .A(A[3]), .Y(n22) );
  INVX2 U70 ( .A(A[5]), .Y(n20) );
  INVX2 U71 ( .A(A[7]), .Y(n18) );
  NAND2BX1 U72 ( .AN(A[1]), .B(N79), .Y(n2) );
  OAI2BB1X1 U73 ( .A0N(A[0]), .A1N(A[1]), .B0(n2), .Y(N80) );
  OR2X1 U74 ( .A(n2), .B(A[2]), .Y(n3) );
  OAI2BB1X1 U75 ( .A0N(n2), .A1N(A[2]), .B0(n3), .Y(N81) );
  OR2X1 U76 ( .A(n3), .B(A[3]), .Y(n4) );
  OAI2BB1X1 U77 ( .A0N(n3), .A1N(A[3]), .B0(n4), .Y(N82) );
  OR2X1 U78 ( .A(n4), .B(A[4]), .Y(n7) );
  OAI2BB1X1 U79 ( .A0N(n4), .A1N(A[4]), .B0(n7), .Y(N83) );
  OR2X1 U80 ( .A(n7), .B(A[5]), .Y(n8) );
  OAI2BB1X1 U81 ( .A0N(n7), .A1N(A[5]), .B0(n8), .Y(N84) );
  XNOR2X1 U82 ( .A(A[6]), .B(n8), .Y(N85) );
  NOR2X1 U83 ( .A(A[6]), .B(n8), .Y(n9) );
  XOR2X1 U84 ( .A(A[7]), .B(n9), .Y(N86) );
endmodule


module Compare ( A, B, C_1, C_2 );
  input [7:0] A;
  input [7:0] B;
  output C_1, C_2;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27;

  INVX2 U1 ( .A(B[6]), .Y(n26) );
  INVX2 U2 ( .A(n12), .Y(C_1) );
  INVX2 U3 ( .A(B[4]), .Y(n25) );
  INVX2 U4 ( .A(A[0]), .Y(n20) );
  INVX2 U5 ( .A(A[2]), .Y(n21) );
  INVX2 U6 ( .A(A[3]), .Y(n22) );
  INVX2 U7 ( .A(B[7]), .Y(n27) );
  INVX2 U8 ( .A(A[5]), .Y(n23) );
  INVX2 U9 ( .A(A[6]), .Y(n24) );
  NOR2X1 U10 ( .A(n23), .B(B[5]), .Y(n14) );
  CLKNAND2X2 U11 ( .A(B[0]), .B(n20), .Y(n2) );
  NOR2X1 U12 ( .A(n21), .B(B[2]), .Y(n17) );
  AOI2BB1X1 U13 ( .A0N(n2), .A1N(A[1]), .B0(B[1]), .Y(n1) );
  AOI211X1 U14 ( .A0(A[1]), .A1(n2), .B0(n17), .C0(n1), .Y(n3) );
  AOI221XL U15 ( .A0(B[3]), .A1(n22), .B0(B[2]), .B1(n21), .C0(n3), .Y(n4) );
  AND2X1 U16 ( .A(A[4]), .B(n25), .Y(n16) );
  NOR2X1 U17 ( .A(n22), .B(B[3]), .Y(n15) );
  OAI32XL U18 ( .A0(n4), .A1(n16), .A2(n15), .B0(A[4]), .B1(n25), .Y(n5) );
  AOI21X1 U19 ( .A0(B[5]), .A1(n23), .B0(n5), .Y(n6) );
  AOI211X1 U20 ( .A0(A[6]), .A1(n26), .B0(n14), .C0(n6), .Y(n7) );
  AOI21X1 U21 ( .A0(B[6]), .A1(n24), .B0(n7), .Y(n9) );
  AND2X1 U22 ( .A(A[7]), .B(n27), .Y(n8) );
  OAI22X1 U23 ( .A0(A[7]), .A1(n27), .B0(n9), .B1(n8), .Y(n12) );
  NOR2X1 U24 ( .A(n20), .B(B[0]), .Y(n10) );
  OAI2B2X1 U25 ( .A1N(B[1]), .A0(n10), .B0(A[1]), .B1(n10), .Y(n11) );
  OAI21X1 U26 ( .A0(B[6]), .A1(n24), .B0(n11), .Y(n13) );
  AOI211X1 U27 ( .A0(A[7]), .A1(n27), .B0(n13), .C0(n12), .Y(n19) );
  NOR4X1 U28 ( .A(n17), .B(n16), .C(n15), .D(n14), .Y(n18) );
  CLKNAND2X2 U29 ( .A(n19), .B(n18), .Y(C_2) );
endmodule


module Datapath ( inport, load_A, load_B, load_R, M2_sel, M3_sel, M1_sel, 
        alu_sel, clk, rst_n, outport, C_1, C_2 );
  input [7:0] inport;
  input [1:0] M1_sel;
  input [2:0] alu_sel;
  output [7:0] outport;
  input load_A, load_B, load_R, M2_sel, M3_sel, clk, rst_n;
  output C_1, C_2;

  wire   [7:0] M1_OUT;
  wire   [7:0] A_reg;
  wire   [7:0] M2_OUT;
  wire   [7:0] R_reg;
  wire   [7:0] Fsub;
  wire   [7:0] M3_OUT;

  Register_0 A ( .D(M1_OUT), .reset(rst_n), .clk(clk), .load(load_A), .Q(A_reg) );
  Register_2 B ( .D(M2_OUT), .reset(rst_n), .clk(clk), .load(load_B), .Q(
        outport) );
  Register_1 R ( .D(A_reg), .reset(rst_n), .clk(clk), .load(load_R), .Q(R_reg)
         );
  MUX3 M1 ( .A(Fsub), .B(inport), .C(outport), .S(M1_sel), .Y(M1_OUT) );
  MUX2_0 M2 ( .A(inport), .B(R_reg), .S(M2_sel), .Y(M2_OUT) );
  MUX2_1 M3 ( .A(outport), .B({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .S(M3_sel), .Y(M3_OUT) );
  ALU FU1 ( .A(A_reg), .B(outport), .sel(alu_sel), .F(Fsub) );
  Compare FU2 ( .A(A_reg), .B(M3_OUT), .C_1(C_1), .C_2(C_2) );
endmodule


module GCD ( start, clk, rst_n, inport, done, outport );
  input [7:0] inport;
  output [7:0] outport;
  input start, clk, rst_n;
  output done;
  wire   C_1, C_2, load_A, load_B, load_R, M2_sel, M3_sel;
  wire   [1:0] M1_sel;
  wire   [2:0] alu_sel;

  Controller u_ctrl ( .start(start), .C_1(C_1), .C_2(C_2), .rst_n(rst_n), 
        .clk(clk), .load_A(load_A), .load_B(load_B), .load_R(load_R), .M2_sel(
        M2_sel), .M3_sel(M3_sel), .done(done), .M1_sel(M1_sel), .alu_sel(
        alu_sel) );
  Datapath u_dp ( .inport(inport), .load_A(load_A), .load_B(load_B), .load_R(
        load_R), .M2_sel(M2_sel), .M3_sel(M3_sel), .M1_sel(M1_sel), .alu_sel(
        alu_sel), .clk(clk), .rst_n(rst_n), .outport(outport), .C_1(C_1), 
        .C_2(C_2) );
endmodule


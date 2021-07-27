// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Fri Jul 16 19:48:28 2021
// Host        : LAPTOP-CCFS063F running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top signed_mul -prefix
//               signed_mul_ signed_mul_stub.v
// Design      : signed_mul
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tftg256-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "mult_gen_v12_0_16,Vivado 2020.2" *)
module signed_mul(CLK, A, B, P)
/* synthesis syn_black_box black_box_pad_pin="CLK,A[31:0],B[31:0],P[31:0]" */;
  input CLK;
  input [31:0]A;
  input [31:0]B;
  output [31:0]P;
endmodule

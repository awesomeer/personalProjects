// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Wed Jul 21 00:42:00 2021
// Host        : LAPTOP-CCFS063F running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top CLK_PLL -prefix
//               CLK_PLL_ CLK_PLL_stub.v
// Design      : CLK_PLL
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tftg256-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module CLK_PLL(clk_out, reset, clk_in)
/* synthesis syn_black_box black_box_pad_pin="clk_out,reset,clk_in" */;
  output clk_out;
  input reset;
  input clk_in;
endmodule

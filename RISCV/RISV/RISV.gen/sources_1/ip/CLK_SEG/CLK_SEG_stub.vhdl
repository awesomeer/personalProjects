-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
-- Date        : Wed Jul 21 00:40:15 2021
-- Host        : LAPTOP-CCFS063F running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub c:/Users/mithi/RISV/RISV.gen/sources_1/ip/CLK_SEG/CLK_SEG_stub.vhdl
-- Design      : CLK_SEG
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tftg256-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLK_SEG is
  Port ( 
    clk_out : out STD_LOGIC;
    clk_in : in STD_LOGIC
  );

end CLK_SEG;

architecture stub of CLK_SEG is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out,clk_in";
begin
end;

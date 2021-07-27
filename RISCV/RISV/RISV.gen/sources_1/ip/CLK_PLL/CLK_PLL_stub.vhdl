-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
-- Date        : Wed Jul 21 00:42:00 2021
-- Host        : LAPTOP-CCFS063F running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top CLK_PLL -prefix
--               CLK_PLL_ CLK_PLL_stub.vhdl
-- Design      : CLK_PLL
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tftg256-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLK_PLL is
  Port ( 
    clk_out : out STD_LOGIC;
    reset : in STD_LOGIC;
    clk_in : in STD_LOGIC
  );

end CLK_PLL;

architecture stub of CLK_PLL is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out,reset,clk_in";
begin
end;

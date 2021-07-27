set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

# clk => 100000000Hz
create_clock -period 10.0 -name iclk -waveform {0.000 5.000} [get_ports iclk]
set_property PACKAGE_PIN N14 [get_ports {iclk}]
set_property IOSTANDARD LVCMOS33 [get_ports {iclk}]

set_property PACKAGE_PIN P6 [get_ports {irst}]
set_property IOSTANDARD LVCMOS33 [get_ports {irst}]

#set_property PACKAGE_PIN K13 [get_ports {led[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
#set_property PACKAGE_PIN K12 [get_ports {led[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
#set_property PACKAGE_PIN L14 [get_ports {led[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
#set_property PACKAGE_PIN L13 [get_ports {led[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
#set_property PACKAGE_PIN M16 [get_ports {led[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
#set_property PACKAGE_PIN M14 [get_ports {led[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
#set_property PACKAGE_PIN M12 [get_ports {led[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]
#set_property PACKAGE_PIN N16 [get_ports {led[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]

#set_property PACKAGE_PIN P15 [get_ports {usb_rx}]
#set_property IOSTANDARD LVCMOS33 [get_ports {usb_rx}]
set_property PACKAGE_PIN P16 [get_ports {usb_tx}]
set_property IOSTANDARD LVCMOS33 [get_ports {usb_tx}]

set_property PACKAGE_PIN B6 [get_ports {io_led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[0]}]
set_property PACKAGE_PIN B5 [get_ports {io_led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[1]}]
set_property PACKAGE_PIN A5 [get_ports {io_led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[2]}]
set_property PACKAGE_PIN A4 [get_ports {io_led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[3]}]
set_property PACKAGE_PIN B4 [get_ports {io_led[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[4]}]
set_property PACKAGE_PIN A3 [get_ports {io_led[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[5]}]
set_property PACKAGE_PIN F4 [get_ports {io_led[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[6]}]
set_property PACKAGE_PIN F3 [get_ports {io_led[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[7]}]
set_property PACKAGE_PIN F2 [get_ports {io_led[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[8]}]
set_property PACKAGE_PIN E1 [get_ports {io_led[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[9]}]
set_property PACKAGE_PIN B2 [get_ports {io_led[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[10]}]
set_property PACKAGE_PIN A2 [get_ports {io_led[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[11]}]
set_property PACKAGE_PIN E2 [get_ports {io_led[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[12]}]
set_property PACKAGE_PIN D1 [get_ports {io_led[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[13]}]
set_property PACKAGE_PIN E6 [get_ports {io_led[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[14]}]
set_property PACKAGE_PIN K5 [get_ports {io_led[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[15]}]
set_property PACKAGE_PIN G2 [get_ports {io_led[16]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[16]}]
set_property PACKAGE_PIN G1 [get_ports {io_led[17]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[17]}]
set_property PACKAGE_PIN H2 [get_ports {io_led[18]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[18]}]
set_property PACKAGE_PIN H1 [get_ports {io_led[19]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[19]}]
set_property PACKAGE_PIN K1 [get_ports {io_led[20]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[20]}]
set_property PACKAGE_PIN J1 [get_ports {io_led[21]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[21]}]
set_property PACKAGE_PIN L3 [get_ports {io_led[22]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[22]}]
set_property PACKAGE_PIN L2 [get_ports {io_led[23]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[23]}]


set_property PACKAGE_PIN D6 [get_ports {sw[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
set_property PULLDOWN true [get_ports {sw[0]}]
set_property PACKAGE_PIN D5 [get_ports {sw[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
set_property PULLDOWN true [get_ports {sw[1]}]
set_property PACKAGE_PIN F5 [get_ports {sw[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
set_property PULLDOWN true [get_ports {sw[2]}]
set_property PACKAGE_PIN E5 [get_ports {sw[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
set_property PULLDOWN true [get_ports {sw[3]}]
set_property PACKAGE_PIN G5 [get_ports {sw[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[4]}]
set_property PULLDOWN true [get_ports {sw[4]}]
set_property PACKAGE_PIN G4 [get_ports {sw[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[5]}]
set_property PULLDOWN true [get_ports {sw[5]}]
set_property PACKAGE_PIN D4 [get_ports {sw[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[6]}]
set_property PULLDOWN true [get_ports {sw[6]}]
set_property PACKAGE_PIN C4 [get_ports {sw[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[7]}]
set_property PULLDOWN true [get_ports {sw[7]}]
set_property PACKAGE_PIN E3 [get_ports {sw[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[8]}]
set_property PULLDOWN true [get_ports {sw[8]}]
set_property PACKAGE_PIN D3 [get_ports {sw[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[9]}]
set_property PULLDOWN true [get_ports {sw[9]}]
set_property PACKAGE_PIN C3 [get_ports {sw[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[10]}]
set_property PULLDOWN true [get_ports {sw[10]}]
set_property PACKAGE_PIN C2 [get_ports {sw[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[11]}]
set_property PULLDOWN true [get_ports {sw[11]}]
set_property PACKAGE_PIN C1 [get_ports {sw[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[12]}]
set_property PULLDOWN true [get_ports {sw[12]}]
set_property PACKAGE_PIN B1 [get_ports {sw[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[13]}]
set_property PULLDOWN true [get_ports {sw[13]}]
set_property PACKAGE_PIN M6 [get_ports {sw[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[14]}]
set_property PULLDOWN true [get_ports {sw[14]}]
set_property PACKAGE_PIN N6 [get_ports {sw[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[15]}]
set_property PULLDOWN true [get_ports {sw[15]}]
set_property PACKAGE_PIN H5 [get_ports {sw[16]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[16]}]
set_property PULLDOWN true [get_ports {sw[16]}]
set_property PACKAGE_PIN H4 [get_ports {sw[17]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[17]}]
set_property PULLDOWN true [get_ports {sw[17]}]
set_property PACKAGE_PIN J3 [get_ports {sw[18]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[18]}]
set_property PULLDOWN true [get_ports {sw[18]}]
set_property PACKAGE_PIN H3 [get_ports {sw[19]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[19]}]
set_property PULLDOWN true [get_ports {sw[19]}]
set_property PACKAGE_PIN J5 [get_ports {sw[20]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[20]}]
set_property PULLDOWN true [get_ports {sw[20]}]
set_property PACKAGE_PIN J4 [get_ports {sw[21]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[21]}]
set_property PULLDOWN true [get_ports {sw[21]}]
set_property PACKAGE_PIN K3 [get_ports {sw[22]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[22]}]
set_property PULLDOWN true [get_ports {sw[22]}]
set_property PACKAGE_PIN K2 [get_ports {sw[23]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[23]}]
set_property PULLDOWN true [get_ports {sw[23]}]


#set_property PACKAGE_PIN C6 [get_ports {io_button[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {io_button[0]}]
#set_property PULLDOWN true [get_ports {io_button[0]}]
set_property PACKAGE_PIN C7 [get_ports {center}]
set_property IOSTANDARD LVCMOS33 [get_ports {center}]
set_property PULLDOWN true [get_ports {center}]
#set_property PACKAGE_PIN A7 [get_ports {io_button[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {io_button[2]}]
#set_property PULLDOWN true [get_ports {io_button[2]}]
#set_property PACKAGE_PIN B7 [get_ports {io_button[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {io_button[3]}]
#set_property PULLDOWN true [get_ports {io_button[3]}]
#set_property PACKAGE_PIN P11 [get_ports {io_button[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {io_button[4]}]
#set_property PULLDOWN true [get_ports {io_button[4]}]


set_property PACKAGE_PIN P8 [get_ports {an[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
set_property PACKAGE_PIN R8 [get_ports {an[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
set_property PACKAGE_PIN N9 [get_ports {an[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
set_property PACKAGE_PIN P9 [get_ports {an[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]

set_property PACKAGE_PIN T5 [get_ports {seg[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]
set_property PACKAGE_PIN R5 [get_ports {seg[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]
set_property PACKAGE_PIN T9 [get_ports {seg[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]
set_property PACKAGE_PIN R6 [get_ports {seg[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]
set_property PACKAGE_PIN R7 [get_ports {seg[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]
set_property PACKAGE_PIN T7 [get_ports {seg[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]
set_property PACKAGE_PIN T8 [get_ports {seg[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]

set_property PACKAGE_PIN T10 [get_ports {dp}]
set_property IOSTANDARD LVCMOS33 [get_ports {dp}]

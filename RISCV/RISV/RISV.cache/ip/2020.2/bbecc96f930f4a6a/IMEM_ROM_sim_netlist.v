// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Wed Jun 30 16:11:58 2021
// Host        : LAPTOP-CCFS063F running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ IMEM_ROM_sim_netlist.v
// Design      : IMEM_ROM
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tftg256-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "IMEM_ROM,blk_mem_gen_v8_4_4,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2020.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clka,
    addra,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [7:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;

  wire [7:0]addra;
  wire clka;
  wire [31:0]douta;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_doutb_UNCONNECTED;
  wire [7:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "8" *) 
  (* C_ADDRB_WIDTH = "8" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "00000013" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     3.375199 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "IMEM_ROM.mem" *) 
  (* C_INIT_FILE_NAME = "IMEM_ROM.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "3" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "256" *) 
  (* C_READ_DEPTH_B = "256" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "1" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "256" *) 
  (* C_WRITE_DEPTH_B = "256" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_4 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[31:0]),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[7:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[7:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(1'b0),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2020.2"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
QGLtnqZzRetDH6gCWT4Js6wuLlZfrNx/VJp3sfR2NF+cxypO5AxN0oDKLJJtmdrtE/ueNDg+Qf7Z
TqBNRojORA==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
B6Ger3hRvfjHkaJ+W8639Kl3TzC9TogLuklOXEiMNdc4Im+DjEUzxb3DKlzu0VW3zxZqjJ3+wsW/
LnRmPCESi5Y9eRJaLFXg79EMfoj4X+nTdHAP6yCfltBADKegZ12gpnB/8ey5yn2KA74LUtPC7jna
iyjqSfsWLGnz6UdXzwk=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
BX+DxgMPRyZbYojCUR9Sk8Lq+3ZigBz4yMFHQkmurfdfDzyTPJCE827eGiPyTenK1QPVhEtf9g06
0BFXq/0COPuU1BWJwdkz1c4dE6/exDwhvEh+hPx3vRY6z8fDEf6aGVIXrHDvrmddehe7yMSIpo+k
aXHR06EEdfHCFY4TggYwhcJVXjkE+ApsVuyfmEfPmYjo8hCWyQyBsUWIOY03q1+MvUjjsmTwgs9g
fh5MY9ToaLfoJxPKdCpsqrBX4LJ+VDGFlAqIcqHTE2jCmPiToZAFXB7fzf1wDjFCBlJyFVDBGi0i
m+CouLSb7X1mvVhdDZgNrZDJMV688Bu3o54vew==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
DaIU/Ddc8USbZ2mURzujJDWDH1JbHl5tFVOOQ2aVaUPIA71yyE38OXVLEtF8rNmujYH30nEeQ+FV
LVJ16aaHw+iiuaqorTM3K5KLohVlN+WlcEtSXHuPNHjw8ddqtzpaX7pH1zqZH+YmfCL5oaNLqDH4
rkBnUl0/Gm/hzSwKjYhXGQFYQ+gGP99OjXakzrAqZzp/Iq4gt+Z5902/JV9thd/isHQImJ0QyK8M
EKM579iPAfXGes2mbiNYHcvDmSPYmW1zlhOE++N1EKeea7j/msnKeyhlC+hGE4Xfn4TVvqgQexCT
rp/wS/MosY6WH1aKFQlFH2hEppA7KXUaQlvG+w==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
XmWoAt4X8hrCJ5yTyug4ajJW5UhfkLNibzjihWzZ4Cr9hQSvWZoTc8rjGsLPbz6Le+/9iI5KxecS
eR0wiAO+G2IkwhZgVBeZdKoFnlnTVAyLjk9wMAFXNyJZM6b1NDbfXlPcUsC6JePvPlwwdWknkSsC
r3KvgkWAS+O3xvRmaNw=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Hw3Y+rShKrXiUViyNU1/O2qv6TgheLHBnFMj1i9MUGrHYqh9pLfLYUgWR7S2vj4jv4S+Ks0BpP4p
dKEqVAFmTCfQNEUHaVcFPkOHgig6L4mhLY6HUUKJoRgiQepgLi/W3V+ZZPQSQFkB3CU4MsJzhXvR
yLcpDriZy8cnAHD87Zi5DrNGBzj3kigJeM0du6lCQbxtF5aEdoaNP+YTnIFtcqYhoYnswQlYt0sV
HKgFA8VzqzL5WYnpH7+1IKmFkJBHkyqHCa9wPK0qCKnxkuDj70YzPVqQ+cocdKU+/gNdpCOdZlci
F2HTxrgfrXndJru3TiDqu4UavqAe0MNuFp3t0w==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
XPVggoWL6aXz+MpODTOZhEUQDa0vfEnUDaYeEHXm2vGyqKJujN2c/FFAFBeBYdJATLsIsQ+BqoPc
pBbcFYXDBfOtFIW2dH6Y1OoD65KyJ/hAq8coa21kFgq4hFat5vzZ2iIfkCpTUr4vDZO7Xne8cZO9
WsHffoTCt5rS59wWm2b8I5R8Eh2TUbQg3RCyrcnD66cvcEnlXe1CNMQ4/loVJpA4IBinBf820Wjc
vw2fZbGI0jXC+ACSHOviH63Xwmn+aRV5Ppkup7IYoon/ieKapRQeASu3TTY37xSBXiInSdtMTzJ6
+4GfO4eSHVriCk/sWbuTBzfRzoSShrnHjzz5LA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2020_08", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
L78XuiswVcgO2gtebzL7SA9BC/jJGAM0v6S9pzmyqL+QYzRneiYeGyDmsW33jEVVSTuNjTXkBLY7
yTOKQruatwe4V0OLi6174saSAmPgerSV1GyLP7KhmusLV/N61avC9TPam+tekhKeE0tds4EnJ3et
4JdLh+SE4Z4pcuqCjB5MFneIYKKWDx7siU6oesAQtoSJOesfMchX63MhOjOHFP/ch+1gHv3T45hg
IGF7V7TrdREVE4f9631tlVJ1o2Dypsmo/76Itz5WCGlTMjAnWXN8IXxKN+PZ3dyt1wjrZm2P/td+
xiGszFnSLrRvw/HferwtSmRx8q0fiHZ88roGTw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kDX5kq2QEe25429T6vQqBCFvV1McKTJRYfK99ymVNK2GGvGLXSzgwJHwB2fj9rM0wme3zYYY0vQR
x+9F4L7KLlOVY6qY3LB59uDzyXBI3mMZaS905HXHJkdZHWtQWpfHhl27LqL+8FSluaD6F+KFfYOV
CwIOVuCIp/XjxFXpNBik7YiPt4kHOlDA97IXNLnYUn/g1csGqeNWce4UTne50ggWvLYGbTFGmTjT
N67TpUiGRVRCSv8Tax72GWFIMFZk3Tlp68ZUSQEybZMWX1U9XdMdtxfvNGhf8mi5jQJ2SupSzKu4
T/+53IN9T8aLePAiGBKKG1ZBj4y1ZyYA7XYvjw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 18928)
`pragma protect data_block
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
PLuPGA==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif

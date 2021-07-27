// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Sun Jun 20 01:25:58 2021
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
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [4:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;

  wire [4:0]addra;
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
  wire [4:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [4:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "5" *) 
  (* C_ADDRB_WIDTH = "5" *) 
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
  (* C_READ_DEPTH_A = "32" *) 
  (* C_READ_DEPTH_B = "32" *) 
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
  (* C_WRITE_DEPTH_A = "32" *) 
  (* C_WRITE_DEPTH_B = "32" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_4 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0}),
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
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[4:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[4:0]),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 18720)
`pragma protect data_block
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
TT+MMOTRbvm+FQtJMAI0aoA7mnhsctpD
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

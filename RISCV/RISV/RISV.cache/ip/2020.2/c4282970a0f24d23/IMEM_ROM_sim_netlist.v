// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Wed Jun 30 02:45:02 2021
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
3yRn1osTx/hUR0OOtv7dd5ZY6XTlqep8sKPSLMajByhos30y78y8iqvjaUTZjmatWht2i4zqSPKk
god2qgvk4SElfE2h1Qu+dYxu1bAp06bbXeL+HHXo+lSdPGh7CuB2zejr46nZzqTfNYubO0hE+/wg
+azLPikt6BMzwF910JTwM1dtHJhmaVRUns48iLoWkoJte61mhejeEONdmBwLOydfKG9+g5e0htzK
FhXtt3CkTxVGQqdPKKVV4PyYLg7NRs9a7yfH7CquCX2Fmgn6Ps2R3SXRTcJ0TyzPVfC1HaLKcbAF
ZHZIJKxxPpRw7teCaB6yPLU5VUmsatAKk2sbdzfOyWX2vTPaMQsU+VguCPOIlt7JXMsJYW9vDDtp
rnml59Tz9sXtw5dEgITeyTCejujf0Xa5eaLH6r3FtKlH1OmS0ojTotdyJwTCJbEN79NXx7WV1Cuv
VPs7sHL+CiinAMEuzpOZlpnE/qgikrUGEElcyhdguoUb8OXiWDlUGpl7QQ8xRA0cKveRbNu+plCi
B8IzNo1V4VU1dHle2eIs2C7V3/5Q2W29rZh9tMYUkkRZK7LZH6NalDh63mP3o8FBSWpwl7PyXPr0
PCnuoRdEvC/EU0CSiCTdWNQGiWY8gWTuN1L11k5CezS/Sdd6P3b1uhJM3ZDjZujOM7r/qmubwRuC
ltX89ounR5LnJZJpIaUVlyb4NlZ1EPBjfvwFj/PdZHIzt8eWIINSr89bFFAtssUmKssKbbbQl80Z
yj612V7CsD8xl0FhmaPY/bsrUaie2DL/GI0ybufCk8vtZ6GCsJ4t2k2P8CC2+by+zjVzAjZecMtN
hHq73FjXu5EsML0osHw6QjAlX9NvFnihUHoDK3h5hrerbmlLYF3oilmJ4bBK+JiDaiwDtj8NaQL+
CxdPFzH3Ula3WZnCkj9q1Srz034C1ifyzJXIg8k48FfluCUbkoF4liShKwNNExXW4blPyWZOlVo4
k2HOlPuwh2up+oTnSJ5pQFqHpuQYMUXai7dcpbQaRfLDanmpC+fYq77uDqu0DEu0Jm1O4mEayV91
zyfaLfzNsgJrSvl+b+gJpRSdCOeCHdmtwTi6cRS3TA7aCk2PvjTWoWQREU9i4NvP6aVvymLsXAwB
gfUc4CLAhwr15cYn7voqKrdW7xNPUh84obLXsTDX8YvClOrW6Dr4Gzr6H5rKdx58b/6w6ByPBGPJ
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
fF6QBA==
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

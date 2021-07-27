`timescale 1ns / 1ps



module top
(
    input iclk,
    input irst,
    input center,
    
    output [23:0] io_led,
    input  [23:0] sw,
    
    output [3:0] an,
    output [6:0] seg,
    output dp,
    
    output usb_tx
);
    wire rst = !irst;
    
    wire clk;
    CLK_PLL clk_pll(.clk_in(iclk), .clk_out(clk), .reset(center));
    
    reg [31:0] counter;
    initial begin
        counter <= 32'd0;
    end
    always @(posedge iclk) begin
        counter <= counter + 1;
    end
    
    wire clk_seg = counter[17];


    
    //CLK_SEG clk_seg_pll(.clk_in(iclk), .clk_out(clk_seg) );
    
    
    wire [31:0] IADRR;
    wire [31:0] IDATA;
    wire        IWAIT;
    
    wire [31:0] MADDR;
    wire [31:0] MDATA;
    wire [3:0]  MBE;
    wire        MEN;
    wire        MRW;
    wire        MWAIT;


    RISCV cpu( IADRR, IDATA, IWAIT, MADDR, MDATA, MBE, MEN, MRW, MWAIT, rst, clk);
    
    IMEM imem( IADRR, IDATA, IWAIT, clk);
    DROM drom( MADDR, MDATA, MBE, MEN, MRW, MWAIT, clk);
    DMEM dmem( MADDR, MDATA, MBE, MEN, MRW, MWAIT, clk);
    
    seg_7 segs( MADDR, MDATA, MEN, MRW, MWAIT,  {dp, seg}, an, clk);
    
    led_24 leds( MADDR, MDATA, MEN, MRW, MWAIT, io_led, rst, clk);
    Input_sw switch( MADDR, MDATA, MEN, MRW, MWAIT, sw, rst, clk);
    
    
    
    
    
    //BPCC bpcc( MADDR, MDATA, MEN, MRW, MWAIT, rst, clk);
    //BPC bpc( MADDR, MDATA, MEN, MRW, MWAIT, rst, clk);
    BPP bpc( MADDR, MDATA, MEN, MRW, MWAIT, rst, clk);
    IPCP ipc( MADDR, MDATA, MEN, MRW, MWAIT, rst, clk);
    UART uart( MADDR, MDATA, MEN, MRW, MWAIT, rst, clk);
    //Tick_counter count( MADDR, MDATA, MEN, MRW, MWAIT, rst, clk);
    
    //Debug outputs
//    assign io_led[15:8] = IADRR[7:0];
//    assign io_led[7:0] = cpu.regs.reg_file[15][7:0];

endmodule

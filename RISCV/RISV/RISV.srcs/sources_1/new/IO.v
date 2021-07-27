`timescale 1ns / 1ps

`include "defines.v"

module seg_7
(

    input [31:0] MADDR,
    inout [31:0] MDATA,
    //wire [3:0]  MBE;
    input       MEN,
    input       MRW,
    output      MWAIT,
    
    output  [7:0] seg,
    output  [3:0] an,
    
    
    input clk
);
    
    
    reg [31:0] seg_data;
    reg [1:0] state;
    
    initial begin
        seg_data <= 32'hFFFF_FFFF;
        state <= 2'b00;
    end
    
    always @(posedge top.clk_seg) begin
        state <= state + 1;
    end
    
    assign an = (state == 2'b00) ? 4'b1110:
                (state == 2'b01) ? 4'b1101:
                (state == 2'b10) ? 4'b1011: 4'b0111;
                
    assign seg = (state == 2'b00) ? seg_data[7:0] :
                 (state == 2'b01) ? seg_data[15:8] :
                 (state == 2'b10) ? seg_data[23:16] : seg_data[31:24];
    
    
    wire seg_en = MEN && (MADDR == 32'd0);
    
    assign MWAIT = seg_en ? 1'b0 : 1'bz;
    assign MDATA = (seg_en && !MRW) ? seg_data : 32'hzzzzzzzz;
    always @(posedge clk) begin
        
        if(seg_en && MRW) begin
            seg_data <= MDATA;
        end
        
    end
    

endmodule




module led_24
(

    input [31:0] MADDR,
    inout [31:0] MDATA,
    //wire [3:0]  MBE;
    input       MEN,
    input       MRW,
    output      MWAIT,
    
    output reg [23:0] leds,
    
    input rst,
    input clk
);


    initial begin
        leds = 24'd0;
    end

    
    wire led_en = MEN && (MADDR == 32'h0000_0004);
    
    assign MWAIT = led_en ? 1'b0 : 1'bz;
    assign MDATA = (led_en && !MRW) ? {8'hFF, leds} : 32'hzzzzzzzz;
    always @(posedge clk) begin
        
        if(rst) begin
            leds <= leds;//24'd0;
        end
        else if(led_en && MRW) begin
            leds <= MDATA[23:0];
        end
        
    end 
    


endmodule




module Input_sw
(
    input [31:0] MADDR,
    inout [31:0] MDATA,
    //wire [3:0]  MBE;
    input       MEN,
    input       MRW,
    output      MWAIT,
    
    input [23:0] sw,
    input         rst,
    input         clk
);




    wire sw_en = MEN && (MADDR == 32'h0000_0008);
    
    assign MWAIT = sw_en ? 1'b0 : 1'bz;
    assign MDATA = (sw_en && !MRW) ? { 8'h00, sw} : 32'hzzzzzzzz;
    

endmodule


module BPP
(
    input [31:0] MADDR,
    inout [31:0] MDATA,
    //wire [3:0]  MBE;
    input       MEN,
    input       MRW,
    output      MWAIT,
    
    input         rst,
    input         clk
);

    reg [63:0] bpcc;
    initial begin
        bpcc <= 64'd0;
    end
    
    always @(posedge clk) begin
        
        if(rst) begin
            bpcc <= 64'd0;
        end
        else if(top.cpu.EXE_V && !top.cpu.mem_stall && (top.cpu.EXE_OP == `INSTR_BRANCH) && !(top.cpu.EXE_BT ^^ top.cpu.cmp_true) ) begin
            bpcc <= bpcc + 1;
        end
        
    end
    
    
    
    reg [63:0] bpc;
    initial begin
        bpc <= 64'd0;
    end
    
    always @(posedge clk) begin
        
        if(rst) begin
            bpc <= 64'd0;
        end
        else if(top.cpu.EXE_V && !top.cpu.mem_stall && (top.cpu.EXE_OP == `INSTR_BRANCH) ) begin
            bpc <= bpc + 1;
        end
        
    end
    
    
    wire bpp_en = MEN && (MADDR[31:4] == 28'h000_0001);
    
    assign MWAIT = bpp_en ? 1'b0 : 1'bz;
    
    wire [31:0] data = (!MADDR[3] && !MADDR[2]) ? bpcc[31:0]  :
                       (!MADDR[3] &&  MADDR[2]) ? bpcc[63:32] :
                       ( MADDR[3] && !MADDR[2]) ? bpc[31:0]   : bpc[63:32];
                       
    assign MDATA = bpp_en && !MRW ? data : 32'hzzzzzzzz;  
    

endmodule



module IPCP
(
    input [31:0] MADDR,
    inout [31:0] MDATA,
    //wire [3:0]  MBE;
    input       MEN,
    input       MRW,
    output      MWAIT,
    
    input         rst,
    input         clk
);
    
    wire full;
    reg [63:0] ipc_counter;
    initial begin
        ipc_counter <= 64'd0;
    end
    
    always @(posedge clk) begin
        
        if(rst || full) begin
            ipc_counter <= 64'd0;
        end
        else begin
            ipc_counter <= ipc_counter + (top.cpu.EXE_V && !top.cpu.mem_stall && top.cpu.EXE_OP == `INSTR_BRANCH)
                                       + (top.cpu.MEM_V && top.cpu.MEM_MEN && top.cpu.MEM_RW && !top.cpu.mem_stall)
                                       + (top.cpu.WR_V);
        end
        
    end
    
    
    
    reg [63:0] ticks;
    initial begin
        ticks <= 64'd0;
    end
    
    always @(posedge clk) begin
        if(rst || full) begin
            ticks <= 64'd0;
        end
        else begin
            ticks <= ticks + 1;
        end
    end
    
    assign full = ticks < ipc_counter;
    
    wire bpp_en = MEN && (MADDR[31:4] == 28'h000_0002);
    
    assign MWAIT = bpp_en ? 1'b0 : 1'bz;
    
    wire [31:0] data = (!MADDR[3] && !MADDR[2]) ? ipc_counter[31:0]  :
                       (!MADDR[3] &&  MADDR[2]) ? ipc_counter[63:32] :
                       ( MADDR[3] && !MADDR[2]) ? ticks[31:0]        : ticks[63:32];
                       
    assign MDATA = bpp_en && !MRW ? data : 32'hzzzzzzzz;  
    

endmodule



/**********

                UART MODULE

**********/

module uart_tx
(   
    input clk,
    input start,
    output ready,
    input [7:0] data,
    output tx
);

    parameter CLK = 100000000;
    parameter BAUD = 115200;
    parameter RATE = ((CLK)/(2*BAUD)) - 1;

// UART CLK Generation
    reg uartClk;
    reg [31:0] counter;
    initial begin
        uartClk <= 1'b0;
        counter <= 32'd0;
    end
    
    always @(posedge clk) begin
        if(counter == RATE) begin
            uartClk <= ~uartClk;
            counter <= 0;
        end
        else counter <= counter + 1;
    end
//END UART CLK Generation
    
    parameter [3:0] TX_IDLE = 4'h0,
                    TX_START = 4'h1,
                    TX_LOOP = 4'h2,
                    TX_STOP = 4'h3;
    
    reg [3:0] state, n_state;
    
    reg [3:0] dataCount, n_dataCount;
    
    reg [9:0] tx_shift, n_tx_shift;
    
    initial begin
        state <= TX_IDLE;
        n_state <= TX_IDLE;
        
        dataCount <= 0;
        n_dataCount <= 0;
        
        tx_shift <= 10'b0000000001;
        n_tx_shift <= 10'b0000000001;
    end
    
    assign tx = tx_shift[0];
    assign ready = state == TX_IDLE;
    
    always @(*) begin
        case(state)
            TX_IDLE: begin
                if(start) n_state <= TX_START;
                else n_state <= TX_IDLE;
                
                n_tx_shift <= tx_shift;
                n_dataCount <= dataCount;
            end
            TX_START: begin
                n_tx_shift <= {data, 2'b01};
                n_dataCount <= 4'h0;
                n_state <= TX_LOOP;
            end
            TX_LOOP: begin
                if(dataCount == 4'd10) begin
                    n_tx_shift <= tx_shift;
                    n_dataCount <= dataCount;
                    n_state <= TX_STOP;
                end
                else begin
                    n_tx_shift <= {1'b1, tx_shift[9:1]};
                    n_dataCount <= dataCount + 1;
                    n_state <= TX_LOOP;
                end
            end
            TX_STOP: begin
                if(start) n_state <= TX_STOP;
                else n_state <= TX_IDLE;
                
                n_tx_shift <= tx_shift;
                n_dataCount <= dataCount;
            end
            default begin
                n_state <= state;
                n_tx_shift <= tx_shift;
                n_dataCount <= dataCount;
            end
        endcase
    end
    
    always @(posedge uartClk) begin
        state <= n_state;
        dataCount <= n_dataCount;
        tx_shift <= n_tx_shift;
    end
    
    
endmodule

//BASE ADDRESS = 0x0000_00030
module UART
(
    input [31:0] MADDR,
    inout [31:0] MDATA,
    //wire [3:0]  MBE;
    input       MEN,
    input       MRW,
    output      MWAIT,
    
    input         rst,
    input         clk
);

    wire uart_en = MEN && (MADDR[31:4] == 28'h000_0003);
    
    reg [7:0] udata;
    initial begin
        udata <= 8'd0;
    end
    always @(posedge clk) begin
        if(uart_en && MRW && MADDR[3:2] == 2'b01)
            udata <= MDATA[7:0];
    end
    
    
    reg [1:0] ustate;
    reg       ustart;
    wire      uready;
    
    initial begin
        ustate <= 2'b00;
        ustart <= 1'b0;
    end
    
    wire ubusy = ustate != 2'b00;
    always @(posedge clk) begin
        
        if(rst) begin
            ustate <= 2'b00;
            ustart <= 1'b0;
        end
        else begin
        
            case(ustate)
            
            2'b00: begin
                
                if(uart_en && MRW && MADDR[3:2] == 2'b00 && MDATA[0]) begin
                    ustate <= 2'b01;
                    ustart <= 1'b1;
                end
                else begin
                    ustate <= 2'b00;
                    ustart <= 1'b0;
                end
            
            end
            2'b01: begin
                
                if(!uready) begin
                    ustate <= 2'b10;
                    ustart <= 1'b0;
                end
                else begin
                    ustate <= 2'b01;
                    ustart <= 1'b1;
                end
                

            end
            2'b10: begin
               
               if(uready) ustate <= 2'b00;
               else ustate <= 2'b10;
                
                ustart <= 1'b0;
            end
            
            default: begin
                ustate <= 2'b00;
                ustart <= 1'b0;
            end
            
            endcase
        
        end
        
        
    end
    
    uart_tx tx(clk, ustart, uready, udata, top.usb_tx);
    
    
    assign MWAIT = uart_en ? 1'b0 : 1'bz;
    wire [31:0] readdata = (MADDR[3:2] == 2'b00) ? {30'd0, ubusy, 1'b0} : {24'd0, udata};
    
    assign MDATA = uart_en && !MRW ? readdata : 32'hzzzzzzzz;
    


endmodule


/*

module BPCC
(   
    input [31:0] MADDR,
    inout [31:0] MDATA,
    //wire [3:0]  MBE;
    input       MEN,
    input       MRW,
    output      MWAIT,
    
    input         rst,
    input         clk
);

    reg [31:0] bp_c_counter;
    wire bp_c_en = MEN && (MADDR == 32'h0000_0010);
    
    assign MWAIT = bp_c_en ? 1'b0 : 1'bz;
    assign MDATA = bp_c_en && !MRW ? bp_c_counter : 32'hzzzzzzzz;
    initial begin
        bp_c_counter <= 32'd0;
    end
    
    always @(posedge clk) begin
        
        if(rst) begin
            bp_c_counter <= 32'd0;
        end
        else if(top.cpu.EXE_V && !top.cpu.mem_stall && (top.cpu.EXE_OP == `INSTR_BRANCH) && !(top.cpu.EXE_BT ^^ top.cpu.cmp_true) ) begin
            bp_c_counter <= bp_c_counter + 1;
        end
        
    end

endmodule


module BPC
(
    input [31:0] MADDR,
    inout [31:0] MDATA,
    //wire [3:0]  MBE;
    input       MEN,
    input       MRW,
    output      MWAIT,
    
    input         rst,
    input         clk
);

    //Number of branchs executed
    reg [31:0] bp_counter;
    wire bp_en = MEN && (MADDR == 32'h0000_0014);
    
    assign MWAIT = bp_en ? 1'b0 : 1'bz;
    assign MDATA = bp_en && !MRW ? bp_counter : 32'hzzzzzzzz;
    initial begin
        bp_counter <= 32'd0;
    end
    
    always @(posedge clk) begin
        
        if(rst) begin
            bp_counter <= 32'd0;
        end
        else if(top.cpu.EXE_V && !top.cpu.mem_stall && (top.cpu.EXE_OP == `INSTR_BRANCH) ) begin
            bp_counter <= bp_counter + 1;
        end
        
    end    


endmodule




module IPC
(
    input [31:0] MADDR,
    inout [31:0] MDATA,
    //wire [3:0]  MBE;
    input       MEN,
    input       MRW,
    output      MWAIT,
    
    input         rst,
    input         clk
);

    //Number of branchs executed
    reg [31:0] ipc_counter;
    wire ipc_en = MEN && (MADDR == 32'h0000_0018);
    
    assign MWAIT = ipc_en ? 1'b0 : 1'bz;
    assign MDATA = ipc_en && !MRW ? ipc_counter : 32'hzzzzzzzz;
    initial begin
        ipc_counter <= 32'd0;
    end
    
    always @(posedge clk) begin
        
        if(rst) begin
            ipc_counter <= 32'd0;
        end
        else begin
            ipc_counter <= ipc_counter + (top.cpu.EXE_V && !top.cpu.mem_stall && top.cpu.EXE_OP == `INSTR_BRANCH)
                                       + (top.cpu.MEM_V && top.cpu.MEM_MEN && top.cpu.MEM_RW && !top.cpu.mem_stall)
                                       + (top.cpu.WR_V);
        end
        
    end    


endmodule



module Tick_counter
(
    
    input [31:0] MADDR,
    inout [31:0] MDATA,
    //wire [3:0]  MBE;
    input       MEN,
    input       MRW,
    output      MWAIT,
    
    input         rst,
    input         clk

);
    
    
    reg [31:0] ticks;
    initial begin
        ticks <= 32'd0;
    end
    
    
    always @(posedge clk) begin
        if(rst) begin
            ticks <= 32'd0;
        end
        else begin
            ticks <= ticks + 1;
        end
    end


    wire tick_en = (MEN && (MADDR == 32'h0000_001C));
    
    assign MWAIT = tick_en ? 1'b0 : 1'bz;
    assign MDATA = (tick_en && !MRW) ? ticks : 32'hzzzzzzzz;

endmodule

*/





 
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2021 03:33:15 AM
// Design Name: 
// Module Name: fetch
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fetch
(
    input clk,
    input rst,
    input int,
    input [31:0] intAddr,
    input btjmp,
    input [31:0] btjmpAddr
);
    
    //0x00000013
    reg [31:0] PC;
    
    reg [31:0] pipePC;
    reg [31:0] pipeInstr;
    
    initial begin
        PC <= 32'h00000000;
        pipePC <= 32'h00000000;
        pipeInstr <= 32'h00000013;
    end
    
    
    
    wire [31:0] imemAddr = btjmp ? btjmpAddr : PC;
    
    always @(posedge clk, negedge rst) begin
        if(!rst) PC <= 32'h00000000;
        else PC <= int ? intAddr : PC + 4;
    end
    
    
    
    
endmodule




module IMEM
(
    input [31:0] memAddr,
    output [31:0] instr
);


    reg [31:0] mem [16'hFFFF : 0];
    assign instr = mem[memAddr];
    
    genvar i;
    generate
        for(i = 0; i <= 17'h10000; i = i + 1) begin
            initial mem[i] = i;
        end
    endgenerate

endmodule
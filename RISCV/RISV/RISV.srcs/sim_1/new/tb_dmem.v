`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/20/2021 03:32:57 AM
// Design Name: 
// Module Name: tb_dmem
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



module tb_mul();

    reg  clk;
    always begin
        clk <= 1'b0; #5; 
        clk <= 1'b1; #5;
    end
    
    
    reg [31:0] rs1, rs2;
    wire [31:0] p;
    
    
    signed_mul ss( .CLK(clk), .A(rs1), .B(rs2), .P(p));
    
    
    initial begin
        rs1 <= 32'd5;
        rs2 <= 32'd23;
    end
    


endmodule 
//module tb_div();

//    reg clk;
    
//    always begin
//        clk <= 1'b0;
//        #5;
//        clk <= 1'b1;
//        #5;
    
//    end
    
//    wire [31:0] div_result;
//    reg [31:0] rs1, rs2;
//    reg [2:0] f3;
//    reg start;
//    wire stall;
//    reg rst;
    
    
//    DIV div( div_result,
//             rs1,
//             rs2,
//             f3,
//             start,
//             stall,
//             rst,
//             clk
//           );
    
    
//    initial begin
    
//        rs1 <= -32'd24;
//        rs2 <= -32'd9;
//        f3 <= 3'b100;
//        start <= 1'b0;
//        rst <= 1'b1;
        
//        #200;
        
//        rst <= 1'b0;
//        start <= 1'b1;
       
//        rs1 <= 32'd16;
//        rs2 <= 32'd5;
        
        
    
//    end



//endmodule


//module tb_dmem();

//    reg [13:0] addr;
//    reg [31:0] write;
//    reg en;
//    reg clk;
//    reg [3:0] be;
    
//    wire [31:0] read;
    
//    always begin
//        #100;
//        clk <= ~clk;
//    end
    
//    initial begin
    
//        addr <= 12'd0;
//        write <= 32'h44332211;
//        en <= 1'b0;
//        clk <= 1'b0;
//        be <= 4'hf;
        
//        #50;
        
//        en <= 1'b1;
//        be <= 4'h8;
        
//        #100;
//        be <= 4'h3;
        
    
//    end
    
    
//    DRAM mem(
//                .addra(addr),
//                .clka(clk),
//                .dina(write),
//                .douta(read),
//                .ena(en),
//                .wea(be)
//            ); 


//endmodule

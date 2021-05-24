`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2021 10:13:40 PM
// Design Name: 
// Module Name: top
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


module top(

input clk,
input rst,
input [4:0] io_button,
input [23:0] sw,
output [23:0] io_led,
output [7:0] led,

input usb_rx,
output usb_tx,
//7 seg
output [3:0] an,
output [6:0] seg,
output dp

);



assign io_led = sw;
assign usb_tx = usb_rx;

assign led[4:0] = io_button;
assign led[7:5] = 3'b101;


seven_seg seg_inst(clk, sw[15:0], sw[19:16], sw[23:20], an, seg, dp, ~rst);

endmodule


module seven_seg(
input clk,
input [15:0] data,
input [3:0] dps,
input [3:0] en,
output [3:0] anode,
output reg [6:0] seg,
output dp,
input rst
);
  
  reg [3:0] an;
  assign anode = an | en;
  
  initial begin
    an <= 4'b1110;
    seg <= 7'b0000000;
  end

  reg [20:0] counter = 0;
  always @(posedge clk, posedge rst) begin
    if(rst) counter <= 0;
    else counter <= counter + 1;
  end
  
  always @(posedge counter[18], posedge rst) begin
    if(rst) an <= 4'b1110;
    else an <= {an[2:0], an[3]};
  end
  
  wire [3:0] segData;
  assign segData = !an[3] ? data[15:12] :
                   !an[2] ? data[11:8]  :
                   !an[1] ? data[7:4]   : data[3:0];
                   
  assign dp = ~(  !an[3] ? dps[3] :
                  !an[2] ? dps[2] :
                  !an[1] ? dps[1] : dps[0] );
                   
  always @(segData) begin
    case(segData)
      4'b0000: seg = 7'b1000000;
      4'b0001: seg = 7'b1111001;
      4'b0010: seg = 7'b0100100;
      4'b0011: seg = 7'b0110000;
      4'b0100: seg = 7'b0011001;
      4'b0101: seg = 7'b0010010;
      4'b0110: seg = 7'b0000010;
      4'b0111: seg = 7'b1111000;
      4'b1000: seg = 7'b0000000;
      4'b1001: seg = 7'b0011000;
      4'b1010: seg = 7'b0001000;
      4'b1011: seg = 7'b0000011;
      4'b1100: seg = 7'b1000110;
      4'b1101: seg = 7'b0100001;
      4'b1110: seg = 7'b0000110;
      4'b1111: seg = 7'b0001110;
    endcase
  end
  
  
endmodule

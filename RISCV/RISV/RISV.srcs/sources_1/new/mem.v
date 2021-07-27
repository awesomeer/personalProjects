`timescale 1ns / 1ps



module IMEM
(    
    input   [31:0]  IADRR,
    output  [31:0]  IDATA,
    output          IWAIT,
    input clk
);

    //IMEM_ROM imem_rom( .addra(IADRR[9:2]), .clka(!clk), .douta(IDATA));
    assign IWAIT = 1'b0;
    
    reg [31:0] ROM [0:1023];
    initial begin
        
        $readmemh("C:\\Users\\mithi\\Desktop\\share\\memrom.txt", ROM);
    
    end
    assign IDATA = ROM[IADRR[11:2]];
//    reg [31:0] data = 32'd0;
//    assign IDATA = data;
//    always @(negedge clk) begin
//        data <= ROM[IADRR[9:2]];
//    end
    

endmodule




//BASE address = 0x0001_0000
//               0x0001_FFFF
module DROM
(
    input   [31:0]  MADDR,
    inout   [31:0]  MDATA,
    input   [3:0]   MBE,
    input           MEN,
    input           MRW,
    output          MWAIT,    
    input           clk
);
    
    reg [31:0] ROM [0:255];
    initial begin
        $readmemh("C:\\Users\\mithi\\Desktop\\share\\datarom.txt", ROM);
    end

    wire rom_en = MEN && (MADDR[31:16] == 16'h0001);
    
    assign MWAIT = rom_en ? 1'b0 : 1'bz;
    assign MDATA = rom_en && !MRW ? ROM[MADDR[9:2]] : 32'hzzzzzzzz;

endmodule




//BASE address = 0x0002_0000
//               0x0002_FFFF
module DMEM
(
    input   [31:0]  MADDR,
    inout   [31:0]  MDATA,
    input   [3:0]   MBE,
    input           MEN,
    input           MRW,
    output          MWAIT,    
    input           clk
);
    
    wire ram_en = MEN && (MADDR[31:16] == 16'h0002);  
    
    
    wire [31:0] ram_read;
    assign MDATA = (ram_en && !MRW) ? ram_read : 32'hzzzzzzzz;
    
    wire [3:0] be = {4{ram_en && MRW}} & MBE; 
    DRAM ram(
                .addra(MADDR[15:2]),
                .clka(clk),
                .dina(MDATA),
                .douta(ram_read),
                .ena(ram_en),
                .wea(be)
            ); 

    wire mwait;
    assign MWAIT = ram_en ? mwait : 1'bz;
    
    
    reg state;
    assign mwait = (!state && ram_en && !MRW);
    
    initial begin
        state <= 1'b0;
    end
    
    always @(posedge clk) begin
        
        if(!state) begin
            state <= ram_en && !MRW;
        end
        else begin
            state <= 1'b0;
        end
    
    end
    
endmodule



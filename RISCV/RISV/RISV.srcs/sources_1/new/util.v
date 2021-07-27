`timescale 1ns / 1ps

`define STACK_BASE 32'h0002_fff0

module REG_FILE
(

    input [4:0] rs1i,
    input [4:0] rs2i,
    input [4:0] rd,
    output [31:0] rs1,
    output [31:0] rs2,
    input [31:0] rdin,
    input write,
    input clk,
    input rst
);

    reg [31:0] reg_file [0:31];
    
    initial begin
    
            reg_file[0] <= 32'd0;   reg_file[1] <= 32'd0;    reg_file[2] <= `STACK_BASE;   reg_file[3] <= 32'd0;
            reg_file[4] <= 32'd0;   reg_file[5] <= 32'd0;    reg_file[6] <= 32'd0;     reg_file[7] <= 32'd0;
            reg_file[8] <= 32'd0;   reg_file[9] <= 32'd0;    reg_file[10] <= 32'd0;    reg_file[11] <= 32'd0;
            reg_file[12] <= 32'd0;  reg_file[13] <= 32'd0;   reg_file[14] <= 32'd0;    reg_file[15] <= 32'd0;
            reg_file[16] <= 32'd0;  reg_file[17] <= 32'd0;   reg_file[18] <= 32'd0;    reg_file[19] <= 32'd0;
            reg_file[20] <= 32'd0;  reg_file[21] <= 32'd0;   reg_file[22] <= 32'd0;    reg_file[23] <= 32'd0;
            reg_file[24] <= 32'd0;  reg_file[25] <= 32'd0;   reg_file[26] <= 32'd0;    reg_file[27] <= 32'd0;
            reg_file[28] <= 32'd0;  reg_file[29] <= 32'd0;   reg_file[30] <= 32'd0;    reg_file[31] <= 32'd0;
    
    
    end
    
    
    assign rs1 = (rs1i == 5'd0) ? 32'd0 : reg_file[rs1i];
    assign rs2 = (rs2i == 5'd0) ? 32'd0 : reg_file[rs2i];
    
    always @(posedge clk) begin
        
        if(rst) begin
        
            reg_file[0] <= 32'd0;   reg_file[1] <= 32'd0;    reg_file[2] <= `STACK_BASE;   reg_file[3] <= 32'd0;
            reg_file[4] <= 32'd0;   reg_file[5] <= 32'd0;    reg_file[6] <= 32'd0;     reg_file[7] <= 32'd0;
            reg_file[8] <= 32'd0;   reg_file[9] <= 32'd0;    reg_file[10] <= 32'd0;    reg_file[11] <= 32'd0;
            reg_file[12] <= 32'd0;  reg_file[13] <= 32'd0;   reg_file[14] <= 32'd0;    reg_file[15] <= 32'd0;
            reg_file[16] <= 32'd0;  reg_file[17] <= 32'd0;   reg_file[18] <= 32'd0;    reg_file[19] <= 32'd0;
            reg_file[20] <= 32'd0;  reg_file[21] <= 32'd0;   reg_file[22] <= 32'd0;    reg_file[23] <= 32'd0;
            reg_file[24] <= 32'd0;  reg_file[25] <= 32'd0;   reg_file[26] <= 32'd0;    reg_file[27] <= 32'd0;
            reg_file[28] <= 32'd0;  reg_file[29] <= 32'd0;   reg_file[30] <= 32'd0;    reg_file[31] <= 32'd0;
            
        end
        else if( write && (rd != 5'd0) ) begin
            reg_file[rd] <= rdin;
        end
        
    end


endmodule



module SRA_SHF
(
    output [31:0] shf_result,
    input  [31:0] US1,
    input  [31:0] US2
);


    wire [31:0] shf_1 = US2[0] ? { US1[31], US1[31:1]} : US1;
    wire [31:0] shf_2 = US2[1] ? { {2{shf_1[31]}}, shf_1[31:2]} : shf_1;
    wire [31:0] shf_3 = US2[2] ? { {4{shf_2[31]}}, shf_2[31:4]} : shf_2;
    wire [31:0] shf_4 = US2[3] ? { {8{shf_3[31]}}, shf_3[31:8]} : shf_3;
    assign shf_result = US2[4] ? { {16{shf_4[31]}}, shf_4[31:16]} : shf_4; 


endmodule


module ALU
(
    output [31:0] result,
    input [31:0] US1,
    input [31:0] US2,
    input [2:0] f3,
    input [6:0] f7,
    output stall,
    
    input rst,
    input clk
);

    wire [31:0] shf_result;
    SRA_SHF sra(shf_result, US1, US2);
    
    wire [31:0] mul_result;
    wire mul_stall;
    MUL mul(mul_result, US1, US2, f3, mul_stall, rst, clk);
    
    wire [31:0] div_result;
    wire div_stall;
    DIV div(div_result, US1, US2, f3, div_stall, rst, clk);
    
    wire [31:0] muldiv_result = f3[2] ? div_result : mul_result;
    assign stall = mul_stall || div_stall;
    
    wire signed [31:0] S1 = $signed(US1);
    wire signed [31:0] S2 = $signed(US2);
    
    assign result = ( f7 == 7'b000_0000 && f3 == 3'b000) ? US1 + US2 :                  // ADD
                    ( f7 == 7'b010_0000 && f3 == 3'b000) ? US1 - US2 :                  // SUB
                    ( f7 == 7'b000_0000 && f3 == 3'b001) ? US1 << US2[4:0] :            // SLL
                    ( f7 == 7'b000_0000 && f3 == 3'b010) ? { 31'd0, S1 < S2} :          //SLT
                    ( f7 == 7'b000_0000 && f3 == 3'b011) ? { 31'd0, US1 < US2} :        //SLTU
                    ( f7 == 7'b000_0000 && f3 == 3'b100) ? US1 ^ US2 :                  //XOR
                    ( f7 == 7'b000_0000 && f3 == 3'b101) ? US1 >> US2[4:0] :            //SRL
                    ( f7 == 7'b010_0000 && f3 == 3'b101) ? shf_result :             //SRA
                    ( f7 == 7'b000_0000 && f3 == 3'b110) ? US1 | US2 :                  //OR
                    ( f7 == 7'b000_0000 && f3 == 3'b111) ? US1 & US2 :                  //AND
                    ( f7 == 7'b000_0001)                 ? muldiv_result :
                    ( f7 == 7'b111_1111)                 ? US2 :
                    ( f7 == 7'b111_1110)                 ? US1 + 32'd4 :
                                                           US1 + US2;
                                                           
                                                           


endmodule


module DIV
(
    output  [31:0] result,
    input   [31:0] rs1,
    input   [31:0] rs2,
    input   [2:0]  f3,
    output         dstall,
    
    input rst,
    input clk
);
    
    parameter DELAY = 8'd18;
    wire [63:0] signed_div;
    wire [63:0] unsigned_div;
    
    wire signed_div_v;
    wire unsigned_div_v;
    
    
    assign result = (f3 == 3'b100) ? signed_div[63:32]     :
                    (f3 == 3'b101) ? unsigned_div[63:32]   :
                    (f3 == 3'b110) ? signed_div[31:0]      : unsigned_div[31:0];
                     
    
    
    reg [1:0] state, nstate;
    reg [7:0] count, ncount;
    reg       stall, nstall;
    
    initial begin

        stall <= 1'b1;
        nstall <= 1'b1;
        
        count <= 0;
        ncount <= 0;
        
        state <= 2'b00;
        nstate <= 2'b00;
    end
    
    wire start = (top.cpu.EXE_OP == `INSTR_OP) && (top.cpu.EXE_F7 == 7'b0000001) && top.cpu.EXE_F3[2];
    assign dstall = start && stall;
    
    always @(*) begin
        
        case(state)
        
            2'b00: begin
            
                if(start) begin
                    nstate <= 2'b01;
                end
                else begin
                    nstate <= 2'b00;
                end
            
                ncount <= DELAY;
                nstall <= 1'b1;
            end
            
            2'b01: begin
                
                if(count != 8'd0) begin
                    ncount <= count - 1;
                    nstall <= 1'b1;
                    nstate <= 2'b01;
                end
                else begin
                    ncount <= count;
                    nstall <= 1'b0;
                    nstate <= 2'b10;
                end
            
            end
            
            2'b10: begin
                
                ncount <= count;
                nstall <= 1'b1;
                nstate <= 2'b00;
                
            end
            
            default begin
                nstate <= 2'b00;
                nstall <= 1'b1;
                ncount <= DELAY;
            end
        
        endcase 
    
   
   
    end
    
    always @(posedge clk) begin
        
        if(rst) begin
            state <= 2'b00;
            stall <= 1'b1;
            count <= DELAY;
        end
        else begin 
            state <= nstate;
            count <= ncount;
            stall <= nstall;
        end
    end
    
    
    Dividers dividers(
                        .s_axis_dividend_tdata(rs1),
                        .s_axis_dividend_tvalid(1'b1),
                        
                        .s_axis_divisor_tdata(rs2),
                        .s_axis_divisor_tvalid(1'b1),
                        
                        .m_axis_dout_tdata(signed_div),
                        .m_axis_dout_tvalid(signed_div_v),
                        
                        .aclk(clk)
                   );
                   
    Divideru divideru(
                        .s_axis_dividend_tdata(rs1),
                        .s_axis_dividend_tvalid(1'b1),
                        
                        .s_axis_divisor_tdata(rs2),
                        .s_axis_divisor_tvalid(1'b1),
                        
                        .m_axis_dout_tdata(unsigned_div),
                        .m_axis_dout_tvalid(unsigned_div_v),
                        
                        .aclk(clk)
                   );



endmodule

module MUL
(
    output  [31:0]  result,
    input   [31:0]  rs1,
    input   [31:0]  rs2,
    input   [2:0]   f3,
    output stall,
    
    input rst,
    input clk
);


    parameter DELAY = 4'd4;

    wire [31:0] ss;
    wire [31:0] ssh;
    wire [31:0] uuh;
    wire [31:0] suh;
    
    
    signed_mul      ss_mul( .P(ss), .A(rs1), .B(rs2), .CLK(clk));
    signed_mulh      ss_mulh( .P(ssh), .A(rs1), .B(rs2), .CLK(clk));
    unsigned_mulh    uu_mul( .P(uuh), .A(rs1), .B(rs2), .CLK(clk));
    signed_unsigned_mulh su_mul( .P(suh), .A(rs1), .B(rs2), .CLK(clk));
                   
    
    assign result = (f3 == 3'b000) ? ss         :
                    (f3 == 3'b001) ? ssh        :
                    (f3 == 3'b010) ? suh        : uuh;
                    
    
    reg [1:0] state;
    reg [3:0] count;
    wire mul_start = (top.cpu.EXE_OP == `INSTR_OP) && (top.cpu.EXE_F7 == 7'b0000001) && !top.cpu.EXE_F3[2];
    assign stall = mul_start && !(state == 2'b10);
    
    
    initial begin
        state <= 2'b00;
        count <= DELAY;
    end
    
    
    
    always @(posedge clk) begin
    
        if(rst) begin
            state <= 2'b00;
            count <= DELAY;
        end
        else begin
            
            case(state)
                
                2'b00: begin
                    if(mul_start) state <= 2'b01;
                    else state <= 2'b00;
                    
                    count <= DELAY;
                end
                2'b01: begin
                    
                    if(count != 4'd0) begin
                        count <= count - 1;
                        state <= 2'b01;
                    end
                    else begin
                        count <= DELAY;
                        state <= 2'b10;
                    end
                    
                end
                2'b10: begin
                    
                    count <= DELAY;
                    state <= 2'b00;
                    
                end
                
                default: begin
                    count <= DELAY;
                    state <= 2'b00;
                end
            endcase
        
        end    
    
    end
    
    

endmodule



module CMP
(
    output          true,
    input   [31:0]  rs1,
    input   [31:0]  rs2,
    input   [2:0]   f3
);

    wire [31:0] srs1 = $signed(rs1);
    wire [31:0] srs2 = $signed(rs2);
    
    assign true = (f3 == 3'b000) ? rs1 == rs2 :     //BEQ
                  (f3 == 3'b001) ? rs1 != rs2 :     //BNE
                  (f3 == 3'b100) ? srs1 < srs2 :    //BLT
                  (f3 == 3'b101) ? srs1 >= srs2 :    //BGE
                  (f3 == 3'b110) ? rs1 < rs2 : rs1 >= rs2;   //BLTU BGEU 


endmodule


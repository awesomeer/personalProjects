`timescale 1ns / 1ps

`include "defines.v"

`define OPCODE DE_INSTR[6:0]
`define RD DE_INSTR[11:7]
`define RS1 DE_INSTR[19:15]
`define RS2 DE_INSTR[24:20]
`define F3 DE_INSTR[14:12]
`define F7 DE_INSTR[31:25]

module RISCV
(
    output  [31:0]  IADDR,
    input   [31:0]  IDATA,
    input           IWAIT,
    
    output  [31:0]  MADDR,
    inout   [31:0]  MDATA,
    output  [3:0]   MBE,
    output          MEN,
    output          MRW,
    input           MWAIT,
    
    input rst,
    input clk
);


/*

        REGISTERS

*/

//      Fetch
    reg [31:0]  PC;
    
    reg [3:0] BHT;
    reg [1:0] predictor[0:15];
    
//      Decode
    reg [31:0]  DE_PC;
    reg [31:0]  DE_INSTR;
    reg         DE_BT;
    reg [3:0]   DE_BI;
    reg         DE_V;

//      Execute
    reg [31:0]  EXE_PC;
    reg [2:0]   EXE_F3;
    reg [6:0]   EXE_F7;
    reg [31:0]  EXE_RS1;
    reg [31:0]  EXE_RS2;
    reg [31:0]  EXE_IMM;
    reg [4:0]   EXE_RD;
    reg [6:0]   EXE_OP;
    reg         EXE_BT;
    reg [3:0]   EXE_BI;
    reg         EXE_V;
    
//      Memory Access
    reg [31:0]  MEM_PC;
    reg         MEM_MEN;
    reg         MEM_RW;
    reg [2:0]   MEM_F3;
    reg [31:0]  MEM_ADDR;
    reg [31:0]  MEM_DATA;
    reg [4:0]   MEM_RD;
    reg         MEM_V;
    
//      Writeback Stage
    reg [31:0]  WR_PC;
    reg [31:0]  WR_RS;
    reg [4:0]   WR_RD;
    reg         WR_V;
    
    
    
/*
        LOGIC
*/
    
    wire [3:0] branch_index;
    wire branch_predict_jump;
    wire        branch;
    wire [31:0] branch_target;
    
    wire decode_stall;
    wire exe_stall;
    wire mem_stall;
    
    
    wire data_avail;
    

//      Fetch Logic
    
    initial begin
        PC <= 32'd0;
        BHT <= 4'd0;
        predictor[0] <= 2'b01; predictor[1] <= 2'b01; predictor[2] <= 2'b01; predictor[3] <= 2'b01;
        predictor[4] <= 2'b01; predictor[5] <= 2'b01; predictor[6] <= 2'b01; predictor[7] <= 2'b01;
        predictor[8] <= 2'b01; predictor[9] <= 2'b01; predictor[10] <= 2'b01; predictor[11] <= 2'b01;
        predictor[12] <= 2'b01; predictor[13] <= 2'b01; predictor[14] <= 2'b01; predictor[15] <= 2'b01;
    end

    assign IADDR = PC;
    
    assign branch_index = PC[5:2] ^ BHT;
    assign branch_predict_jump = (IDATA[6:0] == `INSTR_BRANCH) && predictor[branch_index][1]; 
    
    always @(posedge clk) begin
        
        if(rst) begin
            PC <= 32'd0;
        end
        else if(branch) begin
            PC <= branch_target;
        end
        else if( !(IWAIT || decode_stall || exe_stall || mem_stall) ) begin
            PC <= branch_predict_jump ? PC + { {19{IDATA[31]}}, IDATA[31], IDATA[7], IDATA[30:25], IDATA[11:8], 1'b0} : 
                  (IDATA[6:0] == `INSTR_JAL) ? PC + { {11{IDATA[31]}}, IDATA[31], IDATA[19:12], IDATA[20], IDATA[30:21], 1'b0} : PC + 4;
        end
        
    end
    
    
    
//      Decode Logic
    
    initial begin
        
        DE_PC <= 32'd0;
        DE_INSTR <= 32'd0;
        DE_V <= 1'b0;
        
        DE_BT <= 1'b0;
        DE_BI <= 4'd0;
    end
    
    wire [31:0] rs1;
    wire [31:0] rs2;
    
    REG_FILE regs(`RS1, `RS2, WR_RD, rs1, rs2, WR_RS, WR_V, clk, rst); 
    
    wire [31:0] imm = (`OPCODE == `INSTR_LUI)       ? { DE_INSTR[31:12], 12'd0} : 
                      (`OPCODE == `INSTR_AUIPC)     ? { DE_INSTR[31:12], 12'd0} :
                      (`OPCODE == `INSTR_JAL)       ? { {11{DE_INSTR[31]}}, DE_INSTR[31], DE_INSTR[19:12], DE_INSTR[20], DE_INSTR[30:21], 1'b0} ://TODO
                      (`OPCODE == `INSTR_JALR)      ? { {20{DE_INSTR[31]}}, DE_INSTR[31:20]} :
                      (`OPCODE == `INSTR_BRANCH)    ? { {19{DE_INSTR[31]}}, DE_INSTR[31], DE_INSTR[7], DE_INSTR[30:25], DE_INSTR[11:8], 1'b0} :
                      (`OPCODE == `INSTR_LOAD)      ? { {20{DE_INSTR[31]}}, DE_INSTR[31:20]} :
                      (`OPCODE == `INSTR_STORE)     ? { {20{DE_INSTR[31]}}, DE_INSTR[31:25], DE_INSTR[11:7]} :
                      ((`OPCODE == `INSTR_IMM) && (DE_INSTR[13:12] == 2'b01)) ? { 27'd0, `RS2 } : //Shamt
                                                      { {20{DE_INSTR[31]}}, DE_INSTR[31:20]};
                                                      
     
     wire [6:0] de_f7 = (`OPCODE == `INSTR_LUI)     ? 7'b111_1111 :
                        (`OPCODE == `INSTR_AUIPC)   ? 7'b111_1101 :
                        (`OPCODE == `INSTR_JAL)     ? 7'b111_1110 :
                        (`OPCODE == `INSTR_JALR)    ? 7'b111_1110 :
                        (`OPCODE == `INSTR_LOAD)    ? 7'b111_1101 :
                        (`OPCODE == `INSTR_STORE)   ? 7'b111_1101 :
                        (`OPCODE == `INSTR_IMM && `F3 != 3'b101) ? 7'b000_0000 : `F7;
                        
     
     
     wire rs1_needed = !( (`OPCODE == `INSTR_LUI) ||
                          (`OPCODE == `INSTR_AUIPC) ||
                          (`OPCODE == `INSTR_JAL)
                        );
     
     wire rs2_needed = (`OPCODE == `INSTR_BRANCH) ||
                       (`OPCODE == `INSTR_STORE) ||
                       (`OPCODE == `INSTR_OP);                  
     
     
     wire rs1_stall = ( (EXE_OP == `INSTR_LOAD) && (EXE_RD == `RS1) && (`RS1 != 5'd0) && EXE_V ) ? 1'b1 :
                      ( MEM_MEN && !MEM_RW && mem_stall && (MEM_RD == `RS1) && (`RS1 != 5'd0) && MEM_V ) ? 1'b1: 1'b0;
                      
     wire rs2_stall = ( (EXE_OP == `INSTR_LOAD) && (EXE_RD == `RS2) && (`RS2 != 5'd0) && EXE_V ) ? 1'b1 :
                      ( MEM_MEN && !MEM_RW && mem_stall && (MEM_RD == `RS2) && (`RS2 != 5'd0) && MEM_V ) ? 1'b1: 1'b0;                      
     
     
     //wire rs1_stall = ((!data_avail && (EXE_RD == `RS1) && EXE_V) || ((MEM_RD == `RS1) && MEM_V)) && (`RS1 != 5'd0);
     //wire rs2_stall = ((!data_avail && (EXE_RD == `RS2) && EXE_V) || ((MEM_RD == `RS2) && MEM_V)) && (`RS2 != 5'd0);
     assign decode_stall = DE_V && ( (rs1_stall && rs1_needed) || (rs2_stall && rs2_needed) );
     
     
     always @(posedge clk) begin
     
        if(rst) begin
        
            DE_PC <= 32'd0;
            DE_INSTR <= 32'd0;
            DE_V <= 1'b0;
            DE_BT <= 1'b0;
            DE_BI <= 4'd0;
            
        end
        else if( branch) begin
            
            DE_PC <= PC;
            DE_INSTR <= IDATA;
            DE_V <= 1'b0;
            DE_BT <= predictor[branch_index][1];
            DE_BI <= branch_index;
        
        end
        else if( !(decode_stall || exe_stall || mem_stall) ) begin
            
            DE_PC <= PC;
            DE_INSTR <= IDATA;
            DE_V <= !( IWAIT || branch);
            DE_BT <= predictor[branch_index][1];
            DE_BI <= branch_index;
        
        end
     
     end 
    
    
//      Execute Logic
    
    initial begin
    
        EXE_PC <= 32'd0;
        EXE_F3 <= 3'd0;
        EXE_F7 <= 7'd0;
        EXE_RS1 <= 32'd0;
        EXE_RS2 <= 32'd0;
        EXE_IMM <= 32'd0;
        EXE_RD <= 5'd0;
        EXE_OP <= 7'd0;
        EXE_V <= 1'b0;
        EXE_BT <= 1'b0;
        EXE_BI <= 4'd0;
    
    end
    
    
    assign data_avail = !(  (EXE_OP == `INSTR_BRANCH) ||
                            (EXE_OP == `INSTR_LOAD) ||
                            (EXE_OP == `INSTR_STORE)
                         );
    
    
    wire alu_rs1_mux = (EXE_OP == `INSTR_AUIPC) ||
                       (EXE_OP == `INSTR_JAL) ||
                       (EXE_OP == `INSTR_JALR);
    
    wire alu_rs2_mux = (EXE_OP == `INSTR_LUI) ||
                       (EXE_OP == `INSTR_AUIPC) ||
                       (EXE_OP == `INSTR_LOAD) ||
                       (EXE_OP == `INSTR_STORE) ||
                       (EXE_OP == `INSTR_IMM);
    
    wire [31:0] alu_rs1 = alu_rs1_mux ? EXE_PC : EXE_RS1;
    wire [31:0] alu_rs2 = alu_rs2_mux ? EXE_IMM : EXE_RS2;
    
    wire [31:0] alu_result;
    wire muldiv_stall;
    ALU alu( alu_result, alu_rs1, alu_rs2, EXE_F3, EXE_F7, muldiv_stall, rst, clk);
    
    assign exe_stall = (EXE_OP == `INSTR_OP) && (EXE_F7 == 7'b0000001) && muldiv_stall;
    
    //Branching logic
    wire cmp_true;
    CMP cmp( cmp_true, EXE_RS1, EXE_RS2, EXE_F3 );
    
    wire [31:0] branch_target_jmp;
    assign branch_target_jmp = ((EXE_OP == `INSTR_JALR) ? EXE_RS1 : EXE_PC) + EXE_IMM;
    assign branch_target = ((EXE_OP == `INSTR_BRANCH) && (EXE_BT && !cmp_true)) ? EXE_PC + 4 : branch_target_jmp;
    
    assign branch = EXE_V && ( ((EXE_OP == `INSTR_BRANCH) && (EXE_BT ^^ cmp_true)) || (EXE_OP == `INSTR_JALR));  
    
    //Predictor control
    always @(posedge clk) begin
        
        if(rst) begin
            BHT <= 4'd0;
            predictor[0] <= 2'b01; predictor[1] <= 2'b01; predictor[2] <= 2'b01; predictor[3] <= 2'b01;
            predictor[4] <= 2'b01; predictor[5] <= 2'b01; predictor[6] <= 2'b01; predictor[7] <= 2'b01;
            predictor[8] <= 2'b01; predictor[9] <= 2'b01; predictor[10] <= 2'b01; predictor[11] <= 2'b01;
            predictor[12] <= 2'b01; predictor[13] <= 2'b01; predictor[14] <= 2'b01; predictor[15] <= 2'b01;
        end
        else if(EXE_OP == `INSTR_BRANCH && EXE_V) begin
            if( (predictor[EXE_BI] == 2'b00) && !cmp_true)
                predictor[EXE_BI] <= 2'b00;
            else if ( (predictor[EXE_BI] == 2'b11) && cmp_true)
                predictor[EXE_BI] <= 2'b11;
            else
                predictor[EXE_BI] <= cmp_true ? (predictor[EXE_BI] + 1) : (predictor[EXE_BI] - 1);
                
            BHT <= {BHT[2:0], cmp_true};
        end
    
    end
    
    
    wire [31:0] loaddata;
    always @(posedge clk) begin
    
        if(rst) begin
            
            EXE_PC <= 32'd0;
            EXE_F3 <= 3'd0;
            EXE_F7 <= 7'd0;
            EXE_RS1 <= 32'd0;
            EXE_RS2 <= 32'd0;
            EXE_IMM <= 32'd0;
            EXE_RD <= 5'd0;
            EXE_OP <= 7'd0;
            EXE_V <= 1'b0;
            EXE_BT <= 1'b0;
            EXE_BI <= 4'd0;
            
        end
        else if( !(exe_stall || mem_stall)) begin
            
            EXE_PC  <= DE_PC;
            EXE_F3  <= `F3;
            EXE_F7  <= de_f7;
            
            
            EXE_RS1 <= ( data_avail && (EXE_RD == `RS1) && (`RS1 != 5'd0) && EXE_V) ? alu_result :
                       ( !MEM_MEN && (MEM_RD == `RS1) && (`RS1 != 5'd0) && MEM_V) ? MEM_ADDR :
                       ( MEM_MEN && !MEM_RW && !mem_stall && (MEM_RD == `RS1) && (`RS1 != 5'd0) && MEM_V) ? loaddata :
                       ( (WR_RD == `RS1) && (`RS1 != 5'd0) && WR_V) ? WR_RS : rs1;
            
            EXE_RS2 <= ( data_avail && (EXE_RD == `RS2) && (`RS2 != 5'd0) && EXE_V) ? alu_result :
                       ( !MEM_MEN && (MEM_RD == `RS2) && (`RS2 != 5'd0) && MEM_V) ? MEM_ADDR :
                       ( MEM_MEN && !MEM_RW && !mem_stall && (MEM_RD == `RS2) && (`RS2 != 5'd0) && MEM_V) ? loaddata :
                       ( (WR_RD == `RS2) && (`RS2 != 5'd0) && WR_V) ? WR_RS : rs2;
            
            //EXE_RS1 <= (data_avail && (EXE_RD == `RS1) && EXE_V && (`RS1 != 5'd0)) ? alu_result : 
            //           ((WR_RD == `RS1) && WR_V && (`RS1 != 5'd0))                 ? WR_RS      : rs1;
                       
            //EXE_RS2 <= (data_avail && (EXE_RD == `RS2) && EXE_V && (`RS2 != 5'd0)) ? alu_result :
            //           ((WR_RD == `RS2) && WR_V && (`RS2 != 5'd0))                 ? WR_RS      : rs2;
            
            EXE_IMM <= imm;
            EXE_RD  <= `RD;
            EXE_OP  <= `OPCODE;
            EXE_V   <= DE_V && !decode_stall && !branch;
            EXE_BT <= DE_BT;
            EXE_BI <= DE_BI;
            
        end
    
    
    end
    
    
    
    
//      Memory Access Stage
    
    initial begin
        
        MEM_PC <= 32'd0;
        MEM_MEN <= 1'b0;
        MEM_RW <= 1'b0;
        MEM_F3 <= 3'd0;
        MEM_ADDR <= 32'd0;
        MEM_DATA <= 32'd0;
        MEM_RD <= 5'd0;
        MEM_V <= 1'b0;
        
        
    end
    
    
    

    
    
    wire [31:0] storedata;
    assign storedata[7:0]   = MEM_DATA[7:0];
    assign storedata[15:8]  = (MEM_F3 == 3'b000) ? MEM_DATA[7:0]   : MEM_DATA[15:8];
    assign storedata[23:16] = (MEM_F3 == 3'b010) ? MEM_DATA[23:16] : MEM_DATA[7:0];
    assign storedata[31:24] = (MEM_F3 == 3'b000) ? MEM_DATA[7:0]   :
                              (MEM_F3 == 3'b001) ? MEM_DATA[15:8]  : MEM_DATA[31:24];  
    
    assign MBE = (MEM_F3 == 3'b000 && MEM_ADDR[1:0] == 2'b00) ? 4'b0001 :
                 (MEM_F3 == 3'b000 && MEM_ADDR[1:0] == 2'b01) ? 4'b0010 :
                 (MEM_F3 == 3'b000 && MEM_ADDR[1:0] == 2'b10) ? 4'b0100 :
                 (MEM_F3 == 3'b000 && MEM_ADDR[1:0] == 2'b11) ? 4'b1000 :
                 (MEM_F3 == 3'b001 && !MEM_ADDR[1])           ? 4'b0011 :
                 (MEM_F3 == 3'b001 &&  MEM_ADDR[1])           ? 4'b1100 : 4'b1111;
    
    //Data to be loaded from memory
    assign     loaddata = (MEM_F3 == 3'b000 && MEM_ADDR[1:0] == 2'b00) ? { {24{MDATA[7]}},  MDATA[7:0]}    :
                          (MEM_F3 == 3'b000 && MEM_ADDR[1:0] == 2'b01) ? { {24{MDATA[15]}}, MDATA[15:8]}   :
                          (MEM_F3 == 3'b000 && MEM_ADDR[1:0] == 2'b10) ? { {24{MDATA[23]}}, MDATA[23:16]}  :
                          (MEM_F3 == 3'b000 && MEM_ADDR[1:0] == 2'b11) ? { {24{MDATA[31]}}, MDATA[31:24]}  :
                          
                          (MEM_F3 == 3'b001 && !MEM_ADDR[1])           ? { {16{MDATA[15]}}, MDATA[15:0]}   :
                          (MEM_F3 == 3'b001 &&  MEM_ADDR[1])           ? { {16{MDATA[31]}}, MDATA[31:16]}  :
                                                                                                            
                          (MEM_F3 == 3'b100 && MEM_ADDR[1:0] == 2'b00) ? { 24'd0,           MDATA[7:0]}    :
                          (MEM_F3 == 3'b100 && MEM_ADDR[1:0] == 2'b01) ? { 24'd0,           MDATA[15:8]}   :
                          (MEM_F3 == 3'b100 && MEM_ADDR[1:0] == 2'b10) ? { 24'd0,           MDATA[23:16]}  :
                          (MEM_F3 == 3'b100 && MEM_ADDR[1:0] == 2'b11) ? { 24'd0,           MDATA[31:24]}  :
                          
                          (MEM_F3 == 3'b101 && !MEM_ADDR[1])           ? { 16'd0,           MDATA[15:0]}   :
                          (MEM_F3 == 3'b101 &&  MEM_ADDR[1])           ? { 16'd0,           MDATA[31:16]}  : MDATA;
    
    
    assign MADDR = MEM_ADDR;
    assign MDATA = (MEM_V && MEM_MEN && MEM_RW) ? storedata : 32'hzzzzzzzz;

    assign MEN = MEM_V && MEM_MEN;
    assign MRW = MEM_RW;
    
    assign mem_stall = MEM_V && MEM_MEN && MWAIT;
    
    always @(posedge clk) begin
    
        if(rst) begin
        
            MEM_PC <= 32'd0;
            MEM_MEN <= 1'b0;
            MEM_RW <= 1'b0;
            MEM_F3 <= 3'd0;
            MEM_ADDR <= 32'd0;
            MEM_DATA <= 32'd0;
            MEM_RD <= 5'd0;
            MEM_V <= 1'b0;
            
        end
        else if(!mem_stall) begin
            
            MEM_PC <= EXE_PC;
            MEM_MEN <= (EXE_OP == `INSTR_LOAD) || (EXE_OP == `INSTR_STORE);
            MEM_RW <= (EXE_OP == `INSTR_STORE);
            MEM_F3 <= EXE_F3;
            MEM_ADDR <= alu_result;
            MEM_DATA <= EXE_RS2;
            MEM_RD <= EXE_RD;
            MEM_V <= EXE_V && (EXE_OP != `INSTR_BRANCH) && !exe_stall; 
            
        end
    
    end
    
    
    
//      Write Back Stage

    initial begin
        
        WR_PC <= 32'd0;
        WR_RS <= 32'd0;
        WR_RD <= 5'd0;
        WR_V <= 1'b0;
        
    end

    always @(posedge clk) begin
        
        if(rst) begin
            WR_PC <= 32'd0;
            WR_RS <= 32'd0;
            WR_RD <= 5'd0;
            WR_V <= 1'b0;
        end
        else begin
            WR_PC <= MEM_PC;
            WR_RS <= (MEM_V && MEM_MEN && !MEM_RW) ? loaddata : MEM_ADDR;
            WR_RD <= MEM_RD;
            WR_V <= MEM_V && !(MEM_MEN && mem_stall) && !(MEM_MEN && MEM_RW);
        end
    
    
    end
    
endmodule


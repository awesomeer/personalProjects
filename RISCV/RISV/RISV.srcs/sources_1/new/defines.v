`timescale 1ns / 1ps


`define     INSTR_LUI       7'b0110111
`define     INSTR_AUIPC     7'b0010111

`define     INSTR_IMM       7'b0010011
`define     INSTR_OP        7'b0110011



`define     INSTR_JAL       7'b1101111
`define     INSTR_JALR      7'b1100111

`define     INSTR_BRANCH    7'b1100011




`define     INSTR_LOAD      7'b0000011
`define     INSTR_STORE     7'b0100011




//OP and OP_FUN
`define     OP_ALU          2'b00
`define     OP_MUL          2'b01
`define     OP_MEM          2'b10
`define     OP_BRA          2'b11
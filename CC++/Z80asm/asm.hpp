#ifndef ASM_H_
#define ASM_H_

#include <iostream>
#include <map>
#include <string>
#include <fstream>
#include <vector>

using namespace std;

enum eType {INSTRUCTION, DIRECTIVE};
enum eInstruction {LD, PUSH, POP, // 8/16 Bit load Group
                  EX, EXX, LDI, LDIR, LDD, LDDR, CPI, CPIR, CPD, CPDR, //Exchange, Block Transfer, and Search Group
                  ADD, ADC, SUB, SBC, AND, OR, XOR, CP, INC, DEC, //Arithmetic Group
                  DAA, CPL, NEG, CCF, SCF, NOP, HALT, DI, EI, IM, //CPU control Group and GP Arithmetic
                  RLCA, RLA, RRCA, RRA, RLC, RL, RRC, RR, SLA, SRA, SRL, RLD, RRD, //Rotate and Shift Group
                  BIT, SET, RES, //Bit, Reset, and Test Group
                  JP, JR, DJNZ, //Jump Group
                  CALL, RET, RETI, RETN, RST, //Call and Return Group
                  IN, INI, INIR, IND, INDR, OUT, OUTI, OUTR, OUTD, OTDR}; //Input and Output Group
enum eGroup {LD8, LD16, EBS, A8, A16, CPUGPA, RS, BST, J, CR, IO};

typedef struct assembly{
    eType type;
    eInstruction instruction;
    eGroup group;
    string first, second;
} instruction_t;

int readFile(string fileName);

int firstPass();

#endif
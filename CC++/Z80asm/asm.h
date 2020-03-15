#ifndef ASM_H_
#define ASM_H_

#include <iostream>
#include <string>
#include <fstream>
#include <vector>

using namespace std;

enum type {INSTRUCTION, DIRECTIVE};

int readFile(string fileName);

int firstPass();

#endif
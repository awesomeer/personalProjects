#pragma once
#define SIZE 16384

#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <cstring>
#include <map>
#include <cstdint>

using namespace std;

class Assembler{

    private:
        string inputFile, outputFile;
        vector<string> lines;
        vector<uint8_t> program;
        map<string, uint16_t> symbols;
        

    public:
        Assembler(const string, const string);

    private:
        void firstPass();

};
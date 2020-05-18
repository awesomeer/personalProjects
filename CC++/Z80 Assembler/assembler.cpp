#include "assembler.hpp"

Assembler::Assembler(const string fileName, const string outFile){
    lines.clear();
    program.clear();

    if(outFile.empty())
        outputFile = "out";
    else
        outputFile = outFile;
    
    ifstream file(fileName.c_str(), ios::in);

    while(!file.eof()){
        char buffer[256];
        file.getline(buffer, 256);

        string line(buffer);
        if(!line.empty())
            lines.push_back(line);
    }
    
    for(string line : lines){
        cout << line << endl;
    }

    firstPass();
}


void Assembler::firstPass(){
    
}
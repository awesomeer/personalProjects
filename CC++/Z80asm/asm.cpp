#include "asm.hpp"

string file;
vector<string> lines;

int PC;
unsigned char mem[0xFFFF+1];

map<string, unsigned short> labels;

/*
Reads the assembly file into a vector of strings
for other functions
*/
int readFile(string fileName){
    file = fileName;
    ifstream in(fileName, ios::in);
    if(in.fail()){
        cout << "File failed to open" << endl;
        return -1;
    }

    lines.clear();
    labels.clear();

    while(!in.eof()){
        string line;
        getline(in, line);
        lines.push_back(line);
    }

    return 0;
}

int firstPass(){
    
}
#include "asm.h"

vector<string> lines;
string fileName;
int PC;
unsigned char mem[65536];

/*
Reads the assembly file into a vector of strings
for other functions
*/
int readFile(string fileName){
    ifstream in(fileName, ios::in);
    if(in.fail()){
        cout << "File failed to open" << endl;;
    }

    lines.clear();

    while(!in.eof()){
        string line;
        in >> line;
        lines.push_back(line);
    }

    return 0;
}

int firstPass(){

}
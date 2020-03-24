#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <cstdint>
#include <map>

using namespace std;

string file;
vector<string> lines;
uint16_t pc, sPc;


int readFile(string fileName);
int firstPass();
int assemble();

int readFile(string fileName){
    ifstream in(fileName, ios::in);
    if(in.fail()){
        cout << "File: " << fileName << " failed to open" << endl;
        exit(-1);
    }

    lines.clear();
    while(!in.eof()){
        string line;
        getline(in, line);
        lines.push_back(line);
    }

    return 0;
}

int firstPass(){
    
}

int main(int argc, char ** argv){

    readFile("main.cpp");
    for(int i = 0; i < lines.size(); i++){
        cout << lines[i] << endl;
    }

    firstPass();
    assemble();
    return 0;
}

/*
BYTE
STRING
WORD
REVERSE
*/
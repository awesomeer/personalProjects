#include "asm.h"
#include <vector>
#include <string>

using namespace std;

extern vector<string> lines;

int main(int argc, char ** argv){
    if(argc < 2){
        cout << "No files to compile" << endl;
        exit(-1);
    }

    readFile(argv[1]);
    for(int i = 0; i < lines.size(); i++){
        cout << lines[i] << endl;
    }

    return 0;
}

/*
.ORG
.BYTE
.DB
.DW
LABELS
*/
#include <iostream>
#include "assembler.hpp"

using namespace std;

int main(int argc, char ** argv){
    if(argc < 2){
        cout << "No input files" << endl;
        exit(EXIT_FAILURE);
    }

    string file(argv[1]);

    Assembler assemble(file, "");

    return 0;
}
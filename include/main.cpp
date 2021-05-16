#include <iostream>
#include <vector>
#include "LinkedList.hpp"

using namespace std;


int main(int argc, char ** argv){

    vector<int> ints(10);
    for(int i = 0; i < 10; i++){
        ints[i] = i;
    }
    
    
    LinkedList<int> list(ints);
    int * arrs = list.toArray();
    for(int i = 0; i < 10; i++){
        cout << arrs[i] << endl;
    }
    
    cout << "Custom index: " << arrs[atoi(argv[1])] << endl;
    //delete arrs;
    cout << list << endl;
    return 0;

}

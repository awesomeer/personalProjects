#include <iostream>
#include <fstream>
#include <string>
#include <vector>

#include <algorithm>

#include "../inc/Stock.hpp"


using namespace std;

int main(int argc, char** argv){

    if(argc < 2){
        cout << "Enter File name argument" << endl;
        exit(-1);
    }

    vector<Stock> stocks;
    ifstream file;
    file.open(argv[1], ios::in);
    if(!file.is_open()){
        cout << "Error opening file" << endl;
        exit(-2);
    }
    
    string s;
    getline(file, s);
    while(getline(file, s)){
        stocks.push_back(Stock(s));
    }
    cout << stocks.size() << " stocks read in" << endl;

    std::sort(stocks.begin(), stocks.end(), Stock::sortPerChange);
    for(Stock s : stocks){
        if(s.perChange > 4 && s.perChange < 6)
            cout << s.symbol << " " << s.sale << " " << s.perChange << endl;
    }

    return 0;
}
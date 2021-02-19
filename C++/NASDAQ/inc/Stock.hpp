#pragma once

#include <string>
#include <iostream>


class Stock{

    public:
        std::string symbol;
        std::string name;
        double sale;
        double netChange;
        double perChange;
        unsigned int marketCap;
        std::string country;
        unsigned int IPO;
        unsigned int volume;
        std::string sector;
        std::string industry;

    public:
        Stock();
        Stock(std::string line);

        friend std::ostream& operator <<(std::ostream& os, const Stock& s);
        bool operator < (const Stock& s);


        //Comparsion static functions for std::sort
        static bool sortSale(const Stock& lhs, const Stock& rhs);
        static bool sortVolume(const Stock& lhs, const Stock& rhs);
        static bool sortPerChange(const Stock& lhs, const Stock& rhs);
};




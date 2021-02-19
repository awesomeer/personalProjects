#include "../inc/Stock.hpp"

#include <cstring>
#include <sstream>


char* strtok(char * in){
    static char * str;
    if(in != NULL){
        str = in;
    }

    if(*str == '\0')
        return NULL;

    char * ret = str;
    while(*str != ',' && *str){
        str++;
    }
    *str = '\0';
    str++;

    return ret;
}


Stock::Stock(std::string s){

    char * str = new char[s.length()+1];
    strcpy(str, s.c_str());

    //Symbol
    char * token = strtok(str);
    if(token != NULL){
        this->symbol = token;
    }

    //Name
    token = strtok(NULL);
    if(token != NULL){
        this->name = token;
    }

    //Sale
    token = strtok(NULL);
    token[0] = '+';
    if(token != NULL){
        this->sale = atof(token);
    }

    //netChange
    token = strtok(NULL);
    if(token != NULL){
        this->netChange = atof(token);
    }

    //perChange
    token = strtok(NULL);
    token[strlen(token)] = '\0';
    if(token != NULL){
        this->perChange = atof(token);
    }

    //marketCap
    token = strtok(NULL);
    if(token != NULL){
        this->marketCap = atoi(token);
    }

    //Country
    token = strtok(NULL);
    if(token != NULL){
        this->country = token;
    }

    //IPO
    token = strtok(NULL);
    if(token != NULL){
        this->IPO = atoi(token);
    }

    //Volume
    token = strtok(NULL);
    if(token != NULL){
        this->volume = atoi(token);
    }

    //sector
    token = strtok(NULL);
    if(token != NULL){
        this->sector = token;
    }

    //industry
    token = strtok(NULL);
    if(token != NULL){
        this->industry = token;
    }
}

std::ostream& operator<<(std::ostream& os, const Stock& s){
    os << s.symbol << " $" << s.sale;
    return os;
}

bool Stock::operator < (const Stock& s){
    return this->name < s.name;
}





//Comparsion functions
bool Stock::sortSale(const Stock& lhs, const Stock& rhs){
    return lhs.sale < rhs.sale;
}

bool Stock::sortVolume(const Stock& lhs, const Stock& rhs){
    if(lhs.volume == 0)
        return false;
    if(rhs.volume == 0)
        return true;
    return lhs.volume < rhs.volume;
}

bool Stock::sortPerChange(const Stock& lhs, const Stock& rhs){
    return lhs.perChange < rhs.perChange;
}
#include "spi.h"
#include "ir.h"
#include "slave.h"

#define SEND(x) sendData(x); break;
void slaveInit(){
    spiInit();
    enableIR();
}

void check(){
    if(newData()){
        switch(getData()){
            case 0xA35C:{
                SEND(0x00);
            }
            case 0xA25D:{
                SEND(0x01);
            }
            case 0xBE41:{
                SEND(0x02);
            }
            case 0xBF40:{
                SEND(0x03);
            }
        }
    }
}
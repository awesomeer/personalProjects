/* 
 * File:   main.c
 * Author: mithilesh
 *
 * Created on March 14, 2020, 10:57 PM
 */

#include <avr/io.h>
#include <stdio.h>
#include <stdlib.h>
#include "IR.h"
#include "LED.h"

/*
 * 
 */
int main(int argc, char** argv) {
    LEDInit();
    IRInit();
    uint16_t code;
    while(1){
        if(!getData(&code)){
            changeLed(code);
        }
    }
    return (EXIT_SUCCESS);
}

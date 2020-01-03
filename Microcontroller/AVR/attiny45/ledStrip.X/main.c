/* 
 * File:   main.c
 * Author: mithi
 *
 * Created on January 1, 2020, 1:02 AM
 */

#include <stdio.h>
#include <stdlib.h>


#include "led.h"
#include "ir.h"

/*
 * 
 *
*/

int main() {
    enableIR();
    ledInit();
    while(1){
        if(newData()){
            changeColor(getData());
        }
    }
    return (EXIT_SUCCESS);
}


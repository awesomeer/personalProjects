/* 
 * File:   main.c
 * Author: mithi
 *
 * Created on January 2, 2020, 3:21 PM
 */

#include <stdio.h>
#include <stdlib.h>

/*
 * 
 */
#include "slave.h"
int main(){
    slaveInit();
    while(1){
        check();
    }
    return (EXIT_SUCCESS);
}


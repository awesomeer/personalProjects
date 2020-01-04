#include "spi.h"
#include "led.h"
#include "ir.h"
#include <stdint.h>
#include <string.h>
#include <avr/interrupt.h>
#include <math.h>
#include <stdlib.h>
#include <stdbool.h>

#define TOIE1OFF TIMSK &= (unsigned char)~_BV(TOIE1);
#define step 2.0*3.14159265/512.0
#define one 2.0*3.14159265/3
#define two 4.0*3.14159265/3

const unsigned char start[] = {0x00,0x00,0x00,0x00};
led solidColor = {0xFF, 0x00,0x00,0x00};
bool indi = false;

static void refresh(){
    sendData(start,4);
    sendData((const unsigned char *) leds, 124);
}

void ledInit(){
    spiInit();
    sendData(start, 4);
    for(int i = 0; i < SIZE; i++){
        leds[i].brightness = 0xFF;
        leds[i].red = 0xFF;
        leds[i].green = 0x00;
        leds[i].blue = 0x00;
        sendData((const unsigned char *) &leds[i], 4);
    }
    
    //TCCR1 |= 0xA;
}

void changeColor(){ //Color y,x
    if(getData() == 0xF30C){
        cli();
        static unsigned int count = 0;
        for(int i = 0; i < SIZE; i++){
            if(indi)
                leds[i].red = (((float)i)/((float)SIZE))*255.0;
            else
                leds[i].red = abs(255*cos(count*step));
            leds[i].green = abs(255*cos(count*step+one));
            leds[i].blue = abs(255*cos(count*step+two));
        }
        count = (count+1);
        refresh();
        sei();
    }
    
    if(newData()){
        switch(getData()){
            case 0xA35C:{ //Increase Brightness
                solidColor.brightness = (solidColor.brightness & 0x1F) + 1;
                solidColor.brightness |= 0xE0;
                break;
            }
            case 0xA25D:{ //Decrease Brightness
                solidColor.brightness = (solidColor.brightness & 0x1F) - 1;
                solidColor.brightness |= 0xE0;
                break;
            }
            case 0xAB54:{ //Salmon  1,0
                solidColor.red = 250;
                solidColor.green = 128;
                solidColor.blue = 114;
                TOIE1OFF
                break;
            }
            case 0xAF50:{ //Dark Orange 2,0
                solidColor.red = 255;
                solidColor.green = 140;
                solidColor.blue = 0;
                TOIE1OFF
                break;
            }
            case 0xE31C:{ //Orange 3,0
                solidColor.red = 255;
                solidColor.green = 165;
                solidColor.blue = 0;
                TOIE1OFF
                break;
            }
    //        case 0xE718:{ //Yellow 4,0
    //            solidColor.red = 0xFF;
    //            solidColor.green = 0xFF;
    //            solidColor.blue = 0x00;
    //            TOIE1OFF
    //            break;
    //        }
            case 0xE41B:{} //Light blue 4,4 4,3
            case 0xE01F:{
                solidColor.red = 0x00;
                solidColor.green = 0xFF;
                solidColor.blue = 0xFF;
                TOIE1OFF
                break;
            }
            case 0xA758:{ //Pure Red 0,0
                solidColor.red = 0xFF;
                solidColor.green = 0x00;
                solidColor.blue = 0x00;
                TOIE1OFF
                break;
            }
            case 0xA659:{ //Pure Green 0,1
                solidColor.red = 0x00;
                solidColor.green = 0xFF;
                solidColor.blue = 0x00;
                TOIE1OFF
                break;
            }
            case 0xBA45:{ //Pure Blue 0,2
                solidColor.red = 0x00;
                solidColor.green = 0x00;
                solidColor.blue = 0xFF;
                TOIE1OFF
                break;
            }
            case 0xBB44:{ //Pure White 0,3
                solidColor.red = 0xFF;
                solidColor.green = 0xFF;
                solidColor.blue = 0xFF;
                TOIE1OFF
                break;
            }
            case 0xB748:{} //Pink 1,3 2,3
            case 0xB34C:{
                solidColor.red = 0xFF;
                solidColor.green = 0x00;
                solidColor.blue = 0xFF;
                TOIE1OFF;
                break;
            }
            case 0xEB14:{ //Increase Red
                solidColor.red += 16 - (solidColor.red % 16);
                break;
            }
            case 0xEF10:{ //Decrease Red
                solidColor.red -= 16 - (solidColor.red % 16);
                break;
            }
            case 0xEA15:{ //Increase Green
                solidColor.green += 16 - (solidColor.green % 16);
                break;
            }
            case 0xEE11:{ //Decrease Green
                solidColor.green -= 16 - (solidColor.green % 16);
                break;
            }
            case 0xE916:{ //Increase Blue
                solidColor.blue += 16 - (solidColor.blue % 16);
                break;
            }
            case 0xED12:{ //Decrease Blue
                solidColor.blue -= 16 - (solidColor.blue % 16);
                break;
            }
            case 0xF30C:{
                TIMSK |= _BV(TOIE1);
                indi = !indi;
                return;
            }
        }
        for(int i = 0; i < SIZE; i++){
            memcpy((void *) &leds[i], (void *) &solidColor, 4);
        }
        refresh();
    }
}



//ISR(TIMER1_OVF_vect, ISR_NOBLOCK){
//    static unsigned char count = 0;
//    for(int i = 0; i < SIZE; i++){
//        if(indi)
//            leds[i].red = (((float)i)/((float)SIZE))*255.0;
//        else
//            leds[i].red = abs(255*cos(count*step));
//        leds[i].green = abs(255*cos(count*step+one));
//        leds[i].blue = abs(255*cos(count*step+two));
//    }
//    count = (count+1);
//    refresh();
//}
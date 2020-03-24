#include "LED.h"
#include <avr/pgmspace.h> 
#include <stdlib.h>

#define SIZE 30
#define BRIGHT led[0]
#define LED PB4

const uint8_t start[] = {0x00, 0x00, 0x00, 0x00};
const uint8_t end[] = {0xFF, 0xFF, 0xFF, 0xFF};
led_t solidColor = {0xFF, 0x00, 0x00, 0xFF};
led_t leds[SIZE];

uint8_t fade;

static void refresh(){
    SPIoutArray((uint8_t *) start, 4);
    for(int i = 0; i < SIZE; i++){
        SPIoutArray((uint8_t *) &leds[i], 4);
    }
    SPIoutArray((uint8_t *) end, 4);
}

static void refreshSolid(){
    SPIoutArray((uint8_t *) start, 4);
    for(int i = 0; i < SIZE; i++){
        SPIoutArray((uint8_t *) &solidColor, 4);
    }
    SPIoutArray((uint8_t *) end, 4);
}

void LEDInit(){
    DDRB |= _BV(PB4);
    SPIInit();
    for(int i = 0; i < SIZE; i++){
        memcpy((void *) &leds[i], (void *) &solidColor, 4);
    }
    refresh();
    
    fade = 0;
    TCNT0 = 0;
    TCCR0B |= 0b100;
    TIMSK |= _BV(TOIE0);
}
    
void changeLed(uint16_t code){
    PORTB ^= _BV(LED);
    
        
    if(code == 0xB748){
        fade ^= 0xFF;
        return;
    }
    
    switch(code){
        case 0xA35C:{ //Increase Brightness
            solidColor.bright = (solidColor.bright & 0x1F) + 1;
            solidColor.bright |= 0xE0;
            break;
        }
        case 0xA25D:{ //Decrease Brightness
            solidColor.bright = (solidColor.bright & 0x1F) - 1;
            solidColor.bright |= 0xE0;
            break;
        }
        case 0xAB54:{ //Salmon  1,0
            solidColor.red = 250;
            solidColor.green = 128;
            solidColor.blue = 114;
            break;
        }
        case 0xAF50:{ //Dark Orange 2,0
            solidColor.red = 255;
            solidColor.green = 140;
            solidColor.blue = 0;
            break;
        }
        case 0xE31C:{ //Orange 3,0
            solidColor.red = 255;
            solidColor.green = 165;
            solidColor.blue = 0;
            break;
        }
        case 0xE718:{ //Yellow 4,0
            solidColor.red = 0xFF;
            solidColor.green = 0xFF;
            solidColor.blue = 0x00;
            break;
        }
        case 0xE41B:{} //Light blue 4,4 4,3
        case 0xE01F:{
            solidColor.red = 0x00;
            solidColor.green = 0xFF;
            solidColor.blue = 0xFF;
            break;
        }
        case 0xA758:{ //Pure Red 0,0
            solidColor.red = 0xFF;
            solidColor.green = 0x00;
            solidColor.blue = 0x00;
            break;
        }
        case 0xA659:{ //Pure Green 0,1
            solidColor.red = 0x00;
            solidColor.green = 0xFF;
            solidColor.blue = 0x00;
            break;
        }
        case 0xBA45:{ //Pure Blue 0,2
            solidColor.red = 0x00;
            solidColor.green = 0x00;
            solidColor.blue = 0xFF;
            break;
        }
        case 0xBB44:{ //Pure White 0,3
            solidColor.red = 0xFF;
            solidColor.green = 0xFF;
            solidColor.blue = 0xFF;
            break;
        }
        case 0xB748:{} //Pink 1,3 2,3
        case 0xB34C:{
            solidColor.red = 0xFF;
            solidColor.green = 0x00;
            solidColor.blue = 0xFF;
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

        }
    }
    refreshSolid();

}

const uint8_t red[] PROGMEM  = {255, 254, 254, 254, 254, 254, 253, 253, 252, 251, 251, 250, 249, 248, 247, 246, 245, 244, 242, 241, 239, 238, 236, 235, 233, 231, 229, 228, 226, 224, 221, 219, 217, 215, 213, 210, 208, 205, 203, 200, 198, 195, 193, 190, 187, 184, 182, 179, 176, 173, 170, 167, 164, 161, 158, 155, 152, 149, 146, 143, 139, 136, 133, 130, 127, 124, 121, 118, 115, 111, 108, 105, 102, 99, 96, 93, 90, 87, 84, 81, 78, 75, 72, 70, 67, 64, 61, 59, 56, 54, 51, 49, 46, 44, 41, 39, 37, 35, 33, 30, 28, 26, 25, 23,
                        21, 19, 18, 16, 15, 13, 12, 10, 9, 8, 7, 6, 5, 4, 3, 3, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 3, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 15, 16, 18, 19, 21,
                        23, 25, 26, 28, 30, 33, 35, 37, 39, 41, 44, 46, 49, 51, 54, 56, 59, 61, 64, 67, 70, 72, 75, 78, 81, 84, 87, 90, 93, 96, 99, 102, 105, 108, 111, 115, 118, 121, 124, 127, 130, 133, 136, 139, 143, 146, 149, 152, 155, 158, 161, 164, 167, 170, 173, 176, 179, 182, 184, 187, 190, 193, 195, 198, 200, 203, 205, 208, 210, 213, 215, 217, 219, 221, 224, 226, 228, 229, 231, 233, 235, 236, 238, 239, 241, 242, 244, 245, 246, 247, 248, 249, 250, 251, 251, 252, 253, 253, 254, 254, 254, 254, 254};

const uint8_t green[] PROGMEM = {63, 61, 58, 55, 53, 50, 48, 45, 43, 41, 38, 36, 34, 32, 30, 28, 26, 24, 22, 20, 19, 17, 16, 14, 13, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 4, 4, 5, 6, 7, 8, 10, 11, 12, 14, 15, 17, 18, 20, 22, 23, 25, 27, 29, 31, 33, 35, 38, 40, 42, 45, 47, 49, 52, 54, 57, 60, 62, 65, 68, 71, 73, 76, 79, 82, 85, 88, 91, 94, 97, 100, 103, 106, 109, 112, 116, 119, 122, 125, 128, 131, 134, 137, 141, 144, 147, 150, 153, 156, 159, 162, 165, 168, 171, 174, 
                            177, 180, 182, 185, 188, 191, 193, 196, 199, 201, 204, 206, 209, 211, 213, 216, 218, 220, 222, 224, 226, 228, 230, 232, 234, 235, 237, 238, 240, 241, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 252, 253, 253, 254, 254, 254, 254, 254, 254, 254, 254, 254, 254, 253, 253, 252, 252, 251, 250, 250, 249, 248, 247, 246, 244, 243,
                            242, 240, 239, 237, 236, 234, 232, 231, 229, 227, 225, 223, 221, 219, 216, 214, 212, 209, 207, 205, 202, 200, 197, 194, 192, 189, 186, 183, 181, 178, 175, 172, 169, 166, 163, 160, 157, 154, 151, 148, 145, 142, 138, 135, 132, 129, 126, 123, 120, 117, 113, 110, 107, 104, 101, 98, 95, 92, 89, 86, 83, 80, 77, 74, 72, 69, 66};

const uint8_t blue[] PROGMEM = {63, 66, 69, 72, 74, 77, 80, 83, 86, 89, 92, 95, 98, 101, 104, 107, 110, 113, 117, 120, 123, 126, 129, 132, 135, 138, 142, 145, 148, 151, 154, 157, 160, 163, 166, 169, 172, 175, 178, 181, 183, 186, 189, 192, 194, 197, 200, 202, 205, 207, 209, 212, 214, 216, 219, 221, 223, 225, 227, 229, 231, 232, 234, 236, 237, 239, 240, 242, 243, 244, 246, 247, 248, 249, 250, 250, 251, 252, 252, 253, 253, 254, 254, 254, 254, 254, 254, 254, 254, 254, 254, 253, 253, 252, 252, 251, 250, 249, 248, 247, 246, 245, 244, 243, 241, 240, 238, 237, 235, 234, 232, 230, 228, 226, 224, 222, 220, 218, 216, 213, 211, 209, 206, 204, 201, 199, 196, 193, 191, 188, 185, 182, 180,
177, 174, 171, 168, 165, 162, 159, 156, 153, 150, 147, 144, 141, 137, 134, 131, 128, 125, 122, 119, 116, 112, 109, 106, 103, 100, 97, 94, 91, 88, 85, 82, 79, 76, 73, 71, 68, 65, 62, 60, 57, 54, 52, 49, 47, 45, 42, 40, 38, 35, 33, 31, 29, 27, 25, 23, 22, 20, 18, 17, 15, 14, 12, 11, 10, 8, 7, 6, 5, 4, 4, 3, 2, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 16, 17, 19, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 41, 43, 45, 48, 50, 53, 55, 58, 61};

ISR(TIMER0_OVF_vect, ISR_NOBLOCK){
    if(fade){
        static uint8_t fadeCount = 0;
        for(int i = 0; i < SIZE; i++){
            leds[i].red = pgm_read_byte_near(&red[fadeCount]) >> 1;
            leds[i].green = pgm_read_byte_near(&green[fadeCount]) >> 1;
            leds[i].blue = pgm_read_byte_near(&blue[fadeCount]) >> 1;
        }
        refresh();
        fadeCount++;
    }
}
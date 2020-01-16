#include "FlipNote.hpp"

using namespace std;


FlipNote::FlipNote(){

}

FlipNote::FlipNote(string fileName){

}

#define put(x,r,g,b) data[x] = r; data[x+3072] = g; data[x+6144] = b;
                

CImg<unsigned char> FlipNote::getPrevew(string fileName){
    CImg<unsigned char> frame(64,48, 1, 3, 0);
    unsigned char * data = frame.data();
    ifstream file(fileName, ios::binary | ios::in);
	
	CImgDisplay dis(frame, "test");

    for(int i = 0; i < 0xA0; i++){
        unsigned char temp;
        file >> temp;
        cout << temp;
    }
	
	for(int y = 0; y < 6; y++){
		for(int x = 0; x < 8; x++){
			for(int iy = 0; iy < 8; iy++){
				for(int ix = 0; ix < 4; ix++){
					dis.display(frame);
					system("PAUSE");
					unsigned char pixel;
					file >> pixel;
					 
					int lloc[] = {(x*8)+(2*ix), (y*8)+iy};
					int oloc[] = {(x*8)+((2*ix)+1), (y*8)+iy};
					int lpixel = lloc[1]*64 + lloc[0];
					int opixel = oloc[1]*64 + oloc[0];
					
					cout << (y+1)*(x+1)*(iy+1)*(ix+1) << endl;
					switch(pixel & 0xF){
						case 0x0:
						case 0x2:{
							put(lpixel, 248,248,248)
							break;
						}
						case 0x1:{
							put(lpixel, 80,80,80);
							break;
						}
						case 0x3:{
							put(lpixel, 160,160,160);
							break;
						}
						case 0x4:{
							put(lpixel, 248,0,0);
							break;
						}
						case 0x5:{
							put(lpixel, 120,0,0);
							break;
						}
						case 0x6:{
							put(lpixel, 248, 120,120);
							break;
						}
						case 0x7:{
							put(lpixel, 0,248,0);
							break;
						}
						case 0x8:{
							put(lpixel, 0,0,248);
							break;
						}
						case 0x9:{
							put(lpixel, 0,0,120);
							break;
						}
						case 0xA:{
							put(lpixel, 120,120,248);
							break;
						}
						case 0xB:{
							put(lpixel, 0,248,0);
							break;
						}
						case 0xC:{
							put(lpixel, 248,0,248);
							break;
						}
						case 0xD:
						case 0xE:
						case 0xF:{
							put(lpixel, 0,248,0);
							break;
						}
					}

					switch((pixel >> 4) & 0xF){
						case 0x0:
						case 0x2:{
							put(opixel, 248,248,248)
							break;
						}
						case 0x1:{
							put(opixel, 80,80,80);
							break;
						}
						case 0x3:{
							put(opixel, 160,160,160);
							break;
						}
						case 0x4:{
							put(opixel, 248,0,0);
							break;
						}
						case 0x5:{
							put(opixel, 120,0,0);
							break;
						}
						case 0x6:{
							put(opixel, 248, 120,120);
							break;
						}
						case 0x7:{
							put(opixel, 0,248,0);
							break;
						}
						case 0x8:{
							put(opixel, 0,0,248);
							break;
						}
						case 0x9:{
							put(opixel, 0,0,120);
							break;
						}
						case 0xA:{
							put(opixel, 120,120,248);
							break;
						}
						case 0xB:{
							put(opixel, 0,248,0);
							break;
						}
						case 0xC:{
							put(opixel, 248,0,248);
							break;
						}
						case 0xD:
						case 0xE:
						case 0xF:{
							put(opixel, 0,248,0);
							break;
						}
					}
				}
			}
		}
	}
	
    /* for(int i = 0; i < 1536; i++){
        unsigned char pixel;
        file >> pixel;

        switch(pixel & 0xF){
            case 0x0:
            case 0x2:{
                put(2*i, 248,248,248)
                break;
            }
            case 0x1:{
                put(2*i, 80,80,80);
                break;
            }
            case 0x3:{
                put(2*i, 160,160,160);
                break;
            }
            case 0x4:{
                put(2*i, 248,0,0);
                break;
            }
            case 0x5:{
                put(2*i, 120,0,0);
                break;
            }
            case 0x6:{
                put(2*i, 248, 120,120);
                break;
            }
            case 0x7:{
                put(2*i, 0,248,0);
                break;
            }
            case 0x8:{
                put(2*i, 0,0,248);
                break;
            }
            case 0x9:{
                put(2*i, 0,0,120);
                break;
            }
            case 0xA:{
                put(2*i, 120,120,248);
                break;
            }
            case 0xB:{
                put(2*i, 0,248,0);
                break;
            }
            case 0xC:{
                put(2*i, 248,0,248);
                break;
            }
            case 0xD:
            case 0xE:
            case 0xF:{
                put(2*i, 0,248,0);
                break;
            }
        }

        switch((pixel >> 4) & 0xF){
            case 0x0:
            case 0x2:{
                put((2*i)+1, 248,248,248)
                break;
            }
            case 0x1:{
                put((2*i)+1, 80,80,80);
                break;
            }
            case 0x3:{
                put((2*i)+1, 160,160,160);
                break;
            }
            case 0x4:{
                put((2*i)+1, 248,0,0);
                break;
            }
            case 0x5:{
                put((2*i)+1, 120,0,0);
                break;
            }
            case 0x6:{
                put((2*i)+1, 248, 120,120);
                break;
            }
            case 0x7:{
                put((2*i)+1, 0,248,0);
                break;
            }
            case 0x8:{
                put((2*i)+1, 0,0,248);
                break;
            }
            case 0x9:{
                put((2*i)+1, 0,0,120);
                break;
            }
            case 0xA:{
                put((2*i)+1, 120,120,248);
                break;
            }
            case 0xB:{
                put((2*i)+1, 0,248,0);
                break;
            }
            case 0xC:{
                put((2*i)+1, 248,0,248);
                break;
            }
            case 0xD:
            case 0xE:
            case 0xF:{
                put((2*i)+1, 0,248,0);
                break;
            }
        }
    } */

    return frame;
}
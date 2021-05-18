
void main(){

    char * video = (char *) 0xb8000;
    char len = 0;
    for(int i = 0; i < 80; i++){
        video[2 * (i * 80)] = 0x30 + len;
        len = (len + 1) % 10;
    }

    len = 0;
    for(int i = 0; i < 100; i++){
        video[2 * i] = 0x30 + len;
        len = (len + 1) % 10;
    }

    while(1);
}
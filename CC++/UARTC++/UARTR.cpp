#include <windows.h>
#include <iostream>

#define SIZE 1024
using namespace std;

DCB dcb;
DWORD bytesRead;
DWORD commStatus;
HANDLE port;

bool openPort(char * com,int rate){
	port = CreateFile(com, GENERIC_READ, 0, NULL, OPEN_EXISTING, 0, NULL);
	if(!GetCommState(port, &dcb))
		return false;
	
	dcb.BaudRate = rate;
	dcb.ByteSize = 8;
	dcb.Parity = NOPARITY;
	dcb.StopBits = ONESTOPBIT;
	
	if(!SetCommState(port, &dcb))
		return false;
	
	return true;
}

bool readChar(unsigned char * pt){
	
	SetCommMask(port, EV_RXCHAR | EV_ERR);
	WaitCommEvent(port, &commStatus, 0);
	
	return ReadFile(port, pt, SIZE, &bytesRead, 0);
}

int main(int argc, char * argv[]){
	if(argc != 3){
		cout << "Incorrect number of arguments" << endl;
		exit(2);
	}
	if(!openPort(argv[1], atoi(argv[2]))){
		cout << argv[1] << " failed to open" << endl;
		exit(1);
	}
	
	unsigned char data[SIZE];
	while(true){
		if(readChar(data)){
			for(int i = 0; i < bytesRead; i++){
				cout << data[i];
			}
		}
	}
	CloseHandle(port);
	return 0;
}
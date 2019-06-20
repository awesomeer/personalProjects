#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>


int main(){
	int x = fork();
	if(fork() != 0)
		printf("x = %d\n", ++x);
	
	printf("x = %d\n", --x);
	
	return 0;
}
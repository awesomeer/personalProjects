#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void child(){
	printf("Child\n");
}

void parent(){
	printf("Parent\n");
}

int main(){
	int x = 3;
	if(fork() == 0){
		child();
		printf("pid = %d\n", getpid());
	}
	
	printf("pid = %d\n", getpid());
	
	return 0;
}

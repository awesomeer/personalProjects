#pragma once


#include <stdint.h>


class OS{
		
	
	public:
		class Semaphore{
			private:
				int32_t value;
			public:
				Semaphore();
				Semaphore(int32_t val);
				Semaphore(bool val);
				
				int8_t acquire();
				int8_t release();
		};
		
		typedef struct tcb{
			struct tcb * next;
			uint32_t * sp;
			Semaphore * lock;
			uint32_t sleep;
			uint8_t priority;
			uint8_t id[16];
			uint32_t stack[256];
		} tcb_t;
		
		
		static void init();
		static int8_t addThread(const uint8_t * id, void (*func)(void), uint8_t priority);
		static void sleep(uint32_t ms);
		static void kill();
		static void launch();
		
	private:
		static tcb_t * runPt;
		static tcb_t * ready;
		static tcb_t * sleeping;
		static tcb_t * blocked;

};

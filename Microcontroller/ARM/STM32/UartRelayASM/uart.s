
	
	AREA |.text|, CODE, READONLY, ALIGN=2
	THUMB

HSTR	DCB "Hello\n",0


	EXTERN HFifo
	EXTERN DFifo
	EXTERN SystemCoreClock
	
	IMPORT fifoInit
	IMPORT fifoGet
	IMPORT fifoPut
		
	IMPORT SystemCoreClockUpdate
	EXPORT rmain
	EXPORT USART1_IRQHandler
	EXPORT USART2_IRQHandler
		
PWR		EQU	0x40007000
RCC		EQU	0x40021000
GPIOA	EQU	0x48000000
HUART	EQU 0x40004400 ;USART2
HSPEED	EQU 115200
DUART	EQU 0x40013800 ;USART1
DSPEED	EQU 74880


USART1_IRQHandler
	
	LDR R0, =DFifo
	LDR R2, =DUART
	LDRB R1, [R2, #0x24]
	
	PUSH {R0-R3, R12, LR}
	
	BL fifoPut
	MOV R0, #(0x1 << 3)
	LDR R2, =DUART
	STR R0, [R2, #0x20]
	
	POP {R0-R3, R12, PC}
	
USART2_IRQHandler

	LDR R0, =HFifo
	LDR R2, =HUART
	LDRB R1, [R2, #0x24]
	
	PUSH {R0-R3, R12, LR}
	
	BL fifoPut
	MOV R0, #(0x1 << 3)
	LDR R2, =HUART
	STR R0, [R2, #0x20]
	
	POP {R0-R3, R12, PC}

setClock32MHz
	LDR R0, =PWR
	LDR R1, [R0]
	ORR R1, R1, #0x100
	STR R1, [R0]
	
	
	LDR R0, =RCC
	LDR R1, [R0]
	ORR R1, R1, #0x8
	STR R1, [R0]
	
	LDR R1, [R0]
	BIC R1, R1, #0xF0
	ORR R1, R1, #0xA0
	STR R1, [R0]
	
	BX LR


GPIOAInit
	LDR R0, =RCC
	LDR R1, [R0, #0x4C]
	ORR R1, R1, #0x1
	STR R1, [R0, #0x4C]
	
	LDR R0, =GPIOA
	LDR R1, [R0]
	LDR R2, =0xC03C0030
	BIC R1, R1, R2
	LDR R3, =0x80280020
	ORR R1, R1, R3
	STR R1, [R0]
	
	LDR R1, [R0, #0xC]
	BIC R1, R1, R2
	ORR R1, R1, R3
	STR R1, [R0, #0xC]
	
	LDR R1, [R0, #0x20]
	ORR R1, R1, #0x700
	STR R1, [R0, #0x20]
	LDR R1, [R0, #0x24]
	LDR R2, =0x30000770
	ORR R1, R1, R2
	STR R1, [R0, #0x24]
	
	BX LR

 
HUartInit

	LDR R0, =RCC
	LDR R1, [R0, #0x88]
	ORR R1, R1, #0x4
	STR R1, [R0, #0x88]
	
	LDR R1, [R0, #0x58]
	ORR R1, R1, #(0x1 << 17)
	STR R1, [R0, #0x58]
	
	LDR R0, =HUART
	LDR R1, [R0]
	ORR R1, R1, #0xC
	STR R1, [R0]
	
	LDR R2, =SystemCoreClock
	LDR R2, [R2]
	LDR R3, =HSPEED
	UDIV R1, R2, R3
	STR R1, [R0, #0xC]
	
	LDR R1, [R0]
	ORR R1, R1, #0x21
	STR R1, [R0]
	
	
	BX LR


DUartInit
	
	LDR R0, =RCC
	LDR R1, [R0, #0x88]
	BIC R1, R1, #0x3
	ORR R1, R1, #0x1
	STR R1, [R0, #0x88]
	
	LDR R1, [R0, #0x60]
	ORR R1, R1, #(0x1 << 14)
	STR R1, [R0, #0x60]

	LDR R0, =DUART
	LDR R1, [R0]
	ORR R1, R1, #0xC
	STR R1, [R0]
	
	LDR R2, =SystemCoreClock
	LDR R2, [R2]
	LDR R3, =DSPEED
	UDIV R1, R2, R3
	STR R1, [R0, #0xC]
	
	LDR R1, [R0]
	ORR R1, R1, #0x21
	STR R1, [R0]
	
	
	BX LR

rmain
	
	PUSH {R0-R3, R12, LR}
	BL setClock32MHz
	BL SystemCoreClockUpdate
	
	LDR R0, =HFifo
	BL fifoInit
	
	LDR R0, =DFifo
	BL fifoInit
	
	BL GPIOAInit
	BL HUartInit
	BL DUartInit
	
	

	SUB SP, SP, #8
	
LOOP

	LDR R0, =HUART
	LDR R2, [R0, #0x1C]
	AND R2, R2, #0xC0
	SUBS R2, R2, #0xC0
	BNE HostToDevice
	
	LDR R0, =DFifo
	MOV R1, SP
	BL fifoGet
	CMP R0, #0
	BNE HostToDevice
	
	LDRB R1, [SP]
	LDR R0, =HUART
	STRB R1, [R0, #0x28]
	
HostToDevice

	LDR R0, =DUART
	LDR R2, [R0, #0x1C]
	AND R2, R2, #0xC0
	SUBS R2, R2, #0xC0
	BNE LOOP
	
	LDR R0, =HFifo
	ADD R1, SP, #4
	BL fifoGet
	CMP R0, #0
	BNE LOOP
	
	LDRB R1, [SP, #4]
	LDR R0, =DUART
	STRB R1, [R0, #0x28]
	B LOOP
	
	
	MOV R0, #0
	ADD SP, SP, #8
	POP {R0-R3, R12, PC}
	
	END
		
		
		
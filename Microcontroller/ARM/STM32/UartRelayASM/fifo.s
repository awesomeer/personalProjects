


	AREA |.text|, CODE, READONLY, ALIGN=2
	THUMB
		
		
	EXPORT fifoInit
	EXPORT fifoGet
	EXPORT fifoPut
		
fifoInit
	MOV R1, #0
	STRH R1, [R0]
	STRH R1, [R0, #2]
	BX LR
	
fifoGet
	
	LDRH R2, [R0]
	LDRH R3, [R0, #2]
	CMP R2, R3
	BNE GET1
	MOV R0, #0
	BX LR

GET1
	ADD R0, R0, #4
	LDRB R3, [R0, R2]
	STRB R3, [R1]
	ADD R2, R2, #1
	MOV R3, #0x3FF
	AND R2, R2, R3
	STRH R2, [R0, #-4]
	
	MOV R0, #0
	
	BX LR

fifoPut

	PUSH {R4-R8}
	
	LDRH R2, [R0]
	LDRH R3, [R0, #2]
	
	MOV R4, #0x3FF
	ADD R3, R3, #1
	AND R3, R3, R4
	
	CMP R2, R3
	BNE PUT1
	MOV R0, #0
	POP {R4-R8}
	BX LR
	
	
PUT1
	LDR R2, [R0, #2]
	ADD R0, R0, #4
	STRB R1, [R0, R2]
	STRH R3, [R0, #-2]
	
	POP {R4-R8}
	BX LR
	
	END
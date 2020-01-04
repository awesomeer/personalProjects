    #define PIN3 3
    #define PIN 4
    #define PORTB 0x16
    #define GIFR 0x3A
    .extern data
    .extern prev
    .extern buffer
    
    .global inter
    
    
inter:
    PUSH R27
    PUSH R26
    PUSH R25
    PUSH R24
    PUSH R23
    PUSH R22
    PUSH R21
    PUSH R20
    ;PORTB |= _BV(PIN3);
    SBI PORTB, PIN3
    
    ;if(ON){
    ;    goto exit;
    ;}
    SBIC PORTB, PIN
    RJMP exit
    
    ;data = 0 data: 25:24:23:22
    LDI R26, lo8(data)
    LDI R27, hi8(data)
    
    CLR R22
    CLR R23
    CLR R24
    CLR R25
    
    ;while(OFF);
firstOff:
    SBIS PORTB, PIN
    RJMP firstOff
    
    ;ticks = 0 ticks is R21
    CLR R21
    
firstOn:
    SBIS PORTB, PIN
    RJMP forLoop
    RJMP firstOn
    
    
forLoop:
    ;index is R20
    CLR R20
    
loop:
    LSR R25
    ROR R24
    ROR R23
    ROR R22
secOff:
    SBIS PORTB, PIN
    RJMP secOff

    RCALL delay
    
    SBIS PORTB, PIN
    RJMP CON
    SBR R25, 0x80
    
CON:
    CLR R21
secOn:
    SBIS PORTB, PIN
    RJMP loop
    NOP
    NOP
    NOP
    NOP
    INC R21
    BREQ exit
    RJMP secOn
    
    INC R20
    CPI R20, 0x20
    BRNE loop
    
    RCALL delay
    
    LSL R22
    ROL R23
    ROL R24
    ROL R25
    
    ST X+, R22
    ST X+, R23
    ST X+, R24
    ST X+, R25
    
    LDI R26, lo8(prev)
    LDI R27, hi8(prev)
    
    ST X+, R22
    ST X+, R23
    ST X+, R24
    ST X+, R25
    
exit:
    ;SBI GIFR, 0x05
    CBI PORTB, PIN3
    POP R27
    POP R26
    POP R25
    POP R24
    POP R23
    POP R22
    POP R21
    POP R20
    ret

.global delay
delay:
    PUSH R25
    LDI R25, 0
delayLoop:
    INC R25
    BRNE delayLoop
    POP R25
    ret
    
    
.global delay
delay:
    PUSH R25
    LDI R25, 0
delayLoop:
    INC R25
    BRNE delayLoop
    POP R25
    ret



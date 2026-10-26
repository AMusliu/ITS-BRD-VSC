;******************** (C) COPYRIGHT HAW-Hamburg ********************************
;* File Name          : main.s
;* Author             : Martin Becke    
;* Version            : V1.0
;* Date               : 01.06.2021
;* Description        : This is a simple main to demonstrate data transfer
;                     : and manipulation.
;                     : 
;
;*******************************************************************************
    EXTERN initITSboard ; Helper to organize the setup of the board

    EXPORT main         ; we need this for the linker - In this context it set the entry point,too

ConstByteA  EQU 0xaffe
    
;* We need some data to work on
    AREA DATA, DATA, align=2    
VariableA   DCW 0xbeef
VariableB   DCW 0x1234
VariableC	DCW 0x00

;* We need minimal memory setup of InRootSection placed in Code Section 
    AREA  |.text|, CODE, READONLY, ALIGN = 3    
    ALIGN   
main
    BL initITSboard             ; needed by the board to setup
;* swap memory - Is there another, at least optimized approach?
    ldr     R0,=VariableA   ; Anw01
    ldrb    R2,[R0]         ; Anw02
    ldrb    R3,[R0,#1]      ; Anw03
    lsl     R2, #8          ; Anw04
    orr     R2, R3          ; Anw05
    strh    R2,[R0]         ; Anw06 
    
;* const in var
	ldr		R0,=VariableC	; R0 receives new address
    mov     R5,#ConstByteA  ; Anw07
    strh    R5,[R0]         ; Anw08
	ldrb	R5,[R0]			; First Byte at R0 loaded into R5
	ldrb	R4,[R0,#1]		; Byte at R0+1 loaded into R4
	lsl		R5, #8			; R5 moved by 1 Byte to the left
	orr		R5, R4			; Combines Bytes of R5 and R4
	strh	R5, [R0]		; "feaf" stored at R0 as "affe" due to Little Endian Method
    
;* Change value from x1234 to x3412
    ldr     R1,=VariableB   ; Anw09
    ldrh    R6,[R1]         ; Anw0A
    mov     R7, #0x21DE     ; Anw0B: Load 0x21DE into R7 instead
    add     R6, R6, R7      ; Anw0C: R6(0x1234) + R7(0x21DE) = 0x3412
    strh    R6,[R1]         ; Anw0D: 0x3412 stored at address of R1 in Little Endian Method
    b .                     ; Anw0E
    
    ALIGN
    END
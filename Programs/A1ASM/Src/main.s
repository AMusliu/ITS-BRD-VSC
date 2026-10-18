;******************** (C) COPYRIGHT HAW-Hamburg ********************************
;* File Name          : main.s
;* Author             : Martin Becke
;* Version            : V1.0
;* Date               : 01.06.2021
;* Description        : This is a simple main to switch on two LEDs (D08, D09)
;                     :
;                     :
;
;*******************************************************************************
    EXTERN initITSboard ; Helper to organize the setup of the board

    EXPORT main         ; we need this for the linker
                        ;- In this context it set the entry point,too

; setup the peripherie - Mapping the GPIO
PERIPH_BASE         equ 0x40000000
AHB1PERIPH_BASE     equ (PERIPH_BASE + 0x00020000)
GPIOD_BASE          equ (AHB1PERIPH_BASE + 0x0C00)
    
GPIO_D_SET          equ (GPIOD_BASE + 0x18)
GPIO_D_CLR          equ (GPIOD_BASE + 0x1A)
    

;* We need minimal memory setup of InRootSection placed in Code Section
    AREA  |.text|, CODE, READONLY, ALIGN = 3
    ALIGN
main
    BL initITSboard             ; needed by the board to setup
    nop                         ; no operation
    LDR     R6, =GPIO_D_SET     ; get address of the GPIO data set register
    ;LDR     R7, =GPIO_D_CLR    ; get address of the GPIO data clear register, no need as script meant to switch on LEDs
    MOV     R0, #0x03           ; load mask 0b00000011 (D08 and D09)
    ;MOV     R1, #0x02          ; load mask 0b0010, combined in R0
    ;MOV     R2, #0x40          ; load mask 0b01000000, unnecessary as remains off
    ;MOV     R3, #0x80          ; load mask 0b10000000, unnecessary as remains off

    ; Set LED
    ;STRB    R2, [R6]    ; switch on LED D14, unnecessary due to new arrangements
    ;STRB    R3, [R6]    ; switch on LED D15, unnecessary due to new arrangements
    ;STRB    R0, [R6]    ; switch on LED D08, unnecessary due to new arrangements
    ;STRB    R0, [R7]    ; switch off LED D08, unnecessary due to new arrangements
    STRB    R0, [R6]     ; switch on LEDs D08, D09
    ;STRB    R1, [R6]    ; switch on LED D09, unnecessary due to new arrangements
    ;STRB    R2, [R7]    ; switch off LED D14, unnecessary due to new arrangements
    ;STRB    R3, [R7]    ; switch off LED D15, unnecessary due to new arrangements
    b .

	; ==========================================================================
	; Dokumentation der Schwierigkeiten:
	; 1. Verständnis Hex und Binär in diesem Zusammenhang
	; 2. Von mir auskommentierte Zeilen wurden zunächst weiter ausgeführt
	;    Lösung: Neuen Code speichern, builden und daraufhin debuggen.
    
    ALIGN
    END
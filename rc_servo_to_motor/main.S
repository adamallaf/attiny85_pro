    .file "main.S"
.nolist
.include "../tn85def.inc"
.list

    .text
.global main

main:
        nop                             ; 1 cycle delay
        in      r24, SREG
        cli                             ; disable interrupts
        outi    CLKPR, 0x80             ; set clock prescaler
        out     CLKPR, __ZERO_REG__     ; to div1
        out     SREG, r24
        in      r24, MCUSR              ; *
        andi    r24, 0xf7               ; *
        out     MCUSR, r24              ; *
        in      r24, WDTCR              ; * disable watchdog timer
        ori     r24, 0x18               ; *
        out     WDTCR, r24              ; *
        out     WDTCR, __ZERO_REG__     ; *
        /* Timer 0 */
        in      r16, TIMSK
        ldi     r24, OCIE0A
        eor     r16, r24
        out     TIMSK, r16
        outi    TCCR0A, COM0B0|WGM01
        outi    TCCR0B, CS00           ; Clk_io / 1
        outi    OCR0A, 0xff
        out     OCR0B, __ZERO_REG__
        mov     r24, __ZERO_REG__
        mov     r25, __ZERO_REG__
        /* GPIO */
        ldi     r17, PB1                ; PB1 as output
        out     DDRB, __ZERO_REG__
        out     DDRB, r17
        ldi     r16, PCIE
        out     GIMSK, r16
        ldi     r16, PCINT3
        out     PCMSK, r16
        sei                             ; enable interrupt
loop:
        rjmp    loop

/* Pin change */
.global __vector_2
__vector_2:
        in      r19, SREG
        in      r16, PINB
        ;andi    r16, PB3
        ;andi    r16, PB2

        outi    GIFR, 0x20
        out     SREG, r19
        reti

/* Timer0 On match A */
.global __vector_10
__vector_10:
        in      r19, SREG
        ldi     r16, 0xE0

        out     OCR0A, r16
        out     SREG, r19
        reti

        .end

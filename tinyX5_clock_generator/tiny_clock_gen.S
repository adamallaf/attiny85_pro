    .file "tiny_clock_gen.S"
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
        /* ADC */
        outi    ADMUX, ADC2|ADLAR|REFS0         ; external ref, ARef(PB0)
        outi    ADCSRA, ADATE|ADEN|ADIE|ADPS1|ADPS0   ; set prescaler to 8
        outi    ADCSRB, 0                       ; free running mode
        outi    DIDR0, ADC2D                    ; disable digital input
        /* Timer 0 as Clock generator */
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
        /* Start ADC */
        in      r24, ADCSRA
        ori     r24, ADSC
        out     ADCSRA, r24
loop:
        in      r15, PINB
        sbrc    r15, 3
        rjmp    loop
        sbrs    r15, 2
        rcall   single_pulse
        rjmp    loop

single_pulse:
        outi    PORTB, PB1
        ldi     r17, 242
        ldi     r20, 203
        ldi     r21, 4
nop_loop:                    ; loop for ~123ms
        nop
        dec     r17
        brne    nop_loop
        dec     r20
        brne    nop_loop
        dec     r21
        brne    nop_loop
        in      r17, PORTB
        andi    r17, ~PB1
        out     PORTB, r17
        ldi     r17, 255
        ldi     r20, 200
        ldi     r21, 4
nop_loop1:                   ; loop for ~123ms
        nop
        dec     r17
        brne    nop_loop1
        dec     r20
        brne    nop_loop1
        dec     r21
        brne    nop_loop1
        ret

/* Pin change */
.global __vector_2
__vector_2:
        in      r19, SREG
        in      r16, PINB
        andi    r16, PB3
        brne    pin_high
        in      r24, ADCSRA
        andi    r24, ~(ADATE|ADEN)
        out     ADCSRA, r24
        out     TCCR0B, __ZERO_REG__
        out     TCCR0A, __ZERO_REG__
        rjmp     pcint_done
pin_high:
        in      r24, ADCSRA
        ori     r24, ADSC|ADEN|ADATE
        out     ADCSRA, r24
        outi    TCCR0A, COM0B0|WGM01
        outi    TCCR0B, CS00           ; Clk_io / 1
pcint_done:
        in      r16, TIFR
        andi    r16, 0x81
        out     TIFR, r16              ; clear all interrupt flags
        in      r16, PORTB
        andi    r16, ~PB1
        out     PORTB, r16
        outi    GIFR, 0x20
        out     SREG, r19
        reti

/* ADC Conversion Complete */
.global __vector_8
__vector_8:
        in      r19, SREG
        in      r25, ADCH               ; write ADC value to r25
        out     SREG, r19
        reti

/* Timer0 On match A */
.global __vector_10
__vector_10:
        in      r19, SREG
        ldi     r16, 0xE0
        ldi     r30, pm_lo8(f_20k)
        ldi     r31, pm_hi8(f_20k)
_calc_jump:
        cpc     r25, r16
        brsh    do_jump
        adiw    r30, 2
        subi    r16, 0x20
        brne    _calc_jump
do_jump:
        ijmp
f_20k:  ldi     r16, 199
        rjmp    set_F
f_50k:  ldi     r16, 79
        rjmp    set_F
f_100k: ldi     r16, 39
        rjmp    set_F
f_250k: ldi     r16, 15
        rjmp    set_F
f_500k: ldi     r16, 7
        rjmp    set_F
f_1M:   ldi     r16, 3
        rjmp    set_F
f_2M:   ldi     r16, 1
        rjmp    set_F
f_4M:   mov     r16, __ZERO_REG__
set_F:  out     OCR0A, r16
        out     SREG, r19
        reti

        .end

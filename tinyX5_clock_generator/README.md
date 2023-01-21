# ATtinyX5 Clock Module

PWM 50% duty signal output PB1, clock output.

Tact switch connected to PB2, 10k pul-up, generates a pulse of ~123ms High and ~123ms Low (~4Hz). 

Microswitch bi-stable ON-ON on pin PB3, 10k pull-up, switches between continuous mode and single pulse mode (enables PB2 button).

Potentiometer at **ADC2** (PB4)
External ADC  reference, **AREF** (PB0) set to 2.07V vida voltage divder:
`R1 = 3k; R2 = 1k8 + 330 = 2k130`

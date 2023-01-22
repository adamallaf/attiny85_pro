# ATtinyX5 Clock Module

PWM 50% duty signal output PB1, clock output.

Tact switch connected to PB2, 10k pul-up, generates a pulse of ~123ms High and ~123ms Low (~4Hz). 

Microswitch bi-stable ON-ON on pin PB3, 10k pull-up, switches between continuous mode and single pulse mode (enables PB2 button).

External ADC  reference, **AREF** (PB0) set to 2.07V via voltage divder:

`R1 = 3k; R2 = 1k8 + 330 = 2k130`

Potentiometer at **ADC2** (PB4)

`R1 = 10k; R2 = 10k (ptentiometer); D1 = 1N4148; R3 = 1M`

Voltage divider output curve:

![potentiometer](https://raw.githubusercontent.com/adamallaf/attiny85_pro/master/tinyX5_clock_generator/ng_spice/potentiometer_plot.jpg)

# Servo Signal to Motor Driver Converter

The typical RC servo is controlled by a PWM signal of period 20ms
 and the high pulse duration is 1500&micro;s at 0&deg; (the center position),
 1000&micro;s at -90&deg; and 2000&micro;s at +90&deg;.

This signal needs to be converted to a 3 pin output in order to control
 a motor using a motor driver (i.e. [DRV8838](https://www.pololu.com/product/2290))


from machine import Pin, PWM
from time import sleep
pwm = PWM(Pin(15))
pwm.freq(200)
while True:
    pwm.duty_u16(65500)

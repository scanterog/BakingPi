/******************************************************************************
* Raspberry Pi 2 B - peripheral base 0x3F000000, use GPIO pin 47 for OK/ACT
******************************************************************************/

.section .init
.globl _start
_start:

/* 
* Loads the physical address (the base addr) of the GPIO controller into r0.
*/

ldr r0,=0x3f200000

/*
* The GPIO has 54 pins and each pin has 8 functions. The function 0 (000) is input and the function 1 (001) is output. 
* We want to set the PIN 47 for output. The GPIO functions are stored in block of 10 (pins) with 3 bits per pin. These bits are named control bits.
* Hence, 47 mod 10 = 7; and 7 * 3 = 21. Therefore, we need to set the control bits 21, 22 and 23 to 001 in order to enable the
* output function in the GPIO 47.
* We store 0000 0000 0010 0000 0000 0000 0000 0000 in the proper physical memory (0x3f20 0010).
* Having 54 GPIO, the address range from 0x3f2 0000 to 0x3f2 0014.
* 16 in base 10 is 10 in base 16.
*/
mov r1,#1
lsl r1,#21
str r1,[r0,#16]

/*
* Once defined the function. The next step is to turn the PIN on or off.
* A value of 0 turn it off and a non zero value turn it on.i
* The GPIO controller has two sets of 4 bytes for turning pins on and off.
* => Set 0 (GPIO 0-31) and Set 1 (GPIO 32-53).
* => Clear 0 (GPIO 0-31) and Clear 1 (GPIO 32-53).
* To turn the GPIO 47 on, we need Set 1 (0x3f20 0020).
* 47 mod 32 = 15.
* 32 in base 10 is 20 in base 16.
*/
mov r1,#1
lsl r1,#15
str r1,[r0,#32]


loop$:
b loop$


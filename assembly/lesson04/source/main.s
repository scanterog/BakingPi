/*
* Raspberry Pi 2 model B
*/

.section .init
.globl _start
_start:

b main

.section .text
main:

/*
* Set the stack pointer to 0x8000.
*/
mov sp,#0x8000

/*
* Set output function to GPIO 47.
*/

pinNum .req r0
pinFunc .req r1
mov pinNum,#47
mov pinFunc,#1
bl SetGpioFunction
.unreq pinNum
.unreq pinFunc


loop$:

/*
* Set (value 1 = on) the GPIO 47.
*/

pinNum .req r0
pinVal .req r1
mov pinNum,#47
mov pinVal,#1
bl SetGpio
.unreq pinNum
.unreq pinVal

/*
* Wait 500000 micro seconds. The light will flash 1 time per second.
*/
timeToWait .req r0
ldr timeToWait,=500000
bl Wait
.unreq timeToWait

/*
* Clear (value 0) the GPIO 47.
*/

pinNum .req r0
pinVal .req r1
mov pinNum,#47
mov pinVal,#0
bl SetGpio
.unreq pinNum
.unreq pinVal

/*
* Wait 500000 micro seconds. The light will flash 1 time per second.
*/

timeToWait .req r0
ldr timeToWait,=500000
bl Wait
.unreq timeToWait

b loop$


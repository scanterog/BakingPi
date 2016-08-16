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
* Delay - Decrement the number 0x200000 to 0.
*/

decr .req r0
mov decr,#0x200000
wait1$: 
	sub decr,#1
	teq decr,#0
	bne wait1$
.unreq decr

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
* Delay - Decrement the number 0x200000 to 0.
*/ 

decr .req r0
mov decr,#0x200000
wait2$:
	sub decr,#1
	teq decr,#0
	bne wait2$
.unreq decr

b loop$


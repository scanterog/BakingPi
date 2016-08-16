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

/*
* Load the pattern defined in the data section.
* This pattern encode the Morse code SOS sequence.
*/

ptrn .req r4
ldr ptrn,=pattern
ldr ptrn,[ptrn]
seq .req r5
mov seq,#0

loop$:

	/*
	* Set the GPIO 47 based on the current bit in the pattern.
	*/

	pinNum .req r0
	pinVal .req r1
	mov pinNum,#47
	mov pinVal,#1
	lsl pinVal,seq
	and pinVal,ptrn
	bl SetGpio
	.unreq pinNum
	.unreq pinVal

	/*
	* Wait 250000 micro seconds.
	*/

	timeToWait .req r0
	ldr timeToWait,=250000
	bl Wait
	.unreq timeToWait

	/*
	* Incrementer the sequence counter. 
	* When it reaches 31 (11111) the and operation will return 0.
	*/
	add seq,#1
	and seq,#0b11111
	b loop$

/*
* Store the pattern in the data section of the kernel image.
*/
.section .data
.align 2
pattern:
.int 0b11111111101010100010001000101010


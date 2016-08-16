/*
* Get the GPIO controller base address.
*/
.globl GetGpioAddress
GetGpioAddress:
	ldr r0,=0x3f200000
	mov pc,lr

/*
* void SetGpioFunction(u32 gpioPin, u32 function)
* Sets the given function (2nd param) to the GPIO Pin (1st param)
*/
.globl SetGpioFunction
SetGpioFunction:
	cmp r0,#53
	cmpls r1,#7
	movhi pc,lr

	push {lr}
	mov r2,r0
	bl GetGpioAddress

	functionLoop$:
		cmp r2,#9
		subhi r2,#10
		addhi r0,#4
		bhi functionLoop$

	add r2, r2,lsl #1
	lsl r1,r2
	str r1,[r0]
	pop {pc}

/*
* void setGpio(u32 gpioPin, u32 value)
* Set the given value (2nd param) to the GPIO pin (1st param).
* The value can be 0 (off) or non-zero (on).
*/
.globl SetGpio
SetGpio:
	pinNum .req r0
	pinVal .req r1

	cmp pinNum,#53
	movhi pc,lr
	push {lr}
	mov r2,pinNum
	.unreq pinNum
	pinNum .req r2
	bl GetGpioAddress
	gpioAddr .req r0

	pinBank .req r3
	lsr pinBank,pinNum,#5
	lsl pinBank,#2
	add gpioAddr,pinBank
	.unreq pinBank

	and pinNum,#31
	setBit .req r3
	mov setBit,#1
	lsl setBit,pinNum
	.unreq pinNum

	teq pinVal,#0
	.unreq pinVal
	streq setBit,[gpioAddr,#40]
	strne setBit,[gpioAddr,#28]
	.unreq setBit
	.unreq gpioAddr
	pop {pc}

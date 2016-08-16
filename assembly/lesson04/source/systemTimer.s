/*
* The system timer runs at 1MHz, and just counts always.
* The counter is incremented by 1 every 1 micro second.
*/

/*
* void* GetSystemTimerBase()
* Returns the base address of the System Timer region as a
* physical address in register r0.
*/
.globl GetSystemTimerBase
GetSystemTimerBase: 
	ldr r0,=0x3f003000
	mov pc,lr

/*
* u64 GetTimeStamp()
* Gets the current timestamp of the system timer, and returns it
* in registers r0 (32 bits) and r1 (32 bits), with r1 being the most significant 32 bits.
*/
.globl GetTimeStamp
GetTimeStamp:
	push {lr}
	bl GetSystemTimerBase
	ldrd r0,r1,[r0,#4]
	pop {pc}

/*
* void Wait(u32 delay)
* Waits at least a specified number of microseconds (delay param) before returning.
*/
.globl Wait
Wait:
	delay .req r2
	mov delay,r0	
	push {lr}
	bl GetTimeStamp
	start .req r3
	mov start,r0

	loop$:
		bl GetTimeStamp
		elapsed .req r1
		sub elapsed,r0,start
		cmp elapsed,delay
		.unreq elapsed
		bls loop$

	.unreq delay
	.unreq start
	pop {pc}

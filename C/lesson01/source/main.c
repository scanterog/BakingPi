/*
* RPI 2 model B
*/

#define GPIO_BASE 0x3F200000UL

#define GPIO_GPFSEL0    0
#define GPIO_GPFSEL1    1
#define GPIO_GPFSEL2    2
#define GPIO_GPFSEL3    3
#define GPIO_GPFSEL4    4
#define GPIO_GPFSEL5    5

#define GPIO_GPSET0     7
#define GPIO_GPSET1     8

#define GPIO_GPCLR0     10
#define GPIO_GPCLR1     11

/** GPIO Register set **/
volatile unsigned int* gpio;

int main(void)
{
	/* Assign the address of the GPIO peripheral (Using ARM Physical Address) */
	gpio = (unsigned int*)GPIO_BASE;
	
	/* Enable output function in GPIO47 */
	gpio[GPIO_GPFSEL4] |= (1 << 21);

	/* Set the LED GPIO47 pin high (Turn OK LED on) */
        gpio[GPIO_GPSET1] = (1 << 15);

	while(1)
	;
	
}

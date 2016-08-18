arm-none-eabi-gcc -O2 -mfpu=vfp -mfloat-abi=hard -march=armv7-a -mtune=cortex-a7 -nostartfiles source/main.c -o kernel.elf
arm-none-eabi-objcopy kernel.elf -O binary kernel.img

# BakingPi
Operating Systems Development on Raspberry Pi

The  Cambridge University provides some resources in order to develop a very basic operating systems. The lessons can be found at [Baking Pi – Operating Systems Development](http://www.cl.cam.ac.uk/projects/raspberrypi/tutorials/os/). These lessons are written for the Raspberry Pi (RPI) 1. Hence this repo contains the lessons modified to work with the **Raspberry Pi 2 model B**.

The main differences are:
* The RPI 2B Peripheral Base Address is 0x3f000000 instead of 0x20000000. Hence, considering that the GPIO base is at offset 0x00200000, the address of the GPIO controller is 0x3f200000.
* The OK LED is connected to the GPIO PIN 47 instead of 16.

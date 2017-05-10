#!/bin/bash

# First install Git and the build dependencies
sudo apt-get install git bc

# Next get the sources, which will take some time
git clone --depth=1 https://github.com/raspberrypi/linux

# Raspberry Pi 2/3 default build configuration
cd linux
KERNEL=kernel7
make bcm2709_defconfig

# Build and install the kernel, modules, and Device Tree blobs; this step takes a long time
# Note: On a Raspberry Pi 2/3, the -j4 flag splits the work between all four cores, speeding up compilation significantly.
make -j4 zImage modules dtbs
sudo make modules_install
sudo cp arch/arm/boot/dts/*.dtb /boot/
sudo cp arch/arm/boot/dts/overlays/*.dtb* /boot/overlays/
sudo cp arch/arm/boot/dts/overlays/README /boot/overlays/
sudo cp arch/arm/boot/zImage /boot/$KERNEL.img

# Reboot
sudo reboot


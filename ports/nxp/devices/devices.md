# NXP Devices

This folder is intended for device specific files not available in the NXP mcux-sdk

Subfolder names should match devices in the mcux-sdk to be consistent with the CHIP_FAMILY variable in makefiles

## device.mk

The device.mk file is used to customized the makefile based on the target device.

The NXP mcux-sdk uses common APIs for most peripherals, but there are multiple implementations that need to be matched with the hardware being targeted.  The libraries that are compatible with a device supported in the mcux-sdk are listed in the all_lib_device_CHIP-FAMILY.cmake file.  The directories listed in this file should be added to VPATH and INC_C lists

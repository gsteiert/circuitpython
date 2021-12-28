# This file is part of the MicroPython project, http://micropython.org/
#
# The MIT License (MIT)
#
# SPDX-FileCopyrightText: Copyright (c) 2019 Dan Halbert for Adafruit Industries
# SPDX-FileCopyrightText: Copyright (c) 2019 Artur Pacholec
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Select the board to build for.
ifeq ($(BOARD),)
  $(error You must provide a BOARD parameter)
else
  ifeq ($(wildcard boards/$(BOARD)/.),)
    $(error Invalid BOARD specified)
  endif
endif

# If the build directory is not given, make it reflect the board name.
BUILD ?= build-$(BOARD)
MCUX = mcux-sdk

include ../../py/mkenv.mk
# Board-specific
include boards/$(BOARD)/mpconfigboard.mk
# Device-specific
include devices/$(CHIP_FAMILY)/device.mk
# Port-specific
include mpconfigport.mk
# CircuitPython-specific
include $(TOP)/py/circuitpy_mpconfig.mk

# qstr definitions (must come before including py.mk)
QSTR_DEFS = qstrdefsport.h

# include py core make definitions
include $(TOP)/py/py.mk

include $(TOP)/supervisor/supervisor.mk

# Include make rules and variables common across CircuitPython builds.
include $(TOP)/py/circuitpy_defns.mk

CROSS_COMPILE = arm-none-eabi-

INC += \
	-I. \
	-I../.. \
	-I../lib/mp-readline \
	-I../shared/timeutils \
	-I../../lib/tinyusb/src \
	-I../../supervisor/shared/usb \
	-I$(BUILD) \
	-Iboards/ \
	-Iboards/$(BOARD) \
	-Iperipherals/ \

# NDEBUG disables assert() statements. This reduces code size pretty dramatically, per tannewt.

CFLAGS += -Os -ftree-vrp -DNDEBUG -ffreestanding

#Debugging/Optimization
# Never set -fno-inline because we use inline to move small functions into routines that must be
# in RAM. If inlining is disallowed, then we may end up calling a function in flash when we cannot.
ifeq ($(DEBUG), 1)
  # You may want to disable -flto if it interferes with debugging.
  # CFLAGS += -flto -flto-partition=none
  # You may want to enable these flags to make setting breakpoints easier.
  CFLAGS += -fno-ipa-sra
else
  #CFLAGS += -flto -flto-partition=none
endif

CFLAGS += $(INC) -ggdb -Wall -Werror -std=gnu11 -nostdlib -fshort-enums $(BASE_CFLAGS) $(CFLAGS_MOD) $(COPT) -Werror=missing-prototypes

# TODO: add these when -Werror is applied
# Disable some warnings, as do most ports. NXP SDK causes undef, tinyusb causes cast-align
# CFLAGS += -Wno-undef -Wno-cast-align

OPTIMIZATION_FLAGS ?= -O2 -fno-inline-functions

# option to override compiler optimization level, set in boards/$(BOARD)/mpconfigboard.mk
CFLAGS += $(OPTIMIZATION_FLAGS)

LD_FILES = $(wildcard boards/$(BOARD)/*.ld) flash/$(FLASH).ld devices/$(CHIP_FAMILY)/$(CHIP_FAMILY).ld common.ld

LD_SCRIPT_FLAG := -Wl,-T,

LDFLAGS = $(CFLAGS) -nostartfiles -Wl,-nostdlib $(addprefix $(LD_SCRIPT_FLAG), $(LD_FILES)) -Wl,-Map=$@.map -Wl,-cref -Wl,-gc-sections -specs=nano.specs
LIBS := -lgcc -lc -lnosys -lm

# Use toolchain libm if we're not using our own.
ifndef INTERNAL_LIBM
LIBS += -lm
endif


SRC_SDK := \
	fsl_adc.c \
	fsl_cache.c \
	fsl_clock.c \
	fsl_common.c \
	fsl_common_arm.c \
	fsl_flexspi.c \
	fsl_gpio.c \
	fsl_lpi2c.c \
	fsl_lpspi.c \
	fsl_lpuart.c \
	fsl_ocotp.c \
	fsl_pwm.c \
	fsl_snvs_hp.c \
	fsl_tempmon.c \
	fsl_trng.c \
	system_$(CHIP_FAMILY).c \

$(addprefix $(BUILD)/, $(SRC_SDK:.c=.o)): CFLAGS += -Wno-undef -Wno-missing-prototypes -Wno-cast-align

SRC_C += \
	background.c \
	boards/$(BOARD)/board.c \
	boards/$(BOARD)/flash_config.c \
	boards/$(BOARD)/pins.c \
	fatfs_port.c \
	mphalport.c \
	peripherals/$(CHIP_FAMILY)/clocks.c \
	peripherals/$(CHIP_FAMILY)/periph.c \
	peripherals/$(CHIP_FAMILY)/pins.c \
	reset.c \
	supervisor/flexspi_nor_flash_ops.c

# TODO
#ifeq ($(CIRCUITPY_AUDIOBUSIO),1)
#SRC_C += peripherals/samd/i2s.c peripherals/samd/$(CHIP_FAMILY)/i2s.c
#endif
#
SRC_COMMON_HAL_EXPANDED = $(addprefix shared-bindings/, $(SRC_COMMON_HAL)) \
                          $(addprefix shared-bindings/, $(SRC_BINDINGS_ENUMS)) \
                          $(addprefix common-hal/, $(SRC_COMMON_HAL))

SRC_SHARED_MODULE_EXPANDED = $(addprefix shared-bindings/, $(SRC_SHARED_MODULE)) \
                             $(addprefix shared-module/, $(SRC_SHARED_MODULE)) \
                             $(addprefix shared-module/, $(SRC_SHARED_MODULE_INTERNAL))

SRC_S = \
    $(MCUX)/devices/$(CHIP_FAMILY)/gcc/startup_$(CHIP_FAMILY).S \
    supervisor/cpu.S

OBJ = $(PY_O) $(SUPERVISOR_O) $(addprefix $(BUILD)/, $(SRC_C:.c=.o))
OBJ += $(addprefix $(BUILD)/, $(SRC_SDK:.c=.o))
OBJ += $(addprefix $(BUILD)/, $(SRC_COMMON_HAL_EXPANDED:.c=.o))
OBJ += $(addprefix $(BUILD)/, $(SRC_SHARED_MODULE_EXPANDED:.c=.o))
ifeq ($(INTERNAL_LIBM),1)
OBJ += $(addprefix $(BUILD)/, $(SRC_LIBM:.c=.o))
endif
OBJ += $(addprefix $(BUILD)/, $(SRC_CIRCUITPY_COMMON:.c=.o))
OBJ += $(addprefix $(BUILD)/, $(SRC_S:.S=.o))
OBJ += $(addprefix $(BUILD)/, $(SRC_MOD:.c=.o))

SRC_QSTR += $(SRC_C) $(SRC_SUPERVISOR) $(SRC_COMMON_HAL_EXPANDED) $(SRC_SHARED_MODULE_EXPANDED)

all: $(BUILD)/firmware.bin $(BUILD)/firmware.uf2 $(BUILD)/firmware.hex

$(BUILD)/firmware.elf: $(OBJ) $(LD_FILES)
	$(STEPECHO) "LINK $@"
	$(Q)$(CC) -o $@ $(LDFLAGS) $(filter-out %.ld, $^) -Wl,--start-group $(LIBS) -Wl,--end-group

$(BUILD)/firmware.bin: $(BUILD)/firmware.elf
	$(STEPECHO) "Create $@"
	$(Q)$(OBJCOPY) -O binary -j .flash_config -j .ivt -j .text -j .ARM.exidx -j .data -j .itcm -j .dtcm_data $^ $@

$(BUILD)/firmware.uf2: $(BUILD)/firmware.elf
	$(STEPECHO) "Create $@"
	$(Q)$(OBJCOPY) -O binary -j .text -j .ARM.exidx -j .data -j .itcm -j .dtcm_data $^ $@-binpart
	$(Q)$(PYTHON) $(TOP)/tools/uf2/utils/uf2conv.py -b $(APP_BASE_ADDR) -f MIMXRT10XX -c -o $@ $@-binpart
	$(Q)rm $@-binpart

$(BUILD)/firmware.hex: $(BUILD)/firmware.elf
	$(Q)$(OBJCOPY) -O ihex -j .flash_config -j .ivt -j .text -j .ARM.exidx -j .data -j .itcm -j .dtcm_data $< $@

include $(TOP)/py/mkrules.mk

# Print out the value of a make variable.
# https://stackoverflow.com/questions/16467718/how-to-print-out-a-variable-in-makefile
print-%:
	@echo $* = $($*)

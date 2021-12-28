CFLAGS += \
	-mthumb \
	-mapcs \
	-mcpu=cortex-m7 \
	-mfloat-abi=hard \
	-mfpu=fpv5-sp-d16 \
	-DCPU_$(CHIP_VARIANT) \
	-DDEBUG \
	-DIMXRT10XX \
	-D__PROGRAM_START \
	-g3 -Wno-unused-parameter \
	-ffunction-sections -fdata-sections -fstack-usage

LDFLAGS += -mcpu=cortex-m7 -mfloat-abi=hard -mfpu=fpv5-sp-d16 -mthumb -mapcs

# TinyUSB defines
SRC_C += lib/tinyusb/src/portable/nxp/transdimension/dcd_transdimension.c

CFLAGS += -DCFG_TUSB_MCU=OPT_MCU_MIMXRT10XX -DCFG_TUD_MIDI_RX_BUFSIZE=512 -DCFG_TUD_CDC_RX_BUFSIZE=512 -DCFG_TUD_MIDI_TX_BUFSIZE=512 -DCFG_TUD_CDC_TX_BUFSIZE=512 -DCFG_TUD_MSC_BUFSIZE=1024

USB_HIGHSPEED = 1

# Number of USB endpoint pairs.
USB_NUM_ENDPOINT_PAIRS = 8

# Path to library sources
VPATH += \
    $(MCUX)/CMSIS/Core/Include \
    $(MCUX)/CMSIS/DSP \
    $(MCUX)/drivers/adc_12b1msps_sar \
    $(MCUX)/drivers/adc_etc \
    $(MCUX)/drivers/cache/armv7-m7 \
    $(MCUX)/drivers/common \
    $(MCUX)/drivers/dcdc_1 \
    $(MCUX)/drivers/dcp \
    $(MCUX)/drivers/dmamux \
    $(MCUX)/drivers/edma \
    $(MCUX)/drivers/ewm \
    $(MCUX)/drivers/flexio \
    $(MCUX)/drivers/flexram \
    $(MCUX)/drivers/flexspi \
    $(MCUX)/drivers/gpc_1 \
    $(MCUX)/drivers/gpt \
    $(MCUX)/drivers/igpio \
    $(MCUX)/drivers/kpp \
    $(MCUX)/drivers/lpi2c \
    $(MCUX)/drivers/lpspi \
    $(MCUX)/drivers/lpuart \
    $(MCUX)/drivers/ocotp \
    $(MCUX)/drivers/otfad \
    $(MCUX)/drivers/pit \
    $(MCUX)/drivers/pwm \
    $(MCUX)/drivers/rtwdog \
    $(MCUX)/drivers/sai \
    $(MCUX)/drivers/snvs_hp \
    $(MCUX)/drivers/snvs_lp \
    $(MCUX)/drivers/src \
    $(MCUX)/drivers/tempmon \
    $(MCUX)/drivers/trng \
    $(MCUX)/drivers/wdog01 \
    $(MCUX)/drivers/xbara \
    $(MCUX)/devices/$(CHIP_FAMILY)/. \
    $(MCUX)/devices/$(CHIP_FAMILY)/drivers \
    $(MCUX)/devices/$(CHIP_FAMILY)/utilities \
    $(MCUX)/devices/$(CHIP_FAMILY)/xip \

# Library includes
INC += \
    -I$(MCUX)/CMSIS/Core/Include \
    -I$(MCUX)/CMSIS/DSP \
    -I$(MCUX)/drivers/adc_12b1msps_sar \
    -I$(MCUX)/drivers/adc_etc \
    -I$(MCUX)/drivers/cache/armv7-m7 \
    -I$(MCUX)/drivers/common \
    -I$(MCUX)/drivers/dcdc_1 \
    -I$(MCUX)/drivers/dcp \
    -I$(MCUX)/drivers/dmamux \
    -I$(MCUX)/drivers/edma \
    -I$(MCUX)/drivers/ewm \
    -I$(MCUX)/drivers/flexio \
    -I$(MCUX)/drivers/flexram \
    -I$(MCUX)/drivers/flexspi \
    -I$(MCUX)/drivers/gpc_1 \
    -I$(MCUX)/drivers/gpt \
    -I$(MCUX)/drivers/igpio \
    -I$(MCUX)/drivers/kpp \
    -I$(MCUX)/drivers/lpi2c \
    -I$(MCUX)/drivers/lpspi \
    -I$(MCUX)/drivers/lpuart \
    -I$(MCUX)/drivers/ocotp \
    -I$(MCUX)/drivers/otfad \
    -I$(MCUX)/drivers/pit \
    -I$(MCUX)/drivers/pwm \
    -I$(MCUX)/drivers/rtwdog \
    -I$(MCUX)/drivers/sai \
    -I$(MCUX)/drivers/snvs_hp \
    -I$(MCUX)/drivers/snvs_lp \
    -I$(MCUX)/drivers/src \
    -I$(MCUX)/drivers/tempmon \
    -I$(MCUX)/drivers/trng \
    -I$(MCUX)/drivers/wdog01 \
    -I$(MCUX)/drivers/xbara \
    -I$(MCUX)/devices/$(CHIP_FAMILY)/. \
    -I$(MCUX)/devices/$(CHIP_FAMILY)/drivers \
    -I$(MCUX)/devices/$(CHIP_FAMILY)/utilities \
    -I$(MCUX)/devices/$(CHIP_FAMILY)/xip

# excluded libraries
    # /sdk/../../../middleware
    # /sdk/../../../rtos/freertos/freertos_kernel
    # /sdk/../../utilities/assert
    # /sdk/../../utilities/debug_console
    # /sdk/../../utilities/debug_console_lite
    # /sdk/../../utilities/misc_utilities
    # /sdk/../../boards/evkmimxrt1010/xip
    # /sdk/../../components/codec
    # /sdk/../../components/codec/i2c
    # /sdk/../../components/codec/wm8960
    # /sdk/../../components/fxos8700cq
    # /sdk/../../components/i2c
    # /sdk/../../components/lists
    # /sdk/../../components/osa
    # /sdk/../../components/serial_manager
    # /sdk/../../components/uart

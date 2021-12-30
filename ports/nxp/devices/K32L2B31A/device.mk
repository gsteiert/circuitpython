CFLAGS += \
    -DDEBUG \
    -DCPU_K32L2B31VLH0A \
    -DPRINTF_FLOAT_ENABLE=0 \
    -DSCANF_FLOAT_ENABLE=0 \
    -DPRINTF_ADVANCED_ENABLE=0 \
    -DSCANF_ADVANCED_ENABLE=0 \
    -DFRDM_K32L2B \
    -DFREEDOM \
    -DMCUXPRESSO_SDK \
    -g \
    -O0 \
    -mcpu=cortex-m0plus \
    -Wall \
    -mfloat-abi=soft \
    -mthumb \
    -MMD \
    -MP \
    -fno-common \
    -ffunction-sections \
    -fdata-sections \
    -ffreestanding \
    -fno-builtin \
    -mapcs \
    -std=gnu99 \

LDFLAGS += \
    -g \
    -mcpu=cortex-m0plus \
    -Wall \
    -mfloat-abi=soft \
    --specs=nano.specs \
    --specs=nosys.specs \
    -fno-common \
    -ffunction-sections \
    -fdata-sections \
    -ffreestanding \
    -fno-builtin \
    -mthumb \
    -mapcs \
    -Xlinker \
    --gc-sections \
    -Xlinker \
    -static \
    -Xlinker \
    -z \
    -Xlinker \
    muldefs \
    -Xlinker \
    -Map=output.map \
    -Wl,--print-memory-usage \

#    -T${ProjDirPath}/K32L2B31xxxxA_flash.ld -static

# TinyUSB defines
SRC_C += lib/tinyusb/src/portable/nxp/khci/dcd_khci.c

CFLAGS += -DCFG_TUSB_MCU=OPT_MCU_K32L2BXX

USB_HIGHSPEED = 0

# Number of USB endpoint pairs.
USB_NUM_ENDPOINT_PAIRS = 8

# Path to library sources
VPATH += \
    $(MCUX)/CMSIS/Core/Include \
    $(MCUX)/drivers/adc16\
    $(MCUX)/drivers/cmp\
    $(MCUX)/drivers/common \
    $(MCUX)/drivers/cop \
    $(MCUX)/drivers/dac \
    $(MCUX)/drivers/dma \
    $(MCUX)/drivers/dmamux \
    $(MCUX)/drivers/flash \
    $(MCUX)/drivers/flexio \
    $(MCUX)/drivers/gpio \
    $(MCUX)/drivers/i2c \
    $(MCUX)/drivers/llwu \
    $(MCUX)/drivers/lptmr \
    $(MCUX)/drivers/lpuart \
    $(MCUX)/drivers/pit \
    $(MCUX)/drivers/pmc \
    $(MCUX)/drivers/port \
    $(MCUX)/drivers/rcm \
    $(MCUX)/drivers/rtc \
    $(MCUX)/drivers/sim \
    $(MCUX)/drivers/slcd \
    $(MCUX)/drivers/smc \
    $(MCUX)/drivers/spi \
    $(MCUX)/drivers/tpm \
    $(MCUX)/drivers/uart \
    $(MCUX)/devices/$(CHIP_FAMILY)/. \
    $(MCUX)/devices/$(CHIP_FAMILY)/drivers \

INC += \
    -I$(MCUX)/CMSIS/Core/Include \
    -I$(MCUX)/components/fxos8700cq \
    -I$(MCUX)/components/lists \
    -I$(MCUX)/components/osa \
    -I$(MCUX)/components/serial_manager \
    -I$(MCUX)/components/slcd_engine \
    -I$(MCUX)/components/slcd_engine/LCD-S401M16KR \
    -I$(MCUX)/components/uart \
    -I$(MCUX)/drivers/adc16 \
    -I$(MCUX)/drivers/cmp \
    -I$(MCUX)/drivers/common \
    -I$(MCUX)/drivers/cop \
    -I$(MCUX)/drivers/dac \
    -I$(MCUX)/drivers/dma \
    -I$(MCUX)/drivers/dmamux \
    -I$(MCUX)/drivers/flash \
    -I$(MCUX)/drivers/flexio \
    -I$(MCUX)/drivers/gpio \
    -I$(MCUX)/drivers/i2c \
    -I$(MCUX)/drivers/llwu \
    -I$(MCUX)/drivers/lptmr \
    -I$(MCUX)/drivers/lpuart \
    -I$(MCUX)/drivers/pit \
    -I$(MCUX)/drivers/pmc \
    -I$(MCUX)/drivers/port \
    -I$(MCUX)/drivers/rcm \
    -I$(MCUX)/drivers/rtc \
    -I$(MCUX)/drivers/sim \
    -I$(MCUX)/drivers/slcd \
    -I$(MCUX)/drivers/smc \
    -I$(MCUX)/drivers/spi \
    -I$(MCUX)/drivers/tpm \
    -I$(MCUX)/drivers/uart \
    -I$(MCUX)/devices/$(CHIP_FAMILY)/. \
    -I$(MCUX)/devices/$(CHIP_FAMILY)/drivers \


list(APPEND CMAKE_MODULE_PATH
    ${CMAKE_CURRENT_LIST_DIR}/.
    ${CMAKE_CURRENT_LIST_DIR}/../../CMSIS/Core/Include
    ${CMAKE_CURRENT_LIST_DIR}/../../components/fxos8700cq
    ${CMAKE_CURRENT_LIST_DIR}/../../components/lists
    ${CMAKE_CURRENT_LIST_DIR}/../../components/osa
    ${CMAKE_CURRENT_LIST_DIR}/../../components/serial_manager
    ${CMAKE_CURRENT_LIST_DIR}/../../components/slcd_engine
    ${CMAKE_CURRENT_LIST_DIR}/../../components/slcd_engine/LCD-S401M16KR
    ${CMAKE_CURRENT_LIST_DIR}/../../components/uart
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/adc16
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/cmp
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/common
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/cop
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/dac
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/dma
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/dmamux
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/flash
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/flexio
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/gpio
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/i2c
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/llwu
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/lptmr
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/lpuart
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/pit
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/pmc
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/port
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/rcm
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/rtc
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/sim
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/slcd
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/smc
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/spi
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/tpm
    ${CMAKE_CURRENT_LIST_DIR}/../../drivers/uart
    ${CMAKE_CURRENT_LIST_DIR}/../../../middleware
    ${CMAKE_CURRENT_LIST_DIR}/../../../rtos/freertos/freertos_kernel
    ${CMAKE_CURRENT_LIST_DIR}/../../utilities/assert
    ${CMAKE_CURRENT_LIST_DIR}/../../utilities/debug_console
    ${CMAKE_CURRENT_LIST_DIR}/../../utilities/debug_console_lite
    ${CMAKE_CURRENT_LIST_DIR}/../../utilities/misc_utilities
    ${CMAKE_CURRENT_LIST_DIR}/drivers
    ${CMAKE_CURRENT_LIST_DIR}/utilities
)


# Copy the cmake components into projects
#    include(driver_llwu)
#    include(driver_port)
#    include(driver_lpuart_freertos)
#    include(driver_uart_freertos)
#    include(device_system)
#    include(component_lpuart_adapter)
#    include(driver_i2c)
#    include(driver_i2c_freertos)
#    include(driver_dmamux)
#    include(driver_lptmr)
#    include(driver_gpio)
#    include(component_lists)
#    include(driver_dac)
#    include(driver_cop)
#    include(driver_tpm)
#    include(driver_cmp)
#    include(device_startup)
#    include(driver_adc16)
#    include(driver_clock)
#    include(utility_debug_console_lite)
#    include(driver_flexio_uart)
#    include(component_osa)
#    include(driver_fxos8700cq)
#    include(driver_lpuart)
#    include(CMSIS_Include_core_cm)
#    include(driver_flexio_spi)
#    include(middleware_freertos-kernel_extension)
#    include(driver_flexio)
#    include(utility_shell)
#    include(utility_notifier)
#    include(utility_assert_lite)
#    include(driver_flexio_i2c_master)
#    include(driver_pmc)
#    include(middleware_baremetal)
#    include(driver_spi)
#    include(driver_flash)
#    include(utility_assert)
#    include(driver_sim)
#    include(utility_debug_console)
#    include(device_CMSIS)
#    include(driver_uart)
#    include(driver_flexio_uart_dma)
#    include(utilities_misc_utilities)
#    include(driver_common)
#    include(driver_rtc)
#    include(driver_uart_dma)
#    include(driver_smc)
#    include(driver_spi_dma)
#    include(driver_dma)
#    include(driver_i2c_dma)
#    include(component_serial_manager)
#    include(middleware_freertos-kernel_K32L2B31A)
#    include(driver_slcd)
#    include(driver_lpuart_dma)
#    include(driver_pit)
#    include(component_serial_manager_uart)
#    include(driver_flexio_spi_dma)
#    include(middleware_freertos-kernel_heap_4)
#    include(driver_rcm)
#    include(driver_slcd_engine)
#    include(driver_spi_freertos)
#    include(driver_slcd_lcd_s401m16kr)

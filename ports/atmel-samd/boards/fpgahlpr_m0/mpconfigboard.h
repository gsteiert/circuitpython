#define MICROPY_HW_BOARD_NAME "FPGA Helper"
#define MICROPY_HW_MCU_NAME "samd21e18"

#define CIRCUITPY_BITBANG_APA102
#define MICROPY_HW_APA102_MOSI   (&pin_PA01)
#define MICROPY_HW_APA102_SCK    (&pin_PA00)

// Saleae reads 12mhz which is the limit even though we set it to the safer 8mhz.
#define SPI_FLASH_BAUDRATE  (8000000)

#define SPI_FLASH_MOSI_PIN          PIN_PA08
#define SPI_FLASH_MISO_PIN          PIN_PA10
#define SPI_FLASH_SCK_PIN           PIN_PA11
#define SPI_FLASH_CS_PIN            PIN_PA09
#define SPI_FLASH_MOSI_PIN_FUNCTION PINMUX_PA08D_SERCOM2_PAD0
#define SPI_FLASH_MISO_PIN_FUNCTION PINMUX_PA10D_SERCOM2_PAD2
#define SPI_FLASH_SCK_PIN_FUNCTION  PINMUX_PA11D_SERCOM2_PAD3
#define SPI_FLASH_SERCOM            SERCOM2
#define SPI_FLASH_SERCOM_INDEX      2
#define SPI_FLASH_MOSI_PAD          0
#define SPI_FLASH_MISO_PAD          2
#define SPI_FLASH_SCK_PAD           3
// <o> Transmit Data Pinout
// <0x0=>PAD[0,1]_DO_SCK
// <0x1=>PAD[2,3]_DO_SCK
// <0x2=>PAD[3,1]_DO_SCK
// <0x3=>PAD[0,3]_DO_SCK
#define SPI_FLASH_DOPO              1   // does this need to match the next line??
#define SPI_FLASH_DIPO              2   // same as MISO pad

// These are pins not to reset.
#define MICROPY_PORT_A        (PORT_PA00 | PORT_PA01 | PORT_PA27 | PORT_PA24 | PORT_PA25)
#define MICROPY_PORT_B        (0)
#define MICROPY_PORT_C        (0)

// If you change this, then make sure to update the linker scripts as well to
// make sure you don't overwrite code.
#define CIRCUITPY_INTERNAL_NVM_SIZE 256
  // Check what these numbers mean
#define BOARD_FLASH_SIZE (0x00040000 - 0x2000 - CIRCUITPY_INTERNAL_NVM_SIZE)

#include "external_flash/devices.h"

#define EXTERNAL_FLASH_DEVICE_COUNT 1
#define EXTERNAL_FLASH_DEVICES W25Q64JV_IQ

#include "external_flash/external_flash.h"

#define DEFAULT_I2C_BUS_SCL (&pin_PA23)
#define DEFAULT_I2C_BUS_SDA (&pin_PA22)

#define DEFAULT_SPI_BUS_SCK (&pin_PA07)
#define DEFAULT_SPI_BUS_MOSI (&pin_PA06)
#define DEFAULT_SPI_BUS_MISO (&pin_PA04)

#define DEFAULT_UART_BUS_RX (&pin_PA15)
#define DEFAULT_UART_BUS_TX (&pin_PA14)

// USB is always used internally so skip the pin objects for it.
#define IGNORE_PIN_PA24     1
#define IGNORE_PIN_PA25     1

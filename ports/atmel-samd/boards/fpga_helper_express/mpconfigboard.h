#define MICROPY_HW_BOARD_NAME "Steiert Solutions FPGA Helper"
#define MICROPY_HW_MCU_NAME "samd21e18"

#define CIRCUITPY_BITBANG_APA102
#define MICROPY_HW_APA102_MOSI   (&pin_PA01)
#define MICROPY_HW_APA102_SCK    (&pin_PA00)

#define SPI_FLASH_MOSI_PIN          &pin_PA08
#define SPI_FLASH_MISO_PIN          &pin_PA10
#define SPI_FLASH_SCK_PIN           &pin_PA11
#define SPI_FLASH_CS_PIN            &pin_PA09

// These are pins not to reset.
#define MICROPY_PORT_A        (PORT_PA00 | PORT_PA01)
#define MICROPY_PORT_B        (0)
#define MICROPY_PORT_C        (0)

// If you change this, then make sure to update the linker scripts as well to
// make sure you don't overwrite code.
#define CIRCUITPY_INTERNAL_NVM_SIZE 256

#define BOARD_FLASH_SIZE (0x00040000 - 0x2000 - CIRCUITPY_INTERNAL_NVM_SIZE)

#define DEFAULT_I2C_BUS_SCL (&pin_PA23)
#define DEFAULT_I2C_BUS_SDA (&pin_PA22)

#define DEFAULT_SPI_BUS_SCK (&pin_PA07)
#define DEFAULT_SPI_BUS_MOSI (&pin_PA04)
#define DEFAULT_SPI_BUS_MISO (&pin_PA06)

#define DEFAULT_UART_BUS_RX (&pin_PA15)
#define DEFAULT_UART_BUS_TX (&pin_PA14)

// USB is always used internally so skip the pin objects for it.
#define IGNORE_PIN_PA24     1
#define IGNORE_PIN_PA25     1

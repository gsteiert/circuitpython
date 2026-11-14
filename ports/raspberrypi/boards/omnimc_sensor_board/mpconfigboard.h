// This file is part of the CircuitPython project: https://circuitpython.org
//
// SPDX-FileCopyrightText: Copyright (c) 2024 Scott Shawcroft for Adafruit Industries
//
// SPDX-License-Identifier: MIT

#define MICROPY_HW_BOARD_NAME "OmniMC Sensor Board RP2354"
#define MICROPY_HW_MCU_NAME "rp2350a"

#define MICROPY_HW_NEOPIXEL (&pin_GPIO21)

#define DEFAULT_I2C_BUS_SCL (&pin_GPIO3)
#define DEFAULT_I2C_BUS_SDA (&pin_GPIO2)

#define DEFAULT_UART_BUS_RX (&pin_GPIO1)
#define DEFAULT_UART_BUS_TX (&pin_GPIO0)

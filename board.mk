include $(BOARD_DIR)/firmware/firmware.mk

BOARDINC += $(BOARD_DIR)/generated/controllers/generated

# defines SHORT_BOARD_NAME
include $(BOARD_DIR)/meta-info.env

# this would save some flash while being unable to update WBO controller firmware
DDEFS += -DEFI_WIDEBAND_FIRMWARE_UPDATE=FALSE

DDEFS += -DEFI_MAIN_RELAY_CONTROL=FALSE

# MCU defines
DDEFS += -DSTM32F407xx

# reduce memory usage monitoring
DDEFS += -DRAM_UNUSED_SIZE=100

DDEFS += -DSTM32_ADC_USE_ADC3=TRUE
# todo: make knock pin software-selectable?
DDEFS += -DEFI_SOFTWARE_KNOCK=TRUE -DSTM32_ADC_USE_ADC3=TRUE
DDEFS += -DKNOCK_SPECTROGRAM=FALSE

# assign critical LED to a non-existent pin if you do not have it on your board
# good old PD14 is still the default value
DDEFS += -DLED_CRITICAL_ERROR_BRAIN_PIN=Gpio::I15

//DDEFS += $(PRIMARY_COMMUNICATION_PORT_USART1)
//PRIMARY_COMMUNICATION_PORT_USART1=-DEFI_CONSOLE_TX_BRAIN_PIN=Gpio::A10 -DEFI_CONSOLE_RX_BRAIN_PIN=Gpio::A9 -DTS_PRIMARY_UxART_PORT=UARTD1 -DSTM32_UART_USE_USART1=1

# --- PUERTO PRIMARIO (USART1: A9 y A10) ---
PRIMARY_COMMUNICATION_PORT_USART1 = -DTS_PRIMARY_UxART_PORT=UARTD1 \
                                    -DSTM32_UART_USE_USART1=TRUE \
                                    -DEFI_CONSOLE_TX_BRAIN_PIN=Gpio::A9 \
                                    -DEFI_CONSOLE_RX_BRAIN_PIN=Gpio::A10 \
                                    -DTS_PRIMARY_BAUDRATE=115200

# --- PUERTO SECUNDARIO (USART2: PD5 y PD6) ---
SECONDARY_COMMUNICATION_PORT_USART2 = -DTS_SERIAL_PORT2=UARTD2 \
                                      -DSTM32_UART_USE_USART2=TRUE \
                                      -DEFI_CONSOLE_TX_BRAIN_PIN_2=Gpio::D5 \
                                      -DEFI_CONSOLE_RX_BRAIN_PIN_2=Gpio::D6 \
                                      -DTS_SERIAL_PORT2_BAUDRATE=115200

# Agregar ambos a las definiciones globales
DDEFS += $(PRIMARY_COMMUNICATION_PORT_USART1)
DDEFS += $(SECONDARY_COMMUNICATION_PORT_USART2)

# Flag de seguridad para evitar que la consola bloquee a TunerStudio
DDEFS += -DTS_NO_LOGS=TRUE

# we do not have much Lua RAM, let's drop some fancy functions
DDEFS += -DWITH_LUA_CONSUMPTION=FALSE
DDEFS += -DWITH_LUA_PID=FALSE
DDEFS += -DWITH_LUA_STOP_ENGINE=FALSE


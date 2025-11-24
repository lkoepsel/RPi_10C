# Environmental variables for specific boards
# See https://wellys.com/posts/avr_c_make_part2/ for more information
# Uncomment entire block less top line of block
# After switching boards, Library MUST BE RE-COMPILED
# Use "make LIB_clean && make all_clean && make flash" for a complete re-compile

# Baud rates to 250000 have been tested and work on Uno R3
# Baud rates above 230000 might not work on some ports or serial software
# TC3_RESET is only applicable to ATmega328PB, set to 0 for ATmega328P

# Example Serial Ports on Mac
# /dev/cu.usbserial-01D5BFFC
# /dev/cu.usbmodem5101
# /dev/cu.usbmodem3301
# /dev/cu.usbserial-AB0JQEUX
# /dev/cu.usbmodem14101

# Example Serial Ports on Linux
# /dev/ttyACM0

# Example Serial Ports on Windows
# COM3
# COM4
# COM9

# Using Arduino tools vs. GCC native
# For Arduino tool chain
# TOOLCHAIN [ arduino ]
# OS: [mac | windows | raspberry ]
# For GCC native, both TOOLCHAIN and OS need to be blank

# To reduce code size, remove the floating point library by
# setting 'FLOAT = ', in other words, delete the value YES
# To further reduce code size dramatically, don't use the AVR_C library, 
# set LIBRARY = no_lib, see examples/blink_avr
# 
# All functions must be in avr-libc (standard library), main.c or files in folder
# otherwise, leave blank

# Arduino UNO et al using Optiboot (standard Arduino IDE approach)
MCU = atmega328p
SERIAL = /dev/ttyACM0
F_CPU = 16000000UL
USB_BAUD = 250000UL
SOFT_RESET = 0
LIBDIR = $(DEPTH)Library
LIBRARY = 
FLOAT = YES
PROGRAMMER_TYPE = arduino
PROGRAMMER_ARGS = -F -V -P $(SERIAL) -b 115200
TOOLCHAIN = 
OS = 
TC3_RESET = 0
SOFT_BAUD = 28800UL

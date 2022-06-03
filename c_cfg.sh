. ./cfg.sh

_MCU_="atmega328p"

CROSS_OPTS="-mmcu=$_MCU_ -ffreestanding -nostartfiles -nostdlib -fno-builtin -fno-stack-protector -fno-PIC"

OPTI_LVL=-Os

_GCC_="$CROSS_PATH/bin/avr-gcc $CROSS_OPTS"
_ASM_="$_GCC_"
_GPP_="$CROSS_PATH/bin/avr-g++ $CROSS_OPTS -fno-exceptions -fno-rtti"
_CC_="$_GCC_ -std=c99 -Wall $OPTI_LVL"
_CXX_="$_GPP_ -std=c++17 -Wall $OPTI_LVL"
_LD_="$CROSS_PATH/bin/avr-ld -nostdlib"
_DISASM_="$CROSS_PATH/bin/avr-objdump -D"
_OBJCOPY_="$CROSS_PATH/bin/avr-objcopy"

#!/bin/sh

PROJ=blink

_PROJ_DIR_=$PWD
cd ..
. ./c_cfg.sh
cd $_PROJ_DIR_

$_CC_ -c $PROJ.c -o $PROJ.o
$_DISASM_ $PROJ.o > $PROJ.lst
$_LD_ $PROJ.o -o $PROJ.out
$_OBJCOPY_ -O binary -R .eeprom $PROJ.out $PROJ.bin
$_DISASM_ -m avr -b binary $PROJ.bin > $PROJ.bin.lst
# $_OBJCOPY_ -O ihex -R .eeprom $PROJ.out $PROJ.hex

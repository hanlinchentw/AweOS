## Makefile for AweOS 
# Targets:
#   make            → assemble boot.bin
#   make run        → assemble + run in QEMU
#   make clean      → remove artifacts

C_SOURCES = $(wildcard src/kernel/*.c src/drivers/*.c)
HEADERS = $(wildcard src/kernel/*.h src/drivers/*.h)
OBJ = ${C_SOURCES:.c=.o}

CC = ${PREFIX}/bin/i686-elf-gcc
GDB = ${PREFIX}/bin/i686-elf-gdb

ASM       			:= nasm
ASMFLAGS  			:= -f bin

BOOT_DIR  			:= src/boot
KERNEL_DIR  		:= src/kernel

BOOT_SRC  			:= ${BOOT_DIR}/boot.asm
BOOT_BIN       		:= ${BOOT_DIR}/boot.bin
KERNEL_ENTRY		:= ${BOOT_DIR}/kernel_entry.asm
KERNEL_ENTRY_OBJ	:= ${BOOT_DIR}/kernel_entry.o
KERNEL_SRC			:= ${KERNEL_DIR}/kernel.c

os-image.bin: ${BOOT_BIN} kernel.bin
	cat $^ > os-image.bin

${BOOT_BIN}: ${BOOT_SRC}
	nasm -f bin $< -o ${BOOT_BIN}

${KERNEL_ENTRY_OBJ}: ${KERNEL_ENTRY}
	nasm -f elf $< -o ${KERNEL_ENTRY_OBJ}

kernel.bin: ${KERNEL_ENTRY_OBJ} ${OBJ}
	i686-elf-ld -o kernel.bin -Ttext 0x1000 $^ --oformat binary

kernel.elf: kernel_entry.o ${OBJ}
	i686-elf-ld -o kernel.elf -Ttext 0x1000 $^

run: os-image.bin
	qemu-system-i386 -fda os-image.bin

# Generic rules for wildcards
# To make an object, always compile from its .c
%.o: %.c ${HEADERS}
	${CC} ${CFLAGS} -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf -o $@

%.bin: %.asm
	nasm $< -f bin -o $@

clean:
	rm -rf *.bin *.dis *.o os-image.bin *.elf
	rm -rf src/kernel/*.o src/boot/*.bin src/drivers/*.o src/boot/*.o	

.PHONY: all run clean

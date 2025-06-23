## Makefile for AweOS 
# Targets:
#   make            → assemble boot.bin
#   make run        → assemble + run in QEMU
#   make clean      → remove artifacts

ASM       := nasm
ASMFLAGS  := -f bin
BOOT_SRC  := ./boot/boot.asm
BOOT_BIN  := ./boot/boot.bin

all: $(BOOT_BIN)

$(BOOT_BIN): $(BOOT_SRC)
	$(ASM) $(ASMFLAGS) $< -o $@

run: $(BOOT_BIN)
	qemu-system-i386 -drive format=raw,file=$<

clean:
	$(RM) $(BOOT_BIN)

.PHONY: all run clean


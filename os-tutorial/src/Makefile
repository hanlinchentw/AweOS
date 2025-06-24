C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)
OBJ = ${C_SOURCES:.c=.o}

CC = ${PREFIX}/bin/i686-elf-gcc
GDB = ${PREFIX}/bin/i686-elf-gdb

CFLAGS = -g

os-image.bin: bootsect.bin kernel.bin
	cat $^ > os-image.bin

bootsect.bin: boot/bootsect.asm
	nasm -f bin $< -o bootsect.bin

kernel_entry.o: kernel/kernel_entry.asm
	nasm -f elf $< -o kernel_entry.o

kernel.bin: kernel_entry.o ${OBJ}
	i686-elf-ld -o kernel.bin -Ttext 0x1000 $^ --oformat binary

kernel.elf: kernel_entry.o ${OBJ}
	i686-elf-ld -o kernel.elf -Ttext 0x1000 $^

run: os-image.bin
	qemu-system-i386 -fda os-image.bin

debug: os-image.bin kernel.elf
	qemu-system-i386 -s -fda os-image.bin & 
	${GDB} -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"

%.o: %.c ${HEADERS}
	${CC} ${CFLAGS} -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf -o $@

%.bin: %.asm
	nasm $< -f bin -o %@

clean:
	rm -rf *.bin *.dis *.o os-image.bin *.elf
	rm -rf kernel/*.o boot/*.bin drivers/*.o boot/*.o	


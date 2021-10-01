
all:
	as --32 boot.s -o boot.o

	gcc -m32 -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2  -fno-stack-protector -Wall -Wextra

	ld -m elf_i386 -T linker.ld kernel.o boot.o -o Pactor.bin -nostdlib

	grub-file --is-x86-multiboot Pactor.bin

	mkdir -p isodir/boot/grub
	cp Pactor.bin isodir/boot/Pactor.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue /usr/lib/grub/i386-pc -o Pactor.iso isodir

	qemu-system-x86_64 -cdrom Pactor.iso

add:
	git add --all

clean:
	rm *.o
	rm log.txt

st:
	git status

ASM = nasm
BOOTLOADER_FILE = bootloader/bootloader.asm
KERNEL_FILE = kernel/not_a_kernel.asm

build: $(BOOTLOADER_FILE) $(KERNEL_FILE)
	$(ASM) -f bin $(BOOTLOADER_FILE) -o bootloader.o
	$(ASM) -f bin $(KERNEL_FILE) -o kernel.o
	dd if=bootloader.o of=kernel.img
	dd seek=1 conv=sync if=kernel.o of=kernel.img bs=512
	qemu-system-x86_64 -s kernel.img

clean:
	rm -f *.o kernel.img

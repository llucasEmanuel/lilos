start:
    mov ax, 07C0h ; BIOS loads the bootloader on address 07C00h
    mov ds, ax ; changes the DS start address

    mov si, title_str
    call print_str

    mov si, msg_str
    call print_str  

    call load_kernel_from_disk

    jmp 0900h:0000 ; jumps to a free point to start running the kernel

title_str db "lilOS bootloader", 0
msg_str   db "The kernel is loading...", 0

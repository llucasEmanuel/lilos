start:
    mov ax, 07C0h ; BIOS loads the bootloader on address 07C00h
    mov ds, ax ; changes the DS start address

    mov si, title_str
    call print_str

    mov si, msg_str
    call print_str  

    call load_kernel_from_disk

    jmp 0900h:0000 ; jumps to kernel memory address

load_kernel_from_disk:
    mov ax, 0900h
    mov es, ax ; sets 0900h on ES

    ; kernel stored right after the bootloader on disk

    mov ah, 02h ; service number = 02h (reads sectors from disk and write to memory)
    mov al, 01h ; number of sectors = 01h (dummy kernel don't exceed 512 bytes = 1 sector)
    mov ch, 0h ; track number from disk = 0h
    mov cl, 02h ; sector number from disk = 2h (2nd sector = right after the bootloader)
    mov dh, 0h ; head number = 0h
    mov dl, 80h ; disk type = 80h = hard disk #0
    mov bx, 0h ; memory addres the kernel will be loaded = 0h (actually 0900h:0h)
    int 13h ; calls disk service from BIOS (sets CF to 1 if an error occurs)

    jc kernel_load_error ; if CF = 1 then raise error

    ret

kernel_load_error:
    mov si, load_error_str
    call print_str ; prints error message 

    jmp $ ; infinite loop

print_str:
    mov ah, 0Eh ; write character service for 10h interrupt

print_char:
    lodsb ; loads 1 byte from DS:SI into AL
    cmp al, 0 ; checks for '\0'
    je end_print

    int 10h ; prints character from AL
    jmp print_char

end_print:
    mov al, 0Ah ; move to new line
    int 10h

    mov ah, 03h ; get cursor position
    mov bh, 0
    int 10h

    mov ah, 02h ; move cursor
    mov dl, 0 ; cursor to beggining position
    int 10h

    ret

title_str       db "lilOS kernel", 0
msg_str         db "The lilOS kernel is loading...", 0
load_error_str  db "lilOS kernel cannot be loaded", 0

times 510 - ($ - $$) db 0 ; fills the code with 0 leaving the last 2 bytes free

dw 0xAA55 ; "magic" 2 bytes code used fot bootloader identification


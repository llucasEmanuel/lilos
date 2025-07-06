start:
    mov ax, cs
    mov ds, ax

    ; ... ;

    mov si, kernel_str
    call print_str

    jmp $

print_str:
    mov ah, 0Eh
    
print_char:
    lodsb

    cmp al, 0
    je end

    int 10h

    jmp print_char

end:
    ret

kernel_str db "I am not a kernel i swear to god!", 0
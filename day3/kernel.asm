[org 0x1000]

mov si, MSG_KERNEL
call print_string

jmp $

print_string:
    pusha
    mov ah, 0x0e
print_loop:
    lodsb
    cmp al, 0
    je print_done
    int 0x10
    jmp print_loop
print_done:
    popa
    ret

MSG_KERNEL: db 'Kernel loaded and running!', 0
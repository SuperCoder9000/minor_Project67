[org 0x7c00]

mov si, message
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

message:
    db 'Yo Wassup! This is my OS booting up dawg. Peace!', 0

times 510-($-$$) db 0
dw 0xaa55
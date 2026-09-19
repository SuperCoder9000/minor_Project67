[org 0x7c00]

mov [BOOT_DRIVE], dl

mov si, MSG_REAL_MODE
call print_string

call load_kernel

jmp 0x1000

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

load_kernel:
    mov bx, 0x1000
    mov dh, 5
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret

disk_load:
    push dx
    mov ah, 0x02
    mov al, dh
    mov ch, 0x00
    mov dh, 0x00
    mov cl, 0x02
    int 0x13
    jc disk_error
    pop dx
    cmp al, dh
    jne sectors_error
    ret

disk_error:
    mov si, MSG_DISK_ERROR
    call print_string
    jmp $

sectors_error:
    mov si, MSG_SECTORS_ERROR
    call print_string
    jmp $

BOOT_DRIVE: db 0
MSG_REAL_MODE: db 'Loading kernel from disk...', 0
MSG_DISK_ERROR: db 'Disk read error!', 0
MSG_SECTORS_ERROR: db 'Incorrect number of sectors read!', 0

times 510-($-$$) db 0
dw 0xaa55
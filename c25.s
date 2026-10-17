.section .bss
    .lcomm buf_n, 3

.section .data
    guide_str: .string "Nhap chuoi (4 ky tu): "
    guide_str_len = 22

    guide_n: .string "Nhap n (0-9): "
    guide_n_len = 14

    out_buf: .ascii "0000\n"
    out_len = 5

.section .text
    .global _start

_start:
    movl $guide_str_len, %edx
    movl $guide_str, %ecx
    movl $1, %ebx
    movl $4, %eax
    int $0x80

    movl $6, %edx
    movl $out_buf, %ecx
    movl $0, %ebx
    movl $3, %eax
    int $0x80

    movl $guide_n_len, %edx
    movl $guide_n, %ecx
    movl $1, %ebx
    movl $4, %eax
    int $0x80

    movl $3, %edx
    movl $buf_n, %ecx
    movl $0, %ebx
    movl $3, %eax
    int $0x80

    movb buf_n, %bl
    subb $48, %bl

    movb out_buf+0, %al
    subb $'a', %al
    addb %bl, %al
    movzbl %al, %eax
    movb $26, %dl
    divb %dl
    addb $'a', %ah
    movb %ah, out_buf+0

    movb out_buf+1, %al
    subb $'a', %al
    addb %bl, %al
    movzbl %al, %eax
    movb $26, %dl
    divb %dl
    addb $'a', %ah
    movb %ah, out_buf+1

    movb out_buf+2, %al
    subb $'a', %al
    addb %bl, %al
    movzbl %al, %eax
    movb $26, %dl
    divb %dl
    addb $'a', %ah
    movb %ah, out_buf+2

    movb out_buf+3, %al
    subb $'a', %al
    addb %bl, %al
    movzbl %al, %eax
    movb $26, %dl
    divb %dl
    addb $'a', %ah
    movb %ah, out_buf+3

    movl $out_len, %edx
    movl $out_buf, %ecx
    movl $1, %ebx
    movl $4, %eax
    int $0x80

    movl $0, %ebx
    movl $1, %eax
    int $0x80

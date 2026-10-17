.section .data
    guide: .string "Enter a string: "
    guide_len = 16

    out_buf: .ascii "00000\n"
    out_len = 6

.section .text
    .global _start

_start:
    movl $guide_len, %edx
    movl $guide, %ecx
    movl $1, %ebx
    movl $4, %eax
    int $0x80

    movl $7, %edx
    movl $out_buf, %ecx
    movl $0, %ebx
    movl $3, %eax
    int $0x80

    subb $32, out_buf+0
    subb $32, out_buf+1
    subb $32, out_buf+2
    subb $32, out_buf+3
    subb $32, out_buf+4

    movl $out_len, %edx
    movl $out_buf, %ecx
    movl $1, %ebx
    movl $4, %eax
    int $0x80

    movl $0, %ebx
    movl $1, %eax
    int $0x80

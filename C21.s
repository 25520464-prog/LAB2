.section .data
    msg: .string "NT209UIT"
    msg_end:

    out_buf: .ascii "0\n"
    out_len = 2

.section .text
    .global _start

_start:
    movl $msg_end, %eax
    subl $msg, %eax
    subl $1, %eax

    addl $48, %eax
    movb %al, out_buf+0

    movl $out_len, %edx
    movl $out_buf, %ecx
    movl $1, %ebx
    movl $4, %eax
    int $0x80

    movl $0, %ebx
    movl $1, %eax
    int $0x80

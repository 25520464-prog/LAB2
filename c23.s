.section .bss
    .lcomm num, 3

.section .data
    guide: .string "Enter a number: "
    guide_len = 16

    out_buf: .ascii "Reminder: 0\n"
    out_len = 12

.section .text
    .global _start

_start:
    movl $0, %esi

    movl $guide_len, %edx
    movl $guide, %ecx
    movl $1, %ebx
    movl $4, %eax
    int $0x80

    movl $3, %edx
    movl $num, %ecx
    movl $0, %ebx
    movl $3, %eax
    int $0x80

    movzx num, %eax
    subl $48, %eax
    addl %eax, %esi

    movl $guide_len, %edx
    movl $guide, %ecx
    movl $1, %ebx
    movl $4, %eax
    int $0x80

    movl $3, %edx
    movl $num, %ecx
    movl $0, %ebx
    movl $3, %eax
    int $0x80

    movzx num, %eax
    subl $48, %eax
    addl %eax, %esi

    movl $guide_len, %edx
    movl $guide, %ecx
    movl $1, %ebx
    movl $4, %eax
    int $0x80

    movl $3, %edx
    movl $num, %ecx
    movl $0, %ebx
    movl $3, %eax
    int $0x80

    movzx num, %eax
    subl $48, %eax
    addl %eax, %esi

    movl $guide_len, %edx
    movl $guide, %ecx
    movl $1, %ebx
    movl $4, %eax
    int $0x80

    movl $3, %edx
    movl $num, %ecx
    movl $0, %ebx
    movl $3, %eax
    int $0x80

    movzx num, %eax
    subl $48, %eax
    addl %eax, %esi

    movl %esi, %eax
    movb $8, %bl
    divb %bl
    
    movb %ah, %al
    addb $48, %al
    movb %al, out_buf+10

    movl $out_len, %edx
    movl $out_buf, %ecx
    movl $1, %ebx
    movl $4, %eax
    int $0x80

    movl $0, %ebx
    movl $1, %eax
    int $0x80

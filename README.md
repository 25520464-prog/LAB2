.section .data
    msg_prompt:     .string "Enter a year (4-digits): "
    len_prompt = . - msg_prompt

    msg_leap:       .string "Nam nhuan\n"
    len_leap = . - msg_leap

    msg_not_leap:   .string "Khong phai nam nhuan\n"
    len_not_leap = . - msg_not_leap

.section .bss
    .lcomm buf, 6

.section .text
.globl _start

_start:
    movl $4, %eax
    movl $1, %ebx
    movl $msg_prompt, %ecx
    movl $len_prompt, %edx
    int $0x80

    movl $3, %eax
    movl $0, %ebx
    movl $buf, %ecx
    movl $6, %edx
    int $0x80

    movl $0, %eax
    movl $buf, %esi

    movzbl (%esi), %ebx
    subl $'0', %ebx
    imull $10, %eax, %eax
    addl %ebx, %eax

    movzbl 1(%esi), %ebx
    subl $'0', %ebx
    imull $10, %eax, %eax
    addl %ebx, %eax

    movzbl 2(%esi), %ebx
    subl $'0', %ebx
    imull $10, %eax, %eax
    addl %ebx, %eax

    movzbl 3(%esi), %ebx
    subl $'0', %ebx
    imull $10, %eax, %eax
    addl %ebx, %eax

    movl %eax, %ecx

    movl %ecx, %eax
    movl $0, %edx
    movl $400, %ebx
    divl %ebx
    cmpl $0, %edx
    je is_leap

    movl %ecx, %eax
    movl $0, %edx
    movl $100, %ebx
    divl %ebx
    cmpl $0, %edx
    je not_leap

    movl %ecx, %eax
    movl $0, %edx
    movl $4, %ebx
    divl %ebx
    cmpl $0, %edx
    je is_leap

not_leap:
    movl $4, %eax
    movl $1, %ebx
    movl $msg_not_leap, %ecx
    movl $len_not_leap, %edx
    int $0x80
    jmp exit_prog

is_leap:
    movl $4, %eax
    movl $1, %ebx
    movl $msg_leap, %ecx
    movl $len_leap, %edx
    int $0x80

exit_prog:
    movl $1, %eax
    movl $0, %ebx
    int $0x80

.section .data
    msg_prompt:     .string "Enter a year (4-digits): "
    len_prompt = . - msg_prompt
    msg_leap:       .string "Nam nhuan\n"
    len_leap = . - msg_lea
    msg_not_leap:   .string "Khong phai nam nhuan\n"
    len_not_leap = . - msg_not_leap
    msg_next_leap:  .string "Nam nhuan ke tiep: "
    len_next_leap = . - msg_next_leap
    newline:        .string "\n"
.section .bss
    .lcomm buf, 6
    .lcomm num_str, 12
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

    movl %eax, %edi

    call is_leap_year
    cmpl $1, %eax
    je is_leap

not_leap:
    movl $4, %eax
    movl $1, %ebx
    movl $msg_not_leap, %ecx
    movl $len_not_leap, %edx
    int $0x80
    jmp find_next

is_leap:
    movl $4, %eax
    movl $1, %ebx
    movl $msg_leap, %ecx
    movl $len_leap, %edx
    int $0x80

find_next:
    movl %edi, %eax
    addl $1, %eax

search_loop:
    pushq %rax
    call is_leap_year
    cmpl $1, %eax
    popq %rax
    je found_next
    addl $1, %eax
    jmp search_loop

found_next:
    movl %eax, %esi

    movl $4, %eax
    movl $1, %ebx
    movl $msg_next_leap, %ecx
    movl $len_next_leap, %edx
    int $0x80

    movl %esi, %eax
    call print_number

    movl $4, %eax
    movl $1, %ebx
    movl $newline, %ecx
    movl $1, %edx
    int $0x80

    movl $1, %eax
    movl $0, %ebx
    int $0x80

is_leap_year:
    pushq %rbx
    pushq %rcx
    pushq %rdx

    movl %eax, %ecx

    movl %ecx, %eax
    movl $0, %edx
    movl $400, %ebx
    divl %ebx
    cmpl $0, %edx
    je leap_true

    movl %ecx, %eax
    movl $0, %edx
    movl $100, %ebx
    divl %ebx
    cmpl $0, %edx
    je leap_false

    movl %ecx, %eax
    movl $0, %edx
    movl $4, %ebx
    divl %ebx
    cmpl $0, %edx
    je leap_true

leap_false:
    movl $0, %eax
    jmp leap_done

leap_true:
    movl $1, %eax

leap_done:
    popq %rdx
    popq %rcx
    popq %rbx
    ret

print_number:
    pushq %rax
    pushq %rbx
    pushq %rcx
    pushq %rdx
    pushq %rsi

    movl $num_str, %esi
    addl $11, %esi
    movb $0, (%esi)

    movl $10, %ebx

convert_loop:
    movl $0, %edx
    divl %ebx
    addl $'0', %edx
    decl %esi
    movb %dl, (%esi)
    cmpl $0, %eax
    jg convert_loop

    movl $num_str, %edx
    addl $11, %edx
    subl %esi, %edx

    movl $4, %eax
    movl $1, %ebx
    movl %esi, %ecx
    int $0x80

    popq %rsi
    popq %rdx
    popq %rcx
    popq %rbx
    popq %rax
    ret

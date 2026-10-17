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

    movl $0, %esi

process_loop:
    cmpl $4, %esi
    jge print_result

    movb out_buf(%esi), %al

check_lower:
    cmpb $'a', %al
    jl check_upper
    cmpb $'z', %al
    jg check_upper

    subb $'a', %al
    addb %bl, %al
    movzbl %al, %eax
    movb $26, %dl
    divb %dl
    addb $'a', %ah
    movb %ah, out_buf(%esi)
    jmp next_char

check_upper:
    cmpb $'A', %al
    jl next_char
    cmpb $'Z', %al
    jg next_char

    subb $'A', %al
    addb %bl, %al
    movzbl %al, %eax
    movb $26, %dl
    divb %dl
    addb $'A', %ah
    movb %ah, out_buf(%esi)

next_char:
    incl %esi
    jmp process_loop

print_result:
    movl $out_len, %edx
    movl $out_buf, %ecx
    movl $1, %ebx
    movl $4, %eax
    int $0x80

    movl $0, %ebx
    movl $1, %eax
    int $0x80

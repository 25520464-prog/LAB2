.section .data
    prompt:     .string "Nhap 1 so (5 chu so): "
    len_prompt = . - prompt

    msg_yes:    .string "Doi xung\n"
    len_yes    = . - msg_yes

    msg_no:     .string "Khong doi xung\n"
    len_no     = . - msg_no

.section .bss
    .lcomm input, 6       

.section .text
    .globl _start

_start:
    #inthongtin
    movl $4, %eax
    movl $1, %ebx
    movl $prompt, %ecx
    movl $len_prompt, %edx
    int $0x80
    #doc
    movl $3, %eax
    movl $0, %ebx
    movl $input, %ecx
    movl $6, %edx
    int $0x80
    #chuynso
    movl $0, %eax         
    movl $input, %esi     
    movl $5, %ecx         
convert_loop:
    imull $10, %eax, %eax 
    movzbl (%esi), %ebx   
    subl $'0', %ebx       
    addl %ebx, %eax       
    incl %esi             
    loop convert_loop     
    #taosodaokt
    movl %eax, %edi       
    movl %eax, %ebx     
    movl $0, %ecx         
reverse_loop:
    cmpl $0, %ebx
    jle check_palindrome
    movl %ebx, %eax
    movl $0, %edx
    movl $10, %esi
    divl %esi             
    movl %eax, %ebx      
    imull $10, %ecx, %ecx 
    addl %edx, %ecx       
    jmp reverse_loop
check_palindrome:
    cmpl %ecx, %edi       
    jne not_equal
is_equal:
    movl $4, %eax
    movl $1, %ebx
    movl $msg_yes, %ecx
    movl $len_yes, %edx
    int $0x80
    jmp exit
not_equal:
    movl $4, %eax
    movl $1, %ebx
    movl $msg_no, %ecx
    movl $len_no, %edx
    int $0x80
exit:
    movl $1, %eax
    movl $0, %ebx
    int $0x80



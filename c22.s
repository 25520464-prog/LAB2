.section .bss
    .lcomm MSSV, 10

.section .data
    guide: .string "Nhap MSSV: "
    guide_len = 11

    out_buf: .ascii "000000\nSinh vien nam: 0\n"
    out_len = 24

.section .text
    .global _start

_start:
    movl $guide_len, %edx
    movl $guide, %ecx
    movl $1, %ebx
    movl $4, %eax
    int $0x80

    movl $10, %edx
    movl $MSSV, %ecx
    movl $0, %ebx
    movl $3, %eax
    int $0x80

    movb MSSV+0, %al
    movb %al, out_buf+0         
    movb MSSV+1, %al
    movb %al, out_buf+1         
    
    movb MSSV+4, %al
    movb %al, out_buf+2         
    movb MSSV+5, %al
    movb %al, out_buf+3         
    movb MSSV+6, %al
    movb %al, out_buf+4         
    movb MSSV+7, %al
    movb %al, out_buf+5         

    movb MSSV+0, %al
    subb $48, %al               
    movb $10, %cl
    imulb %cl                    
    
    movb MSSV+1, %bl
    subb $48, %bl               
    addb %bl, %al               

    movb $26, %cl
    subb %al, %cl               
    addb $1, %cl                
    
    addb $48, %cl               
    movb %cl, out_buf+22        

    movl $out_len, %edx         
    movl $out_buf, %ecx         
    movl $1, %ebx               
    movl $4, %eax               
    int $0x80

    movl $0, %ebx               
    movl $1, %eax               
    int $0x80

.section .data

string: .space 400
format_scan_string: .asciz "%s"
format_print_char: .asciz "%c"
newline: .asciz "\n"

.section .text
.global main

main:
    pushl $string
    pushl $format_scan_string
    call scanf
    addl $8, %esp

    lea string, %edi

    movl $0, %eax
    movzbl (%edi), %eax    

    movl $0x80, %ebx       

print_bits:
    test %ebx, %eax        
    jz bit_is_zero

    // If the bit is set, print '1'
    movl $'1', %ecx
    jmp print_bit

bit_is_zero:
    // If the bit is not set, print '0'
    movl $'0', %ecx

print_bit:
    pushl %ecx
    pushl $format_print_char
    call printf
    addl $8, %esp          
    shrl $1, %ebx          
    cmp $0, %ebx          
    jne print_bits        

    // After printing the bits, print a newline for readability
    pushl $newline
    call printf
    addl $4, %esp

    // Exit sequence
    pushl $0
    call fflush
    addl $4, %esp

    movl $1, %eax
    xor %ebx, %ebx
    int $0x80

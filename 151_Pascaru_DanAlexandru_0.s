.data

m: .long 0
n: .long 0

m2: .long 0
n2: .long 0

m3: .long 0
n3: .long 0

i: .long 0
j: .long 0

i2: .long 0
j2: .long 0

index: .long 0
index2: .long 0

p: .long 0

k: .long 0

a: .space 1600
b: .space 1600

format_scan: .asciz "%ld"
format_space: .asciz "%ld "
format_new_line: .asciz "\n"
format_new_line_2: .asciz "%d\n"

.text

.global main

main:

    pushl $m
    pushl $format_scan
    call scanf
    addl $8, %esp

    pushl $n
    pushl $format_scan
    call scanf
    addl $8, %esp

    pushl $p
    pushl $format_scan
    call scanf
    addl $8, %esp

    movl m, %ecx
    movl %ecx, m3
    addl $1, m3    

    movl n, %ecx
    movl %ecx, n3
    addl $1, n3 

    movl m, %ecx
    movl %ecx, m2
    addl $2, m2    

    movl n, %ecx
    movl %ecx, n2
    addl $2, n2 
   
    movl $0, index

et_for_p:

   movl index, %ecx
   cmp %ecx, p
   je et_next_generation

   pushl $i
   pushl $format_scan
   call scanf
   addl $8, %esp

   pushl $j
   pushl $format_scan
   call scanf
   addl $8, %esp

   incl i
   incl j

   movl i, %eax
   movl $0, %edx
   mull n2
   addl j, %eax

   lea a, %edi
   movl $1, (%edi,%eax,4) 
   
   incl index
   jmp et_for_p

et_next_generation:
       
    pushl $k
    pushl $format_scan
    call scanf
    addl $8, %esp

    movl $0, index

    for_k: 
        movl index, %ecx
        cmp %ecx,k 
        je et_afis_a

        movl $1, i
            
            for_i:
                movl i, %ecx
                cmp %ecx, m3
                je suprascriere

                movl $1, j

                    for_j:
                        movl j, %ecx
                        cmp %ecx, n3
                        je cont_i

                        //restabilim pe ce matrice suntem
                       
                        
                        movl i, %eax
                        movl $0, %edx
                        mull n2
                        addl j, %eax

                        movl $0, %ebx
                        
                        lea a, %edi

                        //vecin stanga
                        decl %eax
                        addl (%edi, %eax, 4), %ebx
                        //vecin drepta
                        add $2, %eax
                        addl (%edi, %eax, 4), %ebx
                        //vecin sus
                        decl %eax
                        subl n2, %eax
                        addl (%edi, %eax, 4), %ebx
                        //vecin dreapta sus
                        incl %eax
                        addl (%edi, %eax, 4), %ebx
                        //vecin stanga sus
                        subl $2, %eax
                        addl (%edi, %eax, 4), %ebx
                        //vecin jos
                        incl %eax
                        addl n2, %eax
                        addl n2, %eax
                        addl (%edi, %eax, 4), %ebx
                        //vecin jos dreapta
                        incl %eax
                        addl (%edi, %eax, 4), %ebx
                        //vecin jod stanga
                        subl $2, %eax
                        addl (%edi, %eax, 4), %ebx
                        //revine cum il stiam
                        incl %eax
                        subl n2, %eax 

                        movl (%edi, %eax, 4), %esi

                        //verificam ce fel de celula avem
                        cmp $1, %esi
                        je comparam1

                        jmp comparam0
                         
                        //next generation alive
                        comparam1:
                            
                            cmp $2, %ebx
                            je adauga1
                            
                            cmp $3, %ebx
                            je adauga1

                            jmp adauga0

                        //next gen dead
                        comparam0:

                            cmp $3, %ebx
                            je adauga1

                            jmp adauga0
                        //adugam in matricea utilitara
                        adauga0:

                            lea b, %edi
                            movl $0, (%edi,%eax,4)
                            jmp continua

                        adauga1:

                            lea b, %edi
                            movl $1, (%edi,%eax,4)
                            jmp continua

                        continua:
                            incl j
                            jmp for_j

                cont_i:
                incl i
                jmp for_i

    suprascriere:
        movl $0, i2

            for_lini:
            movl i2, %ecx
            cmp %ecx, m2
            je cont_k

            movl $0,j2
                for_coloane:
                    movl j2, %ecx
                    cmp %ecx, n2
                    je cont_linie

                    movl i2, %eax
                    movl $0, %edx
                    mull n2
                    addl j2, %eax

                    lea a, %edi
                    lea b, %esi

                    movl (%esi, %eax, 4), %ebx
                    movl %ebx, (%edi, %eax, 4)

                    incl j2
                    jmp for_coloane

                cont_linie:
                    incl i2
                    jmp for_lini

    cont_k:
        
        incl index
        jmp for_k


et_afis_a:

    movl $1, i

    for_lines: 

        movl i, %ecx
        cmp %ecx, m3
        je et_exit

        movl $1, j

        for_columns:
            
            movl j, %ecx
            cmp %ecx, n3
            je cont 

            movl i, %eax
            movl $0, %edx
            mull n2
            addl j, %eax

            lea a, %edi
            movl (%edi,%eax,4),%ebx

            pushl %ebx
            pushl $format_space
            call printf
            addl $8, %esp

            pushl $0
            call fflush
            popl %ebx

            incl j
            jmp for_columns
        
    cont: 

        pushl $format_new_line
        call printf
        popl %ebx

        pushl $0
        call fflush
        popl %ebx

        incl i
        jmp for_lines




et_exit:
    movl $1, %eax
    xor %ebx, %ebx
    int $0x80

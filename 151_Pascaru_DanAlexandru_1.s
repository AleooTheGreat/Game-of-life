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

caz: .long 0

p: .long 0

k: .long 0

a: .space 1600
b: .space 1600


string: .space 500
coder: .space 500

index3: .long 0
counter: .long 0

format_scan_string: .asciz "%s"
format_print_long: .asciz "%ld"
format_newline: .asciz "\n"
format_scan: .asciz "%ld"
format_space: .asciz "%ld "
format_new_line: .asciz "\n"
format_new_line_2: .asciz "%d\n"
format_print_char: .asciz "%c"

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
        je xorat

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

xorat:

    pushl $caz
    pushl $format_scan
    call scanf
    addl $8, %esp

    pushl $string
    pushl $format_scan_string
    call scanf
    addl $8, %esp

    lea string, %edi

    movl caz, %ebx

    cmp $0, %ebx
    je et_for_caz_1 

    jmp et_for_caz_2

et_for_caz_2:

        lea coder, %esi
        
        xor %eax, %eax
        movzbl (%edi), %eax

        incl %edi

        xor %eax, %eax
        movzbl (%edi), %eax
        
        incl %edi

        movl $0, counter


    for_string2:

        pushl %edi
        xor %eax, %eax
        movzbl (%edi), %eax

        cmp $0, %eax
        je for_coder_2

        cmp $48, %eax
        je pune0

        cmp $49, %eax
        je pune1

        cmp $50, %eax
        je pune2

        cmp $51, %eax
        je pune3

        cmp $52, %eax
        je pune4

        cmp $53, %eax
        je pune5

        cmp $54, %eax
        je pune6

        cmp $55, %eax
        je pune7

        cmp $56, %eax
        je pune8

        cmp $57, %eax
        je pune9

        cmp $65, %eax
        je puneA

        cmp $66, %eax
        je puneB

        cmp $67, %eax
        je puneC

        cmp $68, %eax
        je puneD

        cmp $69, %eax
        je puneE

        cmp $70, %eax
        je puneF


        pune0:	

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        jmp cont_string_2

        pune1:	

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        jmp cont_string_2

        pune2:	

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        jmp cont_string_2

        pune3:

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter
        
        jmp cont_string_2

        pune4:	

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        jmp cont_string_2

        pune5:	

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        jmp cont_string_2

        pune6:	

        
        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        jmp cont_string_2

        pune7:	

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        jmp cont_string_2

        pune8:	

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        jmp cont_string_2

        pune9:	

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        jmp cont_string_2

        puneA:	

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        jmp cont_string_2

        puneB:	

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        jmp cont_string_2

        puneC:	

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        jmp cont_string_2

        puneD:	

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        jmp cont_string_2

        puneE:	

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $0, (%esi,%ebx,4)
        incl counter

        jmp cont_string_2

        puneF:	

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        movl counter, %ebx
        movl $1, (%esi,%ebx,4)
        incl counter

        jmp cont_string_2


        cont_string_2:

        incl %edi
        jmp for_string2

for_coder_2:
    lea coder, %esi
    lea b, %edi

    movl $0, index3
    movl $0, index

    for_afisat2:

        movl $1, %eax
        mull n2
        mull m2

        movl %eax, %ecx


        cmp index, %ecx
        je reset_index2

        movl index3, %ecx
        cmp counter, %ecx
        je afisare_caractere

        movl (%esi,%ecx,4), %ebx

        movl index, %ecx
        movl (%edi, %ecx,4), %eax
        xor %eax, %ebx

        movl index3, %ecx
        movl %ebx, (%esi,%ecx,4)
        
        incl index
        incl index3
        jmp for_afisat2

reset_index2:
    movl $0, index
    lea b, %edi
    jmp for_afisat2


afisare_caractere:
    
    movl $0, index

    for_hai_sa_afisam2:
        movl index, %ecx
        cmp counter, %ecx
        je et_exit

        movl (%esi,%ecx,4), %ebx
        incl %ecx

        movl (%esi,%ecx,4), %eax
        shl $1, %ebx
        xor %eax, %ebx
        incl %ecx
        
        movl (%esi,%ecx,4), %eax
        shl $1, %ebx
        xor %eax, %ebx
        incl %ecx

        movl (%esi,%ecx,4), %eax
        shl $1, %ebx
        xor %eax, %ebx
        incl %ecx

        movl (%esi,%ecx,4), %eax
        shl $1, %ebx
        xor %eax, %ebx
        incl %ecx

        movl (%esi,%ecx,4), %eax
        shl $1, %ebx
        xor %eax, %ebx
        incl %ecx

        movl (%esi,%ecx,4), %eax
        shl $1, %ebx
        xor %eax, %ebx
        incl %ecx

        movl (%esi,%ecx,4), %eax
        shl $1, %ebx
        xor %eax, %ebx 

        movl %ecx, index

        pushl %ebx
        pushl $format_print_char
        call printf
        addl $8, %esp

        pushl $0
        call fflush
        addl $4, %esp

        incl index
        jmp for_hai_sa_afisam2



et_for_caz_1:

        lea coder, %esi

        movl $0, counter

        for_string:

            pushl %edi
            xor %eax, %eax
            movzbl (%edi), %eax 

            cmp $0, %eax
            je for_coder_1

            movl $128, %ebx
            movl $0, %ecx
            movl $0, index3

            for_chr:
                movl index3, %ecx
                cmp $8, %ecx
                je cont_a

                incl counter

                pushl %eax

                and %ebx, %eax

                cmp $0, %eax
                je print0
                jmp print1

                cont:
                    shr $1, %ebx
                    popl %eax
                    incl index3
                    jmp for_chr

            cont_a:
                popl %edi
                incl %edi
                jmp for_string




        print0:
            pushl %eax
            movl counter, %eax
            decl %eax
            movl $0, (%esi,%eax,4)
            popl %eax
            jmp cont 

        print1:
            pushl %eax
            movl counter, %eax
            decl %eax
            movl $1, (%esi,%eax,4)
            popl %eax
            jmp cont


for_coder_1:
    lea coder, %esi
    lea b, %edi

    movl $0, index3
    movl $0, index

    for_afisat:

        movl $1, %eax
        mull n2
        mull m2

        movl %eax, %ecx


        cmp index, %ecx
        je reset_index

        movl index3, %ecx
        cmp counter, %ecx
        je afisare_hexa

        movl (%esi,%ecx,4), %ebx

        movl index, %ecx
        movl (%edi, %ecx,4), %eax
        xor %eax, %ebx

        movl index3, %ecx
        movl %ebx, (%esi,%ecx,4)
        
        incl index
        incl index3
        jmp for_afisat

reset_index:
    movl $0, index
    lea b, %edi
    jmp for_afisat

afisare_hexa:

    movl $48, %ebx
    pushl %ebx
    pushl $format_print_char
    call printf
    addl $8, %esp      

    pushl $0
    call fflush
    addl $4, %esp 

    movl $120, %ebx
    pushl %ebx
    pushl $format_print_char
    call printf
    addl $8, %esp       

    pushl $0
    call fflush
    addl $4, %esp 

    
    movl $0, index

    for_hai_sa_afisam:
        movl index, %ecx
        cmp counter, %ecx
        je et_exit

        movl (%esi,%ecx,4), %ebx
        incl %ecx

        movl (%esi,%ecx,4), %eax
        shl $1, %ebx
        xor %eax, %ebx
        incl %ecx
        
        movl (%esi,%ecx,4), %eax
        shl $1, %ebx
        xor %eax, %ebx
        incl %ecx

        movl (%esi,%ecx,4), %eax
        shl $1, %ebx
        xor %eax, %ebx

        movl %ecx, index

        cmp $10, %ebx         
        jl is_digit           
        addl $55, %ebx         
        jmp print_hex

is_digit:
    addl $48, %ebx
    pushl %ebx
    pushl $format_print_char
    call printf
    addl $8, %esp      
    
    pushl $0
    call fflush
    addl $4, %esp 

    jmp continuam

print_hex:
    pushl %ebx            
    pushl $format_print_char  
    call printf           
    addl $8, %esp         

    pushl $0
    call fflush
    addl $4, %esp 

    jmp continuam

continuam:
    
    incl index
    jmp for_hai_sa_afisam


et_exit:

movl $1, %eax
xor %ebx, %ebx
int $0x80


section .text
global _start

calculate:
    mov r8, 255 ; idx 
    mov r9, 0 ; r9 = reminder
    mov rax, 0
    mov r10, 0

calculateBegin:
    mov r10, 0
    cmp r8, 0
    jl calculateEnd 
    mov al, byte [rdi + r8]
    cmp byte [rdi + r8], 0
    je nxt
    sub al, 48 
    inc r10 
nxt:
    add al, byte [rsi + r8]
    cmp byte [rsi + r8], 0
    je nxtnxt
    sub al, 48
    inc r10 
nxtnxt:
    cmp r9, 0 
    je nxtnxtnxt
    add al, r9b
    inc r10
nxtnxtnxt:
    cmp r10, 0 
    je calculateEnd
    push rdx 
    mov rdx, 0 
    mov rbx, 10 
    div rbx 
    mov r9, rax 
    mov r12, rdx 
    pop rdx 
    add r12, 48 
    mov byte [rdx + r8], r12b
    
    dec r8 
    jmp calculateBegin

calculateEnd:
    ret 

init:
    mov r8, 255 
    mov r12, 0

init_begin:
    cmp r8, 0
    jl init_end
    mov byte [rdi + r8], 0
    dec r8 
    jmp init_begin

init_end:
    ret

memcpy:
    mov r8, 255 
    mov r12, 0

memcpy_begin:
    cmp r8, 0
    jl memcpy_end
    mov r12b, byte [rsi + r8]
    mov byte [rdi + r8], r12b 
    dec r8 
    jmp memcpy_begin

memcpy_end:
    ret

str_to_int:
    mov rax, 0 
    mov r8, 0 
    mov r12, 0 

str_to_intBegin:
    mov r12b, byte [rdi + r8]
    cmp r12b, 0 
    je str_to_intEnd 
    cmp r12b, 0xa 
    je str_to_intEnd 
    mov rbx, 10 
    mul rbx 
    sub r12, 48 
    add rax, r12 
    inc r8
    jmp str_to_intBegin

str_to_intEnd:
    ret

strlen:
    mov r8, 255
    mov r12, 0 

strlen_begin:
    mov r12b, byte [rdi + r8]
    cmp r12b, 0 
    je strlen_end 
    dec r8 
    jmp strlen_begin

strlen_end:
    mov rax, r8
    ret 

print_fibo:
    call strlen ;
    mov rdx, 255 
    sub rdx, rax
    add rax, 1 
    lea rsi, [rdi + rax]
    mov rdi, 1 
    mov rax, 1 
    syscall

    mov rax, 1 
    mov rdi, 1 
    lea rsi, [aespaWinter]
    mov rdx, 1 
    syscall
    ret

_start:
    mov r10, 0 
    mov byte [num1 + 255], 49 
    mov byte [num2 + 255], 49 
    
    mov rax, 0
    mov rdi, 0
    lea rsi, [n_str]
    mov rdx, 11
    syscall
    
    lea rdi, [n_str]
    call str_to_int 
    mov byte [n], al
    mov rcx, 1 

solve:
    cmp cl, byte [n]
    jg end 
    lea rdi, [num1]
    push rcx 
    call print_fibo

    lea rdi, [num1]
    lea rsi, [num2]
    lea rdx, [num3]
    call calculate

    lea rdi, [num1]
    lea rsi, [num2]
    call memcpy

    lea rdi, [num2]
    lea rsi, [num3] 
    call memcpy

    pop rcx 
    inc rcx 
    jmp solve

solve_begin:

end:
    mov rax, 60 
    mov rdi, 0 
    syscall

section .data  
    aespaWinter db 0xa 

section .bss
    n_str resb 11
    n resb 1 
    num1 resb 256 
    num2 resb 256 
    num3 resb 256 
    num1_length resb 1 
    num2_length resb 1 
    num3_length resb 1 

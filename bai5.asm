section .text
global _start

print_int:
    push rbp 
    mov rbp, rsp 
    sub rsp, 10 
    mov r8, 0 
    mov r12, 0
    mov rax, rdi 

print_int_begin:
    cmp rax, 0
    je print_int_end 
    mov rdx, 0 
    mov rbx, 10 
    div rbx 
    add rdx, 48 
    ; lea r11, [rsp + 10 - r8]
    inc r8 
    lea r11, [rsp + 10]
    sub r11, r8 
    mov byte [r11], dl
    jmp print_int_begin

print_int_end:
    mov rax, 1 
    mov rdi, 1 
    lea rsi, [rsp + 10]
    sub rsi, r8 
    mov rdx, r8 
    syscall 

    mov rsp, rbp 
    pop rbp 
    ret

memcmp: ; rdi = S[i], rsi = C, rdx = C_length
    mov r8, 0 ; for r8 in range(C_length)
    mov rax, 0 

memcmp_begin:
    cmp r8, rdx 
    jge memcmp_returnTrue
    mov r12b, byte [rdi + r8]
    cmp r12b, byte [rsi + r8]
    jne memcmp_returnFalse 
    inc r8 
    jmp memcmp_begin

memcmp_returnFalse:
    mov rax, 0 
    ret 

memcmp_returnTrue:
    mov rax, 1
    ret 

strlen:
    mov r8, 0 
    mov r12, 0 

strlen_begin:
    mov r12b, byte [rdi + r8]
    cmp r12b, 0 
    je strlen_end 
    cmp r12b, 0xa
    je strlen_end 
    inc r8 
    jmp strlen_begin

strlen_end:
    mov rax, r8
    ret

_start:

    mov rax, 0 
    mov rdi, 0 
    lea rsi, [S]
    mov rdx, 101
    syscall
    
    lea rdi, [S]
    call strlen 
    mov byte [S_length], al 

    mov rax, 0 
    mov rdi, 0 
    lea rsi, [C]
    mov rdx, 11
    syscall 

    lea rdi, [C]
    call strlen 
    mov byte [C_length], al

solve:
    mov r8, 0 ; for r8 in range(len(S))
    mov r9, 0 ; answer 
    mov byte [stack + r10], 32 
    add r10, 1 

solve_begin:
    cmp r8b, byte [S_length]
    jge solve_end 
    lea rdi, [S]
    add rdi, r8 
    lea rsi, [C]
    movzx rdx, byte [C_length]
    push r8 
    call memcmp 
    pop r8
    cmp rax, 1 
    jne nxt_loop
    
    mov rcx, 0
    mov rax, r8 
    inc r9 
    cmp rax, 0 
    jne pushStack
    mov byte [stack + r10], 48 
    add r10, 1 
    jmp pushStack_end

pushStack:
    cmp rax, 0 
    je pushStack_popStack
    mov rdx, 0 
    mov rbx, 10 
    div rbx 
    add rdx, 48 
    push rdx 
    inc rcx 
    jmp pushStack

pushStack_popStack:
    pop rdx 
    mov byte [stack + r10], dl 
    add r10, 1
    dec rcx 
    cmp rcx, 0 
    je pushStack_end 
    jmp pushStack_popStack

pushStack_end: 
    mov byte [stack + r10], 32 
    add r10, 1 

nxt_loop:
    inc r8
    jmp solve_begin 

solve_end:
    mov rdi, r9 
    call print_int
    
    sub r10, 1 
    mov rax, 1 
    mov rdi, 1 
    lea rsi, [stack]
    mov rdx, r10
    syscall

end:
    mov rax, 60
    mov rdi, 0 
    syscall 


section .bss 
    stack resb 256
    S resb 105
    C resb 15 
    S_length resb 1 
    C_length resb 1 

section .text
global _start

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

solve:
    movzx r11, byte [len1] ; r11 = len1
    mov r8, 0

solve1:
    cmp r11, 0 
    je nxt_solve
    ; lea r10, [answer + 20 - r8]
    lea r10, [answer + 20]
    sub r10, r8
    ; lea r12, [num1 + r11 - 1]
    lea r12, [num1 - 1]
    add r12, r11
    mov r12b, byte [r12]
    mov byte [r10], r12b
    inc r8
    dec r11 
    jmp solve1 

nxt_solve:
    mov r8, 0 
    movzx r11, byte [len2]
    mov rbx, 0 ; nho'

nxt_solve_begin:
    mov rax, 0
    cmp r11, 0 
    jle nxt_solve_end
    ; lea r12, [num2 + r11 - 1]
    lea r12, [num2 - 1]
    add r12, r11 
    mov al, byte [r12] ; sum = [r12]
    sub al, 48 

nxt_solve_mid:
    ; lea r10, [answer + 20 - r8]
    lea r10, [answer + 20]
    sub r10, r8
    add al, byte [r10]
    cmp al, 48
    jl nxt_mid
    sub al, 48  
nxt_mid:
    movzx rax, al 
    add rax, rbx 
    mov rdx, 0
    mov rcx, 10 ; rax = rax / rcx 
    div rcx 
    mov rbx, rax 
    add rdx, 48 
    ; lea r10, [answer + 20 - r8]
    lea r10, [answer + 20]
    sub r10, r8 
    mov byte [r10], dl 
    inc r8 
    dec r11 
    jmp nxt_solve_begin

nxt_solve_end:
    cmp rbx, 0 
    je end_solve 
    jmp nxt_solve_mid

end_solve:
    mov rax, 1 
    mov rdi, 1 
    lea rsi, [answer]
    mov rdx, 21 
    syscall
    ret 

_start:
    mov rax, 0 
    mov rdi, 0 
    lea rsi, [num1]
    mov rdx, 21
    syscall
    ; read(0, num1, 21)
    
    mov rax, 0
    mov rdi, 0 
    lea rsi, [num2]
    mov rdx, 21
    syscall
    ; read(0, num2, 21)
    
    lea rdi, [num1]
    call strlen 
    mov byte [len1], al 
    ; len1 = strlen(num1)

    lea rdi, [num2]
    call strlen 
    mov byte [len2], al
    ; len2 = strlen(num2)

    call solve

    mov rax, 60 
    mov rdi, 0 
    syscall

section .bss 
    num1 resb 25
    num2 resb 25 
    answer resb 25
    len1 resb 1 
    len2 resb 1 

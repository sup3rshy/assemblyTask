section .text
global _start

solve:
    push rbp 
    mov rbp, rsp 
    sub rsp, 256
    mov r12, 0 
    mov r8, 0 ; r8 = strlen

solve_begin:
    mov r12b, byte [rdi + r8] 
    cmp r12, 0 
    je solve_end
    cmp r12, 0xa 
    je solve_end 
    ; lea r11, [rsp + 256 - r8]
    inc r8
    lea r11, [rsp + 256]
    sub r11, r8
    mov byte [r11], r12b
    jmp solve_begin

solve_end:
    ; print 
    mov rax, 1 
    mov rdi, 1 
    ; lea rsi, [rsp + 256 - r8]
    lea rsi, [rsp + 256]
    sub rsi, r8
    mov rdx, r8
    syscall
    mov rsp, rbp 
    pop rbp 
    ret 

_start:
    sub rsp, 300

    mov rax, 0 
    mov rdi, 0 
    lea rsi, [rsp] 
    mov rdx, 256 
    syscall
    ; read(0, rsp, 256)
    lea rdi, [rsp] 
    call solve

exit:
    mov rax, 60 
    mov rdi, 0 
    syscall

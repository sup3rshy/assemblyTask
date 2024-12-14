section .text
global _start
_start:
    sub rsp, 0x40
    lea r10, [rsp] ; num1 
    mov rax, 0 
    mov rdi, 0 
    mov rsi, r10 
    mov rdx, 11
    syscall 
    ; read(0, num1, 11)
    mov r8, 0 
    lea rdi, [rsp]
    call stoi 
    add r8, rax 
    ; r8 = r8 + rax 
    lea r11, [rsp + 0x20] ; num2 
    mov rax, 0 
    mov rdi, 0 
    mov rsi, r11 
    mov rdx, 11
    syscall
    ; read(0, num2, 11)
    lea rdi, [rsp + 0x20] 
    call stoi 
    add r8, rax 
    ; r8 = r8 + rax 
    mov rax, r8 
    mov r12, 0 
to_string:
    cmp rax, 0 
    je print 
    mov rdx, 0 
    mov rbx, 10 
    div rbx 
    add rdx, 48
    add r12, 1 
    push rdx 
    jmp to_string 
print:
    mov rax, 1 
    mul r12 
    mov r12, 8 
    mul r12 
    mov rdx, rax 
    mov rax, 1 
    mov rdi, 1 
    lea rsi, [rsp] 
    syscall 
    ; write(1, rsp, 8 * len)
exit:
    mov rax, 60 
    mov rdi, 0 
    syscall 
    ; exit(0)
stoi:
    mov rax, 0
    mov rbx, 0 
    mov r12, 0 
loop:
    cmp rbx, 10 
    jg end_loop
    lea rdx, [rdi + rbx] 
    mov r12b, byte [rdx] 
    cmp r12b, 10 
    je end_loop
    cmp r12b, 0
    je end_loop
    sub r12b, 48
    imul rax, 10 
    add rax, r12 
    add rbx, 1 
    jmp loop 
end_loop:
    ret 

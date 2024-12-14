section .text
global _start
_start:

    sub rsp, 0x20 ; allocate 32 bytes 
    mov rax, 0
    mov rdi, 0 
    mov rsi, rsp
    mov rdx, 0x20 
    syscall
    ; read(0, buffer, 0x20)
    ; start loop 
    mov rax, 0 
loop:
    cmp rax, 0x20 
    jg end_loop 
    lea rbx, [rsp + rax]
    mov r10b, byte [rbx]
    cmp r10b, 122 
    jg nxt_loop 
    cmp r10b, 97 
    jl nxt_loop 
    sub r10b, 32 
    mov byte [rbx], r10b 
nxt_loop:
    add rax, 1 
    jmp loop 
end_loop:
    ; end loop 
    mov rax, 1 
    mov rdi, 1 
    mov rsi, rsp 
    mov rdx, 0x20 
    syscall  
    ; write(1, buffer, 0x20)

    mov rax, 60 
    mov rdi, 0 
    syscall
    ; exit(0)

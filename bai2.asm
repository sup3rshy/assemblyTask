section .text
global _start
_start:

    sub rsp, 0x20 ; allocate 0x20 bytes 
    mov rax, 0
    mov rdi, 0 
    mov rsi, rsp
    mov rdx, 0x20 
    syscall
    ; read(0, buffer, 0x20)

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

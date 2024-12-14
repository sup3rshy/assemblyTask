section .text
global _start
_start:
    mov rax, 1 ; syscall write
    mov rdi, 1 ; arg0 
    mov rsi, my_string ; arg1 
    mov rdx, 13 ; arg2
    syscall  
    ; write(1, my_string, 13)

    mov rax, 60 ; syscall exit
    mov rdi, 0 ; arg0
    syscall
    ; exit(0)

; Data 
section .data 
    my_string db "Hello, World!", 0

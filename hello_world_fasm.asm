format ELF64 executable 3

; Three sections in every x86 assembly file: ".data", ".text", ".bss"

segment readable                ; where data is defined before compilation (.data in nasm)
    text db 'Hello, World!', 10 ; Define bytes "Hello, World!" and declare as variable "text"

segment readable executable      ; actual code goes here (.text in nasm)
entry $
    mov rax, 1      ; Set syscall "sys_write" by ID in rax register (1 = sys_write(#filedescriptor (number), $buffer (memory address to the register), count (number)))
    mov rdi, 1      ; Filedescriptor (0 = input, 1 = output, 2 = error)
    mov rsi, text   ; Buffer (variable)
    mov rdx, 14     ; Length of "Hello, World\n"
    syscall

    mov rax, 60     ; Set syscall "sys_exit" by ID
    mov rdi, 0      ; Error code (0 = no error, anything else = error)
    syscall

;section readable writable       ; allocate memory for future use (.bss in nasm)
; Three sections in every x86 assembly file: ".data", ".text", ".bss"

section .data                ; where data is defined before compilation
    text db 'Hello, World!', 10 ; Define bytes "Hello, World!" and declare as variable "text"
    loop_text db 'Looooop', 10
    counter dd 0
    max dd 10

section .text      ; actual code goes here
    default rel
    extern printf
    global main     ; defines entry point
    
main:
    push rbp        ; push to bottom of stack

    mov rax, 1      ; Set syscall "sys_write" by ID in rax register (1 = sys_write(#filedescriptor (number), $buffer (memory address to the register), count (number)))
    mov rdi, 1      ; Filedescriptor (0 = input, 1 = output, 2 = error)
    mov rsi, text   ; Buffer (variable)
    mov rdx, 14     ; Length of "Hello, World\n"
    syscall

    call _loop

    call printf wrt ..plt

    pop rbp         ; pop/release from bottom of stack

    call _exit

_loop:
    mov eax, [max]          ; move max value into eax register
    cmp eax, dword[counter] ; compare value from eax register with counter
    je _exit                ; if max = counter

    mov rax, 1
    mov rdi, 1
    mov rsi, loop_text
    mov rdx, 8
    syscall

    add dword [counter], 1
    
    call _loop            ; if counter < max: do recursion

_exit:
    mov rax, 60     ; Set syscall "sys_exit" by ID
    mov rdi, 0      ; Error code (0 = no error, anything else = error) (also possible: "xor rdi, rdi" bc XORing value to itself is zero (takes less bytes in memory))
    syscall

section .bss       ; allocate memory for future use
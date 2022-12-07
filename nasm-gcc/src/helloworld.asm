; cheatsheet: https://www.cs.uaf.edu/2005/fall/cs301/support/x86/nasm.html
; guide: https://www.tutorialspoint.com/assembly_programming/assembly_quick_guide.htm
; doc: https://www.nasm.us/doc/
; doc: https://nasm.us/doc/nasmdoc3.html
; 10: \n
; 13: \r

;@see https://www.cs.uaf.edu/2017/fall/cs301/lecture/09_11_registers.html#:~:text=eax%20is%20the%2032%2Dbit,processors%20with%20the%2080386%20CPU.
;rax: is the 64-bit, "long" size register.  It was added in 2003 during the transition to 64-bit processors.
;eax: is the 32-bit, "int" size register.  It was added in 1985 during the transition to 32-bit processors with the 80386 CPU.  I'm in the habit of using this register size, since they also work in 32 bit mode, although I'm trying to use the longer rax registers for everything.
;ax: is the 16-bit, "short" size register.  It was added in 1979 with the 8086 CPU, but is used in DOS or BIOS code to this day.
;al;ah: are the 8-bit, "char" size registers.  al is the low 8 bits, ah is the high 8 bits.  They're pretty similar to the old 8-bit registers of the 8008 back in 1972.

;rax: 64-bit extends: eax: 32-bit	extends: ax: 16-bit	extends: ah	al. But it's all the same register! Probably for compatibility reasons.

;rax: Values are returned from functions in this register. 
;rdi: Scratch register.  Function argument #1 in 64-bit Linux
;rsi: Scratch register.  Also used to pass function argument #2 in 64-bit Linux
;rcx: Typical scratch register.  Some instructions also use it as a counter.
;rdx: Scratch register.
;rbx: Preserved register: don't use it without saving it!
;rsp: The stack pointer.  Points to the top of the stack
;rbp: Preserved register.  Sometimes used to store the old value of the stack pointer, or the "base".
;r8;r9;r10;r11: Scratch register.  These were added in 64-bit mode, so they have numbers, not names.
;r12;r13;r14;r15: Preserved register.  You can use it, but you need to save and restore it.

; Macros:
%macro print 1 
  mov rax, 1
  mov rdi, 1
  mov rsi, %1
  mov rdx, 14
  syscall
%endmacro


; section for embedded constants
section .data 
hello_world: db 'hello world!', 13, 10 ; `db` (data byte) to allocate some space, and fill it with a string "hello world!", 10 (line feed).


; section for variables
section .bss 
   user_input resb 25    ; user input
   user_input_length equ $- user_input


; section for commands
section .text 
    global _start
_start:
         mov  eax, 3 ; sys_read
         mov  ebx, 0 ; stdin
         mov  ecx, user_input ; user input
         mov  edx, user_input_length ; max length
         int  80h
         

         mov  eax, 4             ; sys_write
         mov  ebx, 1             ; stdout
         mov  ecx, user_input           ; buffer
         mov  edx, user_input_length          ; length
         int  80h

         mov    eax, 1
         mov    ebx, 0
         int    80h

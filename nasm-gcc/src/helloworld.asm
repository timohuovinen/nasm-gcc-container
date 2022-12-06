; cheatsheet: https://www.cs.uaf.edu/2005/fall/cs301/support/x86/nasm.html
; guide: https://www.tutorialspoint.com/assembly_programming/assembly_quick_guide.htm
; doc: https://www.nasm.us/doc/
; doc: https://nasm.us/doc/nasmdoc3.html
; 10: \n
; 13: \r

; Macros:
%macro print 1 
  mov rax, 1
  mov rdi, 1
  mov rsi, %1
  mov rdx, 14
  syscall
%endmacro

section .data ; section for embedded constants
hello_world: db 'hello world!', 13, 10 ; `db` (data byte) to allocate some space, and fill it with a string "hello world!", 10 (line feed).

section .text ; section for code
global _start

_start:
  print hello_world

  mov rax, 60
  xor rdi, rdi
  syscall

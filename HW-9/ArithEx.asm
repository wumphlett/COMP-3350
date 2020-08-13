; ArithEx.asm - Compute an arithmetic expression, return it to the stack
; Will Humphlett - COMP 3350

.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

include Irvine32.inc

.data
	intro byte "This program will compute the value of the expression x = a + b - c",0
	a_prompt byte "Please enter a value for a: ",0
	b_prompt byte "Please enter a value for b: ",0
	c_prompt byte "Please enter a value for c: ",0
	answer byte "The value of x is: ",0
.code
main proc
	mov edx, offset intro
	call WriteString
	call crlf
	mov edx, offset a_prompt  ; get a value
	call WriteString
	call ReadInt
	push eax
	mov edx, offset a_prompt  ; get b value
	call WriteString
	call ReadInt
	push eax
	mov edx, offset a_prompt  ; get c value
	call WriteString
	call ReadInt
	push eax
	mov ebx, 10
	call arithmetic_expression
	mov eax, [esi]
	mov edx, offset answer
	call WriteString
	call WriteInt
	call crlf
	exit
main endp

arithmetic_expression proc
	pop ebx        ; return address
	pop edx
	pop eax
	sub eax, edx
	pop edx
	add eax, edx
	push eax
	mov esi, esp
	push ebx       ; return address
	ret
arithmetic_expression endp

end main
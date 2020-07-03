; 5Values.asm - Take 5 user inputs, store them in the stack, then pop and print each one
; Will Humphlett - COMP 3350

.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

include Irvine32.inc

.data
	PromptUser BYTE "Please enter a value: ", 0
.code
main proc
	mov ecx, 5
	mov edx, offset PromptUser

	get_ints:
		call WriteString
		call ReadInt
		push eax
	loop get_ints

	mov ecx, 5
	call crlf

	print_ints:
		pop eax
		call WriteInt
		call crlf
	loop print_ints

	exit
main endp

end main
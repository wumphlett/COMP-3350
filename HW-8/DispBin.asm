; DispBin.asm - Display register as binary
; Will Humphlett - COMP 3350

.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

include Irvine32.inc

.data
	int_prompt byte "Provide an int to display as binary: ",0
	bin_result byte "Binary representation: ",0
.code
main proc
	mov edx, offset int_prompt
	call WriteString
	call ReadInt
	mov bx, ax
	mov edx, offset bin_result
	call WriteString

	mov ecx, 16
	l1:
		shl bx, 1
		jnc l2
		mov eax, 1
		call WriteDec
		jmp l3
	l2:
		mov eax, 0
		call WriteDec
	l3:
		loop l1
	call crlf
	
	exit
main endp

end main
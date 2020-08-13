; AddBCD.asm - Add two packed binary coded decimals
; Will Humphlett - COMP 3350

.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

include Irvine32.inc

.data
	iteration byte "Iteration count ",0
	first byte "The first packed bcd number: ",0
	second byte "The second packed bcd number: ",0
	answer byte "The result of addition is ",0
	test_data qword 0999999999h, 1h, 123456789h, 123456789h, 100h, 10h
.code
main proc
	mov ecx, 3
	mov esi, 0
	l1:
		mov edx, offset iteration
		call WriteString
		mov eax, 4
		sub eax, ecx
		call WriteDec
		call crlf

		mov edx, offset first
		call WriteString
		mov eax, dword ptr test_data[esi+4]
		call WriteHex
		mov eax, dword ptr test_data[esi]
		call WriteHex
		call crlf
		mov ebx, dword ptr test_data[esi]
		mov edx, 0
		mov dl, byte ptr test_data[esi+4]
		push edx

		add esi, 8
		mov edx, offset second
		call WriteString
		mov eax, dword ptr test_data[esi+4]
		call WriteHex
		mov eax, dword ptr test_data[esi]
		call WriteHex
		call crlf
		mov eax, dword ptr test_data[esi]
		pop edx
		mov dh, byte ptr test_data[esi+4]

		push ecx
		mov ecx, 4
		l2:
			clc
			cmp ecx, 1
			je adjust
			add al, bl
			daa
			adc ah, 0
			ror eax, 8
			ror ebx, 8
		loop l2

		adjust:
		add al, bl
		daa
		ror eax, 8
		ror ebx, 8

		pop ecx
		mov edi, eax
		movzx eax, dh
		adc al, dl
		daa

		push edx
		mov edx, offset answer
		call WriteString
		call WriteHex
		mov eax, edi
		call WriteHex
		call crlf
		call crlf
		pop edx

		add esi, 8
	dec cx
	jne l1
	exit
main endp

end main
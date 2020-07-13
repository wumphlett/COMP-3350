; SearchInts.asm - Fill the stack with ints, then search for a given value
; Will Humphlett - COMP 3350

.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

include Irvine32.inc

.data
	open_prompt		byte "Please enter the # of integers to place in the stack [1 - 127]: ",0
	prompt			byte "Please input a value: ",0
	target_prompt	byte "Please input a target value: ",0
	string1			byte "The target value is ",0
	string2			byte ", and is located at index: ",0
	target_value	dword ?
.code
main proc
	mov al, -1
	mov edx, offset open_prompt

	.while al > 127 || al == 0
		call WriteString
		call ReadInt
	.endw

	mov bl, al; Save off total item number

	movzx ecx, bl
	mov edx, offset prompt
	call crlf

	populate_stack:
		call WriteString
		call ReadInt
		push eax
	loop populate_stack

	call crlf
	mov edx, offset target_prompt
	call WriteString
	call ReadInt
	mov [target_value], eax

	call Search

	call crlf
	mov edx, offset string1
	call WriteString
	mov eax, [target_value]
	call WriteInt
	mov edx, offset string2
	call WriteString
	mov eax, esi
	call WriteInt
	call crlf

	exit
main endp

Search proc
	pop edi       ; Remove return address from stack
	movzx ecx, bl
	mov esi, 0
	
	search_loop:
		pop eax
		.if eax == [target_value]
			mov edx, ecx
			sub edx, 1
			mov esi, edx
		.endif
	loop search_loop

	push edi      ; Replace return address on the stack
	ret
Search endp

end main
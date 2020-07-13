; XorEncode.asm - Encode a string with a key using the xor instruction
; Will Humphlett - COMP 3350

.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

include Irvine32.inc

.data
	string_name byte "Will Humphlett",0
	key = 28h
	to_encode byte "The string to be encoded is: ",0
	encode byte "The encoded string is: ",0
	decode byte "The string is decoded back to: ",0
.code
main proc
	mov edx, offset to_encode
	call WriteString
	mov edx, offset string_name
	call WriteString
	call crlf

	mov ecx, lengthof string_name - 1
	mov esi, 0
	encode_loop:
		xor string_name[esi], key
		inc esi
	loop encode_loop

	mov edx, offset encode
	call WriteString
	mov edx, offset string_name
	call WriteString
	call crlf

	mov ecx, lengthof string_name - 1
	mov esi, 0
	decode_loop:
		xor string_name[esi], key
		inc esi
	loop decode_loop

	mov edx, offset decode
	call WriteString
	mov edx, offset string_name
	call WriteString
	call crlf
		
	exit
main endp

end main
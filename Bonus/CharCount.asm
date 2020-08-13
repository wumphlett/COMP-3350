; CharCount.asm - Count the characters in a string
; Will Humphlett - COMP 3350

.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

include Irvine32.inc

.data
	prompt byte "String to count: ",0
	answer byte "There are ",0
	answer_fin byte " characters in the string",0
	test_1 byte "This is a test string",0
	test_2 byte "I wonder what will happen with this string",0
	test_3 byte "I cant have an empty string so heres the best I can do",0
.code
main proc
	mov edx, offset prompt
	call WriteString
	mov edx, offset test_1
	call WriteString
	call crlf
	mov edx, offset answer
	call WriteString
	mov eax, lengthof test_1
	sub eax, 1
	call WriteDec
	mov edx, offset answer_fin
	call WriteString
	call crlf
	call crlf

	mov edx, offset prompt
	call WriteString
	mov edx, offset test_2
	call WriteString
	call crlf
	mov edx, offset answer
	call WriteString
	mov eax, lengthof test_2
	sub eax, 1
	call WriteDec
	mov edx, offset answer_fin
	call WriteString
	call crlf
	call crlf

	mov edx, offset prompt
	call WriteString
	mov edx, offset test_3
	call WriteString
	call crlf
	mov edx, offset answer
	call WriteString
	mov eax, lengthof test_3
	sub eax, 1
	call WriteDec
	mov edx, offset answer_fin
	call WriteString
	call crlf
	call crlf
	exit
main endp

end main
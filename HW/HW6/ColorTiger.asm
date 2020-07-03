; ColorTiger.asm - Display "War Eagle" in color
; Will Humphlett - COMP 3350

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

INCLUDE Irvine32.inc

.data
	prompt	BYTE "Please enter an integer [0 - 2]: ",0
	cheer	BYTE "War Eagle",0
.code
main proc
	mov eax, -1
	mov edx, offset prompt

	.while eax < 0 || eax > 2
		call WriteString
		call ReadInt
	.endw

	mov bx, ax
	call crlf

	call DisplayTiger
	call crlf

	exit
main endp

DisplayTiger proc uses eax edx
	.if bx == 0
		mov eax, blue + (white*16)      ; bx == 0, Print "War Eagle" in blue
	.elseif bx == 1
		mov eax, yellow + (red*16)      ; bx == 1, print "War Eagle" in 'orange' (yellow w/ red back)
	.else
		mov eax, white + (black*16)     ; bx == ?, print "War Eagle" in normal white on black
	.endif

	call SetTextColor

	mov edx, offset cheer
	call WriteString

	mov eax, white + (black*16)
	call SetTextColor
	ret
DisplayTiger endp

end main
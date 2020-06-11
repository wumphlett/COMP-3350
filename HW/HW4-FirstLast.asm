; FirstLast.asm - Print Firstname and Lastname
; Will Humphlett - COMP 3350

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

INCLUDE Irvine32.inc

.data
message BYTE "Will Humphlett",0

.code
main proc
	mov edx, offset message
	call WriteString
	exit

main endp
end main
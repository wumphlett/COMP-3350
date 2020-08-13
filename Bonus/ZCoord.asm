; ZCoord.asm - Print the Z coords of an array of 3d points
; Will Humphlett - COMP 3350

.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

include Irvine32.inc

coordinate struct
	x word ?
	y word ?
	z word ?
coordinate ends

.data
	prompt byte "Here are the z coords for a list of ten 3d coordinate pairs:",0
	set_of_coords coordinate 10 dup(<>)
	example_z_coords word 2d,5d,8d,1d,9d,3d,4d,0d,7d,6d
.code
main proc
	mov edx, offset prompt
	call WriteString
	call crlf

	mov ecx, 10
	mov esi, 0
	mov edi, 0
	l1:
		mov bx, example_z_coords[edi]
		mov set_of_coords[esi].z, bx
		add esi, sizeof coordinate
		add edi, 2
	loop l1

	mov ecx, 10
	mov ebx, offset set_of_coords
	mov esi, 4
	mov eax, 0
	l2:
		mov ax, [ebx+esi]
		call WriteDec
		call crlf
		add ebx, sizeof coordinate
	loop l2
	exit
main endp

end main
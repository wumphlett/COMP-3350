; EvenSearch.asm - Search an array for the first even integer
; Will Humphlett - COMP 3350

.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

include Irvine32.inc

.data
	test_array dword 1,2,3,4,5,6,7,8         ; Mixed Ints
	;test_array dword 1,3,5,7,9,11           ; All odds
	;test_array dword 2,4,6,8,10,12          ; All evens
	starting_info byte "The array to be searched is: ",0
	spacing byte ", ",0
	failure byte "No even integer found.",0
	success byte "Even integer found at ",0
	more_info byte " with a value of ",0
.code
main proc	
	mov edx, offset starting_info
	call WriteString
	mov edx, offset spacing
	mov esi, 0
	mov ecx, lengthof test_array
	print_array:
		mov eax, test_array[esi*4]
		call WriteInt
		call WriteString
		inc esi
	loop print_array
	call crlf

	mov eax, 0
	mov esi, 0
	mov ecx, lengthof test_array
	find_even:
		mov eax, test_array[esi*4]

		test eax, 01h
		jz even_found

		inc esi
	loop find_even
	
	mov edx, offset failure
	call WriteString
	call crlf
	exit

	even_found:
		mov edx, offset success
		call WriteString
		push eax
		mov eax, esi
		call WriteInt
		mov edx, offset more_info
		call WriteString
		pop eax
		call WriteInt
		call crlf
	exit
main endp

end main
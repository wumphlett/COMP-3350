; BinMult.asm - Demonstrate Binary Multiplication & Divide Hex into Dec
; Will Humphlett - COMP 3350

.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

include Irvine32.inc

.data
	mult_prompt byte "Provide an int to be multiplied by 27: ",0
    mult_result byte "Your int * 27: ",0
    mov_prompt byte "Moving the decimal components of ABCD1234 into dh and dl",0
    dh_value byte "dh: ",0
    dl_value byte ", dl: ",0
.code
main proc
	mov edx, offset mult_prompt
	call WriteString
	call ReadInt
    call bin_mult
    mov edx, offset mult_result
    call WriteString
    call WriteInt

    call crlf
    call crlf

    mov edx, offset mov_prompt
    call WriteString
    call crlf
    mov eax, 0ABCD1234h
    mov ecx, 16
    into_dl:
        shr eax, 1
        rcr dx, 1
    loop into_dl

    push edx
    mov edx, offset dh_value
    call WriteString
    pop edx
    movzx eax, dh
    call WriteHex
    push edx
    mov edx, offset dl_value
    call WriteString
    pop edx
    movzx eax, dl
    call WriteHex
    call crlf

	exit
main endp

bin_mult proc uses ebx ecx edx
    mov ebx, 27d
    mov edx, eax    ; store original multiplicand into EDX
    mov ecx, 32     ; loop for 32 bits
    mov eax, 0      ; eax will accumulate the result
 
begin_loop:
    shr edx, 1      ; shift lowest bit into carry flag
    jnc dont_add    ; jump if carry flag not set
    add eax, ebx
dont_add:
    shl ebx, 1      ; shifting multiplies EBX by 2
    loop begin_loop

    ret
bin_mult endp

end main
; RobotSensor.asm - Evaluate a robot's sensors and determine if action is needed
; Will Humphlett - COMP 3350

.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

include Irvine32.inc

.data
	agree_msg byte "Agree",0
	disagree_msg byte "Disagree",0
	action_msg byte ", Take Action",0
	test_data byte 0,0, 40,40, 20,20, 70,70, -20,-20, -70,-70, 30,40, -50,70
	test_msg byte "Test Iteration ",0
	colon byte ":",0
	sensor1 byte "Sensor 1: ",0
	spacing byte ", ",0
	sensor2 byte "Sensor 2: ",0
.code
main proc
	mov ecx, lengthof test_data / 2
	mov esi, 0
	mov edi, 1
	test_loop:
		mov edx, offset test_msg
		call WriteString
		mov eax, edi
		call WriteDec
		mov edx, offset colon
		call WriteString
		call crlf
		mov edx, offset sensor1
		call WriteString
		movsx eax, test_data[esi]
		call WriteInt
		mov edx, offset spacing
		call WriteString
		mov edx, offset sensor2
		call WriteString
		movsx eax, test_data[esi+1]
		call WriteInt
		call crlf

		movsx eax, test_data[esi]
		movsx ebx, test_data[esi+1]
		call sensor
		call crlf
		call crlf

		add esi, 2
		inc edi
	loop test_loop
	exit
main endp

sensor proc uses edx
	mov edx, eax
	sub edx, ebx

	;Flow Chart: Determine if sensors agree, if they do determine if an action is recommended
	;if edx <= 2 || edx >= -2
	cmp edx, 2
	jbe agree
	cmp edx, -2
	jb	disagree

	agree:
		mov edx, offset agree_msg
		call WriteString

		;if eax >= 40 && ebx >= 40
		cmp eax, 40
		jl return
		cmp ebx, 40
		jl return

		action:
			mov edx, offset action_msg
			call WriteString
			jmp return
		
	;else
	disagree:
		mov edx, offset disagree_msg
		call WriteString
	
	return:
	ret
sensor endp

end main
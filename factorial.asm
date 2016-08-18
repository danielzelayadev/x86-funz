mov eax, 1	; fact = 1
mov ebx, 6	; n = 6
mov ecx, 1	; for i = 1

loop:
	cmp ebx, ecx
	jl show_result
	imul eax, ecx	; fact = fact * i
	inc ecx
	jmp loop

show_result:
	#show eax	; EasyASM directive


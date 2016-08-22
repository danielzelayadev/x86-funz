main:
	push ebp
	mov ebp, esp

	; Push 5-Character String to Stack

	push 0x00000067
	push 0x64636241

	; Push Param

	push esp

	call strlen
	#show eax		; Print Answer (EasyASM Directive)

	jmp end

strlen:
	; Prologue

	push ebp
	mov ebp, esp
	push 0       ; len = 0

	; Body

	mov ebx, dword [ ebp + 8 ] ; ebx = char* str

	while:
		movzx edx, byte [ ebx ] ; edx = *str
		cmp edx, 0
		je return

		inc dword [ ebp - 4 ]   ; len++

		inc ebx                 ; str++
		jmp while

	return:
		mov eax, dword [ ebp - 4 ]

	; Epilogue

	mov esp, ebp
	pop ebp
	ret

end:
	; Cleaning the stack ;)

	mov esp, ebp
	pop ebp
main:
	push ebp
	mov ebp, esp

	push 47		; int x = 47
	push 50		; int y = 50

	mov eax, ebp
	mov ebx, ebp
	sub eax, 4		; eax = &x
	sub ebx, 8		; ebx = &y

	push ebx
	push eax

	call swap

	mov eax, dword [ ebp - 4 ]
	#show eax					; Print x

	mov eax, dword [ ebp - 8 ]
	#show eax					; Print y

	jmp end

swap:
	push ebp
	mov ebp, esp

	mov eax, dword [ ebp + 8 ]
	mov eax, dword [ eax ]
	push eax			; int temp = *x

	mov eax, dword [ ebp + 12 ]
	mov eax, dword [ eax ]
	mov ebx, dword [ ebp + 8 ]
	mov dword [ ebx ], eax		; *x = *y

	mov eax, dword [ ebp + 12 ]
	mov ebx, dword [ ebp -4 ]
	mov dword [ eax ], ebx		; *y = temp

	mov esp, ebp
	pop ebp
	ret

end:
	; Cleanup

	mov esp, ebp
	pop ebp
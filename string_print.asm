main:
	push ebp
	mov ebp, esp
	sub esp, 4

	mov dword [ ebp - 4 ], 0x00476567

	mov eax, ebp
	sub eax, 4
	push eax
	call string_print

	jmp end

string_print:	; Args (char *str)
	push ebp
	mov ebp, esp

	while:
		mov   eax, dword [ ebp + 8 ]
		#show eax
		movzx eax, byte [ eax ]
		cmp eax, 0
		je end_funct

		push eax
		call print

		inc dword [ ebp + 8 ]
		jmp while

	end_funct:

	mov esp, ebp
	pop ebp
	ret

print:		; Not an actual print
	push ebp
	mov ebp, esp

	#show byte [ ebp + 8 ] hex

	mov esp, ebp
	pop ebp
	ret

end:
	; Cleanup

	mov esp, ebp
	pop ebp
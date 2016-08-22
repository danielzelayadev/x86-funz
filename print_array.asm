main:
	push ebp
	mov ebp, esp
	sub esp, 20

	; 4-Byte Element Array

	mov dword [ ebp - 4 ], 5	; arr[4]
	mov dword [ ebp - 8 ], 7	; arr[3]
	mov dword [ ebp - 12 ], 12	; arr[2]
	mov dword [ ebp - 16 ], 50	; arr[1]
	mov dword [ ebp - 20 ], 1	; arr[0]

	mov eax, ebp
	sub eax, 20
	push 5
	push eax
	call print_array_4b

	; 1-Byte Element Array

	mov dword [ ebp - 24 ], 0x00001002
	mov dword [ ebp - 28 ], 0x34678999

	mov eax, ebp
	sub eax, 28
	push 6
	push eax
	call print_array_1b

	jmp end

print_array_4b:	; Args: (int* arr, int n)
	push ebp
	mov ebp, esp
	sub esp, 4	; int i;

	mov dword [ ebp - 4 ], 0	; i = 0

	for_pa4b:
		mov ebx, dword [ ebp + 12 ]
		cmp dword [ ebp - 4 ], ebx
		je end_pa4b

		mov eax, dword [ ebp - 4 ]
		mov ebx, dword [ ebp + 8 ]
		mov ebx, dword [ ebx + eax*4 ]
		#show ebx

		inc dword [ ebp - 4 ]
		jmp for_pa4b

	end_pa4b:

	mov esp, ebp
	pop ebp
	ret

print_array_1b:	; Args: (char* arr, int n)
	push ebp
	mov ebp, esp
	sub esp, 4	; int i;

	mov dword [ ebp - 4 ], 0	; i = 0

	for_pa1b:
		mov ebx, dword [ ebp + 12 ]
		cmp dword [ ebp - 4 ], ebx
		je end_pa1b

		mov   eax, dword [ ebp - 4 ]
		mov   ebx, dword [ ebp + 8 ]
		movzx ebx, byte [ ebx + eax ]
		#show bl hex

		inc dword [ ebp - 4 ]
		jmp for_pa1b

	end_pa1b:

	mov esp, ebp
	pop ebp
	ret

; @Todo: Print Multidimensional Array

end:
	; Cleanup

	mov esp, ebp
	pop ebp
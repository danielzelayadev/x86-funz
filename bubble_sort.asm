main:
	push ebp
	mov ebp, esp

	; Push Array to Stack

	push 0	; arr[6]
	push 5	; arr[5]
	push 90	; arr[4]
	push 80	; arr[3]
	push 3	; arr[2]
	push 8	; arr[1]
	push 43	; arr[0]

	mov eax, ebp
	sub eax, 28
	push 7
	push eax
	call bubble_sort

	mov eax, ebp
	sub eax, 28
	push 7
	push eax
	call print_array_4b

	jmp end

bubble_sort:	; Args: (int* arr, int n)
	push ebp
	mov ebp, esp
	sub esp, 8

	mov dword [ ebp - 4 ], 0 ; c = 0

	for_bs:
		mov eax, dword [ ebp + 12 ]
		dec eax
		cmp dword [ ebp - 4 ], eax
		je end_bs

		mov dword [ ebp - 8 ], 0

		sfor_bs:
			mov eax, dword [ ebp + 12 ]
			sub eax, dword [ ebp - 4 ]
			dec eax
			cmp dword [ ebp - 8 ], eax
			je cont_bs

			mov eax, dword [ ebp + 8 ]
			mov ebx, dword [ ebp - 8 ]

			mov ecx, dword [ eax + ebx*4 ]

			inc ebx

			mov edx, dword [ eax + ebx*4 ]

			cmp ecx, edx
			jle cont_sfor

			mov ebx, dword [ ebp - 8 ]
			mov ecx, ebx
			imul ecx, 4
			mov edx, eax
			add edx, ecx
			push edx
			inc ebx
			imul ebx, 4
			add eax, ebx
			push eax
			call swap

			cont_sfor:

			inc dword [ ebp - 8 ]	; d++
			jmp sfor_bs

		cont_bs:

		inc dword [ ebp - 4 ] ; c++
		jmp for_bs

	end_bs:

	mov esp, ebp
	pop ebp
	ret

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

end:
	; Cleanup

	mov esp, ebp
	pop ebp
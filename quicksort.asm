main:
	push ebp
	mov ebp, esp

	push 34
	push 100
	push 4
	push 50
	push 5
	push 200
	push 45
	push 2

	mov eax, esp

	push 7
	push 0
	push eax
	call quicksort

	#show dword [ ebp - 32 ][8]

	jmp end

quicksort:
	push ebp
	mov ebp, esp
	sub esp, 16

	mov eax, dword [ ebp + 12 ]	; eax = low
	cmp eax, dword [ ebp + 16 ]
	jge end_qs					; low < high

	mov dword [ ebp - 4 ], eax 	; pivot = low
	mov dword [ ebp - 8 ], eax 	; i = low
	mov ebx, dword [ ebp + 16 ]	; ebx = high
	mov dword [ ebp - 12 ], ebx ; j = high

	mov edx, dword [ ebp + 8 ]	; edx = arr

	while1:
		mov ecx, dword [ ebp - 8 ]	; ecx = i
		cmp ecx, dword [ ebp - 12 ]
		jge post_while1				; i < j

		while2:
			mov ecx, dword [ ebp - 8 ]		; ecx = i

			mov eax, dword [  edx + ecx*4 ]	; eax = arr[i]

			mov ebx, dword [ ebp - 4 ]	; ebx = pivot

			mov ebx, dword [ edx + ebx*4 ]	; ebx = arr[pivot]

			cmp eax, ebx
			jg while3 						; arr[i] <= arr[pivot]
			cmp ecx, dword [ ebp + 16 ]
			jg while3 						; i <= high
			inc dword [ ebp - 8 ]	; i++
			jmp while2

		while3:
			mov ecx, dword [ ebp - 12 ]	; ecx = j

			mov eax, dword [  edx + ecx*4 ]	; eax = arr[j]

			mov ebx, dword [ ebp - 4 ]	; ebx = pivot

			mov ebx, dword [ edx + ebx*4 ]	; ebx = arr[pivot]

			cmp eax, ebx
			jle post_while3					; arr[j] > arr[pivot]
			cmp ecx, dword [ ebp + 12 ]
			jl post_while3					; j >= low
			dec dword [ ebp - 12 ]	; j--
			jmp while3

		post_while3:

			mov eax, dword [ ebp - 8 ]	; eax = i
			mov ebx, dword [ ebp - 12 ]	; ebx = j

			cmp eax, ebx
			jge while1 					; i < j

			mov ecx, dword [ edx + eax*4 ]	; ecx = arr[i]
			mov dword [ ebp - 16 ], ecx 	; temp = arr[i]

			mov ecx, dword [ edx + ebx*4 ]	; ecx = arr[j]
			mov dword [ edx + eax*4 ], ecx 	; arr[i] = arr[j]

			mov ecx, dword [ ebp - 16 ]		; ecx = temp
			mov dword [ edx + ebx*4 ], ecx 	; arr[j] = temp

			jmp while1

	post_while1:

		mov eax, dword [ ebp - 4 ]	; eax = pivot
		mov ebx, dword [ ebp - 12 ]	; ebx = j

		mov ecx, dword [ edx + ebx*4 ]	; ecx = arr[j]
		mov dword [ ebp - 16 ], ecx

		mov ecx, dword [ edx + eax*4 ]	; ecx = arr[pivot]
		mov dword [ edx + ebx*4 ], ecx

		mov ecx, dword [ ebp - 16 ]		; ecx = temp
		mov dword [ edx + eax*4 ], ecx

		dec ebx	; ebx--
		push ebx
		push dword [ ebp + 12 ]
		push dword [ ebp + 8 ]
		call quicksort

		push dword [ ebp + 16 ]
		mov ebx, dword [ ebp - 12 ]	; ebx = j
		inc ebx	; ebx++
		push ebx
		push dword [ ebp + 8 ]
		call quicksort

	end_qs:

	mov esp, ebp
	pop ebp
	ret

end:
	; Cleanup

	mov esp, ebp
	pop ebp
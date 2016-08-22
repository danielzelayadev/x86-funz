main:
	push ebp
	mov ebp, esp

	call funct

	jmp end

funct:
	push ebp
	mov ebp, esp



	mov esp, ebp
	pop ebp
	ret

end:
	; Cleanup

	mov esp, ebp
	pop ebp
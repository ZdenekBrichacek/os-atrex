Int00	proc	far
	cli
	pushad
	sti
	call	FlushKbd
	push	cs
	pop	ds
	mov	ah, 09h
	mov	edx, offset INT00Err
	int	21h
	xor	ax, ax
	int	16h
	cli
	popad
	sti
	iret
int00	endp

ErrorMessage	proc
	call	FlushKbd
	cmp	al, 3
	je	ErrB3_
	ret
ErrB3_:
	cmp	bl, 0FFh
	jne	ErrB3__
ErrB3_u:
	mov	ah, 09h
	mov	edx, offset ErrA2
	int	21h
	mov	ah, 09h
	mov	edx, offset ErrB3
	int	21h
	mov	ah, 09h
	mov	edx, offset ErrK1
	int	21h
	mov	ah, 09h
	mov	edx, offset ErrK2
	int	21h
	mov	ah, 09h
	mov	edx, offset ErrK6
	int	21h
	mov	ah, 09h
	mov	edx, offset ErrX0
	int	21h
	call	FlushKbd
ErrB3___:
	xor	ax, ax
	int	16h
	cmp	al, 13
	je	ErrB3__
	cmp	al, "r"
	je	ErrB3x__
	jmp	ErrB3___
ErrB3__:
	ret

ErrB3x__:
	call	ErrorRegTbl
	jmp	ErrB3_u
ErrorMessage	endp

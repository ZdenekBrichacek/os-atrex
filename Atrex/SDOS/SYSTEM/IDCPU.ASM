_cpuid	proc
	push	ds
	push	dx
	mov	dx, sp
	mov	ax, cs
	mov	ds, ax
	lea	si, id_mess
	call	prtstr

	pushf
	pop	bx
	mov	ax, 0fffh
	and	ax, bx
	push	ax
	popf
	pushf
	pop	ax
	and	ax, 0f000h
	cmp	ax, 0f000h
	lea	si, c8086
	mov	present_86, 1
	je	check_fpu

	or	bx, 0f000h
	push	bx
	popf
	pushf
	pop	ax
	and	ax, 0f000h
	lea	si, c286
	mov	present_86, 0
	mov	present_286, 1
	jz	check_fpu

	mov	bx, sp
	and	sp, not 3
	db	66h
	pushf
	db	66h
	pop	ax
	db	66h
	mov	cx, ax
	db	66h
	xor	ax, 0
	dw	4
	db	66h
	push	ax
	db	66h
	popf
	db	66h
	pushf
	db	66h
	pop	ax
	db	66h
	xor	ax, cx
	lea	si, c386
	mov	present_286, 0
	mov	present_386, 1
	je	check_fpu

	lea	si, c486nfp
	mov	present_386, 0
	mov	present_486, 1

check_fpu:
	fninit
	mov	fp_status, 5a5ah
	fnstsw	fp_status
	mov	ax, fp_status
	cmp	al, 0
	jne	print_one

	cmp	present_486, 1
	je	is_486
	jmp	not_486

is_486:
	lea	si, c486
	jmp	print_one

not_486:
	cmp	present_386, 1
	jne	print_87_287
	call	prtstr

	fldl2e
	fldz
	fdiv
	fld	st
	fchs
	fcompp
	fstsw	fp_status
	mov	ax, fp_status
	lea	si, fp_80287
	sahf
	jz	restore_EFLAGS
	lea	si, fp_80387

restore_EFLAGS:
	finit
	call	prtstr
	db	66h
	push	cx
	db	66h
	popf
	mov	sp, bx
	jmp	cpuid_exit

print_one:
	call	prtstr
	jmp	cpuid_exit

print_87_287:
	call	prtstr
	cmp	present_86, 1
	lea	si, fp_8087
	je	print_one
	lea	si, fp_80287

print_fpu:
	call	prtstr

cpuid_exit:
	lea	si, period
	call	prtstr
	mov	sp, dx
	pop	dx
	pop	ds
	ret
_cpuid	endp

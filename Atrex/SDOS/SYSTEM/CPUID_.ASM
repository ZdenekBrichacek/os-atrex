	TITLE	CPUID_
	DOSSEG
	.model	small
	.stack	100h

	.data
fp_status	dw	?
id_mess		db	"Tento syst‚m obsahuje $"
fp_8087		db	"a 8087 matematickì koprocesor$"
fp_80287	db	"a 80287 matematickì koprocesor$"
fp_80387	db	"a 80387 matematickì koprocesor$"
c8086		db	"n8086/8088 mikroprocesor$"
c286		db	"n80286 mikroprocesor$"
c386		db	"386 mikroprocesor$"
c486		db	"486 DX mikroprocesor /487 SX matematickì koprocesor$"
c486nfp		db	"486 SX mikroprocesor$"
period		db	".",13,10,"$"
present_86	dw	0
present_286	dw	0
present_386	dw	0
present_486	dw	0

	.code
start:
	mov	ax, @data
	mov	ds, ax
	mov	dx, offset id_mess
	mov	ah, 9h
	int	21h

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
	mov	dx, offset c8086
	mov	present_86, 1
	je	check_fpu

	or	bx, 0f000h
	push	bx
	popf
	pushf
	pop	ax
	and	ax, 0f000h
	mov	dx, offset c286
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
	mov	dx, offset c386
	mov	present_286, 0
	mov	present_386, 1
	je	check_fpu

	mov	dx, offset c486nfp
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
	mov	dx, offset c486
	jmp	print_one

not_486:
	cmp	present_386, 1
	jne	print_87_287
	mov	ah, 9
	int	21h

	fldl2e
	fldz
	fdiv
	fld	st
	fchs
	fcompp
	fstsw	fp_status
	mov	ax, fp_status
	mov	dx,offset fp_80287
	sahf
	jz	restore_EFLAGS
	mov	dx, offset fp_80387

restore_EFLAGS:
	finit
	mov	ah, 9h
	int	21h
	db	66h
	push	cx
	db	66h
	popf
	mov	sp, bx
	jmp	exit

print_one:
	mov	ah, 9h
	int	21h
	jmp	exit

print_87_287:
	mov	ah, 9h
	int	21h
	cmp	present_86, 1
	mov	dx, offset fp_8087
	je	print_one
	mov	dx, offset fp_80287

print_fpu:
	mov	ah, 9h
	int	21h
	jmp	exit

exit:
	mov	dx, offset period
	mov	ah, 9h
	int	21h
	mov	ax, 4c00h
	int	21h

	end	start

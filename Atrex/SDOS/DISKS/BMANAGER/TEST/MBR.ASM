org 7C00h
	push	ds
	push	si
	push	cs
	pop	ds
	lea	si, _d
	Call	PrtStr
	Call	Print_Hex
	lea	si, _a
	Call	PrtStr
	mov	dx, ax
	Call	Print_Hex
	lea	si, _b
	Call	PrtStr
	mov	dx, bx
	Call	Print_Hex
	lea	si, _c
	Call	PrtStr
	mov	dx, cx
	Call	Print_Hex
	lea	si, d_
	Call	PrtStr
	mov	dx, di
	Call	Print_Hex
	lea	si, s_
	Call	PrtStr
	pop	si
	mov	dx, si
	Call	Print_Hex
	lea	si, b_
	Call	PrtStr
	mov	dx, bp
	Call	Print_Hex
	lea	si, c_
	Call	PrtStr
	mov	dx, cs
	Call	Print_Hex
	lea	si, e_
	Call	PrtStr
	mov	dx, es
	Call	Print_Hex
	lea	si, ds_
	Call	PrtStr
	pop	ds
	mov	dx, ds
	Call	Print_Hex
	push	cs
	pop	ds
	lea	si, ss_
	Call	PrtStr
	mov	dx, ss
	Call	Print_Hex
	lea	si, sp_
	Call	PrtStr
	mov	dx, sp
	Call	Print_Hex

	jmp	$
_d	db	"dx",0
_a	db	"ax",0
_b	db	"bx",0
_c	db	"cx",0
d_	db	"di",0
s_	db	"si",0
b_	db	"bp",0
c_	db	"cs",0
e_	db	"es",0
ds_	db	"ds",0
ss_	db	"ss",0
sp_	db	"sp",0

;Tisk 2 hex Ÿ¡slic
;DX=¬¡slo
Print_Hex	proc
	pusha
	mov	cx, 4		; 8 hex digits
print_digit:
	rol	dx, 4		; rotate so that lowest 4 bits are used
	mov	ax, 0e0fh	; ah = request, al = mask for nybble
	and	al, dl
	add	al, 090h	; convert al to ascii hex (four instructions)
	daa
	adc	al, 040h
	daa
	push	bx	;;;;;;;;;;;;;
	mov	bl, 7	;;;;;;;;;;;;;
	int	10h
	pop	bx	;;;;;;;;;;;;;
	loop	print_digit
	popa
	ret
Print_Hex	endp

; Routine to print asciiz-string at DS:SI
PrtStr	Proc
	pusha
PS_2:	lodsb
	cmp	al,00h
	jz	fin
	call	prtchr
	jmp	PS_2
fin:
	popa
	ret
PrtStr	endp

; Part of above routine, this one just prints ascii al
prtchr	proc
	pusha
	mov	bh, 0
	mov	cx, 01h
	mov	ah, 0eh
	push	bx	;;;;;;;;;;;;;
	mov	bl, 7	;;;;;;;;;;;;;
	int	10h
	pop	bx	;;;;;;;;;;;;;
	popa
	ret
prtchr	endp

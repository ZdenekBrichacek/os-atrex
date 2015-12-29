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
	mov	bl,VideoAtribut	;;;;;;;;;;;;;
	int	10h
	pop	bx	;;;;;;;;;;;;;
	loop	print_digit
	popa
	ret
Print_Hex	endp

;Tisk 2 hex Ÿ¡slic
;DX=¬¡slo
Print__Hex	proc
	pusha
	mov	cx, 2		; 8 hex digits
print__digit:
	rol	dx, 4		; rotate so that lowest 4 bits are used
	mov	ax, 0e0fh	; ah = request, al = mask for nybble
	and	al, dl
	add	al, 090h	; convert al to ascii hex (four instructions)
	daa
	adc	al, 040h
	daa
	push	bx	;;;;;;;;;;;;;
	mov	bl,VideoAtribut	;;;;;;;;;;;;;
	int	10h
	pop	bx	;;;;;;;;;;;;;
	loop	print__digit
	popa
	ret
Print__Hex	endp

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
	mov	bh, VideoStranka
	mov	cx, 01h
	mov	ah, 0eh
	push	bx	;;;;;;;;;;;;;
	mov	bl, VideoAtribut	;;;;;;;;;;;;;
	int	10h
	pop	bx	;;;;;;;;;;;;;
	popa
	ret
prtchr	endp

;-------------------------
FlushKbd	proc
; Flush the keyboard buffer
;-------------------------
	pushad
FlushKbd_:
	mov	ah,01
	int	16h
	jz	empty
	xor	ah,ah
	int	16h
	jmp	FlushKbd_
empty:
	popad
	ret
FlushKbd	endp

;---------------------------
; Print decimal number (AL).
;---------------------------

prtdec:	push	ax
	push	cx
	xor	ah,ah
	mov	cl,0Ah
	idiv	cl
	cmp	al,09h
	jbe	lt100
	call	prtdec
	jmp	skip10
lt100:	add	al,30h
	call	prtchr
skip10:	mov	al,ah
	add	al,30h
	call	prtchr	
	pop	cx
	pop	ax
	ret

WhereXY	proc
	push	ax
	push	bx
	mov	ax, 0300h
	mov	bh, VideoStranka
	int	10h
	pop	bx
	pop	ax
	ret
;DL=sloupec
;DH=ý dek
WhereXY	endp

GotoXY	proc
;DL=sloupec
;DH=ý dek
	pusha
	mov	ax, 0200h
	mov	bh, VideoStranka
	int	10h
	popa
	ret
GotoXY	endp

ClrScr	proc
	pusha
	mov	dx, 0000h
	call	GotoXY
	mov	bl, VideoAtribut
	mov	bh, VideoStranka
	mov	al, 32
	mov	cx,8000
	mov	ah, 09
	int	10h
	popa
	ret
ClrScr	endp

;DS:SI=ukazatel na ýetØtec ukonŸenì 00h
;ES:DI=ukazatel na c¡lovì ýetØtec
CopyString	proc
LS_:
	LODSB
	STOSB
	cmp	al, 00h
	je	LS_EX_
	jmp	LS_
LS_EX_:
	ret
CopyString	endp

;DS:SI=ukazatel na ýetØtec ukonŸenì 00h
;ES:DI=ukazatel na c¡lovì ýetØtec
;CX=Znak…
CopyString2	proc
LS_2:
	LODSB
	STOSB
	cmp	al, 00h
	je	LS_EX_2
	loop	LS_2
LS_EX_2:
	ret
CopyString2	endp

SetSegments	proc
	push	ax
	mov	ax, cs
	mov	ds, ax
	mov	es, ax
	mov	fs, ax
	pop	ax
	ret
SetSegments	endp

PrintHex32:
	pusha
	push	eax
	mov	bx, dx
	call	GotoXY
	pop	dx
	call	Print_Hex
	dec	bl
	dec	bl
	dec	bl
	dec	bl
	mov	dx, bx
	call	GotoXY
	pop	dx
	call	Print_Hex
	popa
	ret

ReadKey	proc
	xor	ax, ax
	int	16h
	ret
ReadKey	endp

KeybDev	proc
	mov	dh, __Y
	mov	dl, __X
	Call	GotoXY
	mov	al, ">"
	Call	PrtChr
	Call	Done_1
KD_1:
	Call	ReadKey
	cmp	al, 0dh
	je	KD_2
	cmp	al, 00h
	jne	KD_1
	cmp	ah, 50h ;dol…
	je	KD_3
	cmp	ah, 48h	;nahoru
	je	KD_4
	cmp	ah, 0Fh
	je	KD_Exit
	jmp	KD_1
KD_Exit:
	ret
KD_3:
	mov	ax, Part
	add	ax, 6
	cmp	_Y, al
	je	KD_1
	add	_Y, 1
	jmp	KD_5
KD_4:
	cmp	_Y, 7
	je	KD_1
	sub	_Y, 1
	jmp	KD_5
KD_2:
	sub	_Y, 6
	jmp	Done_3
	ret
KD_5:
	mov	dh, __Y
	mov	dl, __X
	Call	GotoXY
	mov	al, " "
	Call	PrtChr

	mov	dh, _Y
	mov	dl, _X
	Call	GotoXY
	mov	al, ">"
	Call	PrtChr

	mov	al, _X
	mov	__X, al
	mov	al, _Y
	mov	__Y, al
	Call	Done_1
	jmp	KD_1
_X	db	1
_Y	db	7
__X	db	1
__Y	db	7
KeybDev	endp

Done_1	proc
	sub	_Y, 6
	cmp	_Y, 1
	je	A_1
	cmp	_Y, 2
	je	A_2
	cmp	_Y, 3
	je	A_3
	cmp	_Y, 4
	je	A_4
	cmp	_Y, 5
	je	A_5
	cmp	_Y, 6
	je	A_6
	cmp	_Y, 7
	je	A_4
	cmp	_Y, 8
	je	A_8
	cmp	_Y, 9
	je	A_9
A_1:
	mov	ah, Table1._Boot
	mov	dl, Table1._Disk
	mov	dh, Table1._Head
	mov	cx, Table1._SecCyl
	mov	al, Table1._sys
	jmp	Done_2
A_2:
	mov	ah, Table2._Boot
	mov	dl, Table2._Disk
	mov	dh, Table2._Head
	mov	cx, Table2._SecCyl
	mov	al, Table2._sys
	jmp	Done_2
A_3:
	mov	ah, Table3._Boot
	mov	dl, Table3._Disk
	mov	dh, Table3._Head
	mov	cx, Table3._SecCyl
	mov	al, Table3._sys
	jmp	Done_2
A_4:
	mov	ah, Table4._Boot
	mov	dl, Table4._Disk
	mov	dh, Table4._Head
	mov	cx, Table4._SecCyl
	mov	al, Table4._sys
	jmp	Done_2
A_5:
	mov	ah, Table5._Boot
	mov	dl, Table5._Disk
	mov	dh, Table5._Head
	mov	cx, Table5._SecCyl
	mov	al, Table5._sys
	jmp	Done_2
A_6:
	mov	ah, Table6._Boot
	mov	dl, Table6._Disk
	mov	dh, Table6._Head
	mov	cx, Table6._SecCyl
	mov	al, Table6._sys
	jmp	Done_2
A_7:
	mov	ah, Table7._Boot
	mov	dl, Table7._Disk
	mov	dh, Table7._Head
	mov	cx, Table7._SecCyl
	mov	al, Table7._sys
	jmp	Done_2
A_8:
	mov	ah, Table8._Boot
	mov	dl, Table8._Disk
	mov	dh, Table8._Head
	mov	cx, Table8._SecCyl
	mov	al, Table8._sys
	jmp	Done_2
A_9:
	mov	ah, Table9._Boot
	mov	dl, Table9._Disk
	mov	dh, Table9._Head
	mov	cx, Table9._SecCyl
	mov	al, Table9._sys
Done_2:
	mov	_dl, dl
	mov	_dh, dh
	mov	_cx, cx
	mov	_b, ah
	mov	__sys, al
	mov	dh, 16
	mov	dl, 3
	Call	GotoXY
	mov	dh, _dl
	Call	Print__Hex
	mov	al, "-"
	Call	PrtChr
	mov	dh, _dh
	Call	Print__Hex
	mov	al, "-"
	Call	PrtChr
	mov	dx, _cx
	Call	Print_Hex
	mov	al, "-"
	Call	PrtChr
	mov	al, _b
	Call	PrtChr
	mov	al, "-"
	Call	PrtChr
	mov	dh, __sys
	Call	Print__hex
	add	_Y, 6
	ret
Done_1	endp

Done_3	proc
	mov	dl, _dl
	mov	dh, _dh
	mov	cx, _cx
	mov	bx, 07C00h
	xor	ax, ax
	mov	es, ax
	mov	ax, 0201h
	int	13h
	mov	ax, cs
	mov	ds, ax
	jc	Done_Error
	mov	ax, 0003h
	int	10h

mov	dx, 00080h
mov	bx, 000FEh
mov	cx, 0E580h
mov	di, 00835h
mov	si, 00000h
mov	bp, 04794h
mov	sp, 04794h

mov	ax, 00000h
mov	es, ax
mov	ax, 00000h
mov	ds, ax
mov	ax, 00A00h
mov	ss, ax
mov	ax, 00000h

;	mov	ax, 07C00h
;	jmp	es:ax
;---
db	0EAh
db	00h
db	7Ch
db	00h
db	00h
;--- jmp	0000:7C00
Done_3	endp

Done_Error	proc
	add	_Y, 6
	jmp	KD_1
Done_Error	endp


_dl	db	?
_dh	db	?
_cx	dw	?
_b	db	?
__sys	db	?
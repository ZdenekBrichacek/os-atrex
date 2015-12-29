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

CheckDisk	proc
	mov	Sektor, 1
	inc	Sektor
	mov	cl, Sektor
	mov	ax, cs
	mov	es, ax
	mov	ah, 02
	mov	al, 1
	mov	dl, 80h
	mov	dh, 0
	mov	ch, 0
	mov	bx, offset DiskTmp
	int	13h
	jc	CheckDisk_Err
	mov	esi, offset DiskTmp+69h+5
	mov	eax, dword ptr [esi]
	mov	_ABMSumCRC, eax
	jmp	CheckDisk_3
CheckDisk_2:
	inc	Sektor
	mov	cl, Sektor
	mov	ax, cs
	mov	es, ax
	mov	ah, 02
	mov	al, 1
	mov	dl, 80h
	mov	dh, 0
	mov	ch, 0
	mov	bx, offset DiskTmp
	int	13h
	jc	CheckDisk_Err

CheckDisk_3:
	mov	ax, cs
	mov	ds, ax
	mov	cx, 512
	mov	si, offset DiskTmp
	xor	eax, eax
CheckDisk_1:
	lodsb
	inc	si
	add	Soucet, eax
	dec	cx
	cmp 	cx, 0000h
	jne	CheckDisk_1
	cmp	Sektor, Sektoru
	jne	CheckDisk_2
	ret

	lea	esi, Ok
	Call	PrtStr
	lea	esi, NR
	Call	PrtStr
CheckDisk_Err:
	lea	esi, Err
	Call	PrtStr
	lea	esi, Exit
	Call	PrtStr
	lea	esi, NR
	Call	PrtStr
	lea	esi, ProvErr
	Call	PrtStr
	mov	dh, ah
	Call	Print__Hex
	lea	esi, Punkt
	Call	PrtStr
	lea	esi, ProvErr_
	Call	PrtStr
	Call	ReadKey
	add	sp, 2
	ret
Sektor		db	?
Soucet		dd	0
_ABMSumCRC	dd	?
CheckDisk	endp


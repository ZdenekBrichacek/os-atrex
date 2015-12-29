;;DokonŸit funkci 0Ah

INT21	proc
	cmp	ah, 01h
	je	I21_01_
	cmp	ah, 02h
	je	I21_02_
	cmp	ah, 03h
	je	I21_03_
	cmp	ah, 04h
	je	I21_04_
	cmp	ah, 05h
	je	I21_05_
	cmp	ah, 06h
	je	I21_06_
	cmp	ah, 07h
	je	I21_07_
	cmp	ah, 08h
	je	I21_08_
	cmp	ah, 09h
	je	I21_09_
;	cmp	ah, 0Ah
;	je	I21_0A_
	cmp	ah, 0Bh
	je	I21_0B_
	cmp	ah, 0Ch
	je	I21_0C

	cmp	ah, 25h
	je	I21_25
	cmp	ah, 35h
	je	I21_35

;	cmp	ah, 052h
;	je	I21_052
;	iret
	jmp	dword ptr cs:[OldInts.OFS_21]
INT21	endp

I21_25	proc
	call	Nastav_Int_Vec
	iret
I21_25	endp

I21_35	proc
	call	Cti_Int_Vec
	iret
I21_35	endp

;Vr t¡ polohu tabulky syst‚mu SDOS
I21_052	proc
	mov	bx, offset Struktury_SDOS_
	push	cs
	pop	es
	iret
I21_052	endp

;Vypr zdn¡ kbd buffer a provede vol n¡
I21_0C	proc
	push	ax
I21__0C_:
	mov	ah, 01
	int	16h
	jnc	I21__0C
	mov	ah, 00
	int	16h
	mov	ScanCode, al
	jmp	I21__0C_
I21__0C:
	mov	ScanCode, 0
	pop	ax
	cmp	al, 01h
	je	I21_01
	cmp	al, 06h
	je	I21_06_
	cmp	al, 07h
	je	I21_07_
	cmp	al, 08h
	je	I21_08_
	cmp	al, 0Ah
	je	I21_0A_
	iret
I21_0C	endp

;;;Pýeskok
I21_01_:
	jmp	I21_01
I21_02_:
	jmp	I21_02
I21_03_:
	jmp	I21_03
I21_04_:
	jmp	I21_04
I21_05_:
	jmp	I21_05
I21_06_:
	jmp	I21_06
I21_07_:
	jmp	I21_07
I21_08_:
	jmp	I21_08
I21_09_:
	jmp	I21_09
I21_0A_:
	jmp	I21_0A
I21_0B_:
	jmp	I21_0B
;;;

; Read character from keyboard
; Out	AL = Character
I21_01	proc
	MOV	AL,ScanCode
	MOV	ScanCode,0
	OR	AL,AL
	JNE	@_@1
	mov	AH,10h
	INT	16H
	OR	AL,AL
	JNE	@_@1
	MOV	ScanCode,AH
	OR	AH,AH
	JNE	@_@1
	MOV	AL,'C'-64
@_@1:	CALL	BreakCheck
	cmp	al, 00
	je	@_@2
	call	PrtChr
@_@2:
	iret
I21_01	endp

;Tisk znaku
;dl = vstup
I21_02	proc
	push	ax
	mov	al, dl
	call	PrtChr
	pop	ax
	iret
I21_02	endp

;Vstup z pomocn‚ho v/v zaý¡zen¡ AUX
;al = vìstup
I21_03	proc
	push	dx
I21_03R:
	mov	ax, 0200h
	mov	dx, word ptr cs:[AUX]
	int	14h
	test	ah, 10000000B
	jnz	I21_03R
	pop	dx
	iret
I21_03	endp

;Vìstup na v/v zaý¡zen¡ AUX
;dl = vstup
I21_04	proc
	push	dx
	push	ax
;I21_04R:
	mov	ax, 0100h
	mov	al, dl
	mov	dx, word ptr cs:[AUX]
	int	14h
;	test	ah, 10000000B
;	jnz	I21_04R
	pop	ax
	pop	dx
	iret
I21_04	endp

;Vìstup na tisk rnu PRN
;dl = vstup
I21_05	proc
	push	dx
	push	ax
	mov	ax, 0000h
	mov	al, dl
	mov	dx, word ptr cs:[PRN]
	int	17h
	pop	ax
	pop	dx
	iret
I21_05	endp

;Vìstup/vstup na konzole
;dl = vstup
I21_06	proc
	cmp	dl, 0ffh
	je	@@_@0
	jmp	I21_02
@@_@0:
	jmp	I21_CtiKbdBuffer
	iret
I21_06	endp

; Read character from keyboard
; Out	AL = Character
I21_07	proc
	MOV	AL,ScanCode
	MOV	ScanCode,0
	OR	AL, AL
	JNE	@_@1_
	mov	AH, 10h
	INT	16H
	OR	AL,AL
	JNE	@_@1_
	MOV	ScanCode,AH
	OR	AH, AH
	JNE	@_@1_
	MOV	AL,'C'-64
@_@1_:
	iret
I21_07	endp

; Read character from keyboard
; Out	AL = Character
I21_08	proc
	MOV	AL,ScanCode
	MOV	ScanCode,0
	OR	AL, AL
	JNE	@_@__1_
	mov	AH, 10h
	INT	16H
	OR	AL,AL
	JNE	@_@__1_
	MOV	ScanCode,AH
	OR	AH, AH
	JNE	@_@__1_
	MOV	AL,'C'-64
@_@__1_:
	CALL	BreakCheck
	iret
I21_08	endp

; Routine to print asciiz-string at DS:DX
I21_09	proc
	push	si
	mov	si, dx
PrtStr_:
	lodsb
	cmp	al,"$"
	jz	fin_
	call	prtchr
	jmp	prtstr_
fin_:
	pop	si
	iret
I21_09	endp

I21_0A	proc
	iret
I21_0A	endp

;Stav stand. vst. zaý¡zen¡
I21_0B	proc
	MOV	AL,ScanCode
	MOV	ScanCode,0
	OR	AL,AL
	JNE	@_@_1__
	mov	AH, 11h
	INT	16H
	OR	AL,AL
	JNE	@_@_1__
	MOV	ScanCode,AH
	OR	AH,AH
	JNE	@_@_1__
	MOV	AL,'C'-64
@_@_1__:
	cmp	al, 00
	je	_0B_00
	mov	al, 0FFh
	jmp	_0B_01
_0B_00:
	mov	al, 00h
_0B_01:
	push	ax
	CALL	BreakCheck
	pop	ax
	iret
I21_0B	endp

I21_CtiKbdBuffer	proc
	MOV	AL,ScanCode
	MOV	ScanCode,0
	OR	AL,AL
	JNE	@_@_1
	mov	AH, 11h
	INT	16H
	OR	AL,AL
	JNE	@_@_1
	MOV	ScanCode,AH
	OR	AH,AH
	JNE	@_@_1
	MOV	AL,'C'-64
@_@_1:	cmp	al, 00
	je	@_@_2
	call	PrtChr
@_@_2:
	iret
I21_CtiKbdBuffer	endp

; Check for Ctrl-Break
BreakCheck	proc
	CMP	BreakFlag,0
	JNE	_@@1
	RET
_@@1:	MOV	BreakFlag,0
_@@2:	MOV	AH,1
	INT	16H
	JE	_@@3
	MOV	AH,0
	INT	16H
	JMP	_@@2
_@@3:	MOV	AL,'^'
	CALL	PrtChr
	MOV	AL,'C'
	CALL	PrtChr
	MOV	AL,13h
	CALL	PrtChr
	MOV	AL,10h
	CALL	PrtChr
	Int	23h
	xor	ax,ax
	ret
BreakCheck	endp



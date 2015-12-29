Int13	proc
	jmp	DD_D
KONEC:
	cli
	pop	ds
	pop	BP
	pop	ES
	pop	DS
	pop	DI
	pop	SI
	pop	DX
	pop	CX
	pop	BX
	pop	AX
	sti
	iret
NV_:
	mov	byte ptr cs:[NV],'0'
	jmp	konec
NV__:
	mov	byte ptr cs:[NV],'1'
	jmp	konec
DD_D:	
	cli
	push	AX
	push	BX
	push	CX
	push	DX
	push	SI
	push	DI
	push	DS
	push	ES
	push	BP
	push	ds
	push	cs
	pop	ds
	sti

	mov	word ptr cs:[Old13._AX], AX
	mov	word ptr cs:[Old13._BX], BX
	mov	word ptr cs:[Old13._CX], CX
	mov	word ptr cs:[Old13._DX], DX

	mov	al,ah	;zaka§ zobrazen¡
	cmp	al,0EEh	;
	je	NV_
	mov	al,ah	;povol zobrazen¡
	cmp	al,0EFh	;
	je	NV__
	mov	al,byte ptr cs:[NV]
	cmp	al,'0'
	je	DAL_
	mov	byte ptr cs:[DISK+1],' '
	mov	al,dl
	cmp	al,00	;A:
	je	DDA__
	cmp	al,01	;B:
	je	DDB__
	cmp	al,80h	;HD0:
	je	DDC__
	cmp	al,81h	;HD1:
	je	DDD__
DDAL:
	mov	byte ptr cs:[DISK],' '
	mov	al,ah
	cmp	al,02	;Ÿten¡
	je	C_
	cmp	al,03	;z pis
	je	Z_
	cmp	al,04	;verifikace
	je	V_
	cmp	al,05	;form tov n¡
	je	F_
	jmp	DDAL1
DDA__:
	jmp	DA_
DDB__:
	jmp	DB_
DDC__:
	jmp	DC_
DDD__:
	jmp	DD_
DDAL1:
	mov	AX,cs ;Disk
	mov	ES,AX
	mov	BP,offset cs:[Disk]
	mov	CX,2
	mov	BH,00h
	mov	BL,(16*7)+0Fh
	mov	DH,0
	mov	DL,78
	mov	AH,13h
	mov	AL,00h
	Int	10h

DAL_:
;	push	ds
;	mov	ax,0040h
;	mov	ds,ax
;	mov	ax,word ptr cs:[Disk]
;	mov	word ptr ds:[00F0h],ax
;	pop	ds

	cli
	pop	ds
	pop	BP
	pop	ES
	pop	DS
	pop	DI
	pop	SI
	pop	DX
	pop	CX
	pop	BX
	pop	AX
	sti
	pushf
	call	dword ptr cs:[OldInts.OFS_13]
	jc	error
	cmp	ah, 00
	jne	error
	iret
C_:
	mov	byte ptr cs:[DISK],'<'
	jmp	DDAL1
Z_:
	mov	byte ptr cs:[DISK],'>'
	jmp	DDAL1
V_:
	mov	byte ptr cs:[DISK],'#'
	jmp	DDAL1
F_:
	mov	byte ptr cs:[DISK],''
	jmp	DDAL1
DA_:
	mov	byte ptr cs:[DISK+1],'A'
	jmp	DDAL
DB_:
	mov	byte ptr cs:[DISK+1],'B'
	jmp	DDAL
DC_:
	mov	byte ptr cs:[DISK+1],'C'
	jmp	DDAL
DD_:
	mov	byte ptr cs:[DISK+1],'D'
	jmp	DDAL
Error:
	cli
	push	AX
	push	BX
	push	CX
	push	DX
	push	SI
	push	DI
	push	DS
	push	ES
	push	BP
	push	ds

	push	ax
	push	ds
	push	cs
	pop	ds
	sti

	push	dx
	push	si
	call	ClrScr
	mov	dx, 0607h
	call	GotoXY
	lea	si, PrintDiskError
	call	PrtStr
	mov	dx, 1032h
	call	GotoXY
	pop	si
	mov	dx,si
	call	Print_Hex
	mov	dx, 0E32h
	call	GotoXY
	pop	dx
	call	Print_Hex
	mov	dx, 0D32h
	call	GotoXY
	mov	dx, cx
	call	Print_Hex
	mov	dx, 0C32h
	call	GotoXY
	mov	dx, bx
	call	Print_Hex
	mov	dx, 0B32h
	call	GotoXY
	mov	dx, ax
	call	Print_Hex
	mov	dx, 0F32h
	call	GotoXY
	mov	dx, bp
	call	Print_Hex
	mov	dx, 0B42h
	call	GotoXY
	mov	dx, di
	call	Print_Hex
	mov	dx, 0C42h
	call	GotoXY
	pop	ds
	mov	dx, ds
	push	cs
	pop	ds
	call	Print_Hex
	mov	dx, 0D42h
	call	GotoXY
	mov	dx, es
	call	Print_Hex
	mov	dx, 0E42h
	call	GotoXY
	pushf
	pop	dx
	call	Print_Hex

	mov	dx, 0B17h
	call	GotoXY
	mov	dx, word ptr cs:[Old13._DX]
	xor	dh, dh
	call	Print_Hex
	mov	dx, 0C17h
	call	GotoXY
	mov	cx, word ptr cs:[Old13._CX]
	and	cx, 1111111111000000B
	xchg	cl, ch
	mov	ax, cx
	xor	ch, ch
	test	ah, 10000000B
	jnz	I13_Ok1
I13_D1:
	test	ah, 01000000B
	jnz	I13_Ok2
	jmp	I13_D12
I13_Ok1:
	or	ch, 00000010B
	jmp	I13_D1
I13_Ok2:
	or	ch, 00000001B
I13_D12:
	mov	dx, cx
	call	Print_Hex
	mov	dx, 0D17h
	call	GotoXY
	mov	cx, word ptr cs:[Old13._CX]
	xor	ch, ch
	and	cl, 00111111B
	mov	dx, cx
	call	Print_Hex
	mov	dx, 0E17h
	call	GotoXY
	mov	dx, word ptr cs:[Old13._DX]
	xor	dl, dl
	xchg	dh, dl
	call	Print_Hex
	mov	dx, 0F17h
	call	GotoXY
	mov	ax, word ptr cs:[Old13._AX]
	xor	ah, ah
	mov	dx, ax
	call	Print_Hex
	mov	dx, 1017h
	call	GotoXY
	mov	ax, word ptr cs:[Old13._AX]
	xor	al, al
	xchg	ah, al
	mov	dx, ax
	call	Print_Hex

	mov	ax, word ptr cs:[Old13._AX]

	cmp	ax, 1c0ah
	je	I13_1c0a
	cmp	ax, 1c0bh
	je	I13_1c0b
	cmp	ax, 1c0ch
	je	I13_1c0c
	cmp	ax, 1c0eh
	je	I13_1c0e

	mov	di, ax
	xchg	ah, al
	add	di, di
	mov	si, [di+Bios_Disk_Func]
	jmp	I13_Dal
I13_1c0a:
	lea	si, DiskFunc_1c0A
	jmp	I13_Dal
I13_1c0b:
	lea	si, DiskFunc_1c0B
	jmp	I13_Dal
I13_1c0c:
	lea	si, DiskFunc_1c0C
	jmp	I13_Dal
I13_1c0e:
	lea	si, DiskFunc_1c0E

I13_Dal:
	mov	dx, 071Ah
	call	GotoXY
	call	PrtStr

	pop	ax

	cmp	ah, 0aah
	je	I13_E0aa
	cmp	ah, 0bbh
	je	I13_E0bb
	cmp	ah, 0cch
	je	I13_E0cc
	cmp	ah, 0e0h
	je	I13_E0e0
	cmp	ah, 0ffh
	je	I13_E0ff

	mov	di, ax
	xchg	ah, al
	add	di, di
	mov	si, [di+Bios_Disk_Error]

I13_PERR:
	mov	bx, cs
	mov	dx, offset Disk+1
	lea	di, TMPString
	push	cs
	pop	ds
	push	cs
	pop	es
	call	FormatString
	push	ds
	push	es
	pop	ds
	pop	es
;	xchg	es, ds
	xchg	di, si
	mov	dx, 0816h
	call	GotoXY
	push	cs
	pop	ds
	lea	si, TMPString
	call	PrtStr

;	lea	si, ENTER_MESS
;	call	PrtStr
;	lea	si, DiskIOErr
;	call	PrtStr
;	lea	si, Disk+1
;	call	PrtStr
;	lea	si, PressAnyK
;	call	PrtStr
	xor	ax,ax
	int	16h

;	mov	dx, word ptr cs:[OldInts.OFS_13]
;	mov	ds, word ptr cs:[OldInts.SEG_13]
;	mov	al, 13h
;	Call	Nastav_Int_Vec		;nast. INT13h

I13_konec:
	cli
	pop	ds
	pop	BP
	pop	ES
	pop	DS
	pop	DI
	pop	SI
	pop	DX
	pop	CX
	pop	BX
	pop	AX
	sti
	iret

I13_E0aa:
	lea	si, DiskError_0aa
	jmp	I13_PERR
I13_E0bb:
	lea	si, DiskError_0bb
	jmp	I13_PERR
I13_E0cc:
	lea	si, DiskError_0cc
	jmp	I13_PERR
I13_E0e0:
	lea	si, DiskError_0e0
	jmp	I13_PERR
I13_E0ff:
	lea	si, DiskError_0ff
	jmp	I13_PERR
int13	endp

VyplnExtBoot	proc
	mov	dh, 00h
	mov	dl, BootFromDisk
	mov	bx, offset cs:ExtBoot.MajorVer
	mov	ax, cs
	mov	es, ax
	mov	ax, 0201h
	mov	cx, 0002h
	int	13h
	jc	VyplnEBerror
	cmp	ah, 00
	jne	VyplnEBerror
	ret
VyplnEBerror:
	lea	si, ENTER_MESS
	call	PrtStr
	lea	si, DiskIOErr
	call	PrtStr
	mov	al, 0Dh
	call	PrtChr
	mov	al, 0Ah
	call	PrtChr
	lea	si, ReplaceDisk
	call	PrtStr
	lea	si, PressAnyK
	call	PrtStr
	xor	ax,ax
	int	16h
	int	19h
	ret
VyplnExtBoot	endp

_TEXT	segment
assume	cs:_TEXT, ds:_TEXT, es:_TEXT, ss:_TEXT
.586P
org 100h
@Filename:
	jmp	Start

;Program_Spec	dw	0001h
;Program_Attrib	dw	0001h
;Program_Name	db	'SHOW ACTIVITY INT13H',0,0
;include	.\makro.mac
include	.\types.asm
include	.\func.asm

Int13_	proc	far
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

	mov	word ptr cs:[Old13._AX], ax
	mov	word ptr cs:[Old13._BX], bx
	mov	word ptr cs:[Old13._CX], cx
	mov	word ptr cs:[Old13._DX], dx

	mov	al,ah	;zakaß zobrazen°
	cmp	al,0EEh	;
	je	NV_
	mov	al,ah	;povol zobrazen°
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
	cmp	al,02	;üten°
	je	C_
	cmp	al,03	;z†pis
	je	Z_
	cmp	al,04	;verifikace
	je	V_
	cmp	al,05	;form†tov†n°
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
	push	ds
	mov	ax,0040h
	mov	ds,ax
	mov	ax,word ptr cs:[Disk]
	mov	word ptr ds:[00F0h],ax
	pop	ds

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
	mov	cs:[OldErrReg._OESP], esp
	mov	cs:[OldErrReg._OSS], ss
	push	cs
	pop	ss
	mov	esp, offset Int13Stack

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
	cmp	ah, 00h
	je	I13_00
	cmp	ah, 01h
	je	I13_01
	cmp	ah, 02h
	je	I13_02
	cmp	ah, 03h
	je	I13_03
	cmp	ah, 04h
	je	I13_04
	cmp	ah, 05h
	je	I13_05
	cmp	ah, 06h
	je	I13_06
	cmp	ah, 07h
	je	I13_07
	cmp	ah, 08h
	je	I13_08
	cmp	ah, 09h
	je	I13_09
	cmp	ah, 0ah
	je	I13_0a
	cmp	ah, 0bh
	je	I13_0b
	cmp	ah, 0ch
	je	I13_0c
	cmp	ah, 0dh
	je	I13_0d
	cmp	ah, 0eh
	je	I13_0e
	cmp	ah, 0fh
	je	I13_0f
	cmp	ah, 10h
	je	I13_10
	cmp	ah, 11h
	je	I13_11
	cmp	ah, 12h
	je	I13_12
	cmp	ah, 13h
	je	I13_13
	cmp	ah, 14h
	je	I13_14
	cmp	ah, 15h
	je	I13_15
	cmp	ah, 16h
	je	I13_16
	cmp	ah, 17h
	je	I13_17
	cmp	ah, 18h
	je	I13_18
	cmp	ah, 19h
	je	I13_19
	cmp	ah, 1ah
	je	I13_1a
	cmp	ah, 1bh
	je	I13_1b
	cmp	ax, 1c0ah
	je	I13_1c0a
	cmp	ax, 1c0bh
	je	I13_1c0b
	cmp	ax, 1c0ch
	je	I13_1c0c
	cmp	ax, 1c0eh
	je	I13_1c0e

	lea	si, DiskFunc_??
I13_Dal:
	mov	dx, 071Ah
	call	GotoXY
	call	PrtStr

	pop	ax
	cmp	ah, 00h
	je	I13_E00
	cmp	ah, 01h
	je	I13_E01
	cmp	ah, 02h
	je	I13_E02
	cmp	ah, 03
	je	I13_E03
	cmp	ah, 04h
	je	I13_E04
	cmp	ah, 05h
	je	I13_E05
	cmp	ah, 06h
	je	I13_E06
	cmp	ah, 07h
	je	I13_E07
	cmp	ah, 08h
	je	I13_E08
	cmp	ah, 09h
	je	I13_E09
	cmp	ah, 0ah
	je	I13_E0a
	cmp	ah, 0bh
	je	I13_E0b
	cmp	ah, 0ch
	je	I13_E0c
	cmp	ah, 10h
	je	I13_E10
	cmp	ah, 011h
	je	I13_E11
	cmp	ah, 20h
	je	I13_E20
	cmp	ah, 40h
	je	I13_E40
	cmp	ah, 80h
	je	I13_E80
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

	lea	si, DiskError_N
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
	Call	Error__

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
	mov	esp, cs:[OldErrReg._OESP]
	mov	ss, cs:[OldErrReg._OSS]
	iret

I13_00:
	lea	si, DiskFunc_00
	jmp	I13_Dal
I13_01:
	lea	si, DiskFunc_01
	jmp	I13_Dal
I13_02:
	lea	si, DiskFunc_02
	jmp	I13_Dal
I13_03:
	lea	si, DiskFunc_03
	jmp	I13_Dal
I13_04:
	lea	si, DiskFunc_04
	jmp	I13_Dal
I13_05:
	lea	si, DiskFunc_05
	jmp	I13_Dal
I13_06:
	lea	si, DiskFunc_06
	jmp	I13_Dal
I13_07:
	lea	si, DiskFunc_07
	jmp	I13_Dal
I13_08:
	lea	si, DiskFunc_08
	jmp	I13_Dal
I13_09:
	lea	si, DiskFunc_09
	jmp	I13_Dal
I13_0a:
	lea	si, DiskFunc_0a
	jmp	I13_Dal
I13_0b:
	lea	si, DiskFunc_0b
	jmp	I13_Dal
I13_0c:
	lea	si, DiskFunc_0c
	jmp	I13_Dal
I13_0d:
	lea	si, DiskFunc_0d
	jmp	I13_Dal
I13_0e:
	lea	si, DiskFunc_0e
	jmp	I13_Dal
I13_0f:
	lea	si, DiskFunc_0f
	jmp	I13_Dal
I13_10:
	lea	si, DiskFunc_10
	jmp	I13_Dal
I13_11:
	lea	si, DiskFunc_11
	jmp	I13_Dal
I13_12:
	lea	si, DiskFunc_12
	jmp	I13_Dal
I13_13:
	lea	si, DiskFunc_13
	jmp	I13_Dal
I13_14:
	lea	si, DiskFunc_14
	jmp	I13_Dal
I13_15:
	lea	si, DiskFunc_15
	jmp	I13_Dal
I13_16:
	lea	si, DiskFunc_16
	jmp	I13_Dal
I13_17:
	lea	si, DiskFunc_17
	jmp	I13_Dal
I13_18:
	lea	si, DiskFunc_18
	jmp	I13_Dal
I13_19:
	lea	si, DiskFunc_19
	jmp	I13_Dal
I13_1a:
	lea	si, DiskFunc_1a
	jmp	I13_Dal
I13_1b:
	lea	si, DiskFunc_1b
	jmp	I13_Dal
I13_1c0a:
	lea	si, DiskFunc_1c0a
	jmp	I13_Dal
I13_1c0b:
	lea	si, DiskFunc_1c0b
	jmp	I13_Dal
I13_1c0c:
	lea	si, DiskFunc_1c0c
	jmp	I13_Dal
I13_1c0e:
	lea	si, DiskFunc_1c0e
	jmp	I13_Dal


I13_E00:
	lea	si, DiskError_00
	jmp	I13_PERR
I13_E01:
	lea	si, DiskError_01
	jmp	I13_PERR
I13_E02:
	lea	si, DiskError_02
	jmp	I13_PERR
I13_E03:
	lea	si, DiskError_03
	jmp	I13_PERR
I13_E04:
	lea	si, DiskError_04
	jmp	I13_PERR
I13_E05:
	lea	si, DiskError_05
	jmp	I13_PERR
I13_E06:
	lea	si, DiskError_06
	jmp	I13_PERR
I13_E07:
	lea	si, DiskError_07
	jmp	I13_PERR
I13_E08:
	lea	si, DiskError_08
	jmp	I13_PERR
I13_E09:
	lea	si, DiskError_09
	jmp	I13_PERR
I13_E0a:
	lea	si, DiskError_0a
	jmp	I13_PERR
I13_E0b:
	lea	si, DiskError_0b
	jmp	I13_PERR
I13_E0c:
	lea	si, DiskError_0c
	jmp	I13_PERR
I13_E10:
	lea	si, DiskError_10
	jmp	I13_PERR
I13_E11:
	lea	si, DiskError_11
	jmp	I13_PERR
I13_E20:
	lea	si, DiskError_20
	jmp	I13_PERR
I13_E40:
	lea	si, DiskError_40
	jmp	I13_PERR
I13_E80:
	lea	si, DiskError_80
	jmp	I13_PERR
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
int13_	endp

Error__	proc
	push	eax
	mov	ax, ds
	push	cs
	pop	ds
	mov	word ptr CS:[OldErrReg._DS], AX
	pop	eax
	mov	dword ptr CS:[OldErrReg._EAX], EAX
	mov	dword ptr CS:[OldErrReg._EBX], EBX
	mov	dword ptr CS:[OldErrReg._ECX], ECX
	mov	dword ptr CS:[OldErrReg._EDX], EDX
	mov	dword ptr CS:[OldErrReg._ESI], ESI
	mov	dword ptr CS:[OldErrReg._EDI], EDI
	mov	dword ptr CS:[OldErrReg._EBP], EBP
	mov	dword ptr CS:[OldErrReg._ESP], ESP
;	mov	dword ptr CS:[OldErrReg._EIP], EIP ;
	db	66h
	pushf
	db	66h
	pop	ax
	mov	dword ptr CS:[OldErrReg._EFLAGS], EAX
	mov	word ptr CS:[OldErrReg._CS], CS ;
	mov	word ptr CS:[OldErrReg._SS], SS
	mov	word ptr CS:[OldErrReg._ES], ES
	mov	word ptr CS:[OldErrReg._FS], FS
	mov	word ptr CS:[OldErrReg._GS], GS
	mov	eax, CR0
	mov	dword ptr CS:[OldErrReg._CR0], EAX
	mov	eax, CR2
	mov	dword ptr CS:[OldErrReg._CR2], EAX
	mov	eax, CR3
	mov	dword ptr CS:[OldErrReg._CR3], EAX

	mov	ax, cs
	mov	ds, ax
	mov	es, ax
	mov	[TMP__3], 00h

	call	ClrScr
	mov	dl, 00h
	mov	dh, 03h
	call	GotoXY
	lea	esi, PrintSystemError
	call	Prtstr

	mov	dl, 18h
	mov	dh, 08h
	mov	eax, cs:[OldErrReg._EAX]
	call	PrintErrorReg32
	mov	dl, 18h
	mov	dh, 09h
	mov	eax, cs:[OldErrReg._EBX]
	call	PrintErrorReg32
	mov	dl, 18h
	mov	dh, 0Ah
	mov	eax, cs:[OldErrReg._ECX]
	call	PrintErrorReg32
	mov	dl, 18h
	mov	dh, 0Bh
	mov	eax, cs:[OldErrReg._EDX]
	call	PrintErrorReg32
	mov	dl, 18h
	mov	dh, 0Ch
	mov	eax, cs:[OldErrReg._ESI]
	call	PrintErrorReg32
	mov	dl, 18h
	mov	dh, 0Dh
	mov	eax, cs:[OldErrReg._EDI]
	call	PrintErrorReg32
	mov	dl, 18h
	mov	dh, 0Eh
	mov	eax, cs:[OldErrReg._EBP]
	call	PrintErrorReg32
	mov	dl, 18h
	mov	dh, 0Fh
	mov	eax, cs:[OldErrReg._ESP]
	call	PrintErrorReg32
	mov	dl, 18h
	mov	dh, 10h
	mov	eax, cs:[OldErrReg._EIP]
	call	PrintErrorReg32
;vyplnÿn° pole EFLAGS
	mov	dl, 18h
	mov	dh, 11h
	mov	eax, cs:[OldErrReg._EFLAGS]
	call	PrintErrorReg32
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000001000000000000000000000B
	jz	Err_NoIDBit
	mov	dx, 111Dh
	lea	si, Err_Sh_ID
	call	PrintCStr
Err_NoIDBit:
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000100000000000000000000B
	jz	Err_NoVIPBit
	mov	[TMP__3], -1
	mov	dx, 1120h
	lea	si, Err_Sh_VIP
	call	PrintCStr
Err_NoVIPBit:
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000010000000000000000000B
	jz	Err_NoVIFBit
	mov	dx, 1124h
	lea	si, Err_Sh_VIF
	call	PrintCStr
Err_NoVIFBit:
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000000100000000000000000B
	jz	Err_NoVMBit
	mov	dx, 1128h
	lea	si, Err_Sh_VM
	call	PrintCStr
Err_NoVMBit:
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000000000010000000000000B ;bit 13
	setnz	TMP__1
	test	eax, 00000000000000000001000000000000B ;bit 12
	setnz	TMP__2
	xor	ax, ax
	mov	al, TMP__1
	shl	al, 1
	add	al, TMP__2
	add	al, 30h
	mov	bl, VideoAtribut
	push	bx
	mov	dx, 112Fh
	call	GotoXY
	mov	VideoAtribut, 0Eh
	call	PrtColorChr
	pop	bx
	mov	VideoAtribut, bl
	;IOPL end
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000000000000100000000000B
	jz	Err_NoOFBit
	mov	dx, 1131h
	lea	si, Err_Sh_OF
	call	PrintCStr
Err_NoOFBit:
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000000000000010000000000B
	jz	Err_NoDFBit
	mov	dx, 1134h
	lea	si, Err_Sh_DF
	call	PrintCStr
Err_NoDFBit:
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000000000000000100000000B
	jz	Err_NoTFBit
	mov	dx, 1137h
	lea	si, Err_Sh_TF
	call	PrintCStr
Err_NoTFBit:
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000000000000000010000000B
	jz	Err_NoSFBit
	mov	dx, 113Ah
	lea	si, Err_Sh_SF
	call	PrintCStr
Err_NoSFBit:
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000000000000000001000000B
	jz	Err_NoZFBit
	mov	dx, 113Dh
	lea	si, Err_Sh_ZF
	call	PrintCStr
Err_NoZFBit:
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000000000000000000010000B
	jz	Err_NoAFBit
	mov	dx, 1140h
	lea	si, Err_Sh_AF
	call	PrintCStr
Err_NoAFBit:
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000000000000000000000100B
	jz	Err_NoPFBit
	mov	dx, 1143h
	lea	si, Err_Sh_PF
	call	PrintCStr
Err_NoPFBit:
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000000000000000000000001B
	jz	Err_NoCFBit
	mov	dx, 1146h
	lea	si, Err_Sh_CF
	call	PrintCStr
Err_NoCFBit:
;
	mov	dl, 24h
	mov	dh, 08h
	mov	ax, cs:[OldErrReg._DS]
	call	PrintErrorReg16
	mov	dl, 24h
	mov	dh, 09h
	mov	ax, cs:[OldErrReg._ES]
	call	PrintErrorReg16
	mov	dl, 24h
	mov	dh, 0Ah
	mov	ax, cs:[OldErrReg._FS]
	call	PrintErrorReg16
	mov	dl, 24h
	mov	dh, 0Bh
	mov	ax, cs:[OldErrReg._GS]
	call	PrintErrorReg16
	mov	dl, 24h
	mov	dh, 0Ch
	mov	ax, cs:[OldErrReg._SS]
	call	PrintErrorReg16
	mov	dl, 24h
	mov	dh, 0Dh
	mov	ax, cs:[OldErrReg._CS]
	call	PrintErrorReg16
;vyplnÿn° pole CR0
	mov	dl, 28h
	mov	dh, 0Eh
	mov	eax, cs:[OldErrReg._CR0]
	call	PrintErrorReg32
	mov	eax, cs:[OldErrReg._CR0]
	test	eax, 10000000000000000000000000000000B
	jz	Err_NoPGBit
	mov	dx, 0E2Dh
	lea	si, Err_Sh_PG
	call	PrintCStr
Err_NoPGBit:
	mov	eax, cs:[OldErrReg._CR0]
	test	eax, 01000000000000000000000000000000B
	jz	Err_NoCDBit
	mov	dx, 0E30h
	lea	si, Err_Sh_CD
	call	PrintCStr
Err_NoCDBit:
	mov	eax, cs:[OldErrReg._CR0]
	test	eax, 00100000000000000000000000000000B
	jz	Err_NoNWBit
	mov	dx, 0E33h
	lea	si, Err_Sh_NW
	call	PrintCStr
Err_NoNWBit:
	mov	eax, cs:[OldErrReg._CR0]
	test	eax, 00000000000001000000000000000000B
	jz	Err_NoAMBit
	mov	dx, 0E36h
	lea	si, Err_Sh_AM
	call	PrintCStr
Err_NoAMBit:
	mov	eax, cs:[OldErrReg._CR0]
	test	eax, 00000000000000010000000000000000B
	jz	Err_NoWPBit
	mov	dx, 0E39h
	lea	si, Err_Sh_WP
	call	PrintCStr
Err_NoWPBit:
	mov	eax, cs:[OldErrReg._CR0]
	test	eax, 00000000000000000000000000100000B
	jz	Err_NoNEBit
	mov	dx, 0E3Ch
	lea	si, Err_Sh_NE
	call	PrintCStr
Err_NoNEBit:
	mov	eax, cs:[OldErrReg._CR0]
	test	eax, 00000000000000000000000000001000B
	jz	Err_NoTSBit
	mov	dx, 0E3Fh
	lea	si, Err_Sh_TS
	call	PrintCStr
Err_NoTSBit:
	mov	eax, cs:[OldErrReg._CR0]
	test	eax, 00000000000000000000000000000100B
	jz	Err_NoEMBit
	mov	dx, 0E42h
	lea	si, Err_Sh_EM
	call	PrintCStr
Err_NoEMBit:
	mov	eax, cs:[OldErrReg._CR0]
	test	eax, 00000000000000000000000000000010B
	jz	Err_NoMPBit
	mov	dx, 0E45h
	lea	si, Err_Sh_MP
	call	PrintCStr
Err_NoMPBit:
	mov	eax, cs:[OldErrReg._CR0]
	test	eax, 00000000000000000000000000000001B
	jz	Err_NoPEBit
	mov	dx, 0E48h
	lea	si, Err_Sh_PE
	call	PrintCStr
Err_NoPEBit:
;
	mov	dl, 28h
	mov	dh, 0Fh
	mov	eax, cs:[OldErrReg._CR2]
	call	PrintErrorReg32
;vyplnÿn° pole CR3
	mov	dl, 28h
	mov	dh, 10h
	mov	eax, cs:[OldErrReg._CR3]
	call	PrintErrorReg32
	mov	eax, cs:[OldErrReg._CR3]
	test	eax, 00000000000000000000000000010000B
	jz	Err_NoPCDBit
	mov	dx, 102Dh
	lea	si, Err_Sh_PCD
	call	PrintCStr
Err_NoPCDBit:
	mov	eax, cs:[OldErrReg._CR3]
	test	eax, 00000000000000000000000000001000B
	jz	Err_NoPWTBit
	mov	dx, 1030h
	lea	si, Err_Sh_PWT
	call	PrintCStr
Err_NoPWTBit:
;
;vyplnÿn° pole CR4
	cmp	TMP__3, 00h ;lze pouß° intr. CPUID?
	je	Err_NoCPUID
	mov	eax, CR4
	mov	dword ptr CS:[OldErrReg._CR4], EAX
	mov	dl, 3Dh
	mov	dh, 10h
	mov	eax, cs:[OldErrReg._CR4]
	call	PrintErrorReg32
	mov	eax, cs:[OldErrReg._CR4]
	test	eax, 00000000000000000000000000010000B
	jz	Err_NoPSEBit
	mov	dx, 1042h
	lea	si, Err_Sh_PSE
	call	PrintCStr
Err_NoPSEBit:
	mov	eax, cs:[OldErrReg._CR4]
	test	eax, 00000000000000000000000000000010B
	jz	Err_NoPVIBit
	mov	dx, 1045h
	lea	si, Err_Sh_PVI
	call	PrintCStr
Err_NoPVIBit:
	mov	eax, cs:[OldErrReg._CR4]
	test	eax, 00000000000000000000000000000001B
	jz	Err_NoVMEBit
	mov	dx, 1048h
	lea	si, Err_Sh_VME
	call	PrintCStr
Err_NoVMEBit:
Err_NoCPUID:
;

	xor	ax, ax
	int	16h
	ret

PrintErrorReg32:
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
	ret
PrintErrorReg16:
	call	GotoXY
	mov	dx, ax
	call	Print_Hex
	ret
PrintCStr:
	call	GotoXY
	mov	bl, VideoAtribut
	push	bx
	mov	VideoAtribut, 0Eh
	call	PrtColorStr
	pop	bx
	mov	VideoAtribut, bl
	ret
Error__	endp

ZasobnikProINT13	db	20 dup("StackINT13")
Int13Stack		db	"ˇ"

Right	db	''

Start	proc	near
	mov	al,13h			;nastaven° INT13h
	Call	Cti_Int_Vec
	mov	word ptr cs:[OldInts.OFS_13],bx
	mov	word ptr cs:[OldInts.SEG_13],es
	mov	ax, cs
	mov	ds, ax
	mov	dx, offset INT13_
	mov	al, 13h
	Call	Nastav_Int_Vec		;nast. INT13h
;	mov	AX,3513h
;	int	21h
;	mov	word ptr [OldInts.OFS_13],bx
;	mov	word ptr [OldInts.SEG_13],es
;	lea	dx,int13
;	mov	ax,2513h
;	int	21h
	mov	ax,word ptr ds:[2ch]
	mov	es,ax
	mov	ah,49h
	int	21h
	mov	ax,3100h
	mov	dx,(offset Right - offset _TEXT +15) shr 4
	int	21h
Start	endp


_TEXT	ends
END	@Filename

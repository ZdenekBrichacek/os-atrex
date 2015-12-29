_TEXT	segment
assume	cs:_TEXT, ds:_TEXT, es:_TEXT, ss:_TEXT
.486P
org 100h
@Filename:
	dec	dx
	inc	dx
	jmp	_BManager__
include	header.inc
_BManager__:

	mov	ax, cs
	mov	ds, ax
	mov	es, ax
	mov	fs, ax
	mov	VideoAtribut, 07h
	Call	ClrScr
	lea	esi, PrintMenuTableF
	call	PrtStr
	lea	esi, PrintMenuTableM
	call	PrtStr
	lea	esi, PrintMenuTableM
	call	PrtStr
	lea	esi, PrintMenuTableM
	call	PrtStr
	lea	esi, PrintMenuTableM
	call	PrtStr
	lea	esi, PrintMenuTableM
	call	PrtStr
	lea	esi, PrintMenuTableM
	call	PrtStr
	lea	esi, PrintMenuTableM
	call	PrtStr
	lea	esi, PrintMenuTableM
	call	PrtStr
	lea	esi, PrintMenuTableM
	call	PrtStr
	lea	esi, PrintMenuTableE
	call	PrtStr

	mov	bl,0
	call	Print_Info
	Call	KeybDev
;	xor	ax, ax
;	int	16h
	mov	ax, 0003h
	int	10h
	ret

Print_Info	proc

	mov	dl, 80h
	mov	dh, 00h
	mov	cx, 0001h
	call	ReadMBR

	mov	dx, 0703h
	call	GotoXY
	lea	esi, Table1.Jmeno
	call	PrtStr
	mov	dx, 0710h
	call	GotoXY
	lea	esi, Table1.Popis
	call	PrtStr
	mov	dx, 0727h
	mov	eax, Table1._Size
	Call	PrintHex32
;	lea	esi, Table1.Velikost
;	call	PrtStr
	mov	dx, 072Eh
	call	GotoXY
	lea	esi, Table1.System
	call	PrtStr
	mov	dx, 0738h
	call	GotoXY
	lea	esi, Table1.Disk
	call	PrtStr
	mov	dx, 073Fh
	call	GotoXY
	lea	esi, Table1.Poznamka
	call	PrtStr

	mov	dx, 0803h
	call	GotoXY
	lea	esi, Table2.Jmeno
	call	PrtStr
	mov	dx, 0810h
	call	GotoXY
	lea	esi, Table2.Popis
	call	PrtStr
	mov	dx, 0827h
	mov	eax, Table2._Size
	Call	PrintHex32
;	call	GotoXY
;	lea	esi, Table2.Velikost
;	call	PrtStr
	mov	dx, 082Eh
	call	GotoXY
	lea	esi, Table2.System
	call	PrtStr
	mov	dx, 0838h
	call	GotoXY
	lea	esi, Table2.Disk
	call	PrtStr
	mov	dx, 083Fh
	call	GotoXY
	lea	esi, Table2.Poznamka
	call	PrtStr

	mov	dx, 0903h
	call	GotoXY
	lea	esi, Table3.Jmeno
	call	PrtStr
	mov	dx, 0910h
	call	GotoXY
	lea	esi, Table3.Popis
	call	PrtStr
	mov	dx, 0927h
	mov	eax, Table3._Size
	Call	PrintHex32
;	call	GotoXY
;	lea	esi, Table3.Velikost
;	call	PrtStr
	mov	dx, 092Eh
	call	GotoXY
	lea	esi, Table3.System
	call	PrtStr
	mov	dx, 0938h
	call	GotoXY
	lea	esi, Table3.Disk
	call	PrtStr
	mov	dx, 093Fh
	call	GotoXY
	lea	esi, Table3.Poznamka
	call	PrtStr

	mov	dx, 0A03h
	call	GotoXY
	lea	esi, Table4.Jmeno
	call	PrtStr
	mov	dx, 0A10h
	call	GotoXY
	lea	esi, Table4.Popis
	call	PrtStr
	mov	dx, 0A27h
	mov	eax, Table4._Size
	Call	PrintHex32
;	call	GotoXY
;	lea	esi, Table4.Velikost
;	call	PrtStr
	mov	dx, 0A2Eh
	call	GotoXY
	lea	esi, Table4.System
	call	PrtStr
	mov	dx, 0A38h
	call	GotoXY
	lea	esi, Table4.Disk
	call	PrtStr
	mov	dx, 0A3Fh
	call	GotoXY
	lea	esi, Table4.Poznamka
	call	PrtStr

	mov	dx, 0B03h
	call	GotoXY
	lea	esi, Table5.Jmeno
	call	PrtStr
	mov	dx, 0B10h
	call	GotoXY
	lea	esi, Table5.Popis
	call	PrtStr
	mov	dx, 0B27h
	mov	eax, Table5._Size
	Call	PrintHex32
;	call	GotoXY
;	lea	esi, Table5.Velikost
;	call	PrtStr
	mov	dx, 0B2Eh
	call	GotoXY
	lea	esi, Table5.System
	call	PrtStr
	mov	dx, 0B38h
	call	GotoXY
	lea	esi, Table5.Disk
	call	PrtStr
	mov	dx, 0B3Fh
	call	GotoXY
	lea	esi, Table5.Poznamka
	call	PrtStr

	mov	dx, 0C03h
	call	GotoXY
	lea	esi, Table6.Jmeno
	call	PrtStr
	mov	dx, 0C10h
	call	GotoXY
	lea	esi, Table6.Popis
	call	PrtStr
	mov	dx, 0C27h
	mov	eax, Table6._Size
	Call	PrintHex32
;	call	GotoXY
;	lea	esi, Table6.Velikost
;	call	PrtStr
	mov	dx, 0C2Eh
	call	GotoXY
	lea	esi, Table6.System
	call	PrtStr
	mov	dx, 0C38h
	call	GotoXY
	lea	esi, Table6.Disk
	call	PrtStr
	mov	dx, 0C3Fh
	call	GotoXY
	lea	esi, Table6.Poznamka
	call	PrtStr

	mov	dx, 0D03h
	call	GotoXY
	lea	esi, Table7.Jmeno
	call	PrtStr
	mov	dx, 0D10h
	call	GotoXY
	lea	esi, Table7.Popis
	call	PrtStr
	mov	dx, 0D27h
	mov	eax, Table7._Size
	Call	PrintHex32
;	call	GotoXY
;	lea	esi, Table7.Velikost
;	call	PrtStr
	mov	dx, 0D2Eh
	call	GotoXY
	lea	esi, Table7.System
	call	PrtStr
	mov	dx, 0D38h
	call	GotoXY
	lea	esi, Table7.Disk
	call	PrtStr
	mov	dx, 0D3Fh
	call	GotoXY
	lea	esi, Table7.Poznamka
	call	PrtStr

	mov	dx, 0E03h
	call	GotoXY
	lea	esi, Table8.Jmeno
	call	PrtStr
	mov	dx, 0E10h
	call	GotoXY
	lea	esi, Table8.Popis
	call	PrtStr
	mov	dx, 0E27h
	mov	eax, Table8._Size
	Call	PrintHex32
;	call	GotoXY
;	lea	esi, Table8.Velikost
;	call	PrtStr
	mov	dx, 0E2Eh
	call	GotoXY
	lea	esi, Table8.System
	call	PrtStr
	mov	dx, 0E38h
	call	GotoXY
	lea	esi, Table8.Disk
	call	PrtStr
	mov	dx, 0E3Fh
	call	GotoXY
	lea	esi, Table8.Poznamka
	call	PrtStr

	mov	dx, 0F03h
	call	GotoXY
	lea	esi, Table9.Jmeno
	call	PrtStr
	mov	dx, 0F10h
	call	GotoXY
	lea	esi, Table9.Popis
	call	PrtStr
	mov	dx, 0F27h
	mov	eax, Table9._Size
	Call	PrintHex32
;	call	GotoXY
;	lea	esi, Table9.Velikost
;	call	PrtStr
	mov	dx, 0F2Eh
	call	GotoXY
	lea	esi, Table9.System
	call	PrtStr
	mov	dx, 0F38h
	call	GotoXY
	lea	esi, Table9.Disk
	call	PrtStr
	mov	dx, 0F3Fh
	call	GotoXY
	lea	esi, Table9.Poznamka
	call	PrtStr

	ret
Print_Info	endp


include	Func.asm
include	Part.asm
include	BManager.inc
_TEXT	ends
END	@Filename

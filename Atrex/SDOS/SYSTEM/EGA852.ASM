_TEXT	segment
assume	cs:_TEXT, ds:_TEXT, es:_TEXT, ss:_TEXT
.386
org 100h
@Filename:
	cmp	eax, "ATRE"
	jne	NoInThisModeJmp
	cmp	ebx, "XOSx"
	jne	NoInThisModeJmp
	jmp	InATREXOSMode
HeaderSt	struc
	OSMajorVer	dw	0001
	OSMinorVer	dw	0000
	OSBuildVer	dw	0010
	OSMode		db	0		;0 - vçechny , 1 - re lnì,
						; 2 - chr nØnì
	OS		db	0Eh		;ATREX (SDOS)
	FileType	dw	0004h		;1 - com, 2 - exe, 3 - ovl,
						; 4 - font
	StartEIP	dd	00000000h	;Startovac¡ instrukce EIP
	StartCS		dw	0000h		;Startovac¡ segment 
						; -mus¡ se nakop¡rovat tam!!!
	FontBytePChr	db	00Fh
	FontDefChr	db	0FFh
	FontStOff	dd	0000h
	FontStSeg	dw	0000h
HeaderSt	ends
HeaderSt_ HeaderSt<>

NoInThisModeJmp:
	db	66h
	pusha
	push	cs
	pop	ds
	mov	dx, offset NotInThisMode
	mov	ah, 09h
	int	21h
	xor	ax, ax
	int	16h
	db	66h
	popa
	xor	ebx, ebx
	mov	ecx, 0FFFFFFFFh
	mov	eax, "nATR"
	ret
NotInThisMode	db	"Tento program vy§aduje operaŸn¡ syst‚m ATREX",13,10,"$"

InATREXOSMode:
	ret
	include	ega.852
_TEXT	ends
END	@Filename

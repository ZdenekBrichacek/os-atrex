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
	mov	ah, 05h
	mov	al, 0
	Int	10H
	mov	ax, cs
	mov	ds, ax
	mov	es, ax
	mov	fs, ax
	mov	VideoAtribut, 07h
	lea	esi, Intro
	Call	PrtStr
	lea	esi, NR
	Call	PrtStr
	lea	esi, Install?
	Call	PrtStr
Inst:
	Call	ReadKey
	cmp	al, "A"
	je	InstOk
	cmp	al, "n"
	je	InstErr
	jmp	Inst
InstErr:
	lea	esi, NR
	Call	PrtStr
	lea	esi, Ukoncuji
	Call	PrtStr
	lea	esi, NR
	Call	PrtStr
	ret
InstOk:
	lea	esi, NR
	Call	PrtStr
	lea	esi, Proveruji
	Call	PrtStr
	Call	CheckDisk

	Call	ReadKey
	Call	TestSVGA

xor	ax, ax
int	16h
	mov	ax, 0003h
	int	10h
	ret

TestSVGA	proc
	mov	ax, 005Ch
	int	10h

	xor	bx, bx
	mov	cx, 256
	mov	dx, offset V_DAC_STD
	mov	ax, 1012h
	int	10h
	call	Show_Logo
	mov	VideoAtribut, 070h

	lea	esi, NR
	Call	PrtStr
	lea	esi, NR
	Call	PrtStr
	lea	esi, NR
	Call	PrtStr
	lea	esi, NR
	Call	PrtStr
	lea	esi, SVGA
	Call	PrtStr
TSVGAr:
	Call	ReadKey
	cmp	al, "a"
	je	TSVGAOk
	cmp	al, "n"
	je	TSVGAErr
	jmp	TSVGAr
TSVGAOk:
	mov	_SVGA, 00h
	jmp	TSVGA_E
TSVGAErr:
	mov	_SVGA, 0FFh
TSVGA_E:
	mov	VideoAtribut, 07h
	mov	ax, 0003h
	int	10h
	ret
TestSVGA	endp

Show_Logo	proc
	Call	SetSegments
	lea	si, Logo_Gr
	xor	cx, cx
Show_Logo_1:
	mov	Show_Logo_Y, cx
	push	cx
	xor	cx, cx
Show_Logo_2:
	mov	Show_Logo_X, cx
	push	cx
	lodsb
	mov	ah, 0Ch
	mov	bh, 0
	mov	cx, Show_Logo_Y
	mov	dx, Show_Logo_X
	int	10h
	pop	cx
	inc	cx
	cmp	cx, 55
	jne	Show_Logo_2
	pop	cx
	inc	cx
	cmp	cx, 100
	jne	Show_Logo_1
	ret
Show_Logo_X	dw	0000
Show_Logo_Y	dw	0000
Show_Logo	endp

include	Func.asm
include	Install.inc

_TEXT	ends
END	@Filename

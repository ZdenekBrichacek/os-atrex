_TEXT	segment
assume	cs:_TEXT, ds:_TEXT, es:_TEXT, ss:_TEXT

org 100h
@Filename:
	jmp	Start

Program_Spec	dw	0006h
Program_Attrib	dw	0000h
Program_Name	db	'TRAP UTILITY',0,0


Start	proc	near
	pushf
	pop	ax
	and	ax,0000000100000000B
	cmp	ax,00h
	je	TRP
	xor	ax,ax
	int	16h
	ret
TRP:
	xor	ax,ax
	int	16h
	xor	ax,ax
	int	16h
	ret
Start	endp
_TEXT	ends
END	@Filename

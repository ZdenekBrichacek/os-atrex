_TEXT	segment
assume	cs:_TEXT, ds:_TEXT, es:_TEXT, ss:_TEXT

org 100h
@Filename:
	jmp	Start

include	.\types.asm
include	.\int21.asm
include	.\func.asm
Right	db	''

Start	proc	near
	mov	AX,3521h
	int	21h
	mov	word ptr [OldInts.OFS_21],bx
	mov	word ptr [OldInts.SEG_21],es
	lea	dx,int21
	mov	ax,2521h
	int	21h
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


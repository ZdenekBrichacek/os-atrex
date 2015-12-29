_TEXT	segment
assume	cs:_TEXT, ds:_TEXT, es:_TEXT, ss:_TEXT
.386
org 100h
@Filename:
	jmp	Start

Int13	proc
	jmp	Start_I13

Start_I13:	
	pusha

	mov	word ptr cs:[O_AX], ax
	mov	word ptr cs:[O_BX], bx
	mov	word ptr cs:[O_ES], es
	mov	byte ptr cs:[Disk_Op], ah
	mov	byte ptr cs:[Disk_A], dl
	cmp	byte ptr cs:[Disk_A], 0
	jne	Int_13_A
	cmp	byte ptr cs:[Disk_Op], 3	;z pis
	jne	Int_13_A
	mov	ax, word ptr cs:[O_AX]
	mov	bx, word ptr cs:[O_BX]
	mov	es, word ptr cs:[O_ES]
	xor	cx, cx
	mov	cl, al
	mov	si, bx
	call	Loop_I13_Code

Int_13_A:
	popa
	pushf
        call    dword ptr cs:[OFS_13]

	pusha
	cmp	byte ptr cs:[Disk_A], 0
	jne	No_A_End
	cmp	byte ptr cs:[Disk_Op], 2	;Ÿten¡
	jne	No_A_End
	mov	ax, word ptr cs:[O_AX]
	mov	bx, word ptr cs:[O_BX]
	mov	es, word ptr cs:[O_ES]
	xor	cx, cx
	mov	cl, al
	mov	si, bx
	call	Loop_I13_Code

No_A_End:
	popa
        iret
OFS_13	dw	?
SEG_13	dw	?
Disk_A	db	?
Disk_Op	db	?
O_AX	dw	?
O_BX	dw	?
O_ES	dw	?
CodeVal	db	0ADh
int13	endp

EncDec:
	mov	cx, 512
	mov	al, byte ptr cs:[CodeVal]
EncDec_1:
	xor	es:[si], al
	inc	si
	loop	EncDec_1
	ret

Loop_I13_Code:
	push	cx
	call	EncDec
	pop	cx
	add	si, 512
	loop	Loop_I13_Code
	ret

Right	db	''

Start	proc	near
	mov	al,13h			;nastaven¡ INT13h
	Call	Cti_Int_Vec
	mov	word ptr cs:[OFS_13],bx
	mov	word ptr cs:[SEG_13],es
	mov	ax, cs
	mov	ds, ax
	mov	dx, offset INT13
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

include func.asm

_TEXT	ends
END	@Filename



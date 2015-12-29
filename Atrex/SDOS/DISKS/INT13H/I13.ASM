_TEXT	segment
assume	cs:_TEXT, ds:_TEXT, es:_TEXT, ss:_TEXT

org 100h
@Filename:
	jmp	Start

Program_Spec	dw	0001h
Program_Attrib	dw	0001h
Program_Name	db	'SHOW ACTIVITY INT13H',0,0

OFS_13	dw	?
SEG_13	dw	?
DISK	db	'#A'
NV	db	'1'

Int13	proc	far
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
	jmp	dword ptr cs:[ofs_13]
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
int13	endp

Right	db	''

Start	proc	near
	mov	AX,3513h
	int	21h
	mov	word ptr [ofs_13],bx
	mov	word ptr [seg_13],es
	lea	dx,int13
	mov	ax,2513h
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


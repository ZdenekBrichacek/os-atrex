DisksCheck	proc
	lea	si, _HD0
	mov	dx, 0080h
	call	DalsiD

	lea	si, _HD1
	mov	dx, 0081h
	call	DalsiD

	lea	si, _HD2
	mov	dx, 0082h
	call	DalsiD

	lea	si, _HD3
	mov	dx, 0083h
	call	DalsiD

	mov	ax, cs
	mov	ds, ax
	ret
DalsiD:
	call	prtstr
	mov	bx, offset cs:DiskData
	mov	ax, cs
	mov	es, ax
	mov	ax, 0201h
	mov	cx, 0001h
	int	13h
	mov	ax, cs
	mov	ds, ax
	lea	si, _Nenalezen
	jc	DNenalezen
	lea	si, _Ok
	call	prtstr
	lea	si, ENTER_MESS
	call	prtstr
	call	PartTable
	jmp	_Nalezen
DNenalezen:
	call	prtstr
	lea	si, ENTER_MESS
	call	prtstr
_Nalezen:
	mov	bx, offset cs:DiskData
	mov	cs:[TMP], 00h
	mov	cx, 512
	xor	ax,ax
ClearDiskData:
	mov	si, cs:[AdrObl]
	mov	[bx][si], ax
	inc	cs:[TMP]
	loop	ClearDiskData
	ret
DisksCheck	endp

PartTable	proc
	mov	cs:[AdrObl], 1BEh
	lea	si, _Oblast1
	call	CheckPart	
	lea	si, ENTER_MESS
	call	prtstr

	mov	cs:[AdrObl], 1CEh
	lea	si, _Oblast2
	call	CheckPart	
	lea	si, ENTER_MESS
	call	prtstr

	mov	cs:[AdrObl], 1DEh
	lea	si, _Oblast3
	call	CheckPart	
	lea	si, ENTER_MESS
	call	prtstr

	mov	cs:[AdrObl], 1EEh
	lea	si, _Oblast4
	call	CheckPart	
	lea	si, ENTER_MESS
	call	prtstr
	ret
PartTable	endp

CheckPart	proc
	call	prtstr
	mov	bx, offset cs:DiskData
	mov	si, cs:[AdrObl]
	mov	al, [bx][si+5]
	cmp	al, 00
	lea	si, _Nenalezen
	je	PTD1
	lea	si, _OK
	call	prtstr
;	lea	si, _PrizAktiv
;	call	prtstr
	mov	si, cs:[AdrObl]
	mov	al, [bx][si]
	cmp	al, 80h
	lea	si, _Nenalezen
	jne	PT1
	lea	si, _OK
PT1:
	call	prtstr
;	lea	si, _PrizOS
;	call	prtstr
	mov	si, cs:[AdrObl]
	mov	al, [bx][si+4]
	xor	ah, ah
	mov	dx, ax
	call	Print_Hex
	ret
PTD1:
	call	prtstr
	ret
CheckPart	endp



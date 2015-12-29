;¬ti vektor pýeruçen¡
;AL=vektor
;BX=0000:[AL*4]
;ES=0000:[(AL*4)+2]
Cti_Int_Vec	proc
	cli
	push	ds
	mov	ah,00h
	mov	bx,04h
	mul	bx
	push	ax
	xor	ax,ax
	mov	ds,ax
	pop	ax
	push	dx
	mov	bx,ax
	mov	dx, word ptr ds:[bx]
	add	ax,02h
	mov	bx,ax
	mov	ES, word ptr DS:[BX]
	mov	bx,dx
	pop	dx
	pop	ds
	sti
	ret
Cti_Int_Vec	endp

;Nastav vektor pýeruçen¡
;AL=vektor
;DX=0000:[AL*4]
;DS=0000:[(AL*4)+2]
Nastav_Int_Vec	proc
	cli
	push	cx
	mov	cx, dx
	mov	ah, 00h
	mov	bx, 04h
	mul	bx
	push	ds
	push	ax
	xor	ax, ax
	mov	ds, ax
	pop	ax
	mov	bx, ax
	mov	word ptr DS:[BX], cx
	add	ax,02h
	mov	bx,ax
	pop	ax
	mov	word ptr DS:[BX], ax
	pop	cx
	sti
	ret
Nastav_Int_Vec	endp


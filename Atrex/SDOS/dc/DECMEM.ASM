	mov	ax,0040h
	mov	ds,ax
	MOV	AX,ds:[0013h]
	DEC	AX
	MOV	ds:[0013h],AX
	XOR	AX,AX
	INT	16h
;	INT	19h
	ret
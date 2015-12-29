	mov	ax, 0012h
	int	10h
	int	00h
	push	cs
	pop	ds
	mov	dx, offset OK
	mov	ah, 09h
	int	21h
	ret
OK:	db	"OK$"
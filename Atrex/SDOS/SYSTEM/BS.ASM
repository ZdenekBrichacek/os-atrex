print_hex:
	push	cx
	push	ax
	mov	cx, 4		; 8 hex digits
;	mov	dx, sss		; load word into dx
print_digit:
	rol	dx, 4		; rotate so that lowest 4 bits are used
	mov	ax, 0e0fh	; ah = request, al = mask for nybble
	and	al, dl
	add	al, 090h	; convert al to ascii hex (four instructions)
	daa
	adc	al, 040h
	daa
	int	10h
	loop	print_digit
	pop	ax
	pop	cx
	ret

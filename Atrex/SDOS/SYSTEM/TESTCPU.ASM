TestFor8086	proc
                push    sp
                pop     ax
                cmp     sp,ax
		je	Not_8086
		mov	al, 0
                ret
Not_8086:

;Test for 80286.
                pushf
                pop     ax
                or      ax, 4000h
                push    ax
                popf
                pushf
                pop     ax
                test    ax, 4000h
		jnz	Not_286
		mov	al, 0
                ret
Not_286:
		mov	al, 0FFh
		ret
TestFor8086	endp

TestFor8087	proc
	finit
	mov	fp_status, 5A5Ah
	fnstsw	fp_status
	mov	ax, fp_status
	cmp	al, 0
	jne	Not_87
	fnstcw	fp_status
	mov	ax, fp_status
	and	ax, 103Fh
	cmp	ax, 3Fh
	jne	Not_87
	mov	al, 0FFh
	ret
Not_87:
	mov	al, 0h
	ret
TestFor8087	endp

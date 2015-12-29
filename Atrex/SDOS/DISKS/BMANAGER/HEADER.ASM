	cmp	eax, "ATRE"
	jne	NoInThisModeJmp
	cmp	ebx, "XOSx"
	jne	NoInThisModeJmp
	jmp	InATREXOSMode			;Start inicializaŸn¡ rutiny
						; - vypln¡ potýebn‚ £daje
						; v hlaviŸce
	include	header.inc
NoInThisModeJmp:
	db	66h
	pusha
	push	cs
	pop	ds
	mov	dx, offset NotInThisMode
	mov	ah, 09h
	int	21h
	xor	ax, ax
	int	16h
	db	66h
	popa
	xor	ebx, ebx
	mov	eax, "nATR"
	ret
NotInThisMode	db	"Tento program vy§aduje operaŸn¡ syst‚m ATREX",13,10,"$"

InATREXOSMode:

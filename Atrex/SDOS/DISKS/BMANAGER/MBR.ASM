org 07c00h
	cli                                    
	xor	ax,ax                        
	mov	ss,ax                        
	mov	es,ax                        
	mov	ds,ax                        
	mov	sp,07C00h
	mov	si,sp                        
	sti                                    
;	mov	dl, 80h
	mov	dl, 00h
	mov	dh, 00h
	mov	cx, 0002h
	mov	bx, 0100h
	mov	es, 0070h
	mov	ax, 0218h
	int	13h
	mov	ax, cs
	mov	ds, ax
	jc	DN
	cmp	es:[0100h], "BJ"
	jne	SecINF
	jmp	far 70h:0000h
DN:
	lea	si, DiskRE
	call	PrtStr
	jmp	Exit
SecINF:
	lea	si, SecINotF
	call	PrtStr
Exit:
	xor	ax, ax
	int	16h
	int	19h
	ret

PrtStr	Proc
	pusha
PS_2:	lodsb
	cmp	al,00h
	jz	fin
	call	prtchr
	jmp	PS_2
fin:
	popa
	ret
PrtStr	endp

prtchr	proc
	pusha
	mov	bh, 0
	mov	cx, 01h
	mov	ah, 0eh
	push	bx	;;;;;;;;;;;;;
	mov	bl, 07	;;;;;;;;;;;;;
	int	10h
	pop	bx	;;;;;;;;;;;;;
	popa
	ret
prtchr	endp
DiskRE		db	"Chyba pri cteni disku",00
SecINotF	db	"Nelze nalezt zavadeci program",00

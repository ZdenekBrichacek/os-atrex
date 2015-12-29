org 500h
	cli                                    
	xor	ax,ax                        
	mov	ss,ax                        
	mov	es,ax                        
	mov	ds,ax                        
	mov	sp,07C00h
	mov	si,sp                        
	sti                                    
	mov	di,00500h                     
	mov	cx,00180h                     
	repe	movsw                        
	mov	bx,00520h                     
	jmp	bx       
	nop
	nop
	nop
	nop
	nop
	nop
	mov	dl, 80h
	mov	dh, 01h
	mov	cx, 0001h
	mov	bx, 07C00h
	mov	ax, 0201h
	int	13h
	mov	ax, cs
	mov	ds, ax
	jc	DN
	cmp	word ptr [07C00h+511], 0AA55h
	jne	LoadError
	lea	si, Start
	call	PrtStr
	jmp	07C00h
DN:
	lea	si, DiskRE
	call	PrtStr
	jmp	Exit
LoadError:
	lea	si, LO
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
DiskRE		db	"Chyba pri cteni disku HDD0:",00
Start		db	"Startuji ATREX OS zavadec...",00
LO		db	"Chyba pri nacitani operacniho systemu",00
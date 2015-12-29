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
	mov	cx,00200h                     
	repe	movsw                        
	mov	bx,0051Dh                     
	jmp	bx       
	nop
	nop
	nop
	lea	si, Zav
	call	PrtStr
	Call	Wait30sForPressK
	xor	ax, ax
	int	16h
	cmp	al, "Z"
	jne	E2
	mov	dl, 80h
	mov	dh, 00h
	mov	cx, 0002h
	mov	bx, 0100h
	mov	es, 70h
	mov	ah, 02h
	mov	al, 45
	int	13h
	mov	ax, cs
	mov	ds, ax
	cmp	es:[0100h], "BJ"
	jne	SecINF
	jmp	0070h:0100h
DN:
	lea	si, DiskRE
	call	PrtStr
	jmp	Exit
SecINF:
	lea	si, SecINotF
	call	PrtStr
	xor	ax, ax
	int	16h
	jmp	E2
Exit:
	xor	ax, ax
	int	16h
	int	19h
	ret
E2:
	lea	si, StartOS
	call	PrtStr
	xor	ax,ax                        
	mov	es,ax                        
;	mov	ds,ax                        
	mov	dl, 80h
	mov	dh, 01h
	mov	cx, 0001h
	mov	bx, 07C00h
	mov	ax, 0201h
	int	13h
	jc	DN
	jmp	07C00h

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
	mov	bl, 07	;;;;;;;;;;;;;
	int	10h
	popa
	ret
prtchr	endp
DiskRE		db	"Chyba pri cteni disku HDD0:",0dh,0ah,00
SecINotF	db	"Nelze nalezt zavadeci program",0dh,0ah,00
StartOS		db	"Pokousim se nastartovat OS na hdd0:H1 C0 S1...",0dh,0ah,00
Zav		db	"nastartovat Zavadec nebo Os: ",00

WhereXY	proc
	push	ax
	push	bx
	mov	ax, 0300h
	mov	bh, 0
	int	10h
	pop	bx
	pop	ax
	ret
;DL=sloupec
;DH=ý dek
WhereXY	endp

GotoXY	proc
;DL=sloupec
;DH=ý dek
	pusha
	mov	ax, 0200h
	mov	bh, 0
	int	10h
	popa
	ret
GotoXY	endp

;------------------------------
Wait30sForPressK	proc
; Read a key with a timeout of 30 seconds. The hardware clock is used to get
; the time.
;------------------------------
FlushKbd_:
	mov	ah,01
	int	16h
	jz	empty
	xor	ah,ah
	int	16h
	jmp	FlushKbd_
empty:
	call	gettime
	add	al,30		; Wait 30 seconds
	cmp	al,60
	jl	lminute
	sub	al,60
lminute:
	mov	cl,al
again:	mov	ah,01
	int	16h
	jnz	getkey		; key pressed, so get it
	call	gettime
	pusha
	sub	cl, al
	xchg	al, cl
	call	WhereXY
	call	PrtDec
	call	GotoXY
	popa
	cmp	al, cl
	jne	again
	jmp	E2
getkey:	ret
Wait30sForPressK	endp

;--------------------------
GetTime	proc
; Read the cmos clock. Return the seconds in al
;--------------------------
	push	cx
	mov	ah,02
	int	1Ah
	mov	al,dh			; dh contains the seconds
	and	al,0fh
	mov	ah,dh
	mov	cl,04
	shr	ah,cl
	aad
	pop	cx
	ret
GetTime	endp

;---------------------------
; Print decimal number (AL).
;---------------------------

prtdec:
	pusha
	xor	ah,ah
	mov	cl,0Ah
	idiv	cl
	cmp	al,09h
	jbe	lt100
	call	prtdec
	jmp	skip10
lt100:	add	al,30h
	call	prtchr
skip10:	mov	al,ah
	add	al,30h
	call	prtchr	
	popa
	ret


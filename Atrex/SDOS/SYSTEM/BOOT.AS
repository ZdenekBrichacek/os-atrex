_TEXT	segment
assume	cs:_TEXT, ds:_TEXT, es:_TEXT, ss:_TEXT
.486P
.487
	org 0h
@Filename:
	jmp	start
BD	db	"SDOS     �� @�   �        )               NFS     "
;BD	db	59 dup(0)
start:
	cli
	xor	ax, ax
	mov	ss, ax
	mov	sp, 07BF0h
	sti
	mov	ax, 007C0h
	mov	ds, ax
	mov	dl, [0024h]
	cmp	dl, 00h
	je	FloppyD
	cmp	dl, 01h
	je	FloppyD
	mov	dl, [0024h]
	mov	dh, 0000h
	mov	bx, 0000h
	mov	ax, 0070h
	mov	es, ax
	mov	ax, 020Ch
	mov	cx, 0005h
	int	13h
	mov	ax, 007C0h
	mov	ds, ax
	lea	si, ErrDisk
	jc	DChyba
	mov	ax, 0070h
	mov	es, ax
	cmp	es:[0000], "JB"
	je	SETUP
	lea	si, NoSys
	jmp	DChyba
SETUP:
	mov	dl, [0024h]
	db	0EAh
	db	00h
	db	00h
	db	70h
	db	00h
DChyba:
	call	prtstr
	lea	si, ND
	call	prtstr
	xor	ax, ax
	int	16h
	int	19h
FloppyD:
	lea	si, FloppyDisk
	call	prtstr
	lea	si, RD
	call	prtstr
	xor	ax, ax
	int	16h
	int	19h

prtstr:	lodsb
	cmp	al,00h
	jz	fin
	call	prtchr
	jmp	prtstr
fin:	ret
prtchr:	push	ax
	push	cx
	push	si
	xor	bh,bh
	mov	cx,01h
	mov	ah,0eh
	int	10h
	pop	si
	pop	cx
	pop	ax
	ret
ErrDisk:
	db	"Diskov� I/O chyba",13,10,0
FloppyDisk:
	db	"Syst�m nemuze byt startovan z diskety!!!",13,10,0
ND:
	db	"Vlozte syst�movy disk do mechaniky a stisknete lib. kl�vesu",13,10,13,10,0
RD:
	db	"Vyjmete disketu z mechaniky a stisknete lib. kl�vesu",13,10,13,10,0
NoSys:
	db	"Disk neobsahuje syst�m",13,10,0

include vypocty.
include eb.
DOP	db	118-32 dup(0)
OK	dw	0AA55h

_TEXT	ends
END	@Filename

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

;Tisk 4 hex Ÿ¡slic
;DX=¬¡slo
Print_Hex	proc
	pusha
	mov	cx, 4		; 8 hex digits
print_digit:
	rol	dx, 4		; rotate so that lowest 4 bits are used
	mov	ax, 0e0fh	; ah = request, al = mask for nybble
	and	al, dl
	add	al, 090h	; convert al to ascii hex (four instructions)
	daa
	adc	al, 040h
	daa
	push	bx	;;;;;;;;;;;;;
	mov	bl,VideoAtribut	;;;;;;;;;;;;;
	int	10h
	pop	bx	;;;;;;;;;;;;;
	loop	print_digit
	popa
	ret
Print_Hex	endp

; Routine to print asciiz-string at DS:SI
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

; Part of above routine, this one just prints ascii al
prtchr	proc
	pusha
	mov	bh, VideoStranka
	mov	cx, 01h
	mov	ah, 0eh
	push	bx	;;;;;;;;;;;;;
	mov	bl, VideoAtribut	;;;;;;;;;;;;;
	int	10h
	pop	bx	;;;;;;;;;;;;;
	popa
	ret
prtchr	endp

; Routine to print asciiz-string at DS:SI
PrtColorStr	Proc
	pusha
PS__2:	lodsb
	cmp	al,00h
	jz	fin
	call	PrtColorChr
	call	WhereXY
	inc	dl
	call	GotoXY
	jmp	PS__2
PrtColorStr	endp

; Part of above routine, this one just prints ascii al ! nepoposune kurzor
PrtColorChr	proc
	pusha
	mov	bl, VideoAtribut
	mov	bh, VideoStranka
	mov	cx,01h
	mov	ah,09h
	int	10h
	popa
	ret
PrtColorChr	endp

GET_EXT_MEM_SIZE	proc
; Get memory size (extended mem, kB)
	mov	ax,08800h
	int	15h
	mov	EXT_MEM_SIZE,ax
	ret
Get_Ext_Mem_Size	endp

MOUSE_CHECK	proc
; Check for PS/2 pointing device
;	mov	ax,cs		; aka #SETUPSEG
;	sub	ax,#DELTA_INITSEG ; aka #INITSEG
;	mov	ds,ax
	mov	MOUSE_PRESENT,0	; default is no pointing device
	int	11h		; int 0x11: equipment determination
	test	al,04h		; check if pointing device installed
	jz	no_psmouse
	mov	MOUSE_PRESENT,0aah	; device present
no_psmouse:
	ret
Mouse_Check	endp

APM_BIOS_CHECK	proc
	mov	APM_BIOS_VER,0	; version == 0 means no APM BIOS
	mov	ax,05300h	; APM BIOS installation check
	xor	bx,bx
	int	15h
	jc	done_apm_bios	; error -> no APM BIOS
	cmp	bx,0504dh	; check for "PM" signature
	jne	done_apm_bios	; no signature -> no APM BIOS
	mov	APM_BIOS_VER,ax	; record the APM BIOS version
	mov	APM_BIOS_FLAGS,cx	;	and flags
	and	cx,02h		; Is 32 bit supported?
	je	done_apm_bios	;	no ...
	mov	ax,05304h	; Disconnect first just in case
	xor	bx,bx
	int	15h		; ignore return code
	mov	ax,05303h	; 32 bit connect
	xor	bx,bx
	int	15h
	jc	no_32_apm_bios	; error
;	mov	[66],ax		; BIOS code segment
;	mov	[68],ebx	; BIOS entry point offset
;	mov	[72],cx		; BIOS 16 bit code segment
;	mov	[74],dx		; BIOS data segment
;	mov	[78],si		; BIOS code segment length
;	mov	[80],di		; BIOS data segment length
	jmp	done_apm_bios
no_32_apm_bios:
	and	APM_BIOS_FLAGS,0fffdh	; remove 32 bit support bit
done_apm_bios:
	ret
APM_BIOS_CHECK	endp

;ENABLE_A20	proc
; that was painless, now we enable A20
;	call	empty_8042
;	mov	al,0D1h		; command write
;	out	64h,al
;	call	empty_8042
;	mov	al,0DFh		; A20 on
;	out	60h,al
;	call	empty_8042
; make sure any possible coprocessor is properly reset..
;	xor	ax,ax
;	out	0f0h,al
;	call	delay
;	out	0f1h,al
;	call	delay
;	ret
;empty_8042:
;	call	delay
;	in	al,64h		; 8042 status port
;	test	al,1		; output buffer?
;	jz	no_output
;	call	delay
;	in	al,60h		; read it
;	jmp	empty_8042
;no_output:
;	test	al,2		; is input buffer full?
;	jnz	empty_8042	; yes - loop
;	ret
;delay:
;	dw	00ebh			; jmp $+2
;	ret
;ENABLE_A20	endp

Int_Bak	Proc
	mov	al,13h
	Call	Cti_Int_Vec
	mov	word ptr cs:[OldInts.OFS_13],bx
	mov	word ptr cs:[OldInts.SEG_13],es
	mov	al,00h
	Call	Cti_Int_Vec
	mov	word ptr cs:[OldInts.OFS_00],bx
	mov	word ptr cs:[OldInts.SEG_00],es
	mov	al,9h
	Call	Cti_Int_Vec
	mov	word ptr cs:[OldInts.OFS_09],bx
	mov	word ptr cs:[OldInts.SEG_09],es
	mov	al,16h
	Call	Cti_Int_Vec
	mov	word ptr cs:[OldInts.OFS_16],bx
	mov	word ptr cs:[OldInts.SEG_16],es
	mov	al,20h
	Call	Cti_Int_Vec
	mov	word ptr cs:[OldInts.OFS_20],bx
	mov	word ptr cs:[OldInts.SEG_20],es
	mov	al,21h
	Call	Cti_Int_Vec
	mov	word ptr cs:[OldInts.OFS_21],bx
	mov	word ptr cs:[OldInts.SEG_21],es
	mov	al,22h
	Call	Cti_Int_Vec
	mov	word ptr cs:[OldInts.OFS_22],bx
	mov	word ptr cs:[OldInts.SEG_22],es
	mov	al,2Fh
	Call	Cti_Int_Vec
	mov	word ptr cs:[OldInts.OFS_2F],bx
	mov	word ptr cs:[OldInts.SEG_2F],es
	ret
Int_Bak	endp

WhereXY	proc
	push	ax
	push	bx
	mov	ax, 0300h
	mov	bh, VideoStranka
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
	mov	bh, VideoStranka
	int	10h
	popa
	ret
GotoXY	endp

ClrScr	proc
	pusha
	mov	dx, 0000h
	call	GotoXY
	mov	bl, VideoAtribut
	mov	bh, VideoStranka
	mov	al, 32
	mov	cx,8000
	mov	ah, 09
	int	10h
	popa
	ret
ClrScr	endp

;DS:SI=ukazatel na ýetØtec ukonŸenì 00h
;->CX=poŸet znak… vŸetnØ 00h
LengthString	proc
	xor	cx,cx
LS_:
	LODSB
	inc	cx
	cmp	al, 00h
	je	LS_EX_
	jmp	LS_
LS_EX_:
	ret
LengthString	endp

;DS:SI=ukazatel na form tovanì ýetØtec ukonŸenì 00h
;ES:DI=ukazatel na c¡lovì ýetØtec
;BX:DX=ukazatel na ýetØtec paramer… + 00h
FormatString	proc
	push	es
	push	di
	cld
FS_1:
	LODSB
	cmp	al, "%"
	je	FS_PARAM
	cmp	al, 00h
	je	FS_EXIT
FS_2:
	STOSB
	jmp	FS_1
FS_EXIT:
	mov	al, 00h
	STOSB
	pop	di
	pop	es
	ret
FS_3:
	mov	bx, ds
	mov	dx, si
	pop	si
	pop	ds
	jmp	FS_1
FS_PARAM:
	LODSB
	cmp	al, "%"
	je	FS_2
	dec	si
	push	ds
	push	si
	mov	ds, bx
	mov	si, dx
;	cmp	al, 00h
;	je	FS_EXIT
FS_4:
	LODSB
	cmp	al, 00h
	je	FS_3
	STOSB
	jmp	FS_4
FormatString	endp

;------------------------------
Wait30sForPressK	proc
; Read a key with a timeout of 30 seconds. The hardware clock is used to get
; the time.
;------------------------------
	call	FlushKbd
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
;	cmp	al,cl
;	push	ax
;	push	cx
;	sub	cl, al
;	xchg	al, cl
;	call	WhereXY
;	call	PrtDec
;	call	GotoXY
;	pop	cx
;	pop	ax
	cmp	al, cl
	jne	again
	mov	al,20h		; timeout, return default char `space'
	ret
getkey:	xor	ah,ah
	int	16h
	ret
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

;-------------------------
FlushKbd	proc
; Flush the keyboard buffer
;-------------------------
	pushad
FlushKbd_:
	mov	ah,01
	int	16h
	jz	empty
	xor	ah,ah
	int	16h
	jmp	FlushKbd_
empty:
	popad
	ret
FlushKbd	endp

;---------------------------
; Print decimal number (AL).
;---------------------------

prtdec:	push	ax
	push	cx
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
	pop	cx
	pop	ax
	ret

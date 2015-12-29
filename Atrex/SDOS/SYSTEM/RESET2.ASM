_TEXT	segment
assume	cs:_TEXT, ds:_TEXT, es:_TEXT, ss:_TEXT
;org	00h

@FD:
	mov	al, 064h
	out	0FEh, al
	mov	al, 070h
	out	08Fh, al
	mov	al, 071h
	out	000h, al
	mov	al, 0Fh
	out	70h, al
	mov	al, 0FFh
	out	71h, al
	mov	ax, 040h
	mov	ds, ax
	mov	ds:[0072h], "''"	;01234h
	mov	ax, 02A0h
	mov	ds, ax
	push   00355h                          
	pop    ss                             
	lea    sp, ds:[00104h]                     
	call   A1
A1:
	push   ax                             
	pushf                                 
	cli                                   
	or	word ptr ds:[08CAh], 0040h
	or	dword ptr ds:[089Ch], 0000000080h
;	or     w,cs:[008CA],040h  ;"@"         
;	or     d,cs:[0089C],000000080h         
	mov    al,00Fh
	out    084h,al                         
	mov    al,000h                         
	out    085h,al                         
	jmp   A2
A2:
	popf                                  
	pop    ax                             
	ret




_TEXT ends
End @FD

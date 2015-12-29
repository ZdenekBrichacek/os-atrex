Reset	proc	near
	mov	word ptr [SEG_R],02A0h
	mov	word ptr [OFS_R],04D4h
	cli
	jmp	dword ptr cs:[OFS_R]
	sti
	ret
OFS_R	dw	?
SEG_R	dw	?
Reset	endp

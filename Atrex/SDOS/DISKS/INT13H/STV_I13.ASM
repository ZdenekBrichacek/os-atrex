_TEXT	segment
assume	cs:_TEXT, ds:_TEXT, es:_TEXT, ss:_TEXT

org 100h
@Filename:
	jmp	Start

Program_Spec	dw	0003h
Program_Attrib	dw	0101h
Program_Name	db	'SHOW PROGRESS INT13H ACTIVITY',0,0

Start	proc	near
	mov	ah,0EFh
	int	13h
	ret
Start	endp
_TEXT	ends
END	@Filename

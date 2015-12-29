P286
WARN PRO
MODEL TINY
;INCLUDE WINDOWS.INC
DATASEG
UDATASEG
   DW 100H DUP (?)
MyStack  LABEL WORD

CODESEG
   STARTUPCODE
   MOV SP,OFFSET MyStack
	PUSH	CS
	POP	DS
	CALL	CLRSCR
	MOV	DELAY_,0FFFFh
	CALL	DELAY
   CALL DoIt
   Push ax
   mov  ah,9
   mov  dx,offset messege
   int  21h
   CALL ReadEnter
   Pop  ax
   MOV AH,4CH
   INT 21H
   RET

	include	crt.asm

messege:
          db 'Tento program lze spustit pouze v prostýed¡ SDOS.',10,13
          db '     StisknØte ENTER       $',10,13

ReadEnter PROC NEAR
@1:
  mov ah,00
  int 16h
  cmp al,13
  jz  @2
  jmp @1
@2:
  RET
ReadEnter ENDP

DoIt PROC NEAR
   MOV AL,1
   RET
DoIt ENDP

END

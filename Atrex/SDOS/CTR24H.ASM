.8086
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
   Push ax
   mov  ah,9
   mov  dx,offset messege
   int  21h
   CALL ReadEnter
   Pop  ax
   INT	24h
   CALL DoIt
   INT	24h
   MOV AH,4CH
   INT 21H
   RET

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

OLD     DD	?
int24:                                         
;        mov     al,3                           
;        iret                             
	PUSHF
	CALL	OLD
	IRET

End_Res	Label	Near
	db	16	dup(00h)

DoIt PROC NEAR
	MOV	AH,35H
	MOV	AL,24H
	INT	21H
	MOV	word ptr [OLD],BX
	MOV	word ptr [OLD+2],ES
	LEA	DX,int24
	PUSH	CS
	POP	DS
	MOV	AH,25H
	MOV	AL,24H
	INT	21H

 	LEA	DX,End_Res
	MOV	CL,04h
	SHR	DX,CL
	INC	DX
	MOV	AL,00h
	MOV	AH,31h
	INT	21h
;   MOV AL,1
;   RET
DoIt ENDP

END

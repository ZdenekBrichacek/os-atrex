
; function FormatStr(var Result: String; Format: String; var Params)

FormatStr	proc

Result		EQU	(DWORD PTR [BP+14])
Format		EQU	(DWORD PTR [BP+10])
Params		EQU	(DWORD PTR [BP+6])
ParOfs		EQU	(WORD PTR [BP-2])
Buffer		EQU	(BYTE PTR [BP-14])

	PUSH	BP
	MOV	BP,SP
	PUSH	WORD PTR Params
	SUB	SP,12
	PUSH	DS
	LDS	SI,Format
	LES	DI,Result
	INC	DI
	CLD
;	LODSB
	XOR	AH,AH
	XCHG	AX,CX
FS@_@1:	JCXZ	FS@_@9
	LODSB
	DEC	CX
	CMP	AL,'%'
	JE	FS@_@3
	push	ds
	pop	es
FS@_@2:	STOSB
	JMP	FS@_@1
FS@_@3:	JCXZ	FS@_@9
	LODSB
	DEC	CX
	CMP	AL,'%'
	JE	FS@_@2
	MOV	BX,' '
	XOR	DX,DX
	CMP	AL,'0'
	JNE	FS@_@4
	MOV	BL,AL
FS@_@4:	CMP	AL,'-'
	JNE	FS@_@5
	INC	BH
	JCXZ	FS@_@9
	LODSB
	DEC	CX
FS@_@5:	CMP	AL,'0'
	JB	FS@_@6
	CMP	AL,'9'
	JA	FS@_@6
	SUB	AL,'0'
	XCHG	AX,DX
	MOV	AH,10
	MUL	AH
	ADD	AL,DL
	XCHG	AX,DX
	JCXZ	FS@_@9
	LODSB
	DEC	CX
	JMP	FS@_@5
FS@_@6:	CMP	AL,'#'
	JNE	FS@_@10
	SHL	DX,1
	SHL	DX,1
	ADD	DX,ParOfs
	MOV	WORD PTR Params,DX
	JMP	FS@_@1
FS@_@9:	XCHG	AX,DI
	LES	DI,Result
	SUB	AX,DI
	DEC	AX
	STOSB
	POP	DS
	MOV	SP,BP
	POP	BP
	RET
FS@_@10:	PUSH	DS
	PUSH	SI
	PUSH	CX
	PUSH	DX
	PUSH	BX
	CALL	Convert
	POP	BX
	POP	DX
	OR	DX,DX
	JE	FS@_@12
	SUB	DX,CX
	JAE	FS@_@12
	OR	BH,BH
	JNE	FS@_@11
	SUB	SI,DX
FS@_@11:	ADD	CX,DX
	XOR	DX,DX
FS@_@12:	OR	BH,BH
	JE	FS@_@13
	REP	MOVSB
FS@_@13:	XCHG	CX,DX
	MOV	AL,BL
	REP	STOSB
	XCHG	CX,DX
	REP	MOVSB
	POP	CX
	POP	SI
	POP	DS
	JMP	FS@_@1

; Convert next parameter to string
; In	AL    = Conversion character
; Out	DS:SI = Pointer to string
;	CX    = String length

Convert:

	XCHG	AX,DX
	LDS	SI,Params
	LODSW
	XCHG	AX,BX
	LODSW
	XCHG	AX,BX
	MOV	WORD PTR Params,SI
	XOR	CX,CX
	LEA	SI,Buffer[12]
	PUSH	SS
	POP	DS
	AND	DL,0DFH
	CMP	DL,'C'
	JE	ConvertChar
	CMP	DL,'S'
	JE	ConvertStr
	CMP	DL,'D'
	JE	ConvertDec
	CMP	DL,'X'
	JE	ConvertHex
	RET

ConvertStr:

	MOV	DX,AX
	OR	DX,BX
	JE	FS_@@1
	MOV	SI,AX
	MOV	DS,BX
	LODSB
	MOV	CL,AL
FS_@@1:	RET

ConvertHex:

	MOV	CL,16
	JMP	SHORT ConvertNum

ConvertDec:

	MOV	CL,10
	OR	BX,BX
	JNS	ConvertNum
	NEG	BX
	NEG	AX
	SBB	BX,0
	CALL	ConvertNum
	MOV	AL,'-'

ConvertChar:

	INC	CX
	DEC	SI
	MOV	[SI],AL
	RET

ConvertNum:

	PUSH	SI
FS@@1:	XOR	DX,DX
	XCHG	AX,BX
	DIV	CX
	XCHG	AX,BX
	DIV	CX
	ADD	DL,'0'
	CMP	DL,'0'+10
	JB	FS@@2
	ADD	DL,'A'-'0'-10
FS@@2:	DEC	SI
	MOV	[SI],DL
	MOV	DX,AX
	OR	DX,BX
	JNE	FS@@1
	POP	CX
	SUB	CX,SI
	RET

FormatStr	endp

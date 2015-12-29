_TEXT	segment
assume	cs:_TEXT, ds:_TEXT, es:_TEXT, ss:_TEXT
.486P
org 100h
@Filename:
;	include	.\HEADER.ASM
	push	eax
	mov	ax, ds
	push	cs
	pop	ds
	mov	word ptr CS:[OldErrReg._DS], AX
	pop	eax
	mov	dword ptr CS:[OldErrReg._EAX], EAX
	mov	dword ptr CS:[OldErrReg._EBX], EBX
	mov	dword ptr CS:[OldErrReg._ECX], ECX
	mov	dword ptr CS:[OldErrReg._EDX], EDX
	mov	dword ptr CS:[OldErrReg._ESI], ESI
	mov	dword ptr CS:[OldErrReg._EDI], EDI
	mov	dword ptr CS:[OldErrReg._EBP], EBP
	mov	dword ptr CS:[OldErrReg._ESP], ESP
;	mov	dword ptr CS:[OldErrReg._EIP], EIP ;
	db	66h
	pushf
	db	66h
	pop	ax
	mov	dword ptr CS:[OldErrReg._EFLAGS], EAX
	mov	word ptr CS:[OldErrReg._CS], CS ;
	mov	word ptr CS:[OldErrReg._SS], SS
	mov	word ptr CS:[OldErrReg._ES], ES
	mov	word ptr CS:[OldErrReg._FS], FS
	mov	word ptr CS:[OldErrReg._GS], GS
	mov	eax, CR0
	mov	dword ptr CS:[OldErrReg._CR0], EAX
	mov	eax, CR2
	mov	dword ptr CS:[OldErrReg._CR2], EAX
	mov	eax, CR3
	mov	dword ptr CS:[OldErrReg._CR3], EAX

	mov	ax, cs
	mov	ds, ax
	mov	es, ax
	mov	[TMP__3], 00h

	call	ClrScr
	mov	dl, 00h
	mov	dh, 03h
	call	GotoXY
	lea	esi, PrintSystemError
	call	Prtstr

	mov	dl, 18h
	mov	dh, 08h
	mov	eax, cs:[OldErrReg._EAX]
	call	PrintErrorReg32
	mov	dl, 18h
	mov	dh, 09h
	mov	eax, cs:[OldErrReg._EBX]
	call	PrintErrorReg32
	mov	dl, 18h
	mov	dh, 0Ah
	mov	eax, cs:[OldErrReg._ECX]
	call	PrintErrorReg32
	mov	dl, 18h
	mov	dh, 0Bh
	mov	eax, cs:[OldErrReg._EDX]
	call	PrintErrorReg32
	mov	dl, 18h
	mov	dh, 0Ch
	mov	eax, cs:[OldErrReg._ESI]
	call	PrintErrorReg32
	mov	dl, 18h
	mov	dh, 0Dh
	mov	eax, cs:[OldErrReg._EDI]
	call	PrintErrorReg32
	mov	dl, 18h
	mov	dh, 0Eh
	mov	eax, cs:[OldErrReg._EBP]
	call	PrintErrorReg32
	mov	dl, 18h
	mov	dh, 0Fh
	mov	eax, cs:[OldErrReg._ESP]
	call	PrintErrorReg32
	mov	dl, 18h
	mov	dh, 10h
	mov	eax, cs:[OldErrReg._EIP]
	call	PrintErrorReg32
;vyplnÿn° pole EFLAGS
	mov	dl, 18h
	mov	dh, 11h
	mov	eax, cs:[OldErrReg._EFLAGS]
	call	PrintErrorReg32
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000001000000000000000000000B
	jz	Err_NoIDBit
	mov	dx, 111Dh
	lea	si, Err_Sh_ID
	call	PrintCStr
Err_NoIDBit:
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000100000000000000000000B
	jz	Err_NoVIPBit
	mov	[TMP__3], -1
	mov	dx, 1120h
	lea	si, Err_Sh_VIP
	call	PrintCStr
Err_NoVIPBit:
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000010000000000000000000B
	jz	Err_NoVIFBit
	mov	dx, 1124h
	lea	si, Err_Sh_VIF
	call	PrintCStr
Err_NoVIFBit:
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000000100000000000000000B
	jz	Err_NoVMBit
	mov	dx, 1128h
	lea	si, Err_Sh_VM
	call	PrintCStr
Err_NoVMBit:
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000000000010000000000000B ;bit 13
	setnz	TMP__1
	test	eax, 00000000000000000001000000000000B ;bit 12
	setnz	TMP__2
	xor	ax, ax
	mov	al, TMP__1
	shl	al, 1
	add	al, TMP__2
	add	al, 30h
	mov	bl, VideoAtribut
	push	bx
	mov	dx, 112Fh
	call	GotoXY
	mov	VideoAtribut, 0Eh
	call	PrtColorChr
	pop	bx
	mov	bl, VideoAtribut
	;IOPL end
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000000000000100000000000B
	jz	Err_NoOFBit
	mov	dx, 1131h
	lea	si, Err_Sh_OF
	call	PrintCStr
Err_NoOFBit:
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000000000000010000000000B
	jz	Err_NoDFBit
	mov	dx, 1134h
	lea	si, Err_Sh_DF
	call	PrintCStr
Err_NoDFBit:
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000000000000000100000000B
	jz	Err_NoTFBit
	mov	dx, 1137h
	lea	si, Err_Sh_TF
	call	PrintCStr
Err_NoTFBit:
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000000000000000010000000B
	jz	Err_NoSFBit
	mov	dx, 113Ah
	lea	si, Err_Sh_SF
	call	PrintCStr
Err_NoSFBit:
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000000000000000001000000B
	jz	Err_NoZFBit
	mov	dx, 113Dh
	lea	si, Err_Sh_ZF
	call	PrintCStr
Err_NoZFBit:
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000000000000000000010000B
	jz	Err_NoAFBit
	mov	dx, 1140h
	lea	si, Err_Sh_AF
	call	PrintCStr
Err_NoAFBit:
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000000000000000000000100B
	jz	Err_NoPFBit
	mov	dx, 1143h
	lea	si, Err_Sh_PF
	call	PrintCStr
Err_NoPFBit:
	mov	eax, cs:[OldErrReg._EFLAGS]
	test	eax, 00000000000000000000000000000001B
	jz	Err_NoCFBit
	mov	dx, 1146h
	lea	si, Err_Sh_CF
	call	PrintCStr
Err_NoCFBit:
;
	mov	dl, 24h
	mov	dh, 08h
	mov	ax, cs:[OldErrReg._DS]
	call	PrintErrorReg16
	mov	dl, 24h
	mov	dh, 09h
	mov	ax, cs:[OldErrReg._ES]
	call	PrintErrorReg16
	mov	dl, 24h
	mov	dh, 0Ah
	mov	ax, cs:[OldErrReg._FS]
	call	PrintErrorReg16
	mov	dl, 24h
	mov	dh, 0Bh
	mov	ax, cs:[OldErrReg._GS]
	call	PrintErrorReg16
	mov	dl, 24h
	mov	dh, 0Ch
	mov	ax, cs:[OldErrReg._SS]
	call	PrintErrorReg16
	mov	dl, 24h
	mov	dh, 0Dh
	mov	ax, cs:[OldErrReg._CS]
	call	PrintErrorReg16
;vyplnÿn° pole CR0
	mov	dl, 28h
	mov	dh, 0Eh
	mov	eax, cs:[OldErrReg._CR0]
	call	PrintErrorReg32
	mov	eax, cs:[OldErrReg._CR0]
	test	eax, 10000000000000000000000000000000B
	jz	Err_NoPGBit
	mov	dx, 0E2Dh
	lea	si, Err_Sh_PG
	call	PrintCStr
Err_NoPGBit:
	mov	eax, cs:[OldErrReg._CR0]
	test	eax, 01000000000000000000000000000000B
	jz	Err_NoCDBit
	mov	dx, 0E30h
	lea	si, Err_Sh_CD
	call	PrintCStr
Err_NoCDBit:
	mov	eax, cs:[OldErrReg._CR0]
	test	eax, 00100000000000000000000000000000B
	jz	Err_NoNWBit
	mov	dx, 0E33h
	lea	si, Err_Sh_NW
	call	PrintCStr
Err_NoNWBit:
	mov	eax, cs:[OldErrReg._CR0]
	test	eax, 00000000000001000000000000000000B
	jz	Err_NoAMBit
	mov	dx, 0E36h
	lea	si, Err_Sh_AM
	call	PrintCStr
Err_NoAMBit:
	mov	eax, cs:[OldErrReg._CR0]
	test	eax, 00000000000000010000000000000000B
	jz	Err_NoWPBit
	mov	dx, 0E39h
	lea	si, Err_Sh_WP
	call	PrintCStr
Err_NoWPBit:
	mov	eax, cs:[OldErrReg._CR0]
	test	eax, 00000000000000000000000000100000B
	jz	Err_NoNEBit
	mov	dx, 0E3Ch
	lea	si, Err_Sh_NE
	call	PrintCStr
Err_NoNEBit:
	mov	eax, cs:[OldErrReg._CR0]
	test	eax, 00000000000000000000000000001000B
	jz	Err_NoTSBit
	mov	dx, 0E3Fh
	lea	si, Err_Sh_TS
	call	PrintCStr
Err_NoTSBit:
	mov	eax, cs:[OldErrReg._CR0]
	test	eax, 00000000000000000000000000000100B
	jz	Err_NoEMBit
	mov	dx, 0E42h
	lea	si, Err_Sh_EM
	call	PrintCStr
Err_NoEMBit:
	mov	eax, cs:[OldErrReg._CR0]
	test	eax, 00000000000000000000000000000010B
	jz	Err_NoMPBit
	mov	dx, 0E45h
	lea	si, Err_Sh_MP
	call	PrintCStr
Err_NoMPBit:
	mov	eax, cs:[OldErrReg._CR0]
	test	eax, 00000000000000000000000000000001B
	jz	Err_NoPEBit
	mov	dx, 0E48h
	lea	si, Err_Sh_PE
	call	PrintCStr
Err_NoPEBit:
;
	mov	dl, 28h
	mov	dh, 0Fh
	mov	eax, cs:[OldErrReg._CR2]
	call	PrintErrorReg32
;vyplnÿn° pole CR3
	mov	dl, 28h
	mov	dh, 10h
	mov	eax, cs:[OldErrReg._CR3]
	call	PrintErrorReg32
	mov	eax, cs:[OldErrReg._CR3]
	test	eax, 00000000000000000000000000010000B
	jz	Err_NoPCDBit
	mov	dx, 102Dh
	lea	si, Err_Sh_PCD
	call	PrintCStr
Err_NoPCDBit:
	mov	eax, cs:[OldErrReg._CR3]
	test	eax, 00000000000000000000000000001000B
	jz	Err_NoPWTBit
	mov	dx, 1030h
	lea	si, Err_Sh_PWT
	call	PrintCStr
Err_NoPWTBit:
;
;vyplnÿn° pole CR4
	cmp	TMP__3, 00h ;lze pouß° intr. CPUID?
	je	Err_NoCPUID
	mov	eax, CR4
	mov	dword ptr CS:[OldErrReg._CR4], EAX
	mov	dl, 3Dh
	mov	dh, 10h
	mov	eax, cs:[OldErrReg._CR4]
	call	PrintErrorReg32
	mov	eax, cs:[OldErrReg._CR4]
	test	eax, 00000000000000000000000000010000B
	jz	Err_NoPSEBit
	mov	dx, 1042h
	lea	si, Err_Sh_PSE
	call	PrintCStr
Err_NoPSEBit:
	mov	eax, cs:[OldErrReg._CR4]
	test	eax, 00000000000000000000000000000010B
	jz	Err_NoPVIBit
	mov	dx, 1045h
	lea	si, Err_Sh_PVI
	call	PrintCStr
Err_NoPVIBit:
	mov	eax, cs:[OldErrReg._CR4]
	test	eax, 00000000000000000000000000000001B
	jz	Err_NoVMEBit
	mov	dx, 1048h
	lea	si, Err_Sh_VME
	call	PrintCStr
Err_NoVMEBit:
Err_NoCPUID:
;

	xor	ax, ax
	int	16h
	int	20h

PrintErrorReg32:
	push	eax
	mov	bx, dx
	call	GotoXY
	pop	dx
	call	Print_Hex
	dec	bl
	dec	bl
	dec	bl
	dec	bl
	mov	dx, bx
	call	GotoXY
	pop	dx
	call	Print_Hex
	ret
PrintErrorReg16:
	call	GotoXY
	mov	dx, ax
	call	Print_Hex
	ret
PrintCStr:
	call	GotoXY
	mov	bl, VideoAtribut
	push	bx
	mov	VideoAtribut, 0Eh
	call	PrtColorStr
	pop	bx
	mov	bl, VideoAtribut
	ret

include	.\types.asm
include	.\func.asm

Err_	struc
	_EAX	dd	0
	_EBX	dd	0
	_ECX	dd	0
	_EDX	dd	0
	_ESI	dd	0
	_EDI	dd	0
	_EBP	dd	0
	_ESP	dd	0
	_EIP	dd	0
	_EFLAGS	dd	0
	_CS	dw	0
	_SS	dw	0
	_DS	dw	0
	_ES	dw	0
	_FS	dw	0
	_GS	dw	0
	_CR0	dd	0
	_CR2	dd	0
	_CR3	dd	0
	_CR4	dd	0
Err_	ends
OldErrReg	Err_ <>

TMP__1		db	0
TMP__2		db	0
TMP__3		db	0
Err_Sh_ID	db	"ID",0
Err_Sh_VIP	db	"VIP",0
Err_Sh_VIF	db	"VIF",0
Err_Sh_VM	db	"VM",0
Err_Sh_OF	db	"OF",0
Err_Sh_DF	db	"DF",0
Err_Sh_TF	db	"TF",0
Err_Sh_SF	db	"SF",0
Err_Sh_ZF	db	"ZF",0
Err_Sh_AF	db	"AF",0
Err_Sh_PF	db	"PF",0
Err_Sh_CF	db	"CF",0
Err_Sh_PG	db	"PG",0
Err_Sh_CD	db	"CD",0
Err_Sh_NW	db	"NW",0
Err_Sh_AM	db	"AM",0
Err_Sh_WP	db	"WP",0
Err_Sh_NE	db	"NE",0
Err_Sh_TS	db	"TS",0
Err_Sh_EM	db	"EM",0
Err_Sh_MP	db	"MP",0
Err_Sh_PE	db	"PE",0
Err_Sh_PCD	db	"PC",0
Err_Sh_PWT	db	"PW",0
Err_Sh_PSE	db	"PS",0
Err_Sh_PVI	db	"PV",0
Err_Sh_VME	db	"VM",0

_TEXT	ends
END	@Filename

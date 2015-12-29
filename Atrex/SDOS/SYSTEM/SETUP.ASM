_TEXT	segment use16
assume	cs:_TEXT, ds:_TEXT, es:_TEXT, ss:_TEXT
org	100h
.486P
.487

@FD:
	inc	dx
	dec	dx
	jmp	start
include	sheader.inc
	db	"ATREX OS 1.00.0010",0

include .\makro.mac

Start:
	mov	ax, cs
	mov	ds, ax
	mov	BootFromDisk, dl
	cli
	mov	ss, ax
	mov	sp, offset ISTACK
	sti

mov	ax, 0012h
int	10h


	call	Int_Bak
	mov	dx, offset INT00
	mov	al, 00h
	Call	Nastav_Int_Vec		;nast. INT00h

	mov	ax, cs
	mov	ds, ax
	lea	si, INIT_MESS	;Startuje se syst‚m ATREX...
	call	prtstr
	lea	si, ENTER_MESS
	call	prtstr

int	3h
	call	TestFor8086
	cmp	al, 0h
	je	CpuInitError

	call	TestFor8087
	cmp	al, 0h
	je	FpuInitError

;	call	VyplnExtBoot
int	3h

	call	LogAdrFyzAdr

	call	SektoruNaFat

	call	GET_EXT_MEM_SIZE
	mov	dx, EXT_MEM_SIZE
	call	Print_Hex
	mov	al, " "
	call	PrtChr

int	3h
	call	APM_BIOS_CHECK
	mov	dx, APM_BIOS_VER
	call	Print_Hex
	mov	al, " "
	call	PrtChr

	call	MOUSE_CHECK
	mov	dx, MOUSE_PRESENT
	call	Print_Hex
	lea	si,ENTER_MESS
	call	prtstr

	call	DisksCheck	;test pý¡tomnosti pevnìch disk…

int	3h
	mov	dx, offset INT13
	mov	al, 13h
	Call	Nastav_Int_Vec		;nast. INT13h

ErrorInit:
	mov	ax, cs
	mov	ds, ax
	lea	si, INIT_ERROR
	call	prtstr
	lea	si, PressAnyK
	call	prtstr

int	3h
	xor	ax,ax
	int	16h
	call	Reset
	ret

CpuInitError:
	mov	ax, cs
	mov	ds, ax
	lea	si, CPU_INIT_ERROR
	call	prtstr
	jmp	ErrorInit

FpuInitError:
	mov	ax, cs
	mov	ds, ax
	lea	si, FPU_INIT_ERROR
	call	prtstr
	jmp	ErrorInit

include	.\Vypocty.asm
include	.\func.asm
include	.\DiskIO.asm
include	.\testcpu.asm
include	.\part.asm
include	.\int21.asm
include	.\ErrorsFc.asm
include	.\Errors.asm
include	.\Reset.asm
include	.\Kbc.asm
include	.\EGA.852
include	.\types.asm

_TEXT ends
End @FD


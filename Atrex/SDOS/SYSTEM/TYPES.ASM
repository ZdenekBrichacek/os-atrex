include	.\DiskCnst.asm
TMPString	db	60 dup(0)

fp_status	dw	?
;id_mess		db	"Tento syst‚m obsahuje ",0
;fp_8087		db	"a 8087 matematickì koprocesor",0
;fp_80287	db	"a 80287 matematickì koprocesor",0
;fp_80387	db	"a 80387 matematickì koprocesor",0
;c8086		db	"n8086/8088 mikroprocesor",0
;c286		db	"n80286 mikroprocesor",0
;c386		db	"386 mikroprocesor",0
;c486		db	"486 DX mikroprocesor /487 SX matematickì koprocesor",0
;c486nfp		db	"486 SX mikroprocesor",0
;period		db	".",13,10,0
;present_86	dw	0
;present_286	dw	0
;present_386	dw	0
;present_486	dw	0

PAX		dw	0
PCX		dw	0
PBX		dw	0
TMP		dw	0

ScanCode	db	0
BreakFlag	db	0
Sektoru_TMP	dd	0
Konst_00195	dt	0.00195
SektoruNaFat_Tmp	dd	?

VideoStranka	db	0
VideoAtribut	db	7


RETEZEC		DB	5 dup(00h),20h,0,0

INIT_MESS: 
		db	"Startuje se syst‚m ATREX...",13,10,0
DiskIOErr:
		db	"Nastala chyba pýi Ÿten¡ z disku ",0
ReplaceDisk:
		db	"VymØåte jej !", 0Dh, 0Ah, 0
PressAnyK:
		db	"StisknØte jakoukoliv kl vesu pro pokraŸov n¡...",13,10,0
INIT_ERROR:
		db	"Nastala chyba pýi inicializaci!",13,10
		db	"Nelze d le pokraŸovat. Vlo§te disk s jinìm syst‚mem a",13,10,0
CPU_INIT_ERROR:
		db	"Tento syst‚m vy§aduje procesor minim lnØ 80386!",13,10,0
FPU_INIT_ERROR:
		db	"Tento syst‚m vy§aduje koprocesor!",13,10,0

_Nenalezen:	db	" nenalezen ",0
_OK:		db	" ok        ",0
_HD0:		db	"Pevnì disk 0: ",0
_HD1:		db	"Pevnì disk 1: ",0
_HD2:		db	"Pevnì disk 2: ",0
_HD3:		db	"Pevnì disk 3: ",0
_Oblast1:	db	"       Oblast1: ",0
_Oblast2:	db	"       Oblast2: ",0
_Oblast3:	db	"       Oblast3: ",0
_Oblast4:	db	"       Oblast4: ",0
_PrizAktiv	db	"               Pý¡znak aktivity: ",0
_PrizOS		db	"               Pý¡znak OS: ",0
AdrObl		dw	0

DISK	db	'  :',0,0

ENTER_MESS:
		db	0Dh, 0Ah, 00h

Old13_	struc
	_AX	dw	?
	_BX	dw	?
	_CX	dw	?
	_DX	dw	?
Old13_	ends
Old13	Old13_ <>

Struktury_SDOS_:
NV		db	'1'
AUX		dw	0
PRN		dw	0
BootFromDisk	db	?

EXT_MEM_SIZE	DW	0
MOUSE_PRESENT	DW	0
APM_BIOS_VER	DW	0
APM_BIOS_FLAGS	DW	0

OldInt_	struc
	OFS_00	dw	?
	SEG_00	dw	?
	OFS_09	dw	?
	SEG_09	dw	?
	OFS_13	dw	?
	SEG_13	dw	?
	OFS_16	dw	?
	SEG_16	dw	?
	OFS_20	dw	?
	SEG_20	dw	?
	OFS_21	dw	?
	SEG_21	dw	?
	OFS_22	dw	?
	SEG_22	dw	?
	OFS_2F	dw	?
	SEG_2F	dw	?
OldInt_	ends
OldInts	OldInt_ <>


ExtBt	struc
	MajorVer	db	?
	MinorVer	db	?
	NFSVer		dw	?
	SecRoot		db	?
	FirstSecRoot	dd	?
	FirstSecDat	dd	?
	SecDAT		dd	?
	SecPart		dd	?
	FirstSecPart	dw	?
	FirstCylPart	dw	?
	FirstHeaPart	db	?
	PartMounted	db	?
	DiskMark	db	8 dup(?)
	MountCode	db	50 dup(?)
	UnMountCode	db	50 dup(?)
	EndSecPart	dw	?
	EndCylPart	dw	?
	EndHeaPart	db	?
	SecSAT		dd	?
	SecSysPart	dw	?
	SecOnCyl	dw	?
	Heads		db	?
	PhysNoDisk	db	?
	SerNoDisk	dd	?
	NameOfDisk	db	11 dup(?)
	MediaID		db	?

	DDpo		db	346 dup(?)
ExtBt	ends
ExtBoot	ExtBt <>

Zasobnik:
		db	(80) dup("Stack")
		ISTACK	db	"ÿ"

DiskData:
		db	(540/8+1) dup("DiskData")

Doplneni	db	6000 dup(0CCh)

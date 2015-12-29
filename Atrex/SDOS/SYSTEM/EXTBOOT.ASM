_TEXT	segment
assume	cs:_TEXT, ds:_TEXT, es:_TEXT, ss:_TEXT
.386
org 100h
@Filename:
	mov	ax, cs
	mov	ds, ax
	mov	fs, ax
	mov	es, ax
	mov	bx, offset ExtBot.MajorVer
	mov	ax, 0302h
	mov	dx, 0000h
	mov	cx, 0002h
	int	13h
	int	20h
	ret

ExtBt	struc
	MajorVer	db	01
	MinorVer	db	01
	NFSVer		dw	0101h
	SecRoot		db	15
	FirstSecRoot	dd	1004-1
	FirstSecDat	dd	1030-1
	SecDAT		dd	1850
	SecPart		dd	2880
	FirstSecPart	dw	0
	FirstCylPart	dw	0
	FirstHeaPart	db	0
	PartMounted	db	1
	DiskMark	db	"A:_Boot0"
	MountCode	db	50 dup(0)
	UnMountCode	db	50 dup(0)
	EndSecPart	dw	2880
	EndCylPart	dw	79
	EndHeaPart	db	1
	SecSAT		dd	11
	SecSysPart	dw	1004
	SecOnCyl	dw	18
	Heads		db	2
	PhysNoDisk	db	0
	SerNoDisk	dd	12345678
	NameOfDisk	db	"BootDisk_A:"
	MediaID		db	0F0h

	DDpo		db	346+512 dup(?)
ExtBt	ends
ExtBot	ExtBt <>

_TEXT	ends
END	@Filename

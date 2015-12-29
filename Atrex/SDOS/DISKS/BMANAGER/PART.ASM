RMBRD	db	?
Level	dw	0
Part	dw	0
Disks	db	0
BF	db	0
DiskTMP	db	8 dup(00)

ReadMBR	proc
;dl<- disk
;dh<-povrch
;cx<-sekcyl
;	mov	dh, 00h
;	mov	cx, 0001h
	mov	cs:RMBRD, dl
	mov	bx, offset cs:DiskData
	mov	ax, cs
	mov	es, ax
	mov	ax, 0201h
	int	13h
	mov	ax, cs
	mov	ds, ax
	jc	DNenalezen

	jmp	PartTable
RMBR_I:
	cmp	RMBRD, 80h
	je	RMBR_hdd0
	cmp	RMBRD, 81h
	je	RMBR_hdd1
	cmp	RMBRD, 82h
	je	RMBR_hdd2
	lea	si, hdd3
	lea	di, DiskTMP
	Call	CopyString
	ret
RMBR_hdd2:
	lea	si, hdd2
	lea	di, DiskTMP
	Call	CopyString
	ret
RMBR_hdd1:
	lea	si, hdd1
	lea	di, DiskTMP
	Call	CopyString
	ret
RMBR_hdd0:
	lea	si, hdd0
	lea	di, DiskTMP
	Call	CopyString
DNenalezen:
	ret
ReadMBR	endp

PartTable	proc
	cmp	word ptr cs:[DiskData+01FEh], 0AA55h
	jne	PartTableExit
	mov	bx, 01BEh
	Call	CheckRec
	mov	bx, 01CEh
	Call	CheckRec
	mov	bx, 01DEh
	Call	CheckRec
	mov	bx, 01EEh
	Call	CheckRec
PartTableExit:
	ret
PartTable	endp

CheckRec	proc
	cmp	byte ptr cs:[DiskData+bx+4], 00h
	je	CheckRecExit
	cmp	byte ptr cs:[DiskData+bx+4], 05h
	je	CheckExtPart
	inc	RecordNum
	cmp	RecordNum, 1
	je	CRR1
	cmp	RecordNum, 2
	je	CRR2
	cmp	RecordNum, 3
	je	CRR3
	cmp	RecordNum, 4
	je	CRR4
	cmp	RecordNum, 5
	je	CRR5
	cmp	RecordNum, 6
	je	CRR6
	cmp	RecordNum, 7
	je	CRR7
	cmp	RecordNum, 8
	je	CRR8
	cmp	RecordNum, 9
	je	CRR9
	ret
CRR1:
	mov	al, byte ptr cs:[DiskData+bx+0]
	mov	Table1._Boot, al
	mov	eax, dword ptr cs:[DiskData+bx+0Ch]
;	imul	eax, 512
	mov	Table1._Size, eax
	mov	al, byte ptr cs:[DiskData+bx+4]
	mov	Table1._Sys, al
	mov	dh, byte ptr cs:[DiskData+bx+1]
	mov	Table1._Head, dh
	mov	cx, word ptr cs:[DiskData+bx+2]
	mov	Table1._SecCyl, cx
	call	SaveTMPSys
	lea	si, SysTMP
	lea	di, Table1.System
	mov	cx, 06
	Call	CopyString2
	call	SaveTMPName
	lea	si, NameTMP
	lea	di, Table1.Jmeno
	mov	cx, 0Bh
	Call	CopyString2
	mov	dl, RMBRD
	mov	Table1._Disk, dl

	call	SaveLevelStatus
	lea	si, LevStat
	lea	di, Table1.Popis
	mov	cx, 14
	Call	CopyString2

	lea	si, PoznTMP
	lea	di, Table1.Poznamka
	mov	cx, 08h
	Call	CopyString2

	call	RMBR_I
	lea	si, DiskTMP
	lea	di, Table1.Disk
	Call	CopyString
	ret
CRR2:
	mov	al, byte ptr cs:[DiskData+bx+0]
	mov	Table2._Boot, al
	mov	eax, dword ptr cs:[DiskData+bx+0Ch]
;	imul	eax, 512
	mov	Table2._Size, eax
	mov	al, byte ptr cs:[DiskData+bx+4]
	mov	Table2._Sys, al
	mov	dh, byte ptr cs:[DiskData+bx+1]
	mov	Table2._Head, dh
	mov	cx, word ptr cs:[DiskData+bx+2]
	mov	Table2._SecCyl, cx
	call	SaveTMPSys
	lea	si, SysTMP
	lea	di, Table2.System
	Call	CopyString
	call	SaveTMPName
	lea	si, NameTMP
	lea	di, Table2.Jmeno
	mov	cx, 0Bh
	Call	CopyString2
	mov	dl, RMBRD
	mov	Table2._Disk, dl

	call	SaveLevelStatus
	lea	si, LevStat
	lea	di, Table2.Popis
	mov	cx, 14
	Call	CopyString2

	lea	si, PoznTMP
	lea	di, Table2.Poznamka
	mov	cx, 08h
	Call	CopyString2

	call	RMBR_I
	lea	si, DiskTMP
	lea	di, Table2.Disk
	Call	CopyString
	ret
CRR3:
	mov	al, byte ptr cs:[DiskData+bx+0]
	mov	Table3._Boot, al
	mov	eax, dword ptr cs:[DiskData+bx+0Ch]
;	imul	eax, 512
	mov	Table3._Size, eax
	mov	al, byte ptr cs:[DiskData+bx+4]
	mov	Table3._Sys, al
	mov	dh, byte ptr cs:[DiskData+bx+1]
	mov	Table3._Head, dh
	mov	cx, word ptr cs:[DiskData+bx+2]
	mov	Table3._SecCyl, cx
	call	SaveTMPSys
	lea	si, SysTMP
	lea	di, Table3.System
	Call	CopyString
	call	SaveTMPName
	lea	si, NameTMP
	lea	di, Table3.Jmeno
	mov	cx, 0Bh
	Call	CopyString2
	mov	dl, RMBRD
	mov	Table3._Disk, dl

	call	SaveLevelStatus
	lea	si, LevStat
	lea	di, Table3.Popis
	mov	cx, 14
	Call	CopyString2

	lea	si, PoznTMP
	lea	di, Table3.Poznamka
	mov	cx, 08h
	Call	CopyString2

	call	RMBR_I
	lea	si, DiskTMP
	lea	di, Table3.Disk
	Call	CopyString
	ret
CRR4:
	mov	al, byte ptr cs:[DiskData+bx+0]
	mov	Table4._Boot, al
	mov	eax, dword ptr cs:[DiskData+bx+0Ch]
;	imul	eax, 512
	mov	Table4._Size, eax
	mov	al, byte ptr cs:[DiskData+bx+4]
	mov	Table4._Sys, al
	mov	dh, byte ptr cs:[DiskData+bx+1]
	mov	Table4._Head, dh
	mov	cx, word ptr cs:[DiskData+bx+2]
	mov	Table4._SecCyl, cx
	call	SaveTMPSys
	lea	si, SysTMP
	lea	di, Table4.System
	Call	CopyString
	call	SaveTMPName
	lea	si, NameTMP
	lea	di, Table4.Jmeno
	mov	cx, 0Bh
	Call	CopyString2
	mov	dl, RMBRD
	mov	Table4._Disk, dl

	call	SaveLevelStatus
	lea	si, LevStat
	lea	di, Table4.Popis
	mov	cx, 14
	Call	CopyString2

	lea	si, PoznTMP
	lea	di, Table4.Poznamka
	mov	cx, 08h
	Call	CopyString2

	call	RMBR_I
	lea	si, DiskTMP
	lea	di, Table4.Disk
	Call	CopyString
	ret
CRR5:
	mov	al, byte ptr cs:[DiskData+bx+0]
	mov	Table5._Boot, al
	mov	eax, dword ptr cs:[DiskData+bx+0Ch]
;	imul	eax, 512
	mov	Table5._Size, eax
	mov	al, byte ptr cs:[DiskData+bx+4]
	mov	Table5._Sys, al
	mov	dh, byte ptr cs:[DiskData+bx+1]
	mov	Table5._Head, dh
	mov	cx, word ptr cs:[DiskData+bx+2]
	mov	Table5._SecCyl, cx
	call	SaveTMPSys
	lea	si, SysTMP
	lea	di, Table5.System
	Call	CopyString
	call	SaveTMPName
	lea	si, NameTMP
	lea	di, Table5.Jmeno
	mov	cx, 0Bh
	Call	CopyString2
	mov	dl, RMBRD
	mov	Table5._Disk, dl

	call	SaveLevelStatus
	lea	si, LevStat
	lea	di, Table5.Popis
	mov	cx, 14
	Call	CopyString2

	lea	si, PoznTMP
	lea	di, Table5.Poznamka
	mov	cx, 08h
	Call	CopyString2

	call	RMBR_I
	lea	si, DiskTMP
	lea	di, Table5.Disk
	Call	CopyString
	ret
CRR6:
	mov	al, byte ptr cs:[DiskData+bx+0]
	mov	Table6._Boot, al
	mov	eax, dword ptr cs:[DiskData+bx+0Ch]
;	imul	eax, 512
	mov	Table6._Size, eax
	mov	al, byte ptr cs:[DiskData+bx+4]
	mov	Table6._Sys, al
	mov	dh, byte ptr cs:[DiskData+bx+1]
	mov	Table6._Head, dh
	mov	cx, word ptr cs:[DiskData+bx+2]
	mov	Table6._SecCyl, cx
	call	SaveTMPSys
	lea	si, SysTMP
	lea	di, Table6.System
	Call	CopyString
	call	SaveTMPName
	lea	si, NameTMP
	lea	di, Table6.Jmeno
	mov	cx, 0Bh
	Call	CopyString2
	mov	dl, RMBRD
	mov	Table6._Disk, dl

	call	SaveLevelStatus
	lea	si, LevStat
	lea	di, Table6.Popis
	mov	cx, 14
	Call	CopyString2

	lea	si, PoznTMP
	lea	di, Table6.Poznamka
	mov	cx, 08h
	Call	CopyString2

	call	RMBR_I
	lea	si, DiskTMP
	lea	di, Table6.Disk
	Call	CopyString
	ret
CRR7:
	mov	al, byte ptr cs:[DiskData+bx+0]
	mov	Table7._Boot, al
	mov	eax, dword ptr cs:[DiskData+bx+0Ch]
;	imul	eax, 512
	mov	Table7._Size, eax
	mov	al, byte ptr cs:[DiskData+bx+4]
	mov	Table7._Sys, al
	mov	dh, byte ptr cs:[DiskData+bx+1]
	mov	Table7._Head, dh
	mov	cx, word ptr cs:[DiskData+bx+2]
	mov	Table7._SecCyl, cx
	call	SaveTMPSys
	lea	si, SysTMP
	lea	di, Table7.System
	Call	CopyString
	call	SaveTMPName
	lea	si, NameTMP
	lea	di, Table7.Jmeno
	mov	cx, 0Bh
	Call	CopyString2
	mov	dl, RMBRD
	mov	Table7._Disk, dl

	call	SaveLevelStatus
	lea	si, LevStat
	lea	di, Table7.Popis
	mov	cx, 14
	Call	CopyString2

	lea	si, PoznTMP
	lea	di, Table7.Poznamka
	mov	cx, 08h
	Call	CopyString2

	call	RMBR_I
	lea	si, DiskTMP
	lea	di, Table7.Disk
	Call	CopyString
	ret
CRR8:
	mov	al, byte ptr cs:[DiskData+bx+0]
	mov	Table8._Boot, al
	mov	eax, dword ptr cs:[DiskData+bx+0Ch]
;	imul	eax, 512
	mov	Table8._Size, eax
	mov	al, byte ptr cs:[DiskData+bx+4]
	mov	Table8._Sys, al
	mov	dh, byte ptr cs:[DiskData+bx+1]
	mov	Table8._Head, dh
	mov	cx, word ptr cs:[DiskData+bx+2]
	mov	Table8._SecCyl, cx
	call	SaveTMPSys
	lea	si, SysTMP
	lea	di, Table8.System
	Call	CopyString
	call	SaveTMPName
	lea	si, NameTMP
	lea	di, Table8.Jmeno
	mov	cx, 0Bh
	Call	CopyString2
	mov	dl, RMBRD
	mov	Table8._Disk, dl

	call	SaveLevelStatus
	lea	si, LevStat
	lea	di, Table8.Popis
	mov	cx, 14
	Call	CopyString2

	lea	si, PoznTMP
	lea	di, Table8.Poznamka
	mov	cx, 08h
	Call	CopyString2

	call	RMBR_I
	lea	si, DiskTMP
	lea	di, Table8.Disk
	Call	CopyString
	ret
CRR9:
	mov	al, byte ptr cs:[DiskData+bx+0]
	mov	Table9._Boot, al
	mov	eax, dword ptr cs:[DiskData+bx+0Ch]
;	imul	eax, 512
	mov	Table9._Size, eax
	mov	al, byte ptr cs:[DiskData+bx+4]
	mov	Table9._Sys, al
	mov	dh, byte ptr cs:[DiskData+bx+1]
	mov	Table9._Head, dh
	mov	cx, word ptr cs:[DiskData+bx+2]
	mov	Table9._SecCyl, cx
	call	SaveTMPSys
	lea	si, SysTMP
	lea	di, Table9.System
	Call	CopyString
	call	SaveTMPName
	lea	si, NameTMP
	lea	di, Table9.Jmeno
	mov	cx, 0Bh
	Call	CopyString2
	mov	dl, RMBRD
	mov	Table9._Disk, dl

	call	SaveLevelStatus
	lea	si, LevStat
	lea	di, Table9.Popis
	mov	cx, 14
	Call	CopyString2

	lea	si, PoznTMP
	lea	di, Table9.Poznamka
	mov	cx, 08h
	Call	CopyString2

	call	RMBR_I
	lea	si, DiskTMP
	lea	di, Table9.Disk
	Call	CopyString
CheckRecExit:
	ret
CheckRec	endp

CheckExtPart	proc
	add	Level, 1
	mov	dh, byte ptr cs:[DiskData+bx+1]
	mov	cx, word ptr cs:[DiskData+bx+2]
	jmp	ReadMBR
CheckExtPart	endp

SaveTMPSys	proc
;	mov	dh, 00h
;	mov	cx, 0001h
	mov	dl, RMBRD
	mov	bx, offset cs:DiskData2
	mov	ax, cs
	mov	es, ax
	mov	ax, 0201h
	int	13h
	mov	cx, 07h
	lea	si, DiskData2+36h
	lea	di, SysTmp
	Call	CopyString2
	cmp	[SysTmp], 00h
	je	SaveTMPSys2
	ret
SaveTMPSys2:
	mov	cx, 07h
	lea	si, DiskData2+52h
	lea	di, SysTmp
	Call	CopyString2
	ret
SaveTMPSys	endp

SaveTMPName	proc
	mov	cx, 08h
	lea	si, DiskData2+3h
	lea	di, PoznTmp
	Call	CopyString2

	mov	cx, 0Bh
	lea	si, DiskData2+2Bh
	lea	di, NameTmp
	Call	CopyString2
	cmp	[NameTmp], 00h
	je	SaveTMPName2
	ret
SaveTMPName2:
	mov	cx, 0Bh
	lea	si, DiskData2+47h
	lea	di, NameTmp
	Call	CopyString2
	ret
SaveTMPName	endp

SaveLevelStatus	proc
	Call	SetSegments
	mov	di, word ptr cs:[Level]
	imul	di, 7
	lea	si, L1
	add	si, di
	lea	di, LevStat
	mov	cx, 7
	Call	CopyString2
	mov	di, word ptr cs:[Part]
	imul	di, 7
	lea	si, _P1
	add	si, di
	lea	di, LevStat
	add	di, 7
	mov	cx, 7
	Call	CopyString2
	add	word ptr [Part], 1
	ret
SaveLevelStatus	endp

TestIfHdd	proc
	mov	ah, 10h
	mov	dl, 80h
	int	13h
	jb	TestIfHdd_1
	inc	Disks
	lea	si, HDD0
	Call	TIHD_1
TestIfHdd_1:
	mov	ah, 10h
	mov	dl, 81h
	int	13h
	jb	TestIfHdd_2
	inc	Disks
	lea	si, HDD1
	Call	TIHD_1
TestIfHdd_2:
	mov	ah, 10h
	mov	dl, 82h
	int	13h
	jb	TestIfHdd_3
	inc	Disks
	lea	si, HDD2
	Call	TIHD_1
TestIfHdd_3:
	mov	ah, 10h
	mov	dl, 83h
	int	13h
	jb	TestIfHdd_4
	inc	Disks
	lea	si, HDD3
	Call	TIHD_1
TestIfHdd_4:
	ret
TIHD_1:
	cmp	Disks, 1
	jne	TIHD_2
	lea	di, DiskT.D1
	mov	cx, 4
	Call	CopyString2
TIHD_2:
	cmp	Disks, 2
	jne	TIHD_3
	lea	di, DiskT.D2
	mov	cx, 4
	Call	CopyString2
TIHD_3:
	cmp	Disks, 3
	jne	TIHD_4
	lea	di, DiskT.D3
	mov	cx, 4
	Call	CopyString2
TIHD_4:
	cmp	Disks, 4
	jne	TIHD_5
	lea	di, DiskT.D4
	mov	cx, 4
	Call	CopyString2
TIHD_5:
	ret
TestIfHdd	endp


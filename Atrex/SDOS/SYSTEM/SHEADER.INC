HeaderSt	struc
						;>
	_DATE_		db	??DATE		;vyplåuje LINKER
	_FILENAME_	db	??FILENAME	;
	_TIME_		db	??TIME		;
	_LINKVER_	dw	??VERSION	;
	_CPU_		dw	@CPU		;
						;<
	_OSMajorVer	dw	0001h
	_OSMinorVer	dw	0000h
	_OSBuildVer	dw	0010h
	_OSSubVer	db	"B"
	_OSMode		db	00h		;0 - vçechny , 1 - re lnì,
						; 2 - chr nØnì
	_OS		db	0Eh		;ATREX (SDOS)
	_OS_		dd	"ATRE"
	_OS__		dd	"XOSx"
	_ModuleType	dw	0006h		;1 - COM, 2 - DAT, 3 - OVL,
						; 4 - font, 5 - DLL, 6 - SYS
	_OSGrSubsystem	db	0FFh		;11h - GUI, 22h - TEXT,
						; FF - zavadØŸ
	_ModuleFlags	dw	22FFh		;xx11h - aplikace, xx22h - TSR
						; xxFFh - j dro
						; 00xxh - 8bit, 11xx - 16bit
						; 22xxh - 32bit, 33xx - 64bit
	_ModMajorVer	dw	0001h
	_ModMinorVer	dw	0000h
	_ModBuildVer	dw	0010h
	_ModSubVer	db	"B"

	_NeedCPU	db	11h		;00h - 8086, 11h - 386
						; 22h - 486, 33h - 586
	_NeedFPU	db	11h		;00h - ne, 11h - ano
	_StartEIP	dd	00000000h	;Startovac¡ instrukce EIP
	_StartCS	dw	0000h		;Startovac¡ segment 
						; -mus¡ se nakop¡rovat tam!!!
	_DataTblOff	dd	00000000h
	_DataTblSeg	dw	0000h
	_ResourceTblOff	dd	00000000h
	_ResourceTblSeg	dw	0000h
	_CodeTableOff	dd	00000000h
	_CodeTableSeg	dw	0000h
	_ImportTblOff	dd	00000000h
	_ImportTblSeg	dw	0000h
	_ExportTblOff	dd	00000000h
	_ExportTblSeg	dw	0000h
	_StartSP	dd	00000000h
	_StartSS	dw	0000h
	_MinMem		dw	0000h		;Potýebn  pamØœ MinMem * 16
	_MaxMem		dw	0000h
	_CheckSumCRC	dd	00000000h		;Kontroln¡ souŸet
	_NeedDOSEnvir	db	00h		;0 - ne, 1 - ano
	_FileSize	dd	00000000h
	_LoadedOK_	db	00h		;00 - mus¡ bìt v souboru
						; 11h - (v pamØti) OK
						; 99h - nelze urŸit
						; FFh - (v pamØti) CHYBA
						; nastavuje inicializaŸn¡ rutina
						; potvrzen¡ zaveden¡ na spr vn‚
						; m¡sto, vyplnØn¡ potýebnìch
						; polo§ek a spr vnost syst‚mu
HeaderSt	ends
HeaderSt_ HeaderSt<>

INT00Err:	db	"Program se pokusil pıi vykon n¡ aritmetick‚ operace o dØlØn¡ nulou.$"
ErrA1:		db	"Pıi vol n¡ funkce % programem % doçlo k chybØ:$",0
ErrA2:		db	"Pıi pr ci syst‚mu ATREX doçlo k vnitın¡ chybØ:",13,10,"$"
ErrB1:		db	"Chyba v pı¡stupu na zaı¡zen¡ %$",0
ErrB2:		db	"Tisk rna na LPT% nem  pap¡r$",0
ErrB3:		db	"Pıi dØlen¡ byl zaznamen n dØlitel roven Ÿ¡slu nula$"
ErrK1:		db	"   StisknØte $"
ErrK2:		db	" Enter-zruçit $"
ErrK3:		db	" Esc-opakovat $"
ErrK4:		db	" Esc-zruçit $"
ErrK5:		db	" Enter-opakovat $"
ErrK6:		db	" r-registry $"
ErrK7:		db	" h-ıeçen¡ $"
ErrX0:		db	13,10,"$"
ErrH0:		db	" nelze nal‚zt § dn‚ ıeçen¡ odpov¡daj¡c¡ho probl‚mu$"
ErrH1:		db	" VyŸistØte disketovou mechaniku$"
ErrH2:		db	" VypnØte poŸ¡taŸ, vypojte pı¡vodn¡ kabely a opØt je zapojte",13,10," na sv‚ m¡sto$"
ErrH3:		db	" Vhodnìm programem proveÔte kontrolu povrchu na disku$"
ErrH4:		db	" Zkuste znovu$"
ErrH5:		db	" Vlo§te pap¡r do tisk rny a zkuste znovu$"

DiskFunc_??	db	"??????????", 0
DiskFunc_00	db	"Reset disku a rekalibrace ıadiŸe", 0
DiskFunc_01	db	"Vraœ stav posledn¡ operace", 0
DiskFunc_02	db	"¬ti sektory", 0
DiskFunc_03	db	"Zapiç sektory", 0
DiskFunc_04	db	"Testuj sektory (veryfikace)", 0
DiskFunc_05	db	"Form tuj stopu", 0
DiskFunc_06	db	"Form tuj stopu a nastav pı¡znak vadnìch sektor…", 0
DiskFunc_07	db	"Form tuj disk poŸ¡naje zadanou stopou", 0
DiskFunc_08	db	"Vraœ informace o disku", 0
DiskFunc_09	db	"Inicializace tabulky diskovìch parametr…", 0
DiskFunc_0a	db	"Dlouh‚ Ÿten¡", 0
DiskFunc_0b	db	"Dlouhì z pis", 0
DiskFunc_0c	db	"Vystaven¡ hlaviŸek na stopu", 0
DiskFunc_0d	db	"Alternativn¡ reset disku", 0
DiskFunc_0e	db	"Diagnostika disku pro PS/2 nebo Ÿten¡ z vyrovn vac¡ pamØti ıadiŸe", 0
DiskFunc_0f	db	"Diagnostika disku pro PS/2 nebo z pis do vyrovn vac¡ pamØti ıadiŸe", 0
DiskFunc_10	db	"Test pıipravenosti disku", 0
DiskFunc_11	db	"Rekalibrace disku", 0
DiskFunc_12	db	"Diagnostika", 0
DiskFunc_13	db	"Diagnostika disku", 0
DiskFunc_14	db	"Diagnostika ıadiŸe", 0
DiskFunc_15	db	"Vraœ typ disku", 0
DiskFunc_16	db	"Vraœ stav vìmØny", 0
DiskFunc_17	db	"Nastav typ disku", 0
DiskFunc_18	db	"Nastav typ m‚dia pro form tov n¡", 0
DiskFunc_19	db	"Zaparkuj hlavy", 0
DiskFunc_1a	db	"Form tuj jednotku", 0
DiskFunc_1b	db	"Vraœ hlaviŸku z vìroby", 0
DiskFunc_1c0A	db	"Vraœ konfiguraci zaı¡zen¡", 0
DiskFunc_1c0B	db	"Vraœ konfiguraci ıadiŸe", 0
DiskFunc_1c0C	db	"Vraœ informaci o POS", 0
DiskFunc_1c0E	db	"Transformuj RBA na ABA", 0

DiskError_00	db	"Nedoçlo k § dn‚ chybØ",0
DiskError_01	db	"Neplatnì po§adavek na ıadiŸ %",0
DiskError_02	db	"Chybn  adresov  znaŸka sektoru disku %",0
DiskError_03	db	"Pokus o z pis na disk % chr nØnì proti z pisu",0
DiskError_04	db	"Sektor na disku % nenalezen",0
DiskError_05	db	"Chyba pıi resetov n¡ ıadiŸe %",0
DiskError_06	db	"Disk % byl vymØnØn",0
DiskError_07	db	"Chybnì parametr pıi pr ci s diskem %",0
DiskError_08    db      "Chyba DMA (overrun)na disku %",0
DiskError_09    db      "PıeteŸen¡ DMA pıes 64KB pıi pr ci s diskem %",0
DiskError_0A    db      "U pevn‚ho disku % detekov n chybnì sektor",0
DiskError_0B    db      "U pevn‚ho disku % detekov na chybn  stopa",0
DiskError_0C    db      "Nepodporovan  stopa na disku %",0
DiskError_0D    db      "Chybnì poŸet sektor… pıi form tov n¡ pevn‚ho disku %",0
DiskError_0E    db      "U pevn‚ho disku % detekov na adresov  znaŸka kontroln¡ch dat",0
DiskError_0F    db      "U pevn‚ho disku % doçlo k chybØ v rozhodov n¡ DMA",0
DiskError_10    db      "æpatn  parita CRC/ECC na disku %",0
DiskError_11    db      "Chybn  data byla u pevn‚ho disku % opravena pomoc¡ ECC",0
DiskError_20    db      "Chyba ıadiŸe %",0
DiskError_40    db      "Chybnì seek (chyba pıi vystavov n¡ hlaviŸek) na disku %",0
DiskError_80    db      "Disk % nen¡ pıipraven",0
DiskError_0AA   db      "Pevnì % disk nen¡ pıipraven",0
DiskError_0BB   db      "Nezn m  diskov  chyba pıi pr ci s pevnìm diskem %",0
DiskError_0CC   db      "U pevn‚ho disku % doçlo k chybØ z pisu",0
DiskError_0E0   db      "U pevn‚ho disku % doçlo k chybØ stavov‚ho registru",0
DiskError_0FF   db      "U pevn‚ho disku % byl pou§it chybnì vìznam operace",0
DiskError_N     db      "Pıi pr ci s diskem % vznikl nezn mì chybovì k¢d %%",0

;8:5
PrintDiskError	db	"ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»", 0Dh, 0Ah
		db	"       ºPıi vol n¡ funkce                                               º", 0Dh, 0Ah
		db	"       ºDoçlo k chybØ                                                   º", 0Dh, 0Ah
		db	"       ºÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄº", 0Dh, 0Ah
		db	"       º Chybuj¡c¡ oblast:            ³ Registry:                       º", 0Dh, 0Ah
		db	"       º     Disk....:                ³     AX..:        DI.....:       º", 0Dh, 0Ah
		db	"       º     Stopa...:                ³     BX..:        DS.....:       º", 0Dh, 0Ah
		db	"       º     Sektor..:                ³     CX..:        ES.....:       º", 0Dh, 0Ah
		db	"       º     Povrch..:                ³     DX..:        Flags..:       º", 0Dh, 0Ah
		db	"       º     Sektor….:                ³     BP..:                       º", 0Dh, 0Ah
		db	"       º     Funkce..:                ³     SI..:                       º", 0Dh, 0Ah
		db	"       ºÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄº", 0Dh, 0Ah
		db	"       º        Zkusit znovu / Konec s chybou / konec Bez chyby         º", 0Dh, 0Ah
		db	"       ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼", 00h

PrintPartition	db	"ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»", 0Dh, 0Ah
		db	"ºDisk:     Cyl:     Pov:     Sektor:    º", 0Dh, 0Ah
		db	"ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»", 0Dh, 0Ah
		db	"º      ³    ³  PoŸ. pozice  ³ Konc. pozice  ³Sektor… pıed³Obsazenìchº", 0Dh, 0Ah
		db	"ºSystem³Boot³Pov. Cyl. Sekt.³Pov. Cyl. Sekt.³  oblast¡   ³ sektor…  º", 0Dh, 0Ah
		db	"ºÄÄÄÄÄÄÅÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄº", 0Dh, 0Ah
		db	"º      ³    ³               ³               ³            ³          º", 0Dh, 0Ah
		db	"º      ³    ³               ³               ³            ³          º", 0Dh, 0Ah
		db	"º      ³    ³               ³               ³            ³          º", 0Dh, 0Ah
		db	"º      ³    ³               ³               ³            ³          º", 0Dh, 0Ah
		db	"ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼", 00h

PrintSystemError	db	"       ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»", 0Dh, 0Ah
		db	"       º                                                                  º", 0Dh, 0Ah
		db	"       º                                                                  º", 0Dh, 0Ah
		db	"       ºÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄº", 0Dh, 0Ah
		db	"       º Registry:                                                        º", 0Dh, 0Ah
		db	"       º     EAX..:           DS..:                                       º", 0Dh, 0Ah
		db	"       º     EBX..:           ES..:                                       º", 0Dh, 0Ah
		db	"       º     ECX..:           FS..:                                       º", 0Dh, 0Ah
		db	"       º     EDX..:           GS..:                                       º", 0Dh, 0Ah
		db	"       º     ESI..:           SS..:                                       º", 0Dh, 0Ah
		db	"       º     EDI..:           CS..:                                       º", 0Dh, 0Ah
		db	"       º     EBP..:           CR0.:          PG CD NW AM WP NE TS EM MP PEº", 0Dh, 0Ah
		db	"       º     ESP..:           CR2.:                                       º", 0Dh, 0Ah
		db	"       º     EIP..:           CR3.:          PC PW CR4.: -------- PS PV VMº", 0Dh, 0Ah
		db	"       º  EFLAGS..:          ID VIP VIF VM IOPL0 OF DF TF SF ZF AF PF CF  º", 0Dh, 0Ah
		db	"       ºÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄº", 0Dh, 0Ah
		db	"       º        Zkusit znovu / Konec s chybou / konec Bez chyby           º", 0Dh, 0Ah
		db	"       ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼", 00h

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

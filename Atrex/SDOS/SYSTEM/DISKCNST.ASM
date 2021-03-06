INT00Err:	db	"Program se pokusil p�i vykon�n� aritmetick� operace o d�l�n� nulou.",0
ErrA1:		db	"P�i vol�n� funkce % programem % do�lo k chyb�:",0
ErrA2:		db	"P�i pr�ci syst�mu ATREX do�lo k vnit�n� chyb�:",0
ErrB1:		db	"Chyba v p��stupu na za��zen� %",0
ErrB2:		db	"Tisk�rna na LPT% nem� pap�r",0
ErrB3:		db	"P�i d�len� byl zaznamen�n d�litel roven ��slu nula",0
ErrK1:		db	"   Stiskn�te ",0
ErrK2:		db	" Enter-zru�it ",0
ErrK3:		db	" Esc-opakovat ",0
ErrK4:		db	" Esc-zru�it ",0
ErrK5:		db	" Enter-opakovat ",0
ErrK6:		db	" r-registry ",0
ErrK7:		db	" h-�e�en� ",0
ErrX0:		db	13,10,0
ErrH0:		db	" nelze nal�zt ��dn� �e�en� odpov�daj�c�ho probl�mu",0
ErrH1:		db	" Vy�ist�te disketovou mechaniku",0
ErrH2:		db	" Vypn�te po��ta�, vypojte p��vodn� kabely a op�t je zapojte",13,10," na sv� m�sto",0
ErrH3:		db	" Vhodn�m programem prove�te kontrolu povrchu na disku",0
ErrH4:		db	" Zkuste znovu",0
ErrH5:		db	" Vlo�te pap�r do tisk�rny a zkuste znovu",0

DiskFunc_??	db	"??????????", 0
DiskFunc_00	db	"Reset disku a rekalibrace �adi�e", 0
DiskFunc_01	db	"Vra� stav posledn� operace", 0
DiskFunc_02	db	"�ti sektory", 0
DiskFunc_03	db	"Zapi� sektory", 0
DiskFunc_04	db	"Testuj sektory (veryfikace)", 0
DiskFunc_05	db	"Form�tuj stopu", 0
DiskFunc_06	db	"Form�tuj stopu a nastav p��znak vadn�ch sektor�", 0
DiskFunc_07	db	"Form�tuj disk po��naje zadanou stopou", 0
DiskFunc_08	db	"Vra� informace o disku", 0
DiskFunc_09	db	"Inicializace tabulky diskov�ch parametr�", 0
DiskFunc_0a	db	"Dlouh� �ten�", 0
DiskFunc_0b	db	"Dlouh� z�pis", 0
DiskFunc_0c	db	"Vystaven� hlavi�ek na stopu", 0
DiskFunc_0d	db	"Alternativn� reset disku", 0
DiskFunc_0e	db	"Diagnostika disku pro PS/2 nebo �ten� z vyrovn�vac� pam�ti �adi�e", 0
DiskFunc_0f	db	"Diagnostika disku pro PS/2 nebo z�pis do vyrovn�vac� pam�ti �adi�e", 0
DiskFunc_10	db	"Test p�ipravenosti disku", 0
DiskFunc_11	db	"Rekalibrace disku", 0
DiskFunc_12	db	"Diagnostika", 0
DiskFunc_13	db	"Diagnostika disku", 0
DiskFunc_14	db	"Diagnostika �adi�e", 0
DiskFunc_15	db	"Vra� typ disku", 0
DiskFunc_16	db	"Vra� stav v�m�ny", 0
DiskFunc_17	db	"Nastav typ disku", 0
DiskFunc_18	db	"Nastav typ m�dia pro form�tov�n�", 0
DiskFunc_19	db	"Zaparkuj hlavy", 0
DiskFunc_1a	db	"Form�tuj jednotku", 0
DiskFunc_1b	db	"Vra� hlavi�ku z v�roby", 0
DiskFunc_1c0A	db	"Vra� konfiguraci za��zen�", 0
DiskFunc_1c0B	db	"Vra� konfiguraci �adi�e", 0
DiskFunc_1c0C	db	"Vra� informaci o POS", 0
DiskFunc_1c0E	db	"Transformuj RBA na ABA", 0

DiskError_00	db	"Nedo�lo k ��dn� chyb�",0
DiskError_01	db	"Neplatn� po�adavek na �adi� %",0
DiskError_02	db	"Chybn� adresov� zna�ka sektoru disku %",0
DiskError_03	db	"Pokus o z�pis na disk % chr�n�n� proti z�pisu",0
DiskError_04	db	"Sektor na disku % nenalezen",0
DiskError_05	db	"Chyba p�i resetov�n� �adi�e %",0
DiskError_06	db	"Disk % byl vym�n�n",0
DiskError_07	db	"Chybn� parametr p�i pr�ci s diskem %",0
DiskError_08    db      "Chyba DMA (overrun)na disku %",0
DiskError_09    db      "P�ete�en� DMA p�es 64KB p�i pr�ci s diskem %",0
DiskError_0A    db      "U pevn�ho disku % detekov�n chybn� sektor",0
DiskError_0B    db      "U pevn�ho disku % detekov�na chybn� stopa",0
DiskError_0C    db      "Nepodporovan� stopa na disku %",0
DiskError_0D    db      "Chybn� po�et sektor� p�i form�tov�n� pevn�ho disku %",0
DiskError_0E    db      "U pevn�ho disku % detekov�na adresov� zna�ka kontroln�ch dat",0
DiskError_0F    db      "U pevn�ho disku % do�lo k chyb� v rozhodov�n� DMA",0
DiskError_10    db      "�patn� parita CRC/ECC na disku %",0
DiskError_11    db      "Chybn� data byla u pevn�ho disku % opravena pomoc� ECC",0
DiskError_20    db      "Chyba �adi�e %",0
DiskError_40    db      "Chybn� seek (chyba p�i vystavov�n� hlavi�ek) na disku %",0
DiskError_80    db      "Disk % nen� p�ipraven",0
DiskError_0AA   db      "Pevn� % disk nen� p�ipraven",0
DiskError_0BB   db      "Nezn�m� diskov� chyba p�i pr�ci s pevn�m diskem %",0
DiskError_0CC   db      "U pevn�ho disku % do�lo k chyb� z�pisu",0
DiskError_0E0   db      "U pevn�ho disku % do�lo k chyb� stavov�ho registru",0
DiskError_0FF   db      "U pevn�ho disku % byl pou�it chybn� v�znam operace",0
DiskError_N     db      "P�i pr�ci s diskem % vznikl nezn�m� chybov� k�d %%",0
Bios_Disk_Func	Label	Word
		dw	offset DiskFunc_00
		dw	offset DiskFunc_01
		dw	offset DiskFunc_02
		dw	offset DiskFunc_03
		dw	offset DiskFunc_04
		dw	offset DiskFunc_05
		dw	offset DiskFunc_06
		dw	offset DiskFunc_07
		dw	offset DiskFunc_08
		dw	offset DiskFunc_09
		dw	offset DiskFunc_0a
		dw	offset DiskFunc_0b
		dw	offset DiskFunc_0c
		dw	offset DiskFunc_0d
		dw	offset DiskFunc_0e
		dw	offset DiskFunc_0f
		dw	offset DiskFunc_10
		dw	offset DiskFunc_11
		dw	offset DiskFunc_12
		dw	offset DiskFunc_13
		dw	offset DiskFunc_14
		dw	offset DiskFunc_15
		dw	offset DiskFunc_16
		dw	offset DiskFunc_17
		dw	offset DiskFunc_18
		dw	offset DiskFunc_19
		dw	offset DiskFunc_1a
		dw	offset DiskFunc_1b
		dw	offset DiskFunc_1c0A
		dw	offset DiskFunc_1c0B
		dw	offset DiskFunc_1c0C
		dw	offset DiskFunc_1c0E
Bios_Disk_Error	Label	Word
		dw	offset DiskError_00
		dw	offset DiskError_01
		dw	offset DiskError_02
		dw	offset DiskError_03
		dw	offset DiskError_04
		dw	offset DiskError_05
		dw	offset DiskError_06
		dw	offset DiskError_07
		dw	offset DiskError_08
		dw	offset DiskError_09
		dw	offset DiskError_0a
		dw	offset DiskError_0b
		dw	offset DiskError_0c
		dw	offset DiskError_0d
		dw	offset DiskError_0e
		dw	offset DiskError_0f
		dw	offset DiskError_10
		dw	offset DiskError_11
		dw	offset DiskError_20
		dw	offset DiskError_40
		dw	offset DiskError_80
		dw	offset DiskError_0AA
		dw	offset DiskError_0BB
		dw	offset DiskError_0CC
		dw	offset DiskError_0E0
		dw	offset DiskError_0FF

;8:5
PrintDiskError	db	"����������������������������������������������������������������ͻ", 0Dh, 0Ah
		db	"       �P�i vol�n� funkce                                               �", 0Dh, 0Ah
		db	"       �Do�lo k chyb�                                                   �", 0Dh, 0Ah
		db	"       ����������������������������������������������������������������ĺ", 0Dh, 0Ah
		db	"       � Chybuj�c� oblast:            � Registry:                       �", 0Dh, 0Ah
		db	"       �     Disk....:                �     AX..:        DI.....:       �", 0Dh, 0Ah
		db	"       �     Stopa...:                �     BX..:        DS.....:       �", 0Dh, 0Ah
		db	"       �     Sektor..:                �     CX..:        ES.....:       �", 0Dh, 0Ah
		db	"       �     Povrch..:                �     DX..:        Flags..:       �", 0Dh, 0Ah
		db	"       �     Sektor�.:                �     BP..:                       �", 0Dh, 0Ah
		db	"       �     Funkce..:                �     SI..:                       �", 0Dh, 0Ah
		db	"       ����������������������������������������������������������������ĺ", 0Dh, 0Ah
		db	"       �        Zkusit znovu / Konec s chybou / konec Bez chyby         �", 0Dh, 0Ah
		db	"       ����������������������������������������������������������������ͼ", 00h

PrintPartition	db	"���������������������������������������ͻ", 0Dh, 0Ah
		db	"�Disk:     Cyl:     Pov:     Sektor:    �", 0Dh, 0Ah
		db	"�������������������������������������������������������������������ͻ", 0Dh, 0Ah
		db	"�      �    �  Po�. pozice  � Konc. pozice  �Sektor� p�ed�Obsazen�ch�", 0Dh, 0Ah
		db	"�System�Boot�Pov. Cyl. Sekt.�Pov. Cyl. Sekt.�  oblast�   � sektor�  �", 0Dh, 0Ah
		db	"�������������������������������������������������������������������ĺ", 0Dh, 0Ah
		db	"�      �    �               �               �            �          �", 0Dh, 0Ah
		db	"�      �    �               �               �            �          �", 0Dh, 0Ah
		db	"�      �    �               �               �            �          �", 0Dh, 0Ah
		db	"�      �    �               �               �            �          �", 0Dh, 0Ah
		db	"�������������������������������������������������������������������ͼ", 00h

PrintSystemError	db	"       ������������������������������������������������������������������ͻ", 0Dh, 0Ah
		db	"       �                                                                  �", 0Dh, 0Ah
		db	"       �                                                                  �", 0Dh, 0Ah
		db	"       ������������������������������������������������������������������ĺ", 0Dh, 0Ah
		db	"       � Registry:                                                        �", 0Dh, 0Ah
		db	"       �     EAX..:           DS..:                                       �", 0Dh, 0Ah
		db	"       �     EBX..:           ES..:                                       �", 0Dh, 0Ah
		db	"       �     ECX..:           FS..:                                       �", 0Dh, 0Ah
		db	"       �     EDX..:           GS..:                                       �", 0Dh, 0Ah
		db	"       �     ESI..:           SS..:                                       �", 0Dh, 0Ah
		db	"       �     EDI..:           CS..:                                       �", 0Dh, 0Ah
		db	"       �     EBP..:           CR0.:          PG CD NW AM WP NE TS EM MP PE�", 0Dh, 0Ah
		db	"       �     ESP..:           CR2.:                                       �", 0Dh, 0Ah
		db	"       �     EIP..:           CR3.:          PC PW CR4.: -------- PS PV VM�", 0Dh, 0Ah
		db	"       �  EFLAGS..:          ID VIP VIF VM IOPL0 OF DF TF SF ZF AF PF CF  �", 0Dh, 0Ah
		db	"       ������������������������������������������������������������������ĺ", 0Dh, 0Ah
		db	"       �        Zkusit znovu / Konec s chybou / konec Bez chyby           �", 0Dh, 0Ah
		db	"       ������������������������������������������������������������������ͼ", 00h

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
	_OSS	dw	0
	_OESP	dd	0
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

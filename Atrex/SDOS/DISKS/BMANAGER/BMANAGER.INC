VideoStranka	db	0
VideoAtribut	db	7
RecordNum	db	0
Ukazatel	db	1
hdd0	db	"HDD0",00
hdd1	db	"HDD1",00
hdd2	db	"HDD2",00
hdd3	db	"HDD3",00
SysTMP	db	15 dup(00)
NameTmp	db	20 dup(00)
PoznTmp	db	10 dup(00)
LevStat	db	20 dup(00)
_P1	db	"Par___1"
_P2	db	"Par___2"
_P3	db	"Par___3"
_P4	db	"Par___4"
_P5	db	"Par___5"
_P6	db	"Par___6"
_P7	db	"Par___7"
_P8	db	"Par___8"
_P9	db	"Par___9"
L1	db	"Lev_1__"
L2	db	"Lev_2__"
L3	db	"Lev_3__"
L4	db	"Lev_4__"
L5	db	"Lev_5__"
L6	db	"Lev_6__"
L7	db	"Lev_7__"
L8	db	"Lev_8__"
L9	db	"Lev_9__"
Level_L	Label	Word

PrintMenuTableF db	13,10,13,10,13,10,13,10
		db      "  旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커", 0Dh, 0Ah
                db      "  �   N쟺ev   �      Popis      �  Velikost  � Syst굆 � Disk �       Pozn쟭ka      �", 0Dh, 0Ah
                db      "  냐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캐", 0Dh, 0Ah,00
PrintMenuTableM db      "  �           �                 �            �        �      �                     �", 0Dh, 0Ah,00
PrintMenuTableE db      "  읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴",18h,19h,1Ch,"�", 0Dh, 0Ah,00

Table_	struc
        Jmeno           db      "-----------",00
        Popis           db      "--------------",00,00,00
        Velikost        db      12 dup(00)
        System          db      "------",00,00
        Disk            db      6 dup(00)
        Poznamka        db      22 dup(00)
	_Head		db	?
	_SecCyl		dw	?
	_Disk		db	?
	_Sys		db	?
	_Size		dd	?
	_Boot		db	"-",00
Table_	ends
Table1	Table_ <>
Table2	Table_ <>
Table3	Table_ <>
Table4	Table_ <>
Table5	Table_ <>
Table6	Table_ <>
Table7	Table_ <>
Table8	Table_ <>
Table9	Table_ <>

DiskT_	struc
	D1		db	"    ",0dh,0ah,20h,20h,20h
	D2		db	"    ",0dh,0ah,20h,20h,20h
	D3		db	"    ",0dh,0ah,20h,20h,20h
	D4		db	"    ",00
DiskT_	ends
DiskT	DiskT_ <>

include	LOGO.inc
include	STD_VDR.inc

DiskData	db	512 dup(?)
DiskData2	db	512 dup(?)

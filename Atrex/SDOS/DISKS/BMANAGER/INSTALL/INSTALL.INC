Sektoru = 22
include	STD_VDR.inc
include	LOGO.inc
VideoStranka	db	0
VideoAtribut	db	7
_SVGA		db	?

Intro		db	"Instalace ATREX Boot Manageru",0dh,0ah
		db	"T�mto programem nainstalujete ATREX Boot Manager na V�� po��ta�",0dh,0ah
		db	"Varov�n�: Autor programu neru�� za mo�n� po�kozen� Va�ich dat �i hardwaru",0dh,0ah
		db	"          p�i pou��v�n� tohoto softwarov�ho produktu!",0dh,0ah
		db	"M�te-li nainstalovan� program pro sledov�n� z�pisu na pevn� disk,",0dh,0ah
		db	"ukon�ete instala�n� program a deaktivujte ho!!!",0dh,0ah
		db	"D�le�it�: Text v hranat�ch z�vork�ch [] zobrazuje mo�nost Va� volby.",0dh,0ah
		db	"          Klade se zde d�raz na velikost p�smen.",0dh,0ah
		db	"          a,A: ano/n,N:ne/?:nev�m/t:text/g:grafika",00
Install?	db	"Opravdu si p�ejete nainstalovat ATREX Boot Manager? [A/n] ",00
Ukoncuji	db	"Ukon�uji instalaci ATREX Boot Manageru...",00
Proveruji	db	"Prov��uji disk HDD0: .",00
Punkt		db	".",00
ProvErr		db	"P�i �ten� disku HDD0 do�lo k chyb� ",00
ProvErr_	db	" Opravte pros�m chybu a zkuste znovu.",00
NR		db	0dh,0ah,00
OK		db	" v po��dku",00
Err		db	" nalezena chyba",00
Exit		db	" nelze pokra�ovat",00
AlreadyI	db	" na disku byl nalezen zavad؟ pro ATREX Boot Manager ",00
AlreadyIErr	db	", ale je po�kozen�.",00
AlII		db	"Informace o nalezen� instalaci:",0dh,0ah
		db	"  verze: 0000.0000.0000.X   slinkov�no dne: 00/00/00 pro CPU: 0000",00
AlData		db	"Sektory vy�adovan� instalac� ji� obsahuj� data! Zobrazit informace? [a/n] ",00
Pokracovat	db	"P�ejete si pokracovat v instalaci? [A/n] ",00
DetekceSVGA	db	"Vlastn�te grafickou kartu SVGA? [a/?/n] ",00
TestSVGA_	db	"Jste p�ipraveni pro testov�n� pou�iteln�ho videom�du? [a/n] ",00
SVGA		db	"Je mozn� prec�st tento text bez anom�li�? [a/n] ",00
SVGAOk		db	"Test SVGA prob�hl v po��dku",00
SVGAErr		db	"Test SVGA se nezda�il",00
GDIorTEXT	db	"Nainstalovat textovou nebo grafickou verzi? [t/g] ",00

DiskTMP		db	512 dup(0)
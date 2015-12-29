Sektoru = 22
include	STD_VDR.inc
include	LOGO.inc
VideoStranka	db	0
VideoAtribut	db	7
_SVGA		db	?

Intro		db	"Instalace ATREX Boot Manageru",0dh,0ah
		db	"T¡mto programem nainstalujete ATREX Boot Manager na V ç poŸ¡taŸ",0dh,0ah
		db	"Varov n¡: Autor programu neruŸ¡ za mo§n  poçkozen¡ Vaçich dat Ÿi hardwaru",0dh,0ah
		db	"          pýi pou§¡v n¡ tohoto softwarov‚ho produktu!",0dh,0ah
		db	"M te-li nainstalovanì program pro sledov n¡ z pisu na pevnì disk,",0dh,0ah
		db	"ukonŸete instalaŸn¡ program a deaktivujte ho!!!",0dh,0ah
		db	"D…le§it‚: Text v hranatìch z vork ch [] zobrazuje mo§nost Vaç¡ volby.",0dh,0ah
		db	"          Klade se zde d…raz na velikost p¡smen.",0dh,0ah
		db	"          a,A: ano/n,N:ne/?:nev¡m/t:text/g:grafika",00
Install?	db	"Opravdu si pýejete nainstalovat ATREX Boot Manager? [A/n] ",00
Ukoncuji	db	"UkonŸuji instalaci ATREX Boot Manageru...",00
Proveruji	db	"ProvØýuji disk HDD0: .",00
Punkt		db	".",00
ProvErr		db	"Pýi Ÿten¡ disku HDD0 doçlo k chybØ ",00
ProvErr_	db	" Opravte pros¡m chybu a zkuste znovu.",00
NR		db	0dh,0ah,00
OK		db	" v poý dku",00
Err		db	" nalezena chyba",00
Exit		db	" nelze pokraŸovat",00
AlreadyI	db	" na disku byl nalezen zavadØŸ pro ATREX Boot Manager ",00
AlreadyIErr	db	", ale je poçkozenì.",00
AlII		db	"Informace o nalezen‚ instalaci:",0dh,0ah
		db	"  verze: 0000.0000.0000.X   slinkov no dne: 00/00/00 pro CPU: 0000",00
AlData		db	"Sektory vy§adovan‚ instalac¡ ji§ obsahuj¡ data! Zobrazit informace? [a/n] ",00
Pokracovat	db	"Pýejete si pokracovat v instalaci? [A/n] ",00
DetekceSVGA	db	"Vlastn¡te grafickou kartu SVGA? [a/?/n] ",00
TestSVGA_	db	"Jste pýipraveni pro testov n¡ pou§iteln‚ho videom¢du? [a/n] ",00
SVGA		db	"Je mozn‚ prec¡st tento text bez anom li¡? [a/n] ",00
SVGAOk		db	"Test SVGA probØhl v poý dku",00
SVGAErr		db	"Test SVGA se nezdaýil",00
GDIorTEXT	db	"Nainstalovat textovou nebo grafickou verzi? [t/g] ",00

DiskTMP		db	512 dup(0)
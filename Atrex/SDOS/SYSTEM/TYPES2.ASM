DiskIOErr:
		db	"Nastala chyba p�i �ten� z disku ",0
PressAnyK:
		db	"Stiskn�te jakoukoliv kl�vesu pro pokra�ov�n�...",13,10,0
ENTER_MESS:
		db	0Dh, 0Ah, 00h

OFS_13	dw	?
SEG_13	dw	?
DISK	db	'#A'
NV	db	'1'
RETEZEC		DB	5 dup(0),0,0,0


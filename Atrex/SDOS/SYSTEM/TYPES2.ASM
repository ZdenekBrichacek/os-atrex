DiskIOErr:
		db	"Nastala chyba pýi Ÿten¡ z disku ",0
PressAnyK:
		db	"StisknØte jakoukoliv kl vesu pro pokraŸov n¡...",13,10,0
ENTER_MESS:
		db	0Dh, 0Ah, 00h

OFS_13	dw	?
SEG_13	dw	?
DISK	db	'#A'
NV	db	'1'
RETEZEC		DB	5 dup(0),0,0,0


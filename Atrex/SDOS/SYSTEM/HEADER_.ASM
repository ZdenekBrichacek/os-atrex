_TEXT	segment
assume	cs:_TEXT, ds:_TEXT, es:_TEXT, ss:_TEXT
.386
org 100h
@Filename:
	include	header.asm
_TEXT	ends
END	@Filename

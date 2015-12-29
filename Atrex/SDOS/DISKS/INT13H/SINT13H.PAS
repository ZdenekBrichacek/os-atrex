uses crt;
Function SINT13HA:Char;
var RgAL:byte;
begin
  asm
        push    ds
	mov	ax,0040h
	mov	ds,ax
	mov	AX,ds:[00F0h]
        mov     RgAL,AL
        pop     ds
  end;
  SINT13HA:=Chr(RgAL);
end;

Function SINT13HB:Char;
var RgAH:byte;
begin
  asm
        push     ds
	mov	ax,0040h
	mov	ds,ax
	mov	AX,ds:[00F0h]
        mov     RgAH,AH
        pop     ds
  end;
  SINT13HB:=Chr(RgAH);
end;
begin
  repeat
    Write(SINT13HA, SINT13HB,#13);
  until keypressed;
  readkey;
end.
var
  a:byte;
label     d;
begin
  for a:= 114 to 255 do
    begin
      writeln(a);
      readln;
      if a = 7 then goto d;
      asm
        mov       ah, 00h
        mov       al, a
        int       10h
      end;
      writeln(a);
      readln;
d:
    end;
end.
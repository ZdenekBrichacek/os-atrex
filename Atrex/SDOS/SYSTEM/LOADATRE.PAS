{$M $4000,0,0}
uses dos;
var
  s:string;
  i:integer;
  FromF, ToF: file;
  NumRead, NumWritten: Word;
  Buf: array[1..50000] of Char;
begin
  s:='';
  for i:= 2 to ParamCount do
    s:=s+' '+ParamStr(i);
{  SwapVectors;}
  Assign(FromF, ParamStr(1)); { Open input file }
  Reset(FromF, 1);  { Record size = 1 }
  BlockRead(FromF, Buf, SizeOf(Buf), NumRead);
  inline(
  $66/$B8/$45/$52/$54/$41/$66/$BB/$78/$53/$4F/$58);
  asm
     push       ds
     push       cs
     pop        ds
     mov        cx, offset Buf
     call       cx
     pop        ds
  end;
  Close(FromF);
{  Exec(ParamStr(1), s);
  SwapVectors;
  Halt(DosExitCode);}
end.
66 B8 45 52 ≥ 54 41 66 BB ≥ 78 53 4F 58 ≥ 66 3D 45 52   f∏ERTAfªxSOXf=ER
54 41 75 1E ≥ 90 90 66 81 ≥ FB 78 53 4F ≥ 58 75 13 90   TAuêêfÅ˚xSOXê
90 EB 59 90 ≥ 01 00 00 00 ≥ 0A 00 00 0E ≥ 00 00 00 00   .........êÎYêu
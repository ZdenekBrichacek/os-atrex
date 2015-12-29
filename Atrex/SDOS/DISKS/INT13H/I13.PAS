{$M $400,0,0}
uses dos;
var
  OldBiosDisk: Procedure;
  BiosDisk:byte;
  Rg:registers;
  Disk:String[2];

{$F+}
Procedure NewBiosDisk(Flags, CS, IP, AX, BX, CX, DX, SI, DI, DS, ES, BP: Word);interrupt;
begin
  Disk:='??';
  if (Lo(DX) = 00) then Disk[1]:='A';
  if (Lo(DX) = 01) then Disk[1]:='B';
  if (Lo(DX) = $80) then Disk[1]:='C';
  if (Lo(DX) = $81) then Disk[1]:='D';
  if (Hi(AX) = 02) then Disk[0]:='<';
  if (Hi(AX) = 03) then Disk[0]:='>';
  if ((Hi(AX) = 00) or (Hi(AX) = 09) or (Hi(AX) = 08) or (Hi(AX) = $15) or
     (Hi(AX) = $16)) then Disk[0]:='~';
  if (Hi(AX) = 05) then Disk[0]:='';
  if (Hi(AX) = 04) then Disk[0]:='#';
  Rg.CX:=2;
  Rg.AX:=$1300;
  Rg.BH:=$00;
  Rg.BL:=(16*7)+$0F;
  Rg.DH:=0;
  Rg.DL:=78;
  Rg.ES:=Seg(Disk);
  Rg.BP:=Ofs(Disk);
  Intr($10,Rg);

{  if (AX and $FF00 = $0500) then
    begin
      AX:=$0300;
      Flags:=Flags or 1;
    end
  else}
    asm
      mov BiosDisk,1
      mov ax,word ptr OldBiosDisk
      mov word ptr cs:[@OD],ax
      mov ax,word ptr OldBiosDisk + 2
      mov word ptr cs:[@SD],ax
      mov word ptr cs:[@DS],ds
      pop bp
      pop es
      pop ds
      pop di
      pop si
      pop dx
      pop cx
      pop bx
      pop ax
      pushf
      call dword ptr cs:[@OD]
      mov word ptr cs:[@OD],ds
      mov ds,word ptr cs:[@DS]
      mov BiosDisk,0
      mov ds,word ptr cs:[@OD]
      retf 2
@OD: dw $0000
@SD: dw $0000
@DS: dw $0000
    end;
end;
{$F-}

begin
  BiosDisk:=0;
  GetIntVec($13,@OldBiosDisk);
  SetIntVec($13,Addr(NewBiosDisk));
  Keep(0);
end.
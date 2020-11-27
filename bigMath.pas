unit bigMath;

interface

uses
  Math, Classes, SysUtils, Contnrs, Dialogs, StrUtils;

type
  TOperatoren = (Addition, Subtraktion, Multiplikation, Division);
  TStackType  = (EOPC, ENUM);

type
  TStackSpeicher = class(TObject)
  public
    Command : TStackType;
    Zahl    : String;
    Operator: TOperatoren;
  public
    constructor Create;
    destructor Destory;
  end;

type
  TBigMathSolver = class(TObject)
  private
    FObjektListe   : TObjectList;
  public
    constructor Create;
    destructor  Destroy; override;
    procedure Push(Zahl: String); overload;
    procedure Push(Operator: TOperatoren); overload;
    function  Pop () : TStackSpeicher;
    function  Calc() : String;
  end;

var
  FZwischenSumme : String;

implementation

constructor TStackSpeicher.Create;
begin
  inherited Create;
end;

destructor TStackSpeicher.Destory;
begin
  inherited Destroy;
end;

constructor TBigMathSolver.Create;
begin
  inherited Create;

  FObjektListe := TObjectList.Create;
  FObjektListe.OwnsObjects := true;
end;

destructor TBigMathSolver.Destroy;
begin
  FObjektListe.Clear;
  FObjektListe.Free;
  FObjektListe := nil;

  inherited Destroy;
end;

procedure TBigMathSolver.Push(Zahl: String);
var
  p: TStackSpeicher;
begin
  p := TStackSpeicher.Create;
  p.Command := ENUM;
  p.Zahl    := Zahl;
  FObjektListe.Add(p);
end;

procedure TBigMathSolver.Push(Operator: TOperatoren);
var
  p: TStackSpeicher;
begin
  p := TStackSpeicher.Create;
  p.Command  := EOPC;
  p.Operator := Operator;
  FObjektListe.Insert(0,p);
end;

function TBigMathSolver.Pop: TStackSpeicher;
var
  p: TStackSpeicher;
begin
  if (FObjektListe.Count - 1) < 0 then begin
    result := nil;
    exit;
  end;

  p := TStackSpeicher(FObjektListe.Last);
  p.Command  := TStackSpeicher(FObjektListe.Last).Command;
  p.Zahl     := TStackSpeicher(FObjektListe.Last).Zahl;
  p.Operator := TStackSpeicher(FObjektListe.Last).Operator;
end;

function TBigMathSolver.Calc: String;
var
  elt   : TStackSpeicher;
  zahl  : String;
  calcOP: TOperatoren;
  len   : Integer;
  res,i,k : Integer;
  strA  : String;
  strB  : String;
  numA, numB, numC, numD: Integer;
  commA, commB, found, has_Comma: Boolean;
  numR : Real;
  sp,spA,spB  : String;
  carry : Byte;
  p     : Integer;

  function LeftPad(value: String; length: Integer = 8; pad: Char = '0'): string;
  begin
    result := RightStr(StringOfChar(pad,length) + value, length);
  end;
  function RightPad(PadString : string ; HowMany : integer ; PadValue : string): string;
  var
    Counter : integer;
    x : integer;
    NewString : string;
  begin
    Counter := HowMany - Length(PadString);
    for x := 1 to Counter do
    begin
      NewString := NewString + PadValue;
    end;
    Result := PadString + NewString;
  end;
begin
  if (FObjektListe.Count < 2) then begin
    result := 'no data';
    exit;
  end;

  commA := false;
  commB := false;
  FZwischenSumme := '';
  carry := 0;
  strA  := '';
  strB  := '';
  p     := 0;
  i     := FObjektListe.Count;
  while (i <> 0) do begin;
    if ((i - 1) > 1) then begin
      dec(i);
      sp := IntToStr(i);
//    sp := RightPad(sp, 5,'0');
//    sp := LeftPad (sp,12,'0');
      if TStackSpeicher(FObjektListe[i]).Command = ENUM then
      strA := TStackSpeicher(FObjektListe[i]).Zahl + '@';
    end else begin
      break;
    end;
    if ((i - 1) > 0) then begin
      dec(i);
      if TStackSpeicher(FObjektListe[i]).Command = ENUM then
      strB := TStackSpeicher(FObjektListe[i]).Zahl + '@';
    end else begin
      break;
    end;
    if ((i - 1) = 0) then begin
      if TStackSpeicher(FObjektListe[i-1]).Command = EOPC then begin
        calcOP := TStackSpeicher(FObjektListe[i-1]).Operator;
        if calcOP = Division then begin
        while ((Length(strA)-1) <> 0) do begin
          spA := strA;
          spB := strB;

          numA := StrToInt(Copy(strA,1,1));
          numB := StrToInt(Copy(strB,1,1));

          case numB of
            9: begin
              case numA of
                0: begin // 0
                  numC := 0;
                end;
                1: begin // 9
                end;
                2: begin // 4
                end;
                3: begin // 3
                end;
                4: begin // 2
                end;
                5: begin // 1
                end;
                6: begin // 1
                end;
                7: begin // 1
                end;
                8: begin // 1
                end;
                9: begin // 1
                end;
              end;
            end;
            8: begin
              case numA of
                0: begin // 0
                  numC := 0;
                end;
                1: begin // 8
                  numC := 8;
                end;
                2: begin // 4
                  numC := 4;
                end;
                3: begin // 2
                  numC := 2;
                end;
                4: begin // 2
                  numC := 2;
                end;
                5: begin // 1
                  numC := 1;
                end;
                6: begin // 1
                  numC := 1;
                end;
                7: begin // 1
                  numC := 1;
                end;
                8: begin // 1
                  numC := 1;
                end;
              end;
            end;
            7: begin
              case numA of
                0: begin // 0
                  numC := 0;
                end;
                1: begin // 7
                  numC := 7;
                end;
                2: begin // 3
                  numC := 3;
                end;
                3: begin // 2
                  numC := 2;
                end;
                4: begin // 1
                  numC := 1;
                end;
                5: begin // 1
                  numC := 1;
                end;
                6: begin // 1
                  numC := 1;
                end;
                7: begin // 1
                  numC := 1;
                end;
              end;
            end;
            6: begin
              case numA of
                0: begin // 0
                  numC := 0;
                end;
                1: begin // 6
                  numC := 6;
                end;
                2: begin // 3
                  numC := 3;
                end;
                3: begin // 2
                  numC := 2;
                end;
                4: begin // 1
                  numC := 1;
                end;
                5: begin // 1
                  numC := 1;
                end;
                6: begin // 1
                  numC := 1;
                end;
              end;
            end;
            5: begin
              case numA of
                0: begin // 0
                  numC := 0;
                end;
                1: begin // 5
                  numC := 5;
                end;
                2: begin // 2
                  numC := 2;
                end;
                3: begin // 1
                  numC := 1;
                end;
                4: begin // 1
                  numC := 1;
                end;
                5: begin // 1
                  numC := 1;
                end;
              end;
            end;
            4: begin
              case numA of
                0: begin // 0
                  numC := 0;
                end;
                1: begin // 4
                  numC := 4;
                end;
                2: begin // 2
                  numC := 2;
                end;
                3: begin // 1
                  numC := 1;
                end;
                4: begin // 1
                  numC := 1;
                end;
              end;
            end;
            3: begin
              case numA of
                0: begin // 0
                  numC := 0;
                end;
                1: begin // 3
                  numC := 3;
                end;
                2: begin // 1
                  numC := 1;
                end;
                3: begin // 1
                  numC := 1;
                end;
              end;
            end;
            2: begin
              case numA of
                0: begin // 0
                  numC := 0;
                end;
                1: begin // 2
                  numC := 2;
                end;
                2: begin // 1
                  numC := 1;
                end;
              end;
            end;
            1: begin
              case numA of
                0: begin // 0
                  numC := 0;
                end;
                1: begin // 1
                  numC := 1;
                end;
              end;
            end;
            0: begin
              numC := 0;
            end;
          end;

          numD := numC * numA;
          numC := numB - numD;

          if numC = 0 then
          numC := numB;

          FZwischenSumme :=
          FZwischenSumme + IntToStr(numC);

          ShowMessage('div: ' + #13 +
          'numA: ' + inttostr(numA) + #13 +
          'numB: ' + inttostr(numB) + #13#13 +
          'numC: ' + inttostr(numC) + #13 +
          'numD: ' + inttostr(numD) + #13 +
          'zsum: ' + FZwischenSumme);

          delete(strA,1,1);
          delete(strB,1,1);
        end;

(*
          for k := 0 to Length(strA) - 1 do begin
            if (Copy(strA,k,1) = '@') then begin
              if k > Length(strA)-1 then begin
                FZwischenSumme := '0';
                result := '0';
                exit;
              end;
            end;
            if (Copy(strB,k,1) = '@') then begin
              if k > Length(strB)-1 then begin
                FZwischenSumme := '0';
                result := '0';
                exit;
              end;
            end;
            if ((Copy(strA,1,1) = '0') and (Copy(strB,1,1) = '0')) then begin
              delete(strA,1,1);
              delete(strB,1,1);

//              ShowMessage(strA + #13 + strB);
            end else begin
              break;
            end;
          end;
          //
          carry := 0;
          strA  := spA;
          strB  := spB;
          ShowMessage(strA + #13+ strb);
          for k := 0 to Length(strA) - 1 do begin
            if (Copy(strB,1,1) = '0') and (StrToInt(Copy(strA,1,1)) > 0) then begin
              FZwischenSumme := 'Fehler: div / 0';
              result := FZwischenSumme;
              exit;
            end else begin
              delete(strA,1,1);
              delete(strB,1,1);

              if  (Copy(strA,1,1) = '@')
              and (Copy(strB,1,1) = '@') then begin
                if carry = 1 then
                result := '0,' + FZwischenSumme else
                result :=        FZwischenSumme;
                exit;
              end;

              numA := StrToInt(Copy(strA,1,1));
              numB := StrToInt(Copy(strB,1,1));

              if numA = numB then begin
                if  (Char(numA) = '@')
                and (Char(numB) = '@') then begin
                  if carry = 1 then
                  result := '0,' + FZwischenSumme else
                  result :=        FZwischenSumme;
                  exit;
                end;
              end else begin
                numR  := numA / numB;
                spA := FloatToStr(numR);
                if numR < 0 then begin
                  sp := Copy(spA,3,1);
                  FZwischenSumme := sp +
                  FZwischenSumme ;
                  carry := 1;
                end else begin
                  FZwischenSumme := spA +
                  FZwischenSumme ;
                end;
              end;
            end;
          end;
          if carry = 1 then begin
            result := '0,' +
            FZwischenSumme ;
            exit;
          end; *)
        end;
      end;
    end;
    // calculation
    case calcOP of
      Addition: begin
        len := 0;
        while (len <> (Length(strA)-1)) do begin
          if ((Length(strA)-1) < 1) then begin
            result := IntToStr(carry) + FZwischenSumme;
            break;
          end else begin
            if Copy (strA,Length(strA)-1,1) = ',' then begin
              delete(strA,Length(strA),1);
              commA := true;
            end;
            if Copy (strB,Length(strB)-1,1) = ',' then begin
              delete(strB,Length(strB),1);
              commB := true;
            end;

            if (commA) or (commB) then begin
              commA := false;
              commB := false;

              FZwischenSumme := ',' +
              FZwischenSumme ;

              continue;
            end;

            if Length(strA)-1 < 1 then begin
              if carry > 0 then
              result := IntToStr(carry) + FZwischenSumme else
              result := FZwischenSumme;
              break;
            end;

            delete(strA,Length(strA),1);
            delete(strB,Length(strB),1);

            numA := StrToInt(Copy(strA,Length(strA),1));
            numB := StrToInt(Copy(strB,Length(strA),1));

            numC := numA + numB + carry;

            if Length(IntToStr(numC)) > 1 then begin
              carry := StrToInt(Copy(IntToStr(numC),1,1));
              FZwischenSumme := Copy(IntToStr(numC),2,1) +
              FZwischenSumme ;
            end else begin
              carry := 0;
              FZwischenSumme := Copy(IntToStr(numC),1,1) +
              FZwischenSumme ;
            end;
          end;
        end;
      end;
      Subtraktion: begin
        len   := 0;
        carry := 0;
        while (len <> (Length(strA)-1)) do begin
          if ((Length(strA)-1) < 1) then begin
            result := IntToStr(carry) + FZwischenSumme;
            break;
          end else begin
            if Copy (strA,Length(strA)-1,1) = ',' then begin
              delete(strA,Length(strA),1);
              commA := true;
            end;
            if Copy (strB,Length(strB)-1,1) = ',' then begin
              delete(strB,Length(strB),1);
              commB := true;
            end;

            if (commA) or (commB) then begin
              commA := false;
              commB := false;

              FZwischenSumme := ',' +
              FZwischenSumme ;

              continue;
            end;

            delete(strA,Length(strA),1);
            delete(strB,Length(strB),1);

            numA := StrToInt(Copy(strB,Length(strA),1));
            numB := StrToInt(Copy(strA,Length(strA),1));

            if numB > 0 then begin
              numC := numA - numB - carry;
            end else begin
              numC := 0 - (numA + carry);
            end;

            if numC < 0 then begin
              numC  := (10 + numC);
              carry := 1;
            end else begin
              carry := 0;
            end;

            FZwischenSumme := IntToStr(numC) +
            FZwischenSumme ;
          end;
        end;
      end;
      Multiplikation: begin
        len   := 0;
        carry := 0;
        while (len <> (Length(strA)-1)) do begin
          if ((Length(strA)-1) < 1) then begin
            result := IntToStr(carry) + FZwischenSumme;
            break;
          end else begin
            if Copy (strA,Length(strA)-1,1) = ',' then begin
              delete(strA,Length(strA),1);
              commA := true;
            end;
            if Copy (strB,Length(strB)-1,1) = ',' then begin
              delete(strB,Length(strB),1);
              commB := true;
            end;

            if (commA) or (commB) then begin
              commA := false;
              commB := false;

              FZwischenSumme := ',' +
              FZwischenSumme ;

              continue;
            end;

            delete(strA,Length(strA),1);
            delete(strB,Length(strB),1);

            numA := StrToInt(Copy(strB,Length(strA),1));
            numB := StrToInt(Copy(strA,Length(strA),1));

            if (numA = 0) or (numB = 0) then begin
              numC := 0 + carry;
            end else begin
              numC := ((numA * numB) + carry);
            end;

            spA := IntToStr(numC);
            if Length(spA) > 1 then begin
              FZwischenSumme := Copy(spA,Length(spA),1) +
              FZwischenSumme ;
              carry := StrToInt(Copy(spA,Length(spA)-1,1));
            end else begin
              FZwischenSumme := Copy(spA,Length(spA),1) +
              FZwischenSumme ;
              carry := 0;
            end;
          end;
        end;
      end;
    end;
  end;
  result := FZwischenSumme;
end;

end.

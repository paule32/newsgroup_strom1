program strom1;

{$R 'meine.res' 'meine.rc'}

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  bigMath in 'bigMath.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.


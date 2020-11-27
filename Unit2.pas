unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  TForm2 = class(TForm)
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
  public
    FTimerFlag : Boolean;
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.dfm}

// Form1 constructor
procedure TForm2.Timer1Timer(Sender: TObject);
begin
  if ProgressBar1.Position = 100 then begin
    Timer1.Enabled := false;
    Timer1.Free;
    Timer1 := nil;

    if not Assigned(Form1) then
    Form1 := TForm1.Create(self);
    Form1.BringToFront;
    Form1.ShowModal;
  end else begin
    if not Assigned(Form1) then begin
      Form1 := TForm1.Create(self);
      Form1.Visible := false;
    end;
  end;
end;

// Form1 destructor
procedure TForm2.Timer2Timer(Sender: TObject);
begin
  if ProgressBar1.Position = 0 then begin
    Form2.Timer2.Enabled := false;
  end else begin
    FTimerFlag := true;
  end;
end;

end.

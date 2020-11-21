unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Menus, ExtCtrls, Buttons, Grids,
  JvDesignSurface, JvComponentBase, JvInspector, JvExControls;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Button1: TButton;
    MainMenu1: TMainMenu;
    Programm1: TMenuItem;
    Beenden1: TMenuItem;
    ScrollBox1: TScrollBox;
    RichEdit1: TRichEdit;
    Button2: TButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    TabSheet2: TTabSheet;
    DrawGrid1: TStringGrid;
    N1: TMenuItem;
    DateiLaden1: TMenuItem;
    DateiSpeichern1: TMenuItem;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    ScrollBox2: TScrollBox;
    Panel2: TPanel;
    Splitter1: TSplitter;
    JvDesignSurface1: TJvDesignSurface;
    Panel3: TPanel;
    Splitter2: TSplitter;
    JvInspector1: TJvInspector;
    JvInspectorBorlandPainter1: TJvInspectorBorlandPainter;
    JvDesignScrollBox1: TJvDesignScrollBox;
    JvDesignPanel1: TJvDesignPanel;
    Panel4: TPanel;
    ComboBox1: TComboBox;
    Panel5: TPanel;
    ListBox1: TListBox;
    Splitter3: TSplitter;
    Panel6: TPanel;
    Panel7: TPanel;
    ComboBox2: TComboBox;
    ListBox2: TListBox;
    PaintBox1: TPaintBox;
    procedure Button1Click(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DrawGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure DrawGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure DrawGrid1Click(Sender: TObject);
    procedure DateiSpeichern1Click(Sender: TObject);
    procedure DateiLaden1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure TabSheet2Enter(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure PaintBox1Click(Sender: TObject);
  private
    ID_ComboBox:   Array[0..20] of TComboBox;
    TYPE_ComboBox: Array[0..20] of TComboBox;
    IN_ComboBox:   Array[0..20] of TComboBox;
    OUT_ComboBox:  Array[0..20] of TComboBox;

    OHM_Edit:      Array[0..20] of TEdit;
    AMPERE_Edit:   Array[0..20] of TEdit;
    VOLT_Edit:     Array[0..20] of TEdit;

    Elektro_Types : TStrings;
    oldIconBitmap : TBitmap;
    newIconBitmap : TBitmap;

    IconBitmapChanged : LongBool;
    IconBitmapError   : LongBool;

    procedure ComboBox_Exit(Sender: TObject);
  public
    destructor Destroy;
  end;

var
  Form1: TForm1;

implementation

uses maprotation;

type
  TEigenschaften = Record
    Farbe: TColor;
    Schrift: TFont;
  end;
  var EigenschaftenGrid : Array[0..5,0..20] of TEigenschaften;

{$R *.dfm}

destructor TForm1.Destroy;
var
  i: Integer;
begin
  Elektro_Types.Clear;
  Elektro_Types.Free;
  Elektro_Types := nil;

  oldIconBitmap.FreeImage;
  oldIconBitmap.Free;

  newIconBitmap.FreeImage;
  newIconBitmap.Free;

  for i := 0 to Length(VOLT_Edit) - 1 do begin
    VOLT_Edit[i].ClearSelection;
    VOLT_Edit[i].ClearUndo;
    VOLT_Edit[i].Clear;
    VOLT_Edit[i].Free;
    VOLT_Edit[i] := nil;
  end;

  for i := 0 to Length(AMPERE_Edit) - 1 do begin
    AMPERE_Edit[i].ClearSelection;
    AMPERE_Edit[i].ClearUndo;
    AMPERE_Edit[i].Clear;
    AMPERE_Edit[i].Free;
    AMPERE_Edit[i] := nil;
  end;

  for i := 0 to Length(OHM_Edit) - 1 do begin
    OHM_Edit[i].ClearSelection;
    OHM_Edit[i].ClearUndo;
    OHM_Edit[i].Clear;
    OHM_Edit[i].Free;
    OHM_Edit[i] := nil;
  end;

  for i := 0 to Length(OUT_ComboBox) - 1 do begin
    OUT_ComboBox[i].Items.Clear;
    OUT_ComboBox[i].Items.Free;
    OUT_ComboBox[i].Clear;
    OUT_ComboBox[i].Free;
    OUT_ComboBox[i] := nil;
  end;

  for i := 0 to Length(IN_ComboBox) - 1 do begin
    IN_ComboBox[i].Items.Clear;
    IN_ComboBox[i].Items.Free;
    IN_ComboBox[i].Clear;
    IN_ComboBox[i].Free;
    IN_ComboBox[i] := nil;
  end;

  for i := 0 to Length(TYPE_ComboBox) - 1 do begin
    TYPE_ComboBox[i].Items.Clear;
    TYPE_ComboBox[i].Items.Free;
    TYPE_ComboBox[i].Clear;
    TYPE_ComboBox[i].Free;
    TYPE_ComboBox[i] := nil;
  end;

  ComboBox1.Items.Clear;
  ComboBox1.Items.Free;
  ComboBox1.Clear;
  ComboBox1.Free;
  ComboBox1 := nil;

  ComboBox2.Items.Clear;
  ComboBox2.Items.Free;
  ComboBox2.Clear;
  ComboBox2.Free;
  ComboBox2 := nil;

  ListBox1.Items.Clear;
  ListBox1.Items.Free;
  ListBox1.Clear;
  ListBox1.Free;
  ListBox1 := nil;

  ListBox2.Items.Clear;
  ListBox2.Items.Free;
  ListBox2.Clear;
  ListBox2.Free;
  ListBox2 := nil;

  DrawGrid1.Free;
  DrawGrid1 := nil;

  inherited Destroy;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Beenden1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  rs: TResourceStream;
  bmp: TBitmap;
  i,j: Integer;
begin
  rs := TResourceStream.Create(
        hInstance,
        PChar('ohmGesetz'),
        RT_RCDATA);
  try
    rs.Position := 0;
    RichEdit1.PlainText := false;
    RichEdit1.Lines.LoadFromStream(rs);
  finally
    rs.Free;
  end;

  rs  := TResourceStream.Create(
         hInstance,
         PChar('spenden'),
         RT_BITMAP);
  bmp := TBitmap.Create;
  try
    rs.Position;
    bmp.LoadFromResourceName(hInstance,'spenden');
    SpeedButton1.Glyph := bmp;
    SpeedButton2.Glyph := bmp;
  finally
    bmp.Free;
    rs.Free;
  end;

  Elektro_Types := TStringList.Create;
  with Elektro_Types do begin
    Add('Stromquelle');
    Add('Draht');
    Add('Widerstand');
    Add('Kondensator');
  end;

  PaintBox1.Height := 78;
  PaintBox1.Width  := 78;

  oldIconBitmap        := TBitmap.Create;
  oldIconBitmap.Width  := PaintBox1.Width;
  oldIconBitmap.Height := PaintBox1.Height;

  newIconBitmap        := TBitmap.Create;
  newIconBitmap.Width  := PaintBox1.Width;
  newIconBitmap.Height := PaintBox1.Height;

  IconBitmapChanged    := false;

  DrawGrid1.ColWidths[0] := 10;
  DrawGrid1.ColWidths[2] := 180;
  DrawGrid1.ColWidths[3] := 90;
  DrawGrid1.ColWidths[4] := 90;
  DrawGrid1.ColWidths[5] := 90;
  DrawGrid1.ColWidths[6] := 90;

  for i := 0 to 20 do begin
    ID_ComboBox[i] := TComboBox.Create(DrawGrid1);
    try
      with ID_ComboBox[i] do begin
        Visible := false;
        Parent  := DrawGrid1;
        OnExit  := ComboBox_Exit;

        Items.BeginUpdate;
        for j := 0 to 20 do
        Items.Add(IntToStr(j+1));
        Items.EndUpdate;
      end
    finally
      //ID_ComboBox[i].Free;
    end;
  end;

  for i := 0 to 20 do begin
    TYPE_ComboBox[i] := TComboBox.Create(DrawGrid1);
    try
      with TYPE_ComboBox[i] do begin
        Parent  := DrawGrid1;
        Visible := false;
        OnExit  := ComboBox_Exit;

        Items.BeginUpdate;
        Items.AddStrings(Elektro_Types);
        Items.EndUpdate;
      end;
    finally
      //TYPE_ComboBox[i].Free;
    end;
  end;

  for i := 0 to 20 do begin
    IN_ComboBox[i] := TComboBox.Create(DrawGrid1);
    try
      with IN_ComboBox[i] do begin
        Parent  := DrawGrid1;
        Visible := false;
        OnExit  := ComboBox_Exit;

        Items.BeginUpdate;
        for j := 0 to 20 do
        Items.Add(IntToStr(j+1));
        Items.EndUpdate;
      end;
    finally
      //IN_ComboBox[i].Free;
    end;
  end;

  for i := 0 to 20 do
  begin
    OUT_ComboBox[i] := TComboBox.Create(DrawGrid1);
    try
      with OUT_ComboBox[i] do begin
        Parent  := DrawGrid1;
        Visible := false;
        OnExit  := ComboBox_Exit;

        Items.BeginUpdate;
        for j := 0 to 20 do
        Items.Add(IntToStr(j+1));
        Items.EndUpdate;
      end;
    finally
      //OUT_ComboBox[i].Free;
    end;
  end;

  for i := 0 to 20 do
  begin
    OHM_Edit[i] := TEdit.Create(DrawGrid1);
    OHM_Edit[i].Parent := DrawGrid1;
    OHM_Edit[i].Visible := false;

    AMPERE_Edit[i] := TEdit.Create(DrawGrid1);
    AMPERE_Edit[i].Parent := DrawGrid1;
    AMPERE_Edit[i].Visible := false;

    VOLT_Edit[i] := TEdit.Create(DrawGrid1);
    VOLT_Edit[i].Parent := DrawGrid1;
    VOLT_Edit[i].Visible := false;
  end;
end;

procedure TForm1.DrawGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  if (ACol = 0) and (ARow = 0) then
  begin
    DrawGrid1.Canvas.Brush.Color := TColor(RGB(100,200,255));
    DrawGrid1.Canvas.FillRect(rect);
  end;
  if (ACol > 0) and (ARow = 0) then
  begin
    DrawGrid1.Canvas.Brush.Color := TColor(RGB(220,220,255));
    DrawGrid1.Canvas.FillRect(rect);
    DrawGrid1.Canvas.Font.Color := clBlack;
    DrawGrid1.Canvas.Font.Name := 'Arial';
    DrawGrid1.Canvas.Font.Size := 10;
    DrawGrid1.Canvas.Font.Style := [fsBold];

    case Acol of
      1: begin DrawGrid1.Canvas.TextOut(rect.Left + 10,1,'ID');  end;
      2: begin DrawGrid1.Canvas.TextOut(rect.Left + 10,1,'Typ'); end;
      3: begin
           DrawGrid1.Canvas.TextOut(rect.Left + 10,1,'IN');
           DrawGrid1.Canvas.Font.Color := clRed;
           DrawGrid1.Canvas.Font.Style := [];
           DrawGrid1.Canvas.TextOut(rect.Left + 36,1,'minus');
      end;
      4: begin
           DrawGrid1.Canvas.TextOut(rect.Left + 10,1,'OUT');
           DrawGrid1.Canvas.Font.Color := clRed;
           DrawGrid1.Canvas.Font.Style := [];
           DrawGrid1.Canvas.TextOut(rect.Left + 46,1,'plus');
      end;
      5: begin DrawGrid1.Canvas.TextOut(rect.Left + 10,1,'Ohm');    end;
      6: begin DrawGrid1.Canvas.TextOut(rect.Left + 10,1,'Ampere'); end;
      7: begin DrawGrid1.Canvas.TextOut(rect.Left + 10,1,'Volt');   end;
    end;
  end;
end;

procedure TForm1.DrawGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  R: TRect;
  pos: TPoint;
  i: Integer;
  match: Boolean;
begin
  match := false;

  if (ACol = 1) and (ARow >= DrawGrid1.FixedRows) then
  begin
    match := true;
    DrawGrid1.Perform(WM_CANCELMODE, 0,0);
    R   := DrawGrid1.CellRect(ACol, ARow);
    pos := self.ScreenToClient(self.ClientToScreen(R.TopLeft));
    with ID_ComboBox[ARow-1] do begin
      Visible := true;
      SetBounds(pos.X, pos.Y, R.Right - R.Left, DrawGrid1.Height);
      ItemIndex := (DrawGrid1.RowCount * 7) + i;
      Show;
      BringToFront;
      SetFocus;
      DroppedDown := true;
    end;
  end;
  if match = true then exit;

  if (ACol = 2) and (ARow >= DrawGrid1.FixedRows) then
  begin
    match := true;
    DrawGrid1.Perform(WM_CANCELMODE, 0,0);
    R   := DrawGrid1.CellRect(ACol, ARow);
    pos := self.ScreenToClient(self.ClientToScreen(R.TopLeft));
    with TYPE_ComboBox[ARow - 1] do begin
      Visible := true;
      BoundsRect := R;
      Height := DrawGrid1.Height;
      ItemIndex := (DrawGrid1.RowCount * 7) + 2;;
      Show;
      BringToFront;
      SetFocus;
      DroppedDown := true;
    end;
  end;
  if match = true then exit;

  if (ACol = 3) and (ARow >= DrawGrid1.FixedRows) then
  begin
    DrawGrid1.Perform(WM_CANCELMODE, 0,0);
    R   := DrawGrid1.CellRect(ACol, ARow);
    pos := self.ScreenToClient(self.ClientToScreen(R.TopLeft));
    with IN_ComboBox[ARow-1] do begin
      Visible := true;
      BoundsRect := R;
      Height := DrawGrid1.Height;
      ItemIndex := (DrawGrid1.RowCount * 7) + 3;
      Show;
      BringToFront;
      SetFocus;
      DroppedDown := true;
    end;
  end;

  if (ACol = 4) and (ARow >= DrawGrid1.FixedRows) then
  begin
    DrawGrid1.Perform(WM_CANCELMODE, 0,0);
    R   := DrawGrid1.CellRect(ACol, ARow);
    pos := self.ScreenToClient(self.ClientToScreen(R.TopLeft));
    with OUT_ComboBox[ARow - 1] do begin
      Visible := true;
      SetBounds(pos.X, pos.Y, R.Right-R.Left, DrawGrid1.Height);
      ItemIndex := (DrawGrid1.RowCount * 7) + 4;
      Show;
      BringToFront;
      SetFocus;
      DroppedDown := true;
    end;
  end;

  if (ACol = 5) and (ARow >= DrawGrid1.FixedRows) then
  begin
    DrawGrid1.Perform(WM_CANCELMODE, 0,0);
    R   := DrawGrid1.CellRect(ACol, ARow);
    pos := self.ScreenToClient(self.ClientToScreen(R.TopLeft));
    with OHM_Edit[ARow - 1] do begin
      Visible := true;
      SetBounds(pos.X, pos.Y, R.Right-R.Left, 20);
      Show;
      BringToFront;
      SetFocus;
    end;
  end;

  if (ACol = 6) and (ARow >= DrawGrid1.FixedRows) then
  begin
    DrawGrid1.Perform(WM_CANCELMODE, 0,0);
    R   := DrawGrid1.CellRect(ACol, ARow);
    pos := self.ScreenToClient(self.ClientToScreen(R.TopLeft));
    with AMPERE_Edit[ARow - 1] do begin
      Visible := true;
      SetBounds(pos.X, pos.Y, R.Right-R.Left, 20);
      Show;
      BringToFront;
      SetFocus;
    end;
  end;

  if (ACol = 7) and (ARow >= DrawGrid1.FixedRows) then
  begin
    DrawGrid1.Perform(WM_CANCELMODE, 0,0);
    R   := DrawGrid1.CellRect(ACol, ARow);
    pos := self.ScreenToClient(self.ClientToScreen(R.TopLeft));
    with VOLT_Edit[ARow - 1] do begin
      Visible := true;
      SetBounds(pos.X, pos.Y, R.Right-R.Left, 20);
      Show;
      BringToFront;
      SetFocus;
    end;
  end;

end;

procedure TForm1.DrawGrid1Click(Sender: TObject);
var
  i: Integer;
begin
end;

procedure TForm1.ComboBox_Exit(Sender: TObject);
begin
  with Sender as TComboBox do begin
    hide;
    if ItemIndex >= 0 then
    begin
      with DrawGrid1 do
      Cells[col, row] := Items[ItemIndex];
    end;
  end;
end;

procedure TForm1.DateiSpeichern1Click(Sender: TObject);
var
  len: Integer;
  i,j,k: Integer;
  strList: TStrings;
  line,tmp: String;
  match: Boolean;
begin
  match := false;
  if SaveDialog1.Execute then
  begin
    strList := TStringList.Create;
    try
      for k := 0 to DrawGrid1.RowCount - 1 do begin
        match := false;
        line := '';
        for i := 0 to DrawGrid1.ColCount - 1 do begin
          if (i = 2) and (k > 0) then begin
            match := false;
            len := Elektro_Types.Count - 1;
            for j := 0 to len do begin
              if Elektro_Types[j] = DrawGrid1.Cells[i,k] then begin
                line := line + '|' + IntToStr(j+1) +
                ' - ' + DrawGrid1.Cells[i,k];
                match := true;
                break;
              end;
            end;
          end else begin
            line := line + '|' + DrawGrid1.Cells[i,k];
          end;
        end;
        strList.Add(line);
      end;
      strList.SaveToFile(SaveDialog1.FileName);
    finally
      strList.Free;
    end;
  end;
end;

procedure TForm1.DateiLaden1Click(Sender: TObject);
var
  f: TextFile;
  i,k: Integer;
  iTmp: Integer;
  strTemp: String;
begin
  if OpenDialog1.Execute then
  begin
    AssignFile(f, OpenDialog1.FileName);
    Reset(f);
    with DrawGrid1 do begin
      ReadLn(f, iTmp); ColCount := iTmp;
      ReadLn(f, iTmp); RowCount := iTmp;
      for i := 0 to ColCount do
      for k := 0 to RowCount do begin
        ReadLn(f, strTemp);
        Cells[i,k] := strTemp;
      end;
    end;
    CloseFile(f);
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  TabSheet2Enter(Sender);
end;

procedure TForm1.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  if ListBox1.ItemIndex = 0 then begin
    with ListBox1.Canvas do begin
      Font.Color := clBlack;
      TextOut(Rect.Left,Rect.Top, ListBox1.Items[Index]);
    end;
  end;
end;

procedure TForm1.TabSheet2Enter(Sender: TObject);
begin
  ListBox1.Items.Clear;
  ListBox1.Clear;
  ComboBox1.Text := ComboBox1.Items[0];
  ListBox1.Items.Add('DC Quelle');
  ListBox1.Items.Add('AC Quelle');
end;

procedure TForm1.TabSheet2Show(Sender: TObject);
begin
  TabSheet2Enter(Sender);
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
var
  rect: TRect;
  x1,y1,x2,y2: Integer;
  res: LongBool;
begin
  rect.Left   := 0;
  rect.Top    := 0;
  rect.Right  := PaintBox1.Width;
  rect.Bottom := PaintBox1.Height;

  with PaintBox1.Canvas do begin
    if IconBitmapError then begin
      Brush.Color := clYellow;
      FillRect(rect);
      exit;
    end;

    if IconBitmapChanged then begin
      SetStretchBltMode(Handle, COLORONCOLOR);
      res := StretchBlt(
	           Handle,                      0, 0, rect.Right, rect.Bottom,
          	 newIconBitmap.Canvas.Handle, 0, 0, rect.Right, rect.Bottom,
             SRCCOPY);
      if not res then begin
        Brush.Color := clRed;
        FillRect(rect);
        exit;
      end;
      Brush.Color := clLime;
      FillRect(rect);
      IconBitmapChanged := false;
    end else begin
    Brush.Color := clWhite;
    FillRect(rect);

    case ListBox1.ItemIndex of
      0: begin
        Pen.Color := clBlack;
        Pen.Width := 2;
        y1 := Trunc(((rect.Bottom + Pen.Width) / 2));
        x1 := 10;
        MoveTo(x1,y1);
        LineTo(x1+15   ,y1   );
        MoveTo(x1+15   ,y1-10);
        LineTo(x1+15   ,y1+10);
        LineTo(x1+15+15,y1   );
        LineTo(x1+15   ,y1-10);

        Pen.Width := 4;
        MoveTo(x1+15+15+3,y1-10);
        LineTo(x1+15+15+3,y1+10);

        Pen.Width := 2;
        MoveTo(x1+15+15+3   ,y1);
        LineTo(x1+15+15+3+15,y1);

        Pen.Color := clBlue;
        x2 := Trunc((x1 - 4) + 4 * cos(120));
        y2 := Trunc( y1      + 4 * sin(120));
        Ellipse(x2 - 4, y2 - 5, x2 + 2, y2 + 2);

        x2 := Trunc((x1 + 49) + 4 * cos(120));
        Ellipse(x2 - 4, y2 - 5, x2 + 2, y2 + 2);
      end;
      1: begin
      end;
    end;
    end;
  end;
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
  PaintBox1.Repaint;
end;

procedure TForm1.PaintBox1Click(Sender: TObject);
var
  res: LongBool;
begin
  res := BitBlt(oldIconBitmap.Canvas.Handle,
         0, 0,
         PaintBox1.Width,
         PaintBox1.Height,
         PaintBox1.Canvas.Handle,
         0, 0,
         SRCCOPY);
  if not res then begin
    IconBitmapError := true;
    PaintBox1.Repaint;
    exit;
  end;

  setmaps(oldIconBitmap,newIconBitmap);
  CoarseRotate(46);
  IconBitmapChanged := true;
end;

end.


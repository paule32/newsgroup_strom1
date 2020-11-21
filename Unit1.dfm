object Form1: TForm1
  Left = 84
  Top = 163
  Width = 988
  Height = 510
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    972
    451)
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 872
    Top = 120
    Width = 73
    Height = 65
    Anchors = [akTop, akRight]
    Color = clAqua
    ParentColor = False
    OnClick = PaintBox1Click
    OnPaint = PaintBox1Paint
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 432
    Width = 972
    Height = 19
    Panels = <>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 972
    Height = 49
    Align = alTop
    Caption = 'S H A R E W A R E  -   V E R S I O N'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      972
      49)
    object SpeedButton1: TSpeedButton
      Left = 8
      Top = 0
      Width = 97
      Height = 41
    end
    object SpeedButton2: TSpeedButton
      Left = 864
      Top = 0
      Width = 97
      Height = 41
      Anchors = [akTop, akRight]
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 49
    Width = 857
    Height = 383
    ActivePage = TabSheet2
    Align = alLeft
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Ohmche Gesetz'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      DesignSize = (
        849
        355)
      object ScrollBox1: TScrollBox
        Left = 8
        Top = 8
        Width = 833
        Height = 335
        Anchors = [akLeft, akTop, akRight, akBottom]
        Color = clBtnHighlight
        ParentColor = False
        TabOrder = 0
        object RichEdit1: TRichEdit
          Left = 0
          Top = 0
          Width = 812
          Height = 257
          Align = alTop
          BorderStyle = bsNone
          Color = clMoneyGreen
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          HideScrollBars = False
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 0
        end
        object DrawGrid1: TStringGrid
          Left = 0
          Top = 288
          Width = 777
          Height = 120
          ColCount = 8
          DefaultRowHeight = 18
          RowCount = 22
          TabOrder = 1
          OnClick = DrawGrid1Click
          OnDrawCell = DrawGrid1DrawCell
          OnSelectCell = DrawGrid1SelectCell
          ColWidths = (
            64
            64
            64
            64
            64
            64
            64
            112)
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Designer'
      ImageIndex = 1
      OnEnter = TabSheet2Enter
      OnShow = TabSheet2Show
      object ScrollBox2: TScrollBox
        Left = 0
        Top = 0
        Width = 849
        Height = 355
        Align = alClient
        TabOrder = 0
        object Splitter1: TSplitter
          Left = 177
          Top = 0
          Height = 351
        end
        object Splitter2: TSplitter
          Left = 369
          Top = 0
          Width = 4
          Height = 351
        end
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 177
          Height = 351
          Align = alLeft
          Caption = 'Panel2'
          TabOrder = 0
          object Splitter3: TSplitter
            Left = 1
            Top = 233
            Width = 175
            Height = 3
            Cursor = crVSplit
            Align = alTop
          end
          object Panel4: TPanel
            Left = 1
            Top = 1
            Width = 175
            Height = 23
            Align = alTop
            AutoSize = True
            Caption = 'Panel4'
            TabOrder = 0
            DesignSize = (
              175
              23)
            object ComboBox1: TComboBox
              Left = -2
              Top = 1
              Width = 179
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              ItemHeight = 13
              TabOrder = 0
              Text = 'Stromquellen'
              OnChange = ComboBox1Change
              Items.Strings = (
                'Stromquellen'
                'Dr'#228'jte'
                'Widerst'#228'nde'
                'Dioden'
                'Kondensatoren')
            end
          end
          object Panel5: TPanel
            Left = 1
            Top = 24
            Width = 175
            Height = 209
            Align = alTop
            Caption = 'Panel5'
            TabOrder = 1
            object ListBox1: TListBox
              Left = 1
              Top = 1
              Width = 173
              Height = 207
              Align = alClient
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Arial'
              Font.Style = []
              ItemHeight = 17
              ParentFont = False
              TabOrder = 0
              OnClick = ListBox1Click
              OnDrawItem = ListBox1DrawItem
            end
          end
          object Panel6: TPanel
            Left = 1
            Top = 236
            Width = 175
            Height = 114
            Align = alClient
            Caption = 'Panel6'
            TabOrder = 2
            object Panel7: TPanel
              Left = 1
              Top = 1
              Width = 173
              Height = 23
              Align = alTop
              AutoSize = True
              Caption = 'Panel7'
              TabOrder = 0
              object ComboBox2: TComboBox
                Left = 0
                Top = 1
                Width = 177
                Height = 21
                ItemHeight = 13
                TabOrder = 0
              end
            end
            object ListBox2: TListBox
              Left = 1
              Top = 24
              Width = 173
              Height = 89
              Align = alClient
              ItemHeight = 13
              TabOrder = 1
            end
          end
        end
        object Panel3: TPanel
          Left = 180
          Top = 0
          Width = 189
          Height = 351
          Align = alLeft
          Caption = 'Panel3'
          TabOrder = 1
          object JvInspector1: TJvInspector
            Left = 1
            Top = 1
            Width = 187
            Height = 349
            Align = alClient
            ItemHeight = 16
            TabStop = True
            TabOrder = 0
          end
        end
        object JvDesignScrollBox1: TJvDesignScrollBox
          Left = 373
          Top = 0
          Width = 472
          Height = 351
          Align = alClient
          TabOrder = 2
          object JvDesignPanel1: TJvDesignPanel
            Left = 0
            Top = 0
            Width = 468
            Height = 347
            Align = alClient
            Caption = 'JvDesignPanel1'
            TabOrder = 0
          end
        end
      end
    end
  end
  object Button1: TButton
    Left = 873
    Top = 398
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Schlie'#223'en'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 872
    Top = 72
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Berechnen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object MainMenu1: TMainMenu
    Left = 120
    Top = 8
    object Programm1: TMenuItem
      Caption = 'Programm'
      object DateiLaden1: TMenuItem
        Caption = 'Datei Laden ...'
        ShortCut = 16463
        OnClick = DateiLaden1Click
      end
      object DateiSpeichern1: TMenuItem
        Caption = 'Datei Speichern'
        ShortCut = 16467
        OnClick = DateiSpeichern1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Beenden1: TMenuItem
        Caption = 'Beenden'
        ShortCut = 16472
        OnClick = Beenden1Click
      end
    end
  end
  object SaveDialog1: TSaveDialog
    Filter = 'DATA|*.dat'
    Left = 152
    Top = 8
  end
  object OpenDialog1: TOpenDialog
    Filter = 'DATA *.dat|*-dat'
    Left = 176
    Top = 8
  end
  object JvDesignSurface1: TJvDesignSurface
    Left = 264
    Top = 8
  end
  object JvInspectorBorlandPainter1: TJvInspectorBorlandPainter
    CategoryFont.Charset = DEFAULT_CHARSET
    CategoryFont.Color = clBtnText
    CategoryFont.Height = -11
    CategoryFont.Name = 'MS Sans Serif'
    CategoryFont.Style = []
    NameFont.Charset = DEFAULT_CHARSET
    NameFont.Color = clWindowText
    NameFont.Height = -11
    NameFont.Name = 'MS Sans Serif'
    NameFont.Style = []
    ValueFont.Charset = DEFAULT_CHARSET
    ValueFont.Color = clNavy
    ValueFont.Height = -11
    ValueFont.Name = 'MS Sans Serif'
    ValueFont.Style = []
    DrawNameEndEllipsis = False
    Left = 296
    Top = 8
  end
end

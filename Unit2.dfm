object Form2: TForm2
  Left = 141
  Top = 266
  Width = 339
  Height = 159
  Caption = 'Form2'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 16
    Width = 148
    Height = 19
    Caption = 'Bereite Daten vor ...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ProgressBar1: TProgressBar
    Left = 24
    Top = 56
    Width = 273
    Height = 25
    TabOrder = 0
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 56
    Top = 56
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 250
    OnTimer = Timer2Timer
    Left = 168
    Top = 56
  end
end

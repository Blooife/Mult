object Form2: TForm2
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Form2'
  ClientHeight = 621
  ClientWidth = 887
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object MediaPlayer1: TMediaPlayer
    Left = 280
    Top = 296
    Width = 253
    Height = 30
    AutoOpen = True
    DoubleBuffered = True
    FileName = 'C:\Users\Asus\Downloads\INSTASAMKA_-_shake.mp3'
    Visible = False
    ParentDoubleBuffered = False
    TabOrder = 0
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 400
    OnTimer = Timer1Timer
    Left = 752
    Top = 528
  end
end

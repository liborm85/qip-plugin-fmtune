object frmBassPlayer: TfrmBassPlayer
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmBassPlayer'
  ClientHeight = 463
  ClientWidth = 434
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 168
    Top = 48
    Width = 12
    Height = 13
    Caption = '...'
  end
  object Label2: TLabel
    Left = 168
    Top = 72
    Width = 12
    Height = 13
    Caption = '...'
  end
  object Label3: TLabel
    Left = 168
    Top = 101
    Width = 12
    Height = 13
    Caption = '...'
  end
  object Label4: TLabel
    Left = 168
    Top = 120
    Width = 12
    Height = 13
    Caption = '...'
  end
  object Label5: TLabel
    Left = 168
    Top = 144
    Width = 12
    Height = 13
    Caption = '...'
  end
  object lblMeta: TLabel
    Left = 32
    Top = 184
    Width = 34
    Height = 13
    Caption = 'lblMeta'
  end
  object lvPlugins: TListView
    Left = 24
    Top = 256
    Width = 385
    Height = 185
    Columns = <
      item
        Width = 200
      end
      item
        Width = 100
      end
      item
      end>
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object Memo1: TMemo
    Left = 8
    Top = 25
    Width = 137
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object tmrLoadNowPlaying: TTimer
    Interval = 5000
    OnTimer = tmrLoadNowPlayingTimer
    Left = 248
    Top = 176
  end
end

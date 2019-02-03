object frmRecording: TfrmRecording
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Recording'
  ClientHeight = 123
  ClientWidth = 258
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblInfo: TLabel
    Left = 8
    Top = 8
    Width = 12
    Height = 13
    Caption = '...'
  end
  object lblVersion: TLabel
    Left = 8
    Top = 88
    Width = 78
    Height = 13
    Caption = 'version: 0.1.0.0'
  end
  object lblBuffer: TLabel
    Left = 8
    Top = 36
    Width = 34
    Height = 13
    Caption = 'Buffer:'
  end
  object lblInfo2: TLabel
    Left = 8
    Top = 60
    Width = 9
    Height = 13
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pbBuffer: TProgressBar
    Left = 48
    Top = 32
    Width = 200
    Height = 17
    Smooth = True
    SmoothReverse = True
    TabOrder = 0
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 106
    Width = 258
    Height = 17
    Panels = <>
    SimplePanel = True
    SizeGrip = False
  end
  object tbButtons: TToolBar
    Left = 177
    Top = 55
    Width = 73
    Height = 23
    Align = alNone
    Caption = 'tbButtons'
    Images = ilButtons
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    object tbtnRecord: TToolButton
      Left = 0
      Top = 0
      Hint = 'Record'
      ImageIndex = 0
      OnClick = tbtnRecordClick
    end
    object tbtnPause: TToolButton
      Left = 23
      Top = 0
      Hint = 'Pause'
      ImageIndex = 1
      OnClick = tbtnPauseClick
    end
    object tbtnStop: TToolButton
      Left = 46
      Top = 0
      Hint = 'Stop'
      ImageIndex = 2
      OnClick = tbtnStopClick
    end
  end
  object pnlInfo: TPanel
    Left = 230
    Top = 85
    Width = 16
    Height = 16
    BevelOuter = bvNone
    TabOrder = 3
    object imgInfo: TImage
      Left = 0
      Top = 0
      Width = 16
      Height = 16
      Align = alClient
      ExplicitLeft = 8
      ExplicitTop = 8
      ExplicitWidth = 105
      ExplicitHeight = 105
    end
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 104
    Top = 65520
  end
  object Timer: TTimer
    OnTimer = TimerTimer
    Left = 152
    Top = 65520
  end
  object ilButtons: TImageList
    Left = 200
    Top = 65520
  end
end

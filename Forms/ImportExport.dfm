object frmImportExport: TfrmImportExport
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Import/Export'
  ClientHeight = 382
  ClientWidth = 425
  Color = 16772829
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblFastSearch: TLabel
    Left = 16
    Top = 16
    Width = 60
    Height = 13
    Caption = 'Fast search:'
  end
  object lvStations: TListView
    Left = 6
    Top = 40
    Width = 412
    Height = 246
    Checkboxes = True
    Columns = <
      item
        Width = 380
      end>
    ReadOnly = True
    RowSelect = True
    ShowColumnHeaders = False
    TabOrder = 0
    ViewStyle = vsReport
  end
  object btnSelectAll: TButton
    Left = 108
    Top = 292
    Width = 100
    Height = 25
    Caption = 'Select All'
    TabOrder = 1
    OnClick = btnSelectAllClick
  end
  object btnUnselectAll: TButton
    Left = 214
    Top = 292
    Width = 100
    Height = 25
    Caption = 'Unselect All'
    TabOrder = 2
    OnClick = btnUnselectAllClick
  end
  object btnInvertSelection: TButton
    Left = 318
    Top = 292
    Width = 100
    Height = 25
    Caption = 'Invert selection'
    TabOrder = 3
    OnClick = btnInvertSelectionClick
  end
  object edtFastSearch: TEdit
    Left = 106
    Top = 13
    Width = 312
    Height = 21
    TabOrder = 4
    OnChange = edtFastSearchChange
  end
  object btnStart: TButton
    Left = 160
    Top = 347
    Width = 100
    Height = 25
    Caption = 'Start'
    TabOrder = 5
    OnClick = btnStartClick
  end
end

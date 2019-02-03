object frmOptions: TfrmOptions
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Options: ...'
  ClientHeight = 464
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BottomLine: TShape
    Left = -8
    Top = 425
    Width = 657
    Height = 40
    Brush.Color = 5525059
  end
  object lblPluginVersion: TLabel
    Left = 8
    Top = 436
    Width = 70
    Height = 13
    Caption = 'Version ?.?.?.?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object pnlCont: TPanel
    Left = 167
    Top = 8
    Width = 465
    Height = 416
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 5
    Visible = False
  end
  object pnlText: TPanel
    Left = 167
    Top = 8
    Width = 465
    Height = 25
    Caption = 'Unknown'
    Color = 5525059
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 6
  end
  object btnAbout: TBitBtn
    Left = 167
    Top = 431
    Width = 90
    Height = 25
    Caption = 'About plugin...'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 4
    OnClick = btnAboutClick
  end
  object btnOK: TBitBtn
    Left = 343
    Top = 431
    Width = 90
    Height = 25
    Caption = 'OK'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    Left = 439
    Top = 431
    Width = 90
    Height = 25
    Caption = 'Cancel'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object btnApply: TBitBtn
    Left = 535
    Top = 431
    Width = 90
    Height = 25
    Caption = 'Apply'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 3
    OnClick = btnApplyClick
  end
  object pgcOptions: TPageControl
    Left = 167
    Top = 39
    Width = 465
    Height = 386
    ActivePage = tsXStatus
    TabOrder = 7
    object tsGeneral: TTabSheet
      Caption = 'General'
      object gbUpdater: TGroupBox
        Left = 3
        Top = 3
        Width = 451
        Height = 94
        Caption = 'Updater'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object lblUpdaterInterval: TLabel
          Left = 28
          Top = 62
          Width = 42
          Height = 13
          Caption = 'Interval:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblUpdaterIntervalUnit: TLabel
          Left = 150
          Top = 62
          Width = 27
          Height = 13
          Caption = 'hours'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object chkUpdaterCheckingUpdates: TCheckBox
          Left = 15
          Top = 20
          Width = 255
          Height = 17
          Caption = 'Checking updates'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = chkUpdaterCheckingUpdatesClick
        end
        object edtUpdaterInterval: TEdit
          Left = 76
          Top = 59
          Width = 33
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          Text = '0'
        end
        object udUpdaterInterval: TUpDown
          Left = 127
          Top = 59
          Width = 17
          Height = 21
          Min = 1
          Max = 999
          Position = 1
          TabOrder = 2
          OnClick = udUpdaterIntervalClick
        end
        object btnUpdaterCheckUpdate: TBitBtn
          Left = 183
          Top = 57
          Width = 75
          Height = 25
          Caption = 'Check'
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 3
          OnClick = btnUpdaterCheckUpdateClick
        end
        object chkAnnounceBeta: TCheckBox
          Left = 28
          Top = 39
          Width = 129
          Height = 17
          Caption = 'Announce beta version'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
        end
      end
      object gbLanguage: TGroupBox
        Left = 3
        Top = 103
        Width = 451
        Height = 126
        Caption = 'Language'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object lblInfoTransAuthor: TLabel
          Left = 15
          Top = 44
          Width = 37
          Height = 13
          Caption = 'Author:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblInfoTransEmail: TLabel
          Left = 15
          Top = 63
          Width = 32
          Height = 13
          Caption = 'E-mail:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblTransAuthor: TLabel
          Left = 100
          Top = 44
          Width = 12
          Height = 13
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblTransEmail: TLabel
          Left = 100
          Top = 63
          Width = 12
          Height = 13
          Cursor = crHandPoint
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          OnClick = lblTransEmailClick
          OnMouseEnter = lblTransEmailMouseEnter
          OnMouseLeave = lblTransEmailMouseLeave
        end
        object lblInfoTransWeb: TLabel
          Left = 15
          Top = 82
          Width = 26
          Height = 13
          Caption = 'Web:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblTransURL: TLabel
          Left = 100
          Top = 82
          Width = 12
          Height = 13
          Cursor = crHandPoint
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          OnClick = lblTransURLClick
          OnMouseEnter = lblTransURLMouseEnter
          OnMouseLeave = lblTransURLMouseLeave
        end
        object lblLanguage: TLabel
          Left = 15
          Top = 25
          Width = 51
          Height = 13
          Caption = 'Language:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblLanguageVersion: TLabel
          Left = 223
          Top = 25
          Width = 12
          Height = 13
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblLanguageRem: TLabel
          Left = 15
          Top = 101
          Width = 27
          Height = 13
          Caption = 'pozn.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object cmbLangs: TComboBox
          Left = 99
          Top = 21
          Width = 106
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 0
          ParentFont = False
          TabOrder = 0
          OnChange = cmbLangsChange
        end
      end
    end
    object tsAdvanced: TTabSheet
      Caption = 'Advanced'
      ImageIndex = 1
      object gbAdvancedOptions: TGroupBox
        Left = 3
        Top = 3
        Width = 451
        Height = 150
        Caption = 'Options'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object chkEnableEqualizer: TCheckBox
          Left = 15
          Top = 57
          Width = 200
          Height = 17
          Caption = 'Enable Equalizer'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = chkEnableEqualizerClick
        end
        object btnEqualizerSetup: TButton
          Left = 36
          Top = 76
          Width = 133
          Height = 19
          Caption = 'Setup'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = btnEqualizerSetupClick
        end
        object chkUseQIPMute: TCheckBox
          Left = 15
          Top = 20
          Width = 215
          Height = 17
          Caption = 'Use QIP mute sound'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object chkPlayOnStart: TCheckBox
          Left = 15
          Top = 39
          Width = 200
          Height = 17
          Caption = 'Play on start'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
        end
        object chkSaveLastStream: TCheckBox
          Left = 15
          Top = 101
          Width = 200
          Height = 17
          Caption = 'Save last station stream'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object chkShowComments: TCheckBox
          Left = 15
          Top = 119
          Width = 200
          Height = 17
          Caption = 'Show comments'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
      end
      object gbAutomaticOnOffRadio: TGroupBox
        Left = 3
        Top = 159
        Width = 451
        Height = 196
        Caption = 'Automatic On and Off radio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object imgStatusLunch: TImage
          Left = 22
          Top = 156
          Width = 16
          Height = 16
        end
        object imgStatusAway: TImage
          Left = 236
          Top = 23
          Width = 16
          Height = 16
        end
        object imgStatusNA: TImage
          Left = 236
          Top = 45
          Width = 16
          Height = 16
        end
        object imgStatusOccupied: TImage
          Left = 236
          Top = 68
          Width = 16
          Height = 16
        end
        object imgStatusDND: TImage
          Left = 236
          Top = 90
          Width = 16
          Height = 16
        end
        object imgStatusOnline: TImage
          Left = 236
          Top = 112
          Width = 16
          Height = 16
        end
        object imgStatusOffline: TImage
          Left = 236
          Top = 156
          Width = 16
          Height = 16
        end
        object imgStatusFFC: TImage
          Left = 22
          Top = 45
          Width = 16
          Height = 16
        end
        object imgStatusEvil: TImage
          Left = 22
          Top = 68
          Width = 16
          Height = 16
        end
        object imgStatusDepres: TImage
          Left = 22
          Top = 90
          Width = 16
          Height = 16
        end
        object imgStatusAtHome: TImage
          Left = 22
          Top = 112
          Width = 16
          Height = 16
        end
        object imgStatusAtWork: TImage
          Left = 22
          Top = 134
          Width = 16
          Height = 16
        end
        object imgStatusInvisible: TImage
          Left = 236
          Top = 134
          Width = 16
          Height = 16
        end
        object chkStatusFFCAuto: TComboBox
          Left = 44
          Top = 43
          Width = 104
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 0
          ParentFont = False
          TabOrder = 0
        end
        object chkStatusEvilAuto: TComboBox
          Left = 44
          Top = 65
          Width = 104
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 0
          ParentFont = False
          TabOrder = 1
        end
        object chkStatusDepresAuto: TComboBox
          Left = 44
          Top = 87
          Width = 104
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 0
          ParentFont = False
          TabOrder = 2
        end
        object chkStatusAtHomeAuto: TComboBox
          Left = 44
          Top = 109
          Width = 104
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 0
          ParentFont = False
          TabOrder = 3
        end
        object chkStatusAtWorkAuto: TComboBox
          Left = 44
          Top = 131
          Width = 104
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 0
          ParentFont = False
          TabOrder = 4
        end
        object chkStatusLunchAuto: TComboBox
          Left = 44
          Top = 153
          Width = 104
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 0
          ParentFont = False
          TabOrder = 5
        end
        object chkStatusAwayAuto: TComboBox
          Left = 258
          Top = 20
          Width = 104
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 0
          ParentFont = False
          TabOrder = 6
        end
        object chkStatusNAAuto: TComboBox
          Left = 258
          Top = 43
          Width = 104
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 0
          ParentFont = False
          TabOrder = 7
        end
        object chkStatusOccupiedAuto: TComboBox
          Left = 258
          Top = 65
          Width = 104
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 0
          ParentFont = False
          TabOrder = 8
        end
        object chkStatusDNDAuto: TComboBox
          Left = 258
          Top = 87
          Width = 104
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 0
          ParentFont = False
          TabOrder = 9
        end
        object chkStatusOnlineAuto: TComboBox
          Left = 258
          Top = 109
          Width = 104
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 0
          ParentFont = False
          TabOrder = 10
        end
        object chkStatusInvisibleAuto: TComboBox
          Left = 258
          Top = 131
          Width = 104
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 0
          ParentFont = False
          TabOrder = 11
        end
        object chkStatusOfflineAuto: TComboBox
          Left = 258
          Top = 153
          Width = 104
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 0
          ParentFont = False
          TabOrder = 12
        end
        object chkAutoUseWherePlaying: TCheckBox
          Left = 15
          Top = 20
          Width = 222
          Height = 17
          Caption = 'Use where radio playing'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
        end
      end
    end
    object tsPopUp: TTabSheet
      Caption = 'PopUp'
      ImageIndex = 6
      object gbSetPopUp: TGroupBox
        Left = 3
        Top = 3
        Width = 451
        Height = 102
        Caption = 'gbSetPopUp'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object rbPopUpShowAsXStatus: TRadioButton
          Left = 28
          Top = 57
          Width = 416
          Height = 17
          Caption = 'Show as X-Status'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = rbPopUpShowAsXStatusClick
        end
        object rbPopUpPersonalSettings: TRadioButton
          Left = 28
          Top = 74
          Width = 416
          Height = 17
          Caption = 'Personal settings'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = rbPopUpPersonalSettingsClick
        end
        object chkShowPopups: TCheckBox
          Left = 15
          Top = 20
          Width = 426
          Height = 17
          Caption = 'Show popups'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = chkShowPopupsClick
        end
        object chkShowPopUpIfChangeInfo: TCheckBox
          Left = 28
          Top = 39
          Width = 386
          Height = 17
          Caption = 'Show popup window everytime, when any information is changed.'
          Checked = True
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 3
        end
      end
      object gbPopUp: TGroupBox
        Left = 3
        Top = 111
        Width = 451
        Height = 164
        Caption = 'gbPopUp'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object edtPopUp: TMemo
          Left = 22
          Top = 25
          Width = 330
          Height = 91
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object btnPopUpPreview: TBitBtn
          Left = 22
          Top = 122
          Width = 75
          Height = 25
          Caption = 'Preview'
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 1
          OnClick = btnPopUpPreviewClick
        end
        object btnPopUpTemplates: TBitBtn
          Left = 358
          Top = 25
          Width = 84
          Height = 25
          Caption = 'Templates'
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 2
          OnClick = btnPopUpTemplatesClick
        end
        object btnPopUpSyntax: TBitBtn
          Left = 358
          Top = 122
          Width = 84
          Height = 25
          Caption = 'Syntax'
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 3
          OnClick = btnSyntaxClick
        end
        object btnPopUpDefault: TBitBtn
          Left = 265
          Top = 122
          Width = 84
          Height = 25
          Caption = 'Default'
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 4
          OnClick = btnPopUpDefaultClick
        end
      end
    end
    object tsCL: TTabSheet
      Caption = 'Cont. List'
      ImageIndex = 2
      object gbSkin: TGroupBox
        Left = 3
        Top = 3
        Width = 451
        Height = 126
        Caption = 'Skin'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object lblInfoSkinAuthor: TLabel
          Left = 15
          Top = 48
          Width = 37
          Height = 13
          Caption = 'Author:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblInfoSkinEmail: TLabel
          Left = 15
          Top = 86
          Width = 32
          Height = 13
          Caption = 'E-mail:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblSkinAuthor: TLabel
          Left = 100
          Top = 48
          Width = 12
          Height = 13
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblSkinEmail: TLabel
          Left = 100
          Top = 86
          Width = 12
          Height = 13
          Cursor = crHandPoint
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          OnClick = lblSkinEmailClick
          OnMouseEnter = lblSkinEmailMouseEnter
          OnMouseLeave = lblSkinEmailMouseLeave
        end
        object lblInfoSkinWeb: TLabel
          Left = 15
          Top = 105
          Width = 26
          Height = 13
          Caption = 'Web:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblSkinWeb: TLabel
          Left = 100
          Top = 105
          Width = 12
          Height = 13
          Cursor = crHandPoint
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          OnClick = lblSkinWebClick
          OnMouseEnter = lblSkinWebMouseEnter
          OnMouseLeave = lblSkinWebMouseLeave
        end
        object lblInfoSkinVersion: TLabel
          Left = 15
          Top = 67
          Width = 39
          Height = 13
          Caption = 'Version:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblSkinVersion: TLabel
          Left = 100
          Top = 67
          Width = 14
          Height = 13
          Caption = '?.?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object cmbSkin: TComboBox
          Left = 15
          Top = 21
          Width = 145
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 0
          ParentFont = False
          TabOrder = 0
          OnChange = cmbSkinChange
        end
      end
      object gbSpecContact: TGroupBox
        Left = 3
        Top = 135
        Width = 451
        Height = 198
        Caption = 'Contact list'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object lblSpecCntLine1: TLabel
          Left = 33
          Top = 25
          Width = 32
          Height = 13
          Caption = 'Line 1:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object edtSpecCntLine1: TMemo
          Left = 83
          Top = 23
          Width = 257
          Height = 59
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object btnSpecCntDefault: TBitBtn
          Left = 256
          Top = 161
          Width = 84
          Height = 25
          Caption = 'Default'
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 1
          OnClick = btnSpecCntDefaultClick
        end
        object btnSpecCntLine1Templates: TBitBtn
          Left = 346
          Top = 19
          Width = 84
          Height = 25
          Caption = 'Templates'
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentDoubleBuffered = False
          ParentFont = False
          Style = bsNew
          TabOrder = 2
          OnClick = btnSpecCntLine1TemplatesClick
        end
        object btnSpecCntLine2Templates: TBitBtn
          Left = 346
          Top = 98
          Width = 84
          Height = 25
          Caption = 'Templates'
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 3
          OnClick = btnSpecCntLine2TemplatesClick
        end
        object btnSpecCntPreview: TBitBtn
          Left = 83
          Top = 161
          Width = 84
          Height = 25
          Caption = 'Preview'
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 4
          OnClick = btnSpecCntPreviewClick
        end
        object btnSpecCntSyntax: TBitBtn
          Left = 346
          Top = 161
          Width = 84
          Height = 25
          Caption = 'Syntax'
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 5
          OnClick = btnSyntaxClick
        end
        object edtSpecCntLine2: TMemo
          Left = 83
          Top = 96
          Width = 257
          Height = 59
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object chkSpecCntLine1ScrollText: TCheckBox
          Left = 346
          Top = 66
          Width = 89
          Height = 17
          Caption = 'Scroll text'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object chkSpecCntLine2ScrollText: TCheckBox
          Left = 346
          Top = 138
          Width = 89
          Height = 17
          Caption = 'Scroll text'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object chkSpecCntShowLine2: TCheckBox
          Left = 15
          Top = 97
          Width = 62
          Height = 17
          Caption = 'Line 2:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
        end
      end
    end
    object tsXStatus: TTabSheet
      Caption = 'X-Status'
      ImageIndex = 3
      object gbXStatus: TGroupBox
        Left = 3
        Top = 95
        Width = 451
        Height = 178
        Caption = 'X-Status:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object lblXStatusTitle: TLabel
          Left = 15
          Top = 25
          Width = 24
          Height = 13
          Caption = 'Title:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblXStatusText: TLabel
          Left = 15
          Top = 51
          Width = 26
          Height = 13
          Caption = 'Text:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object edtXStatusText: TMemo
          Left = 71
          Top = 48
          Width = 257
          Height = 89
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object edtXStatusTitle: TEdit
          Left = 71
          Top = 22
          Width = 257
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 20
          ParentFont = False
          TabOrder = 1
        end
        object btnXStatusDefault: TBitBtn
          Left = 244
          Top = 143
          Width = 84
          Height = 25
          Caption = 'Default'
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 2
          OnClick = btnXStatusDefaultClick
        end
        object btnXStatusTitleTemplates: TBitBtn
          Left = 334
          Top = 19
          Width = 84
          Height = 25
          Caption = 'Templates'
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentDoubleBuffered = False
          ParentFont = False
          Style = bsNew
          TabOrder = 3
          OnClick = btnXStatusTitleTemplatesClick
          OnMouseDown = btnXStatusTitleTemplatesMouseDown
        end
        object btnXStatusTextTemplates: TBitBtn
          Left = 334
          Top = 50
          Width = 84
          Height = 25
          Caption = 'Templates'
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 4
          OnClick = btnXStatusTextTemplatesClick
          OnMouseDown = btnXStatusTextTemplatesMouseDown
        end
        object btnXStatusPreview: TBitBtn
          Left = 69
          Top = 143
          Width = 84
          Height = 25
          Caption = 'Preview'
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 5
          OnClick = btnXStatusPreviewClick
        end
        object btnSyntax: TBitBtn
          Left = 334
          Top = 143
          Width = 84
          Height = 25
          Caption = 'Syntaxe'
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 6
          OnClick = btnSyntaxClick
        end
      end
      object gbXStatusOptions: TGroupBox
        Left = 3
        Top = 3
        Width = 451
        Height = 86
        Caption = 'gbXStatusOptions'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object rbChangeIfAny: TRadioButton
          Left = 28
          Top = 57
          Width = 408
          Height = 17
          Caption = 'Change with any X-Status'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object rbChangeIfMusic: TRadioButton
          Left = 28
          Top = 39
          Width = 408
          Height = 17
          Caption = 'Change content if X-Status is "Music"'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object chkEnableXStatus: TCheckBox
          Left = 15
          Top = 20
          Width = 171
          Height = 17
          Caption = 'Enable X-Status'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = chkEnableXStatusClick
        end
      end
    end
    object tsHotKeys: TTabSheet
      Caption = 'Hot Keys'
      ImageIndex = 6
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object gbHotKeys: TGroupBox
        Left = 3
        Top = 3
        Width = 451
        Height = 193
        Caption = 'Hot Keys'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object lblHotKeyFMtune: TLabel
          Left = 15
          Top = 43
          Width = 40
          Height = 13
          Caption = 'FMtune:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblHotKeyMute: TLabel
          Left = 15
          Top = 103
          Width = 28
          Height = 13
          Caption = 'Mute:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblHotKeyVolumeUp: TLabel
          Left = 15
          Top = 63
          Width = 54
          Height = 13
          Caption = 'Volume Up:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblHotKeyVolumeDown: TLabel
          Left = 15
          Top = 83
          Width = 68
          Height = 13
          Caption = 'Volume Down:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblHotKeyStationPrev: TLabel
          Left = 15
          Top = 143
          Width = 63
          Height = 13
          Caption = 'Station Prev:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblHotKeyStationNext: TLabel
          Left = 15
          Top = 123
          Width = 64
          Height = 13
          Caption = 'Station Next:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblHotKeyEnableDisableXStatus: TLabel
          Left = 15
          Top = 163
          Width = 118
          Height = 13
          Caption = 'Enable/Disable X-Status:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object HotKey1: THotKey
          Left = 170
          Top = 43
          Width = 121
          Height = 19
          HotKey = 0
          Modifiers = []
          TabOrder = 0
          OnEnter = GetOffHotKey
          OnExit = GetHotKeysActivate
        end
        object chkUseHotKeys: TCheckBox
          Left = 15
          Top = 20
          Width = 426
          Height = 17
          Caption = 'Use Hot Keys'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = chkUseHotKeysClick
        end
        object HotKey2: THotKey
          Left = 170
          Top = 103
          Width = 121
          Height = 19
          HotKey = 0
          Modifiers = []
          TabOrder = 2
          OnEnter = GetOffHotKey
          OnExit = GetHotKeysActivate
        end
        object HotKey3: THotKey
          Left = 170
          Top = 63
          Width = 121
          Height = 19
          HotKey = 0
          Modifiers = []
          TabOrder = 3
          OnEnter = GetOffHotKey
          OnExit = GetHotKeysActivate
        end
        object HotKey4: THotKey
          Left = 170
          Top = 83
          Width = 121
          Height = 19
          HotKey = 0
          Modifiers = []
          TabOrder = 4
          OnEnter = GetOffHotKey
          OnExit = GetHotKeysActivate
        end
        object HotKey5: THotKey
          Left = 170
          Top = 123
          Width = 121
          Height = 19
          HotKey = 0
          Modifiers = []
          TabOrder = 5
          OnEnter = GetOffHotKey
          OnExit = GetHotKeysActivate
        end
        object HotKey6: THotKey
          Left = 170
          Top = 143
          Width = 121
          Height = 19
          HotKey = 0
          Modifiers = []
          TabOrder = 6
          OnEnter = GetOffHotKey
          OnExit = GetHotKeysActivate
        end
        object HotKey7: THotKey
          Left = 170
          Top = 163
          Width = 121
          Height = 19
          HotKey = 0
          Modifiers = []
          TabOrder = 7
          OnEnter = GetOffHotKey
          OnExit = GetHotKeysActivate
        end
      end
    end
    object tsExtSources: TTabSheet
      Caption = 'Ext. sources'
      ImageIndex = 7
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object gbExtSourceOptions: TGroupBox
        Left = 3
        Top = 3
        Width = 451
        Height = 86
        Caption = 'Options'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object chkLoadSongsExternal: TCheckBox
          Left = 15
          Top = 20
          Width = 410
          Height = 17
          Caption = 'Load songs from external sources'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object chkShowCovers: TCheckBox
          Left = 15
          Top = 39
          Width = 410
          Height = 17
          Caption = 'Show cover of song'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = chkShowCoversClick
        end
        object chkSaveCovers: TCheckBox
          Left = 28
          Top = 57
          Width = 410
          Height = 17
          Caption = 'Save cover of song to directory'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
      end
    end
    object tsConnection: TTabSheet
      Caption = 'Connection'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object gbProxy: TGroupBox
        Left = 3
        Top = 3
        Width = 451
        Height = 134
        Caption = 'Proxy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object lblProxyServerInfo: TLabel
          Left = 28
          Top = 105
          Width = 120
          Height = 13
          Caption = '[user:pass@]server:port'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object edtProxyServer: TEdit
          Left = 28
          Top = 78
          Width = 412
          Height = 21
          TabOrder = 0
        end
        object rbProxyQIPConf: TRadioButton
          Left = 15
          Top = 38
          Width = 373
          Height = 15
          Caption = 'Configuration as QIP'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = rbProxyQIPConfClick
        end
        object rbProxyManualConf: TRadioButton
          Left = 15
          Top = 57
          Width = 373
          Height = 15
          Caption = 'Maual configuration'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = rbProxyManualConfClick
        end
        object rbNoProxy: TRadioButton
          Left = 15
          Top = 20
          Width = 373
          Height = 15
          Caption = 'I have direct connection to the Internet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = rbNoProxyClick
        end
      end
    end
  end
  object lstMenu: TListBox
    Left = 8
    Top = 8
    Width = 153
    Height = 416
    TabStop = False
    Style = lbOwnerDrawFixed
    DoubleBuffered = False
    ExtendedSelect = False
    ItemHeight = 25
    ParentDoubleBuffered = False
    TabOrder = 0
    OnClick = lstMenuClick
    OnDrawItem = lstMenuDrawItem
    OnMouseDown = lstMenuMouseDown
  end
  object pmTemplates: TPopupMenu
    Images = ImageList1
    OwnerDraw = True
    Left = 96
    Top = 368
    object miTemplates_Values: TMenuItem
      Caption = 'Values'
      OnClick = miTemplates_ValuesClick
      OnDrawItem = DrawMenu
      OnMeasureItem = MeasureMenu
    end
    object miTemplates_Texts: TMenuItem
      Caption = 'Texts'
      OnClick = miTemplates_TextsClick
      OnDrawItem = DrawMenu
      OnMeasureItem = MeasureMenu
    end
    object miTemplates_CapitalFollowingLetter: TMenuItem
      Caption = 'Capital following letter  (%^%)'
      Visible = False
      OnClick = miTemplates_CapitalFollowingLetterClick
      OnDrawItem = DrawMenu
      OnMeasureItem = MeasureMenu
    end
  end
  object ImageList1: TImageList
    Left = 24
    Top = 328
    Bitmap = {
      494C010101000800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      00000000001500000030020100400100003E0000002700000006000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000160D06
      0673542A09C08E511DE3B96614F3AB590DF07D410CDA28150895000000180000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000103A1E0CABDE81
      29FFFFB767FFFFB566FFF39A41FFE47D16FFE17406FFDF750EFF2C1705860000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001309055EE48021FFFFC7
      84FFF3A75AFFD6700AFFD26B03FFD46E08FFD46F09FFE07408FF824408C30000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000021121170F18B22FFFFC9
      8DFFDF7D1DFFD16902FFD56F09FFD56F09FFD46E09FFE07508FF3A1E007C0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000603011BA75504CDEE96
      3FFFEA8E33FFD56D05FFDF7409FFD77009FFD77008FFC7680EF80C06032A0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000C060010582C
      01698545059B924B07AB532B059BA95706E9E57705FF713D1BC4000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000C060150CD6A07FAE27508FF24130E6A000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000D773D07CCE47708FFBC620FF20301011B000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000150B0469DC7209FFE17508FF5A2F0DA900000000000000020000
      00080000000F0000001700000007000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000127E410ED4DF7409FFDC7209FF3E200AA3140B016F21120289301A
      04993F2512AD542D15C30D070655000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000180C0770DD7309FFD66F09FFD46E08FFCC6907FCDE7813FFEE841AFFF68C
      24FFFDA64EFFFFAA4DFF341A0476000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0017864711DBE07408FFD46E09FFD56F09FFD66F08FFD56E07FFD36D07FFCF68
      01FFE37F1AFFD88740F70503042D000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002010
      077BE07408FFD56F09FFD56F09FFD56F09FFD56F09FFD56F09FFD46E08FFD36C
      06FFEC8318FF854C1ECB00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000038546
      17DAE07407FFD46F09FFD56F09FFD26D08FCCE6B08F7C86808F0B96006DFA656
      06C89D5207B22F18015300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000013E22
      1269713B01824F290360361C0242281401301E100125140A00190904000B0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
end

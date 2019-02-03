unit Options;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, Menus, ImgList;

type
  TfrmOptions = class(TForm)
    pnlCont: TPanel;
    pnlText: TPanel;
    lblPluginVersion: TLabel;
    btnAbout: TBitBtn;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    btnApply: TBitBtn;
    pgcOptions: TPageControl;
    tsGeneral: TTabSheet;
    tsAdvanced: TTabSheet;
    tsCL: TTabSheet;
    tsXStatus: TTabSheet;
    tsConnection: TTabSheet;
    gbUpdater: TGroupBox;
    chkUpdaterCheckingUpdates: TCheckBox;
    lblUpdaterInterval: TLabel;
    edtUpdaterInterval: TEdit;
    udUpdaterInterval: TUpDown;
    lblUpdaterIntervalUnit: TLabel;
    btnUpdaterCheckUpdate: TBitBtn;
    gbProxy: TGroupBox;
    lblProxyServerInfo: TLabel;
    edtProxyServer: TEdit;
    pmTemplates: TPopupMenu;
    miTemplates_Values: TMenuItem;
    miTemplates_Texts: TMenuItem;
    miTemplates_CapitalFollowingLetter: TMenuItem;
    chkEnableXStatus: TCheckBox;
    rbChangeIfMusic: TRadioButton;
    rbChangeIfAny: TRadioButton;
    gbXStatus: TGroupBox;
    lblXStatusTitle: TLabel;
    lblXStatusText: TLabel;
    edtXStatusText: TMemo;
    edtXStatusTitle: TEdit;
    btnXStatusDefault: TBitBtn;
    btnXStatusTitleTemplates: TBitBtn;
    btnXStatusTextTemplates: TBitBtn;
    gbSkin: TGroupBox;
    lblInfoSkinAuthor: TLabel;
    lblInfoSkinEmail: TLabel;
    lblSkinAuthor: TLabel;
    lblSkinEmail: TLabel;
    lblInfoSkinWeb: TLabel;
    lblSkinWeb: TLabel;
    cmbSkin: TComboBox;
    chkUseQIPMute: TCheckBox;
    chkPlayOnStart: TCheckBox;
    chkEnableEqualizer: TCheckBox;
    tsHotKeys: TTabSheet;
    gbHotKeys: TGroupBox;
    lblHotKeyFMtune: TLabel;
    lblHotKeyMute: TLabel;
    lblHotKeyVolumeUp: TLabel;
    lblHotKeyVolumeDown: TLabel;
    HotKey1: THotKey;
    chkUseHotKeys: TCheckBox;
    HotKey2: THotKey;
    HotKey3: THotKey;
    HotKey4: THotKey;
    gbLanguage: TGroupBox;
    lblInfoTransAuthor: TLabel;
    lblInfoTransEmail: TLabel;
    lblTransAuthor: TLabel;
    lblTransEmail: TLabel;
    lblInfoTransWeb: TLabel;
    lblTransURL: TLabel;
    lblLanguage: TLabel;
    lstMenu: TListBox;
    btnEqualizerSetup: TButton;
    lblInfoSkinVersion: TLabel;
    lblSkinVersion: TLabel;
    BottomLine: TShape;
    lblLanguageVersion: TLabel;
    gbAdvancedOptions: TGroupBox;
    gbXStatusOptions: TGroupBox;
    cmbLangs: TComboBox;
    chkAnnounceBeta: TCheckBox;
    lblLanguageRem: TLabel;
    gbAutomaticOnOffRadio: TGroupBox;
    imgStatusLunch: TImage;
    imgStatusAway: TImage;
    imgStatusNA: TImage;
    imgStatusOccupied: TImage;
    imgStatusDND: TImage;
    imgStatusOnline: TImage;
    imgStatusOffline: TImage;
    imgStatusFFC: TImage;
    imgStatusEvil: TImage;
    imgStatusDepres: TImage;
    imgStatusAtHome: TImage;
    imgStatusAtWork: TImage;
    imgStatusInvisible: TImage;
    chkStatusFFCAuto: TComboBox;
    chkStatusEvilAuto: TComboBox;
    chkStatusDepresAuto: TComboBox;
    chkStatusAtHomeAuto: TComboBox;
    chkStatusAtWorkAuto: TComboBox;
    chkStatusLunchAuto: TComboBox;
    chkStatusAwayAuto: TComboBox;
    chkStatusNAAuto: TComboBox;
    chkStatusOccupiedAuto: TComboBox;
    chkStatusDNDAuto: TComboBox;
    chkStatusOnlineAuto: TComboBox;
    chkStatusInvisibleAuto: TComboBox;
    chkStatusOfflineAuto: TComboBox;
    chkAutoUseWherePlaying: TCheckBox;
    ImageList1: TImageList;
    HotKey5: THotKey;
    HotKey6: THotKey;
    lblHotKeyStationPrev: TLabel;
    lblHotKeyStationNext: TLabel;
    btnXStatusPreview: TBitBtn;
    btnSyntax: TBitBtn;
    chkSaveLastStream: TCheckBox;
    lblHotKeyEnableDisableXStatus: TLabel;
    HotKey7: THotKey;
    chkShowComments: TCheckBox;
    tsPopUp: TTabSheet;
    gbSetPopUp: TGroupBox;
    rbPopUpShowAsXStatus: TRadioButton;
    rbPopUpPersonalSettings: TRadioButton;
    chkShowPopups: TCheckBox;
    gbPopUp: TGroupBox;
    edtPopUp: TMemo;
    btnPopUpPreview: TBitBtn;
    btnPopUpTemplates: TBitBtn;
    btnPopUpSyntax: TBitBtn;
    btnPopUpDefault: TBitBtn;
    chkShowPopUpIfChangeInfo: TCheckBox;
    gbSpecContact: TGroupBox;
    lblSpecCntLine1: TLabel;
    edtSpecCntLine1: TMemo;
    btnSpecCntDefault: TBitBtn;
    btnSpecCntLine1Templates: TBitBtn;
    btnSpecCntLine2Templates: TBitBtn;
    btnSpecCntPreview: TBitBtn;
    btnSpecCntSyntax: TBitBtn;
    edtSpecCntLine2: TMemo;
    chkSpecCntLine1ScrollText: TCheckBox;
    chkSpecCntLine2ScrollText: TCheckBox;
    chkSpecCntShowLine2: TCheckBox;
    tsExtSources: TTabSheet;
    gbExtSourceOptions: TGroupBox;
    chkLoadSongsExternal: TCheckBox;
    chkShowCovers: TCheckBox;
    chkSaveCovers: TCheckBox;
    rbProxyQIPConf: TRadioButton;
    rbProxyManualConf: TRadioButton;
    rbNoProxy: TRadioButton;
    procedure btnAboutClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnApplyClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure miTemplates_ValuesClick(Sender: TObject);
    procedure miTemplates_TextsClick(Sender: TObject);
    procedure miTemplates_CapitalFollowingLetterClick(Sender: TObject);
    procedure cmbSkinChange(Sender: TObject);
    procedure udUpdaterIntervalClick(Sender: TObject; Button: TUDBtnType);
    procedure lblSkinEmailClick(Sender: TObject);
    procedure lblTransEmailClick(Sender: TObject);
    procedure lblTransURLClick(Sender: TObject);
    procedure lblSkinWebClick(Sender: TObject);
    procedure btnXStatusDefaultClick(Sender: TObject);
    procedure btnUpdaterCheckUpdateClick(Sender: TObject);
    procedure lstMenuClick(Sender: TObject);
    procedure btnEqualizerSetupClick(Sender: TObject);
    procedure chkEnableEqualizerClick(Sender: TObject);
    procedure lstMenuDrawItem(Control: TWinControl; Index: Integer; Rect: TRect;
      State: TOwnerDrawState);

    procedure MeasureMenu(Sender: TObject;
      ACanvas: TCanvas; var Width, Height: Integer);
    procedure DrawMenu(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
    procedure cmbLangsChange(Sender: TObject);
    procedure GetOffHotKey(Sender: TObject);
    procedure GetHotKeysActivate(Sender: TObject);
    procedure btnXStatusPreviewClick(Sender: TObject);
    procedure btnSyntaxClick(Sender: TObject);
    procedure lstMenuMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure rbPopUpPersonalSettingsClick(Sender: TObject);
    procedure rbPopUpShowAsXStatusClick(Sender: TObject);
    procedure btnPopUpPreviewClick(Sender: TObject);
    procedure chkShowPopupsClick(Sender: TObject);
    procedure btnXStatusTitleTemplatesMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnXStatusTextTemplatesMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnPopUpDefaultClick(Sender: TObject);
    procedure btnXStatusTitleTemplatesClick(Sender: TObject);
    procedure btnXStatusTextTemplatesClick(Sender: TObject);
    procedure btnPopUpTemplatesClick(Sender: TObject);
    procedure chkEnableXStatusClick(Sender: TObject);
    procedure btnSpecCntLine1TemplatesClick(Sender: TObject);
    procedure btnSpecCntLine2TemplatesClick(Sender: TObject);
    procedure btnSpecCntPreviewClick(Sender: TObject);
    procedure btnSpecCntDefaultClick(Sender: TObject);
    procedure lblSkinEmailMouseEnter(Sender: TObject);
    procedure lblSkinWebMouseEnter(Sender: TObject);
    procedure lblSkinWebMouseLeave(Sender: TObject);
    procedure lblSkinEmailMouseLeave(Sender: TObject);
    procedure lblTransEmailMouseEnter(Sender: TObject);
    procedure lblTransEmailMouseLeave(Sender: TObject);
    procedure lblTransURLMouseLeave(Sender: TObject);
    procedure lblTransURLMouseEnter(Sender: TObject);
    procedure chkShowCoversClick(Sender: TObject);
    procedure PridejMenu;
    procedure chkUseProxyServerClick(Sender: TObject);
    procedure rbProxyManualConfClick(Sender: TObject);
    procedure rbProxyQIPConfClick(Sender: TObject);
    procedure rbNoProxyClick(Sender: TObject);
    procedure chkUseHotKeysClick(Sender: TObject);
    procedure chkUpdaterCheckingUpdatesClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure ShowSkinInfo;
    procedure ShowLanguageInfo;
  end;

var
  frmOptions: TfrmOptions;

  TemplatesValues  : TStringList;
  TemplatesValuesInfo  : TStringList;
  pmTemplates_Type : Integer;
  TemplatesTexts   : TStringList;
  TemplatesTextsInfo : TStringList;

implementation

uses General, IniFiles, UpdaterUnit, TextSearch, Convs, Drawing,
     u_lang_ids,
     u_qip_plugin,
     uLNG,
     uSuperReplace,
     uToolTip,
     uComments,
     uTheme,
     uEqualizer,
     uLinks,
     uINI,
     uImage,
     uIcon;

{$R *.dfm}


procedure TfrmOptions.udUpdaterIntervalClick(Sender: TObject;
  Button: TUDBtnType);
begin
  edtUpdaterInterval.Text := IntToStr( udUpdaterInterval.Position );
end;

procedure TfrmOptions.ShowSkinInfo;
var sAuthor, sEmail, sURL, sTrans, sTransInfo, sVersion: WideString;
    iFS, iFS1, iFS2: Integer;
    INI : TIniFile;
begin

  INI := TiniFile.Create(PluginDllPath +
                         'Skins\' + cmbSkin.Text + '\skin.ini');

  sTrans := INIReadStringUTF8(INI, 'Info', 'Author', LNG('Texts','unknown', 'unknown'));
  sVersion := INIReadStringUTF8(INI, 'Info', 'Version', LNG('Texts','unknown', 'unknown'));

  INIFree(INI);

  iFS := StrPosE(sTrans,' [',1,False);
  sAuthor := Copy(sTrans, 1, iFS);

  sTransInfo := FoundStr(sTrans, ' [', ']', 1, iFS, iFS1, iFS2);

  sEmail := FoundStr(sTransInfo, 'EMAIL="', '"', 1, iFS, iFS1, iFS2);
  sURL := FoundStr(sTransInfo, 'URL="', '"', 1, iFS, iFS1, iFS2);

  lblSkinAuthor.Caption  := sAuthor;
  lblSkinVersion.Caption := sVersion;

  sEmail := Trim(sEmail);
  sURL := Trim(sURL);

  if sEmail<>'' then
    begin
      lblSkinEmail.Enabled   := True;
      lblSkinEmail.Caption   := sEmail;
    end
  else
    begin
      lblSkinEmail.Enabled   := False;
      lblSkinEmail.Caption   := LNG('Texts','unknown', 'unknown');
    end;

  if sURL<>'' then
    begin
      lblSkinWeb.Enabled   := True;
      lblSkinWeb.Caption   := sURL;
    end
  else
    begin
      lblSkinWeb.Enabled   := False;
      lblSkinWeb.Caption   := LNG('Texts','unknown', 'unknown');
    end;

end;

procedure TfrmOptions.ShowLanguageInfo;
var sAuthor, sEmail, sURL, sTrans, sTransInfo, sVersion, sLang: WideString;
    iFS, iFS1, iFS2: Integer;
    INI : TIniFile;
begin
  if Copy(cmbLangs.Text,1,1)='<' then
    INI := TIniFile.Create(PluginDllPath +
                         'Langs\' + QIPInfiumLanguage + '.lng')
  else
    INI := TIniFile.Create(PluginDllPath +
                         'Langs\' + cmbLangs.Text + '.lng');

  sTrans := INIReadStringUTF8(INI, 'Info', 'Translator', LNG('Texts','unknown', 'unknown'));
  sVersion := INIReadStringUTF8(INI, 'Info', 'Version', '0.0.0');

  INIFree(INI);

  sLang := PluginLanguage;
  PluginLanguage := cmbLangs.Text;
  if sVersion < PluginVersionWithoutBuild then
    lblLanguageVersion.Caption := '(' + LNG('FORM Options', 'Language.VersionError', 'version of translation is not actual') + ')'
  else
    lblLanguageVersion.Caption := '';
  PluginLanguage := sLang;

  lblLanguageVersion.Left := cmbLangs.Left + cmbLangs.Width + 4;

  iFS := StrPosE(sTrans,' [',1,False);
  sAuthor := Copy(sTrans, 1, iFS);

  sTransInfo := FoundStr(sTrans, ' [', ']', 1, iFS, iFS1, iFS2);

  sEmail := FoundStr(sTransInfo, 'EMAIL="', '"', 1, iFS, iFS1, iFS2);
  sURL := FoundStr(sTransInfo, 'URL="', '"', 1, iFS, iFS1, iFS2);

  lblTransAuthor.Caption  :=  sAuthor;


  sEmail := Trim(sEmail);
  sURL := Trim(sURL);

  if sEmail<>'' then
    begin
      lblTransEmail.Enabled   := True;
      lblTransEmail.Caption   := sEmail;
    end
  else
    begin
      lblTransEmail.Enabled   := False;
      lblTransEmail.Caption   := LNG('Texts','unknown', 'unknown');
    end;

  if sURL<>'' then
    begin
      lblTransURL.Enabled   := True;
      lblTransURL.Caption   := sURL;
    end
  else
    begin
      lblTransURL.Enabled   := False;
      lblTransURL.Caption   := LNG('Texts','unknown', 'unknown');
    end;
end;


procedure TfrmOptions.btnAboutClick(Sender: TObject);
begin
  OpenAbout;
end;

procedure TfrmOptions.btnApplyClick(Sender: TObject);
var
  INI : TIniFile;
  ActualMenu: Integer;

begin

  (* X-Status *)
  XStatus_Boolean := chkEnableXStatus.Checked;
    EnDisXStatus(BoolToInt(XStatus_Boolean), XSTATUS_MODE_SILENCE);

  if rbChangeIfMusic.Checked = True then
    XStatus_Type := 1
  else
    XStatus_Type := 2;

  if not (XStatus_Title = edtXStatusTitle.Text) then
    ChangeXStatus := True;
  if not (XStatus_Text = edtXStatusText.Text) then
    ChangeXStatus := True;

  XStatus_Title := edtXStatusTitle.Text;
  XStatus_Text := edtXStatusText.Text;
  (* *)



  if rbPopUpShowAsXStatus.Checked = True then
    PopupType := 1
  else
    PopupType := 2;

  ShowPopups := chkShowPopups.Checked;
  PopupText := edtPopup.Text;
  ShowPopUpIfChangeInfo := chkShowPopUpIfChangeInfo.Checked;

  UseQIPMute := chkUseQIPMute.Checked;
  ShowComments := chkShowComments.Checked;
  LoadSongsExternal := chkLoadSongsExternal.Checked;
  ShowCover := chkShowCovers.Checked;
  SaveCover := chkSaveCovers.Checked;
  if (not LoadSongsExternal) and RadioExternalInfo then
  begin
    iSong := '';
    iBitrate := '';
    iRadio := LNG('PLAYER', 'Connecting', 'Connecting...');
    iCover := '';
    CoverFile := iCover;
  end;

  SaveLastStream := chkSaveLastStream.Checked;


  if rbNoProxy.Checked = True then
    Proxy_Mode := 0
  else
  if rbProxyQIPConf.Checked = True then
    Proxy_Mode := 1
  else
  if rbProxyManualConf.Checked = True then
    Proxy_Mode  := 2;
  Proxy_Server  := edtProxyServer.Text;

  PlayOnStart := chkPlayOnStart.Checked;
  EqualizerEnabled := chkEnableEqualizer.Checked;

  CheckUpdates := chkUpdaterCheckingUpdates.Checked;
  CheckBetaUpdates := chkAnnounceBeta.Checked;
  CheckUpdatesInterval := ConvStrToInt( edtUpdaterInterval.Text );
  PluginLanguage := cmbLangs.Text;

  HotKeyEnabled := chkUseHotKeys.Checked;

  AutoStatusFFC := chkStatusFFCAuto.ItemIndex;
  AutoStatusEvil := chkStatusEvilAuto.ItemIndex;
  AutoStatusDepres := chkStatusDepresAuto.ItemIndex;
  AutoStatusAtHome := chkStatusAtHomeAuto.ItemIndex;
  AutoStatusAtWork := chkStatusAtWorkAuto.ItemIndex;
  AutoStatusLunch := chkStatusLunchAuto.ItemIndex;
  AutoStatusAway := chkStatusAwayAuto.ItemIndex;
  AutoStatusNA := chkStatusNAAuto.ItemIndex;
  AutoStatusOccupied := chkStatusOccupiedAuto.ItemIndex;
  AutoStatusDND := chkStatusDNDAuto.ItemIndex;
  AutoStatusOnline := chkStatusOnlineAuto.ItemIndex;
  AutoStatusInvisible := chkStatusInvisibleAuto.ItemIndex;
  AutoStatusOffline := chkStatusOfflineAuto.ItemIndex;

  AutoUseWherePlaying := chkAutoUseWherePlaying.Checked;

  SpecCntLine1Text := edtSpecCntLine1.Text;
  SpecCntLine2Text := edtSpecCntLine2.Text;

  SpecCntLine1ScrollText := chkSpecCntLine1ScrollText.Checked;
  SpecCntLine2ScrollText := chkSpecCntLine2ScrollText.Checked;

  SpecCntShowLine2 := chkSpecCntShowLine2.Checked;

  HotKeyFMtune := HotKey1.HotKey;
  HotKeyVolumeUp   := HotKey3.HotKey;
  HotKeyVolumeDown := HotKey4.HotKey;
  HotKeyMute   := HotKey2.HotKey;
  HotKeyStationNext := HotKey5.HotKey;
  HotKeyStationPrev := HotKey6.HotKey;
  HotKeyEnableDisableXStatus := HotKey7.HotKey;

  INIGetProfileConfig(INI);

  INIWriteBool(INI, 'Conf', 'CheckUpdates', CheckUpdates);
  INIWriteInteger(INI, 'Conf', 'CheckUpdatesInterval', CheckUpdatesInterval);
  INIWriteBool(INI, 'Conf', 'CheckBetaUpdates', CheckBetaUpdates);
  INIWriteStringUTF8(INI, 'Conf', 'Language', PluginLanguage);

  PluginTheme.Name := cmbSkin.Text;

  INIWriteStringUTF8(INI, 'Conf', 'Skin', PluginTheme.Name );

  OpenTheme;

  INIWriteBool(INI, 'Conf', 'UseQIPMute', UseQIPMute);
  INIWriteBool(INI, 'Conf', 'PlayOnStart', PlayOnStart);
  INIWriteBool(INI, 'Conf', 'SaveLastStream', SaveLastStream);
  INIWriteBool(INI, 'Conf', 'ShowComments', ShowComments);
  INIWriteBool(INI, 'Conf', 'LoadSongsExternal', LoadSongsExternal);
  INIWriteBool(INI, 'Conf', 'ShowCover', ShowCover);
  INIWriteBool(INI, 'Conf', 'SaveCover', SaveCover);

  INIWriteBool(INI, 'Conf', 'HotKey', HotKeyEnabled);
  INIWriteInteger(INI, 'Conf', 'HotKeyFMtune',               HotKeyFMtune) ;
  INIWriteInteger(INI, 'Conf', 'HotKeyVolumeUp',             HotKeyVolumeUp) ;
  INIWriteInteger(INI, 'Conf', 'HotKeyVolumeDown',           HotKeyVolumeDown) ;
  INIWriteInteger(INI, 'Conf', 'HotKeyMute',                 HotKeyMute) ;
  INIWriteInteger(INI, 'Conf', 'HotKeyStationNext',          HotKeyStationNext) ;
  INIWriteInteger(INI, 'Conf', 'HotKeyStationPrev',          HotKeyStationPrev) ;
  INIWriteInteger(INI, 'Conf', 'HotKeyEnableDisableXStatus', HotKeyEnableDisableXStatus) ;

  INIWriteBool(INI, 'XStatus', 'Enabled', XStatus_Boolean);
  INIWriteInteger(INI, 'XStatus', 'Type', XStatus_Type);

  INIWriteStringUTF8(INI, 'XStatus', 'Title', XStatus_Title );
  INIWriteStringUTF8(INI, 'XStatus', 'Text', XStatus_Text );

  INIWriteBool(INI, 'Popup', 'Enabled', ShowPopups);
  INIWriteInteger(INI, 'Popup', 'Type', PopupType);
  INIWriteStringUTF8(INI, 'Popup', 'Text', PopupText );
  INIWriteBool(INI, 'Popup', 'ShowPopUpIfChangeInfo', ShowPopUpIfChangeInfo);

  INIWriteInteger(INI, 'Proxy', 'Mode', Proxy_Mode);
  case Proxy_Mode of
  0,
  1: ;
  2: INIWriteStringUTF8(INI, 'Proxy', 'Server', Proxy_Server );
  end;


  INIWriteBool(INI, 'Equalizer', 'Enabled', EqualizerEnabled);

  INIWriteBool(INI, 'Conf', 'AutoOnOffUseWherePlaying', AutoUseWherePlaying);
  INIWriteInteger(INI, 'Conf', 'AutoOnOffFFC',  AutoStatusFFC  );
  INIWriteInteger(INI, 'Conf', 'AutoOnOffEvil',  AutoStatusEvil  );
  INIWriteInteger(INI, 'Conf', 'AutoOnOffDepres', AutoStatusDepres  );
  INIWriteInteger(INI, 'Conf', 'AutoOnOffAtHome', AutoStatusAtHome  );
  INIWriteInteger(INI, 'Conf', 'AutoOnOffAtWork', AutoStatusAtWork  );
  INIWriteInteger(INI, 'Conf', 'AutoOnOffLunch',  AutoStatusLunch  );
  INIWriteInteger(INI, 'Conf', 'AutoOnOffAway',  AutoStatusAway  );
  INIWriteInteger(INI, 'Conf', 'AutoOnOffNA',  AutoStatusNA  );
  INIWriteInteger(INI, 'Conf', 'AutoOnOffOccupied',  AutoStatusOccupied  );
  INIWriteInteger(INI, 'Conf', 'AutoOnOffDND',  AutoStatusDND  );
  INIWriteInteger(INI, 'Conf', 'AutoOnOffOnline',  AutoStatusOnline  );
  INIWriteInteger(INI, 'Conf', 'AutoOnOffInvisible',  AutoStatusInvisible  );
  INIWriteInteger(INI, 'Conf', 'AutoOnOffOffline', AutoStatusOffline  );


  INIWriteBool(INI, 'SpecCnt', 'ShowLine2', SpecCntShowLine2 );

  INIWriteStringUTF8(INI, 'SpecCnt', 'L1Text', SpecCntLine1Text );
  INIWriteStringUTF8(INI, 'SpecCnt', 'L2Text', SpecCntLine2Text );

  INIWriteBool(INI, 'SpecCnt', 'L1ScrollText', SpecCntLine1ScrollText );
  INIWriteBool(INI, 'SpecCnt', 'L2ScrollText', SpecCntLine2ScrollText );

  INIFree(INI);

  HotKeysDeactivate;

  QIPPlugin.RemoveSpecContact( UniqContactId );
  QIPPlugin.AddSpecContact( UniqContactId, SpecCntHeight );

  QIPPlugin.RedrawSpecContact(UniqContactId);

  ActualMenu := lstMenu.ItemIndex;

  FormShow(Sender);

  if HotKeyEnabled then
    HotKeysActivate;

  lstMenu.ItemIndex := ActualMenu;
  pnlText.Caption := lstMenu.Items[ActualMenu];
  pgcOptions.ActivePageIndex := ActualMenu;

  AddComments(FOptions);
end;

procedure TfrmOptions.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmOptions.btnEqualizerSetupClick(Sender: TObject);
begin
  OpenEqualizer;
  FEqualizer.chkEnableEqualizer.Enabled := False;
end;

procedure TfrmOptions.btnOKClick(Sender: TObject);
begin
  btnApplyClick(Sender);

  Close;
end;

procedure TfrmOptions.btnSpecCntDefaultClick(Sender: TObject);
begin
  edtSpecCntLine1.Text   := LNG('DEFAULT', 'SpecCnt.Line1', '%station%');
  edtSpecCntLine2.Text   := LNG('DEFAULT', 'SpecCnt.Line2', '%song%');
end;

procedure TfrmOptions.btnSpecCntLine1TemplatesClick(Sender: TObject);
var
  where: TPoint;
begin
  where := Mouse.CursorPos;
  pmTemplates_Type := 4;
  pmTemplates.Popup(where.X,where.Y);
end;

procedure TfrmOptions.btnSpecCntLine2TemplatesClick(Sender: TObject);
var
  where: TPoint;
begin
  where := Mouse.CursorPos;
  pmTemplates_Type := 5;
  pmTemplates.Popup(where.X,where.Y);
end;

procedure TfrmOptions.btnSpecCntPreviewClick(Sender: TObject);
var
  sText, sTitle: WideString;
begin
  sTitle := edtSpecCntLine1.Text;
  sTitle := StringReplace(sTitle, '%station%', 'BBC Radio', [rfReplaceAll, rfIgnoreCase]);
  sTitle := StringReplace(sTitle, '%genre%', 'Pop', [rfReplaceAll, rfIgnoreCase]);
  sTitle := StringReplace(sTitle, '%song%', 'Haddaway - What is Love', [rfReplaceAll, rfIgnoreCase]);
  sTitle := StringReplace(sTitle, '%format%', '128kbps', [rfReplaceAll, rfIgnoreCase]);
  sTitle := StringReplace(sTitle, '%language%', 'English', [rfReplaceAll, rfIgnoreCase]);
  sTitle := StringReplace(sTitle, '%stationweb%', 'http://www.bbc.co.uk', [rfReplaceAll, rfIgnoreCase]);
  sTitle := ReplCondBlocks(sTitle);
  sText := edtSpecCntLine2.Text;
  sText := StringReplace(sText, '%station%', 'BBC Radio', [rfReplaceAll, rfIgnoreCase]);
  sText := StringReplace(sText, '%genre%', 'pop', [rfReplaceAll, rfIgnoreCase]);
  sText := StringReplace(sText, '%song%', 'Haddaway - What is Love', [rfReplaceAll, rfIgnoreCase]);
  sText := StringReplace(sText, '%format%', '128kbps', [rfReplaceAll, rfIgnoreCase]);
  sText := StringReplace(sText, '%language%', 'English', [rfReplaceAll, rfIgnoreCase]);
  sText := StringReplace(sText, '%stationweb%', 'http://www.bbc.co.uk', [rfReplaceAll, rfIgnoreCase]);
  sText := ReplCondBlocks(sText);
  TaskMessageDlg(sTitle, sText, mtInformation, [mbOK], 0);
end;

procedure TfrmOptions.btnSyntaxClick(Sender: TObject);
var
  sText: WideString;
begin
  sText := LNG('FORM Options', 'XStatus.XStatus.Syntax', 'Conditional blocks are special blocks, the text from which will be shown only at the filled data. It gives possibility to show the text defined by you (eg. song) only if the information on an album is brought in a tag[br][br]Example: {{%song%= (listening %song%)}}=I am listening to radio[br][br]Before change of the X-Status plugin checks information in %song% and if not null that will show it: listening %song%. If data is not present - the plugin will not show all conditional block[br][br]Syntax of the conditional block: {{tag=info}}[br][br]''{{'' - the beginning of the conditional block[br][br]''tag'' - a template from the list[br][br]''='' - a separator[br][br]''info'' - all text which will be shown in the presence of the information in a tag[br][br]''}}'' - the end of the conditional block[br][br]Examples:[br][br]');
  sText := sText + '{{%song%=[%song%]}}[br]';
  sText := sText + '{{%genre%=genre is %genre%}}[br]';
  sText := sText + 'Now Listening: {{%station%=%station%}} {{%song%=- %song%}}[br]';
  sText := TagsReplace(sText);
  MessageDlg(sText, mtInformation, [mbOK], 0);
end;

procedure TfrmOptions.btnXStatusPreviewClick(Sender: TObject);
var
  sText, sTitle: WideString;
begin
  sTitle := edtXStatusTitle.Text;
  sTitle := StringReplace(sTitle, '%station%', 'BBC Radio', [rfReplaceAll, rfIgnoreCase]);
  sTitle := StringReplace(sTitle, '%genre%', 'Pop', [rfReplaceAll, rfIgnoreCase]);
  sTitle := StringReplace(sTitle, '%song%', 'Haddaway - What is Love', [rfReplaceAll, rfIgnoreCase]);
  sTitle := StringReplace(sTitle, '%format%', '128kbps', [rfReplaceAll, rfIgnoreCase]);
  sTitle := StringReplace(sTitle, '%language%', 'English', [rfReplaceAll, rfIgnoreCase]);
  sTitle := StringReplace(sTitle, '%stationweb%', 'http://www.bbc.co.uk', [rfReplaceAll, rfIgnoreCase]);
  sTitle := ReplCondBlocks(sTitle);
  sText := edtXStatusText.Text;
  sText := StringReplace(sText, '%station%', 'BBC Radio', [rfReplaceAll, rfIgnoreCase]);
  sText := StringReplace(sText, '%genre%', 'pop', [rfReplaceAll, rfIgnoreCase]);
  sText := StringReplace(sText, '%song%', 'Haddaway - What is Love', [rfReplaceAll, rfIgnoreCase]);
  sText := StringReplace(sText, '%format%', '128kbps', [rfReplaceAll, rfIgnoreCase]);
  sText := StringReplace(sText, '%language%', 'English', [rfReplaceAll, rfIgnoreCase]);
  sText := StringReplace(sText, '%stationweb%', 'http://www.bbc.co.uk', [rfReplaceAll, rfIgnoreCase]);
  sText := ReplCondBlocks(sText);
  TaskMessageDlg(sTitle, sText, mtInformation, [mbOK], 0);
end;

procedure TfrmOptions.btnUpdaterCheckUpdateClick(Sender: TObject);
begin
  CheckNewVersion(True);
end;

procedure TfrmOptions.btnXStatusDefaultClick(Sender: TObject);
begin
  edtXStatusTitle.Text  := LNG('DEFAULT', 'XStatus.Title', 'I am listening to radio');
  edtXStatusText.Text   := LNG('DEFAULT', 'XStatus.Text', '%station%');
end;

procedure TfrmOptions.btnXStatusTextTemplatesClick(Sender: TObject);
var
  where: TPoint;
begin
  where := Mouse.CursorPos;
  pmTemplates_Type := 2;
  pmTemplates.Popup(where.X,where.Y);
end;

procedure TfrmOptions.btnXStatusTextTemplatesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  where: TPoint;
begin
  where := Mouse.CursorPos;
  pmTemplates_Type := 2;
  pmTemplates.Popup(where.X,where.Y);
end;

procedure TfrmOptions.btnXStatusTitleTemplatesClick(Sender: TObject);
var
  where: TPoint;
begin
  where := Mouse.CursorPos;
  pmTemplates_Type := 1;
  pmTemplates.Popup(where.X,where.Y);
end;

procedure TfrmOptions.btnXStatusTitleTemplatesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  where: TPoint;
begin
  where := Mouse.CursorPos;
  pmTemplates_Type := 1;
  pmTemplates.Popup(where.X,where.Y);
end;

procedure TfrmOptions.btnPopUpDefaultClick(Sender: TObject);
begin
  edtPopUp.Text   := LNG('DEFAULT', 'PopUp.Text', '%station%');
end;

procedure TfrmOptions.btnPopUpPreviewClick(Sender: TObject);
var
  sText: WideString;
begin
  sText := edtPopUp.Text;
  sText := StringReplace(sText, '%station%', 'BBC Radio', [rfReplaceAll, rfIgnoreCase]);
  sText := StringReplace(sText, '%genre%', 'pop', [rfReplaceAll, rfIgnoreCase]);
  sText := StringReplace(sText, '%song%', 'Haddaway - What is Love', [rfReplaceAll, rfIgnoreCase]);
  sText := StringReplace(sText, '%format%', '128kbps', [rfReplaceAll, rfIgnoreCase]);
  sText := StringReplace(sText, '%language%', 'English', [rfReplaceAll, rfIgnoreCase]);
  sText := StringReplace(sText, '%stationweb%', 'http://www.bbc.co.uk', [rfReplaceAll, rfIgnoreCase]);
  sText := ReplCondBlocks(sText);
  TaskMessageDlg('FMtune', sText, mtInformation, [mbOK], 0);
end;

procedure TfrmOptions.btnPopUpTemplatesClick(Sender: TObject);
var
  where: TPoint;
begin
  where := Mouse.CursorPos;
  pmTemplates_Type := 3;
  pmTemplates.Popup(where.X,where.Y);
end;

procedure TfrmOptions.chkEnableEqualizerClick(Sender: TObject);
begin
  EqualizerEnabled := chkEnableEqualizer.Checked;
  if chkEnableEqualizer.Checked then
    begin
      btnEqualizerSetup.Enabled := True;
      if EqualizerToRadioGenre then
      begin
        if Stations.Count - 1 >= Radio_StationID then
          ActiveEqualizer(TStation(Stations.Objects[Radio_StationID]).Genre)
      end
      else
        ActiveEqualizer(EqualizerOption);
    end
  else
    begin
      btnEqualizerSetup.Enabled := False;
      DeactiveEqualizer;
    end;

end;

procedure TfrmOptions.chkEnableXStatusClick(Sender: TObject);
var
  i: integer;
begin
  with TCheckBox(Sender) do
    begin
      for i:=0 to gbXStatus.ControlCount-1 do
        gbXStatus.Controls[i].Enabled := Checked;
      rbChangeIfMusic.Enabled := Checked;
      rbChangeIfAny.Enabled   := Checked;
    end;
end;

procedure TfrmOptions.chkShowCoversClick(Sender: TObject);
begin
  //chkSaveCovers.Enabled := chkShowCovers.Checked;
end;

procedure TfrmOptions.chkShowPopupsClick(Sender: TObject);
var
  i: integer;
begin
  with TCheckBox(Sender) do
    begin
      if Checked then
        for i:=0 to gbPopUp.ControlCount-1 do
          gbPopUp.Controls[i].Enabled := rbPopUpPersonalSettings.Checked
      else
        for i:=0 to gbPopUp.ControlCount-1 do
          gbPopUp.Controls[i].Enabled := Checked;
      rbPopUpShowAsXStatus.Enabled    := Checked;
      rbPopUpPersonalSettings.Enabled := Checked;
      //chkShowPopUpIfChangeInfo.Enabled := Checked;
    end;
end;

procedure TfrmOptions.chkUpdaterCheckingUpdatesClick(Sender: TObject);
var
  i: integer;
begin
  with TCheckBox(Sender) do
    begin
      for i := 0 to gbUpdater.ControlCount-1 do
        gbUpdater.Controls[i].Enabled := Checked;
      Enabled := True;
      btnUpdaterCheckUpdate.Enabled := True;

      // pokud je plugin v testovací fázi, jsou zapnuty beta aktualizace
      if Trim(PLUGIN_VER_BETA) <> '' then
        chkAnnounceBeta.Enabled := False;

    end;
end;

procedure TfrmOptions.chkUseHotKeysClick(Sender: TObject);
var
  i: integer;
begin
  with TCheckBox(Sender) do
    begin
      for i := 0 to gbHotKeys.ControlCount-1 do
        gbHotKeys.Controls[i].Enabled := Checked;
      Enabled := True;
    end;
end;

procedure TfrmOptions.chkUseProxyServerClick(Sender: TObject);
var
  i: integer;
begin
  with TCheckBox(Sender) do
    begin
      for i:=0 to gbProxy.ControlCount-1 do
          gbProxy.Controls[i].Enabled := Checked;
      Enabled := True;
      rbProxyManualConfClick(rbProxyManualConf);
    end;
end;

procedure TfrmOptions.cmbLangsChange(Sender: TObject);
begin
  ShowLanguageInfo;
end;

procedure TfrmOptions.cmbSkinChange(Sender: TObject);
begin
  ShowSkinInfo;
end;

procedure TfrmOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  OptionsIsShow := False;
  FOptions.Destroy;
end;

procedure TfrmOptions.PridejMenu;
var
  hLibraryPics : THandle;
  I, Iact      : Byte;
begin
  hLibraryPics := LoadLibrary( PWideChar(Pics) );
  PluginSkin.General.Icon         := LoadImageAsIconFromResource(48, hLibraryPics);
  PluginSkin.Advanced.Icon        := LoadImageAsIconFromResource(49, hLibraryPics);
  PluginSkin.Skin.Icon            := LoadImageAsIconFromResource(50, hLibraryPics);
  PluginSkin.HotKeys.Icon         := LoadImageAsIconFromResource(51, hLibraryPics);
  PluginSkin.Connect.Icon         := LoadImageAsIconFromResource(52, hLibraryPics);
  PluginSkin.PopUp.Icon           := LoadImageAsIconFromResource(53, hLibraryPics);
  PluginSkin.ExtSource.Icon       := LoadImageAsIconFromResource(54, hLibraryPics);
  FreeLibrary(hLibraryPics);

  // zde se definuje poøadí karet
  { první položka }
  I := 0;
  Iact := TTabSheet(pgcOptions.FindChildControl('tsGeneral')).PageIndex;
  AddIconToStringList(PluginSkin.OptionsIcons, PluginSkin.General.Icon, I);
  pgcOptions.Pages[Iact].Caption    := QIPPlugin.GetLang(LI_GENERAL);
  pgcOptions.Pages[Iact].ImageIndex := I;
  pgcOptions.Pages[Iact].PageIndex := I;
  { druhá položka }
  I := 1;
  Iact := TTabSheet(pgcOptions.FindChildControl('tsAdvanced')).PageIndex;
  AddIconToStringList(PluginSkin.OptionsIcons, PluginSkin.Advanced.Icon, I);
  pgcOptions.Pages[Iact].Caption := LNG('FORM Options', 'Advanced', 'Advanced');
  pgcOptions.Pages[Iact].ImageIndex := I;
  pgcOptions.Pages[Iact].PageIndex := I;
  { tøetí položka }
  I := 2;
  Iact := TTabSheet(pgcOptions.FindChildControl('tsPopUp')).PageIndex;
  AddIconToStringList(PluginSkin.OptionsIcons, PluginSkin.PopUp.Icon, I);
  pgcOptions.Pages[Iact].Caption := LNG('FORM Options', 'PopUp', 'Popup');
  pgcOptions.Pages[Iact].ImageIndex := I;
  pgcOptions.Pages[Iact].PageIndex := I;
  { ètvrtá položka }
  I := 3;
  Iact := TTabSheet(pgcOptions.FindChildControl('tsCL')).PageIndex;
  AddIconToStringList(PluginSkin.OptionsIcons, PluginSkin.Skin.Icon, I);
  pgcOptions.Pages[Iact].Caption := QIPPlugin.GetLang(LI_CONTACT_LIST);
  pgcOptions.Pages[Iact].ImageIndex := I;
  pgcOptions.Pages[Iact].PageIndex := I;
  { pátá položka }
  I := 4;
  Iact := TTabSheet(pgcOptions.FindChildControl('tsXStatus')).PageIndex;
  AddIconToStringList(PluginSkin.OptionsIcons, PluginSkin.ST_away.Icon, I);
  pgcOptions.Pages[Iact].Caption := LNG('FORM Options', 'XStatus', 'X-Status');
  pgcOptions.Pages[Iact].ImageIndex := I;
  pgcOptions.Pages[Iact].PageIndex := I;
  { šestá položka }
  I := 5;
  Iact := TTabSheet(pgcOptions.FindChildControl('tsHotKeys')).PageIndex;
  AddIconToStringList(PluginSkin.OptionsIcons, PluginSkin.HotKeys.Icon, I);
  pgcOptions.Pages[Iact].Caption := QIPPlugin.GetLang(LI_HOT_KEYS);
  pgcOptions.Pages[Iact].ImageIndex := I;
  pgcOptions.Pages[Iact].PageIndex := I;
  { sedmá položka }
  I := 6;
  Iact := TTabSheet(pgcOptions.FindChildControl('tsExtSources')).PageIndex;
  AddIconToStringList(PluginSkin.OptionsIcons, PluginSkin.ExtSource.Icon, I);
  pgcOptions.Pages[Iact].Caption := LNG('FORM Options', 'ExternalSources', 'External sources');
  pgcOptions.Pages[Iact].ImageIndex := I;
  pgcOptions.Pages[Iact].PageIndex := I;
  { osmá položka }
  I := 7;
  Iact := TTabSheet(pgcOptions.FindChildControl('tsConnection')).PageIndex;
  AddIconToStringList(PluginSkin.OptionsIcons, PluginSkin.Connect.Icon, I);
  pgcOptions.Pages[Iact].Caption := QIPPlugin.GetLang(LI_CONNECTION);
  pgcOptions.Pages[Iact].ImageIndex := I;
  pgcOptions.Pages[Iact].PageIndex := I;
end;

procedure TfrmOptions.FormShow(Sender: TObject);
var INI : TIniFile;
    idx : Integer;

    rec: TSearchRec;
    LngPath: WideString;
    NewItem: TMenuItem;
    sText: WideString;

    sAuthor, sEmail, sURL, sTrans, sVersion, sTransInfo: WideString;
    iFS: Integer;

begin

  PridejMenu;


  Color := frmBgColor;

  // vytvoøení šablon
  TemplatesValues := TStringList.Create;
  TemplatesValues.Clear;

  TemplatesTexts := TStringList.Create;
  TemplatesTexts.Clear;

  TemplatesValuesInfo := TStringList.Create;
  TemplatesValuesInfo.Clear;

  TemplatesTextsInfo := TStringList.Create;
  TemplatesTextsInfo.Clear;


  //***          Nastavení jazyka        ***
  //****************************************
  //--- komentáøe
  chkUpdaterCheckingUpdates.Hint := LNG('COMMENTS', 'CheckingUpdates', 'Plugin checks the availability of new version (of program) in the given interval.');
  chkAnnounceBeta.Hint           := LNG('COMMENTS', 'CheckBetaUpdates', 'Checking availability of beta version of plugin. This choice is automatically selected, if you have beta version of plugin.');
  chkSaveLastStream.Hint         := LNG('COMMENTS', 'SaveLastStream', 'By setting another format, this one sets as default for selected station.');
  chkPlayOnStart.Hint            := LNG('COMMENTS', 'PlayOnStart', 'Start playing the last known station at QIP start.');
  chkShowPopupIfChangeInfo.Hint  := LNG('COMMENTS', 'ShowPopupIfChangeInfo', 'Information window is shown everytime, when any information about radio is changed.');
  chkEnableXStatus.Hint          := LNG('COMMENTS', 'ShowXStatus', 'X-status is a status, which is shown to other users. With it''s activation the plugin changes it according to other settings.');
  chkSaveCovers.Hint             := LNG('COMMENTS', 'SaveCover', 'Zapnutím této volby se nestahují již stažené obrázky alb a tak pøi èasto opakujících písnièkách zbyteènì nestahujete.');
  lblXStatusTitle.Hint           := LNG('COMMENTS', 'XStatusTitleMaxChars', 'Maximální poèet znakù je 20');
  //---

  btnAbout.Caption         := LNG('FORM Options', 'About', 'About plugin...');

  //--- nastavení Updater
  gbUpdater.Caption                 := LNG('FORM Options', 'General.Updates', 'Updater');
  chkUpdaterCheckingUpdates.Caption := LNG('FORM Options', 'General.CheckingUpdates', 'Checking updates');
  lblUpdaterInterval.Caption        := LNG('FORM Options', 'General.CheckingUpdates.Interval', 'Interval') + ':';
  lblUpdaterIntervalUnit.Caption    := LNG('FORM Options', 'General.CheckingUpdates.Interval.Unit', 'hours');
  btnUpdaterCheckUpdate.Caption     := QIPPlugin.GetLang(LI_CHECK);
  chkAnnounceBeta.Caption           := LNG('FORM Options', 'General.CheckingUpdates.Beta', 'Announce beta version');
  edtUpdaterInterval.Left     := lblUpdaterInterval.Left + lblUpdaterInterval.Width + 4;
  udUpdaterInterval.Left      := edtUpdaterInterval.Left + edtUpdaterInterval.Width;
  lblUpdaterIntervalUnit.Left := udUpdaterInterval.Left + udUpdaterInterval.Width + 4;
  btnUpdaterCheckUpdate.Left  := lblUpdaterIntervalUnit.Left + lblUpdaterIntervalUnit.Width + 4;

  //--- nastavení Language
  gbLanguage.Caption         := QIPPlugin.GetLang(LI_LANGUAGE);
  lblLanguage.Caption        := QIPPlugin.GetLang(LI_LANGUAGE)+':';
  lblLanguageRem.Caption     := LNG('FORM Options', 'Language.Rem', 'rem: Partial translation is take from QIP.');
  lblInfoTransAuthor.Caption := QIPPlugin.GetLang(LI_AUTHOR) + ':';
  lblInfoTransEmail.Caption  := QIPPlugin.GetLang(LI_EMAIL) + ':';
  lblInfoTransWeb.Caption    := QIPPlugin.GetLang(LI_WEB_SITE) + ':';
  //---

  //--- nastavení Advanced
  gbAdvancedOptions.Caption  := QIPPlugin.GetLang(LI_OPTIONS);
  chkUseQIPMute.Caption      := LNG('FORM Options', 'Advanced.UseQIPMute', 'Use QIP mute sound');
  chkPlayOnStart.Caption     := LNG('FORM Options', 'Advanced.PlayOnStart', 'Play on start');
  chkEnableEqualizer.Caption := LNG('FORM Options', 'Advanced.EnableEqualizer', 'Enable Equalizer');
  btnEqualizerSetup.Caption  := LNG('FORM Options', 'Advanced.EqualizerSetup', 'Setup');
  chkSaveLastStream.Caption  := LNG('FORM Options', 'Advanced.SaveLastStream', 'Save last station stream');
  chkShowComments.Caption      := LNG('FORM Options', 'Advanced.ShowComments', 'Show comments');
  //---

  //--- nastavení PopUp
  gbSetPopUp.Caption              := QIPPlugin.GetLang(LI_OPTIONS);
  gbPopUp.Caption                 := LNG('FORM Options', 'PopUp', 'Popup') + ': ' + LNG('FORM Options', 'PopUp.PersonalSettings', 'Personal settings');
  chkShowPopups.Caption           := LNG('FORM Options', 'Advanced.ShowPopups', 'Show popups');
  chkShowPopupIfChangeInfo.Caption:= LNG('FORM Options', 'PopUp.ShowPopupIfChangeInfo', 'Show popup window everytime, when any information is changed.');
  rbPopUpShowAsXStatus.Caption    := LNG('FORM Options', 'PopUp.ShowAsXStatus', 'Show as X-Status');
  rbPopUpPersonalSettings.Caption := LNG('FORM Options', 'PopUp.PersonalSettings', 'Personal settings');
  btnPopUpPreview.Caption         := LNG('FORM Options', 'XStatus.XStatus.Preview', 'Preview');
  btnPopUpTemplates.Caption       := LNG('FORM Options', 'XStatus.XStatus.Templates', 'Templates');
  btnPopUpDefault.Caption         := LNG('FORM Options', 'XStatus.XStatus.Default', 'Default');
  btnPopUpSyntax.Caption          := LNG('FORM Options', 'Connection.Proxy.Syntax', 'Syntax');
  //---

  //--- nastavení Skin
  gbSkin.Caption             := LNG('FORM Options', 'Skin', 'Skin');
  lblInfoSkinVersion.Caption := QIPPlugin.GetLang(LI_VERSION) + ':';
  lblInfoSkinAuthor.Caption  := QIPPlugin.GetLang(LI_AUTHOR) + ':';
  lblInfoSkinEmail.Caption   := QIPPlugin.GetLang(LI_EMAIL) + ':';
  lblInfoSkinWeb.Caption     := QIPPlugin.GetLang(LI_WEB_SITE) + ':';

  gbSpecContact.Caption := QIPPlugin.GetLang(LI_CONTACT_LIST);
  btnSpecCntPreview.Caption         := LNG('FORM Options', 'XStatus.XStatus.Preview', 'Preview');
  btnSpecCntLine1Templates.Caption  := LNG('FORM Options', 'XStatus.XStatus.Templates', 'Templates');
  btnSpecCntLine2Templates.Caption  := LNG('FORM Options', 'XStatus.XStatus.Templates', 'Templates');
  btnSpecCntDefault.Caption         := LNG('FORM Options', 'XStatus.XStatus.Default', 'Default');
  chkSpecCntLine1ScrollText.Caption := LNG('FORM Options', 'Advanced.ScrollText', 'Scroll text');
  chkSpecCntLine2ScrollText.Caption := LNG('FORM Options', 'Advanced.ScrollText', 'Scroll text');

  lblSpecCntLine1.Caption           := LNG('FORM Options', 'SpecCnt.Line1', 'Line 1')+':';
  chkSpecCntShowLine2.Caption       := LNG('FORM Options', 'SpecCnt.Line2', 'Line 2')+':';

  btnSpecCntSyntax.Caption          := LNG('FORM Options', 'Connection.Proxy.Syntax', 'Syntax');
  //---

  //--- nastavení X-Status
  gbXStatusOptions.Caption       := QIPPlugin.GetLang(LI_OPTIONS);
  chkEnableXStatus.Caption       := LNG('FORM Options', 'XStatus.Enable', 'Enable X-Status');
  rbChangeIfMusic.Caption        := LNG('FORM Options', 'XStatus.ChangeIfMusic', 'Change content if X-Status is "Music"');
  rbChangeIfAny.Caption          := LNG('FORM Options', 'XStatus.ChangeIfAny', 'Change with any X-Status');

  gbXStatus.Caption              := LNG('FORM Options', 'XStatus', 'X-Stasus') + ':';
  lblXStatusTitle.Caption        := LNG('FORM Options', 'XStatus.XStatus.Title', 'Title') + ':';
  lblXStatusText.Caption         := LNG('FORM Options', 'XStatus.XStatus.Text', 'Text') + ':';
  btnXStatusDefault.Caption      := LNG('FORM Options', 'XStatus.XStatus.Default', 'Default');
  btnXStatusPreview.Caption      := LNG('FORM Options', 'XStatus.XStatus.Preview', 'Preview');

  btnXStatusTitleTemplates.Caption := LNG('FORM Options', 'XStatus.XStatus.Templates', 'Templates');
  btnXStatusTextTemplates.Caption  := LNG('FORM Options', 'XStatus.XStatus.Templates', 'Templates');

  TemplatesTexts.Add(LNG('FORM Options', 'XStatus.XStatus.TextsInfo.N/A', 'N/A'));
  TemplatesTexts.Add(LNG('FORM Options', 'XStatus.XStatus.TextsInfo.NowListening', 'Now listening'));
  TemplatesTexts.Add(LNG('FORM Options', 'XStatus.XStatus.TextsInfo.CoolSong', 'cool song'));

  miTemplates_Values.Caption    := LNG('FORM Options', 'XStatus.XStatus.Menu.Values', 'Values');
  miTemplates_Texts.Caption     := LNG('FORM Options', 'XStatus.XStatus.Menu.Texts', 'Texts');
  miTemplates_CapitalFollowingLetter.Caption := LNG('FORM Options', 'XStatus.XStatus.Menu.CapitalFollowingLetter', 'Capital following letter') + '  %^%';

  btnSyntax.Caption          := LNG('FORM Options', 'Connection.Proxy.Syntax', 'Syntax');
  //---

  //--- nastavení On and Off radio
  gbAutomaticOnOffRadio.Caption   := LNG('FORM Options', 'OnOffRadio.Automatic', 'Automatic On and Off radio');
  chkAutoUseWherePlaying.Caption  := LNG('FORM Options', 'OnOffRadio.Automatic.UseWherePlaying', 'Use where radio playing');

  chkStatusFFCAuto.Clear;
  chkStatusEvilAuto.Clear;
  chkStatusDepresAuto.Clear;
  chkStatusAtHomeAuto.Clear;
  chkStatusAtWorkAuto.Clear;
  chkStatusLunchAuto.Clear;
  chkStatusAwayAuto.Clear;
  chkStatusNAAuto.Clear;
  chkStatusOccupiedAuto.Clear;
  chkStatusDNDAuto.Clear;
  chkStatusOnlineAuto.Clear;
  chkStatusInvisibleAuto.Clear;
  chkStatusOfflineAuto.Clear;

  for idx := 0 to 2 do
  begin
    if idx = 0 then
      sText := LNG('FORM Options', 'OnOffRadio.Automatic.0', 'nothing')
    else if idx = 1 then
      sText := LNG('FORM Options', 'OnOffRadio.Automatic.1', 'radio On')
    else if idx = 2 then
      sText := LNG('FORM Options', 'OnOffRadio.Automatic.2', 'radio Off');

    chkStatusFFCAuto.Items.Add(sText);
    chkStatusEvilAuto.Items.Add(sText);
    chkStatusDepresAuto.Items.Add(sText);
    chkStatusAtHomeAuto.Items.Add(sText);
    chkStatusAtWorkAuto.Items.Add(sText);
    chkStatusLunchAuto.Items.Add(sText);
    chkStatusAwayAuto.Items.Add(sText);
    chkStatusNAAuto.Items.Add(sText);
    chkStatusOccupiedAuto.Items.Add(sText);
    chkStatusDNDAuto.Items.Add(sText);
    chkStatusOnlineAuto.Items.Add(sText);
    chkStatusInvisibleAuto.Items.Add(sText);
    chkStatusOfflineAuto.Items.Add(sText);
  end;
  //---

  //--- nastavení Hot Keys
  gbHotKeys.Caption            := QIPPlugin.GetLang(LI_HOT_KEYS);
  chkUseHotKeys.Caption        := LNG('FORM Options', 'HotKeys.Use', 'Use Hot Keys');
  lblHotKeyFMtune.Caption      := LNG('FORM Options', 'HotKeys.FMtune', 'FMtune') + ':';
  lblHotKeyVolumeUp.Caption    := LNG('FORM Options', 'HotKeys.VolumeUp', 'Volume Up') + ':';
  lblHotKeyVolumeDown.Caption  := LNG('FORM Options', 'HotKeys.VolumeDown', 'Volume Down') + ':';
  lblHotKeyMute.Caption        := LNG('FORM Options', 'HotKeys.Mute', 'Mute') + ':';
  lblHotKeyStationNext.Caption := LNG('FORM Options', 'HotKeys.StationNext', 'Station Next') + ':';
  lblHotKeyStationPrev.Caption := LNG('FORM Options', 'HotKeys.StationPrev', 'Station Prev') + ':';
  lblHotKeyEnableDisableXStatus.Caption := LNG('FORM Options', 'HotKeys.EnableDisableXStatus', 'Enable/Disable X-Status') + ':';
  //---

  //--- nastavení Conncetion
  gbProxy.Caption             := QIPPlugin.GetLang(LI_PROXY);
  rbNoProxy.Caption           := QIPPlugin.GetLang(LI_CON_HAVE_DC_TO_INET);
  rbProxyQIPConf.Caption      := LNG('FORM Options', 'Connection.ProxyQIP', 'Configuration as QIP');
  rbProxyManualConf.Caption   := QIPPlugin.GetLang(LI_CON_MANUAL_PROXY);
  lblProxyServerInfo.Caption  := LNG('FORM Options', 'Connection.Proxy.Syntax', 'Syntax') + ': ' + LNG('FORM Options', 'Connection.Proxy.How', '[user:pass@]server:port');
  //---

  //--- nastavení Externí zdroje
  gbExtSourceOptions.Caption   := QIPPlugin.GetLang(LI_OPTIONS);
  chkLoadSongsExternal.Caption := LNG('FORM Options', 'ExternalSources.LoadSongsExternal', 'Load songs from external sources');
  chkShowCovers.Caption        := LNG('FORM Options', 'ExternalSources.ShowCovers', 'Show cover of song');
  chkSaveCovers.Caption        := LNG('FORM Options', 'ExternalSources.SaveCovers', 'Save cover of song to directory');
  //---

  //****************************************

  //***    Nastavení dalších voleb       ***
  //****************************************
  // nastavení ikonky
  Icon := PluginSkin.PluginIcon.Icon;

  // nastavení mezery od Vzhled: do výbìru skinu
//  cmbSkin.Left := lblSkin.Left + lblSkin.Width + 4;

  // nastavení hlavièky
  Caption := PLUGIN_NAME + ' | ' + QIPPlugin.GetLang(LI_OPTIONS);

  // hlavní tlaèítka Options
  btnOK.Caption := QIPPlugin.GetLang(LI_OK);
  btnCancel.Caption := QIPPlugin.GetLang(LI_CANCEL);
  btnApply.Caption := QIPPlugin.GetLang(LI_APPLY);

  // verze pluginu
  lblPluginVersion.Caption := QIPPlugin.GetLang(LI_VERSION) + ' ' + PluginVersion;
  lblPluginVersion.Color := BottomLine.Brush.Color;

  // èasový interval aktualizací
  edtUpdaterInterval.Text := IntToStr( CheckUpdatesInterval );
  udUpdaterInterval.Position := CheckUpdatesInterval;
  chkAnnounceBeta.Checked := CheckBetaUpdates;

  // pokud je plugin v testovací fázi, jsou zapnuty beta aktualizace
  if Trim(PLUGIN_VER_BETA) <> '' then
    begin
      chkAnnounceBeta.Enabled := False;
    end;

  // zjištìní zašktrnutí
  chkAutoUseWherePlaying.Checked := AutoUseWherePlaying;

  // nastavení aktuálních nastavených hodnot
  chkStatusFFCAuto.ItemIndex       := AutoStatusFFC;
  chkStatusEvilAuto.ItemIndex      := AutoStatusEvil;
  chkStatusDepresAuto.ItemIndex    := AutoStatusDepres;
  chkStatusAtHomeAuto.ItemIndex    := AutoStatusAtHome;
  chkStatusAtWorkAuto.ItemIndex    := AutoStatusAtWork;
  chkStatusLunchAuto.ItemIndex     := AutoStatusLunch;
  chkStatusAwayAuto.ItemIndex      := AutoStatusAway;
  chkStatusNAAuto.ItemIndex        := AutoStatusNA;
  chkStatusOccupiedAuto.ItemIndex  := AutoStatusOccupied;
  chkStatusDNDAuto.ItemIndex       := AutoStatusDND;
  chkStatusOnlineAuto.ItemIndex    := AutoStatusOnline;
  chkStatusInvisibleAuto.ItemIndex := AutoStatusInvisible;
  chkStatusOfflineAuto.ItemIndex   := AutoStatusOffline;

  // pøiøazení obrázkù k On/Off radio
  imgStatusFFC.Picture       := PluginSkin.ST_ffc.Image.Picture;
  imgStatusEvil.Picture      := PluginSkin.ST_evil.Image.Picture;
  imgStatusDepres.Picture    := PluginSkin.ST_depression.Image.Picture;
  imgStatusAtHome.Picture    := PluginSkin.ST_at_home.Image.Picture;
  imgStatusAtWork.Picture    := PluginSkin.ST_at_work.Image.Picture;
  imgStatusLunch.Picture     := PluginSkin.ST_lunch.Image.Picture;
  imgStatusAway.Picture      := PluginSkin.ST_away.Image.Picture;
  imgStatusNA.Picture        := PluginSkin.ST_na.Image.Picture;
  imgStatusOccupied.Picture  := PluginSkin.ST_occ.Image.Picture;
  imgStatusDND.Picture       := PluginSkin.ST_dnd.Image.Picture;
  imgStatusOnline.Picture    := PluginSkin.ST_online.Image.Picture;
  imgStatusInvisible.Picture := PluginSkin.ST_invisible.Image.Picture;
  imgStatusOffline.Picture   := PluginSkin.ST_offline.Image.Picture;


  TemplatesValues.Clear;
  // nastavení šablon
  TemplatesValues.Add('%station%');
  TemplatesValues.Add('%genre%');
  TemplatesValues.Add('%song%');
  TemplatesValues.Add('%format%');
  TemplatesValues.Add('%bitrate%');
  TemplatesValues.Add('%language%');
  TemplatesValues.Add('%stationweb%');

  // text - preklad
  TemplatesValuesInfo.Add(LNG('FORM Options', 'XStatus.XStatus.ValuesInfo.Station', 'Station name'));
  TemplatesValuesInfo.Add(LNG('FORM Options', 'XStatus.XStatus.ValuesInfo.Genre', 'Genre'));
  TemplatesValuesInfo.Add(LNG('FORM Options', 'XStatus.XStatus.ValuesInfo.Song', 'Song'));
  TemplatesValuesInfo.Add(LNG('FORM Options', 'XStatus.XStatus.ValuesInfo.Format', 'Format'));
  TemplatesValuesInfo.Add(LNG('FORM Info', 'Bitrate', 'Bitrate'));
  TemplatesValuesInfo.Add(LNG('FORM Options', 'XStatus.XStatus.ValuesInfo.Language', 'Language'));
  TemplatesValuesInfo.Add(LNG('FORM Options', 'XStatus.XStatus.ValuesInfo.Web', 'Web'));


  miTemplates_Values.Clear;
  for idx := 0 to TemplatesValues.Count - 1 do
  begin
    NewItem := TMenuItem.Create(Self);
    NewItem.Caption := TemplatesValues.Strings[idx] + ' - ' + TemplatesValuesInfo.Strings[idx];
    NewItem.Tag     := idx;
    NewItem.OnClick := miTemplates_ValuesClick;
    NewItem.OnDrawItem := DrawMenu;
    sText := Format('TemplatesValue_%d',[idx]);
    if FOptions.FindChildControl(sText) <> nil then
      FOptions.FindChildControl(sText).Destroy;
    NewItem.Name := sText;
    NewItem.OnMeasureItem := MeasureMenu;

    miTemplates_Values.Add(NewItem);
  end;

  miTemplates_Texts.Clear;
  for idx := 0 to TemplatesTexts.Count - 1 do
  begin
    NewItem := TMenuItem.Create(Self);
    NewItem.Caption := TemplatesTexts.Strings[idx];
    NewItem.Tag     := idx;
    NewItem.OnClick := miTemplates_TextsClick;
    NewItem.OnDrawItem := DrawMenu;
    sText := Format('TemplatesText_%d',[idx]);
    if FOptions.FindChildControl(sText) <> nil then
      FOptions.FindChildControl(sText).Destroy;
    NewItem.Name := sText;
    NewItem.OnMeasureItem := MeasureMenu;

    miTemplates_Texts.Add(NewItem);
  end;
  //****************************************

  LngPath := PluginDLLPath + 'Langs\';

  cmbLangs.Clear;

  cmbLangs.Items.Add('<default>');
  if cmbLangs.Items[cmbLangs.Items.Count - 1] = PluginLanguage then
    cmbLangs.ItemIndex := cmbLangs.Items.Count - 1;
      
  if FindFirst(LngPath + '*.lng', faAnyFile, rec) = 0 then
    begin
      repeat
          if rec.Name = '' then
          else if rec.Name = '.' then
          else if rec.Name = '..' then
          else
            begin
              cmbLangs.Items.Add( Copy(rec.Name, 1 , Length(rec.Name)-Length(ExtractFileExt(rec.Name))) ) ;
              if cmbLangs.Items[cmbLangs.Items.Count - 1] = PluginLanguage then
                cmbLangs.ItemIndex := cmbLangs.Items.Count - 1;
            end;
      until FindNext(rec) <> 0;
    end;
  FindClose(rec);

  ShowLanguageInfo;

  LngPath := PluginDllPath + 'Skins\';

  cmbSkin.Clear;
  if FindFirst(LngPath + '*.*', faDirectory, rec) = 0 then
    begin
      While FindNext(rec) = 0 do
        begin
          if ExtractFileExt(rec.Name) <> '' then
            rec.Name := '';
          if rec.Name = '' then
          else if rec.Name = '.' then
          else if rec.Name = '..' then
          else
            begin
              if (FileExists(PluginDllPath + 'Skins\' + Copy(rec.Name, 1 , Length(rec.Name)) + '\skin.ini') = True) and
                 (FileExists(PluginDllPath + 'Skins\' + Copy(rec.Name, 1 , Length(rec.Name)) + '\graph.dll') = True) then
              begin
                cmbSkin.Items.Add( Copy(rec.Name, 1 , Length(rec.Name))) ;
                if cmbSkin.Items[cmbSkin.Items.Count - 1] = PluginTheme.Name then
                  cmbSkin.ItemIndex := cmbSkin.Items.Count - 1;
              end;
            end;
        end;
    end;
  FindClose(rec);

  ShowSkinInfo;

  chkUseQIPMute.Checked := UseQIPMute;
  chkPlayOnStart.Checked := PlayOnStart;

  chkEnableEqualizer.Checked := EqualizerEnabled;

  chkShowComments.Checked := ShowComments;
  chkLoadSongsExternal.Checked := LoadSongsExternal;
  chkShowCovers.Checked := ShowCover;
  chkSaveCovers.Checked := SaveCover;

  btnEqualizerSetup.Enabled := EqualizerEnabled;


  chkUseHotKeys.Checked := HotKeyEnabled;
  chkUseHotKeysClick(chkUseHotKeys);

  HotKey1.HotKey := HotKeyFMtune;
  HotKey3.HotKey := HotKeyVolumeUp;
  HotKey4.HotKey := HotKeyVolumeDown;
  HotKey2.HotKey := HotKeyMute;
  HotKey5.Hotkey := HotKeyStationNext;
  HotKey6.Hotkey := HotKeyStationPrev;
  HotKey7.Hotkey := HotKeyEnableDisableXStatus;

  chkEnableXStatus.Checked := XStatus_Boolean;


  if XStatus_Type = 1 then
    rbChangeIfMusic.Checked := True
  else if XStatus_Type = 2 then
    rbChangeIfAny.Checked := True;

  edtXStatusTitle.Text := XStatus_Title;
  edtXStatusText.Text  := XStatus_Text;

  edtPopup.Text  := PopupText;
  //chkShowPopUpIfChangeInfo.Checked := ShowPopUpIfChangeInfo;

  if PopupType = 1 then
  begin
    rbPopUpShowAsXStatus.Checked := True;
    rbPopUpShowAsXStatusClick(Self);
  end
  else if PopupType = 2 then
  begin
    rbPopUpPersonalSettings.Checked := True;
    rbPopUpPersonalSettingsClick(Self);
  end;

  chkSaveLastStream.Checked := SaveLastStream;

  chkShowPopups.Checked := ShowPopups;

  case Proxy_Mode of
  0: rbNoProxy.Checked := True;
  1: rbProxyQIPConf.Checked := True;
  2: begin
       rbProxyManualConf.Checked := True;
       edtProxyServer.Text := Proxy_Server;
     end;
  end;

  chkUpdaterCheckingUpdates.Checked := CheckUpdates;

  edtSpecCntLine1.Text := SpecCntLine1Text;
  edtSpecCntLine2.Text := SpecCntLine2Text;

  chkSpecCntLine1ScrollText.Checked := SpecCntLine1ScrollText;
  chkSpecCntLine2ScrollText.Checked := SpecCntLine2ScrollText;
  chkSpecCntShowLine2.Checked := SpecCntShowLine2;

  lstMenu.Clear;
  idx:=0;
  while ( idx <= pgcOptions.PageCount - 1 ) do
  begin
    pgcOptions.Pages[idx].TabVisible := false;
    lstMenu.Items.Add ( pgcOptions.Pages[idx].Caption );
    Inc(idx);
  end;

//  lstMenu.ItemHeight := 26;
  pgcOptions.ActivePageIndex:=0;
  lstMenu.ItemIndex := 0;
  pnlText.Caption := lstMenu.Items[lstMenu.ItemIndex];

  chkShowPopupsClick(chkShowPopups);
  chkEnableXStatusClick(chkEnableXStatus);
  chkShowCoversClick(nil);

  AddComments(FOptions);

  OptionsIsShow := True;
end;

procedure TfrmOptions.GetOffHotKey(Sender: TObject);
begin
//  HotKeysDeactivate;
end;

procedure TfrmOptions.GetHotKeysActivate(Sender: TObject);
begin
//  HotKeysActivate;
end;

procedure TfrmOptions.lblSkinEmailClick(Sender: TObject);
begin
  LinkUrl( 'mailto:'+lblSkinEmail.Caption);
end;

procedure TfrmOptions.lblSkinEmailMouseEnter(Sender: TObject);
begin
  OnMouseOverLink(Sender);
end;

procedure TfrmOptions.lblSkinEmailMouseLeave(Sender: TObject);
begin
  OnMouseOutLink(Sender);
end;

procedure TfrmOptions.lblSkinWebClick(Sender: TObject);
begin
  LinkUrl( lblSkinWeb.Caption);
end;

procedure TfrmOptions.lblSkinWebMouseEnter(Sender: TObject);
begin
  OnMouseOverLink(Sender);
end;

procedure TfrmOptions.lblSkinWebMouseLeave(Sender: TObject);
begin
  OnMouseOutLink(Sender);
end;

procedure TfrmOptions.lblTransEmailClick(Sender: TObject);
begin
  LinkUrl( 'mailto:'+lblTransEmail.Caption);
end;

procedure TfrmOptions.lblTransEmailMouseEnter(Sender: TObject);
begin
  OnMouseOverLink(Sender);
end;

procedure TfrmOptions.lblTransEmailMouseLeave(Sender: TObject);
begin
  OnMouseOutLink(Sender);
end;

procedure TfrmOptions.lblTransURLClick(Sender: TObject);
begin
  LinkUrl( lblTransURL.Caption);
end;

procedure TfrmOptions.lblTransURLMouseEnter(Sender: TObject);
begin
  OnMouseOverLink(Sender);
end;

procedure TfrmOptions.lblTransURLMouseLeave(Sender: TObject);
begin
  OnMouseOutLink(Sender);
end;

procedure TfrmOptions.lstMenuClick(Sender: TObject);
begin
  pgcOptions.ActivePageIndex := lstMenu.ItemIndex;
  pnlText.Caption := lstMenu.Items[lstMenu.ItemIndex];
  lstMenu.Refresh;
  lstMenu.Update;
end;

procedure TfrmOptions.lstMenuDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var CenterText : integer;
begin

  if lstMenu.ItemIndex = Index then
  begin
    lstMenu.Canvas.Brush.Color := $FFE0C2{QIP_Colors.Focus};
    lstMenu.Canvas.FillRect(Rect);
    lstMenu.Canvas.Brush.Color := $FF9933{QIP_Colors.FocusFrame};
    lstMenu.Canvas.FrameRect(Rect);
  end
  else
  begin
    lstMenu.Canvas.Brush.Color := clWindow;
    lstMenu.Canvas.FillRect (rect);
    lstMenu.Canvas.FrameRect(rect);
  end;

  DrawIconEx(lstMenu.Canvas.Handle, rect.Left + 4, rect.Top + 4, TIcon(PluginSkin.OptionsIcons.Objects[index]).Handle, 16, 16, 0, 0, DI_NORMAL);

  //ilMenu.Draw(lstMenu.Canvas,rect.Left + 4, rect.Top + 4, index );

  SetBkMode(lstMenu.Canvas.Handle, TRANSPARENT);

  CenterText := ( rect.Bottom - rect.Top - lstMenu.Canvas.TextHeight(text)) div 2 ;
  lstMenu.Canvas.Font.Color := clWindowText;
  lstMenu.Canvas.TextOut (rect.left + {ilMenu.Width}16 + 8 , rect.Top + CenterText,
                          lstMenu.Items.Strings[index]);
end;

procedure TfrmOptions.lstMenuMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlText.SetFocus; // odnastavení aktivity na jiný objekt (zabránìní èerchovanému orámování)
end;

procedure TfrmOptions.miTemplates_CapitalFollowingLetterClick(Sender: TObject);
begin
  if pmTemplates_Type=1 then
    edtXStatusTitle.SelText := '%^%'
  else if pmTemplates_Type=2 then
    edtXStatusText.SelText := '%^%'
  else if pmTemplates_Type=3 then
    edtPopup.SelText := '%^%'
  else if pmTemplates_Type=4 then
    edtSpecCntLine1.SelText := '%^%'
  else if pmTemplates_Type=5 then
    edtSpecCntLine2.SelText := '%^%';

end;

procedure TfrmOptions.miTemplates_TextsClick(Sender: TObject);
var idx: Integer;
begin
  if Sender <> miTemplates_Texts then
  begin
    idx := (Sender as TMenuItem).Tag;
    if pmTemplates_Type=1 then
      edtXStatusTitle.SelText := TemplatesTexts.Strings[idx]
    else if pmTemplates_Type=2 then
      edtXStatusText.SelText := TemplatesTexts.Strings[idx]
    else if pmTemplates_Type=3 then
      edtPopUp.SelText := TemplatesTexts.Strings[idx]
    else if pmTemplates_Type=4 then
      edtSpecCntLine1.SelText := TemplatesTexts.Strings[idx]
    else if pmTemplates_Type=5 then
      edtSpecCntLine2.SelText := TemplatesTexts.Strings[idx]
  end;

end;

procedure TfrmOptions.miTemplates_ValuesClick(Sender: TObject);
var
  idx: Integer;
  Owner: TComponent;
begin
  if Sender <> miTemplates_Values then
  begin
    //Owner := TMenuItem(Sender).Owner;

    idx := (Sender as TMenuItem).Tag;
    if pmTemplates_Type=1 then
      edtXStatusTitle.SelText := TemplatesValues.Strings[idx]
    else if pmTemplates_Type=2 then
      edtXStatusText.SelText := TemplatesValues.Strings[idx]
    else if pmTemplates_Type=3 then
      edtPopUp.SelText := TemplatesValues.Strings[idx]
    else if pmTemplates_Type=4 then
      edtSpecCntLine1.SelText := TemplatesValues.Strings[idx]
    else if pmTemplates_Type=5 then
      edtSpecCntLine2.SelText := TemplatesValues.Strings[idx]
  end;
end;


procedure TfrmOptions.rbPopUpShowAsXStatusClick(Sender: TObject);
var
  i: integer;
begin
  for i:=0 to gbPopUp.ControlCount-1 do
    gbPopUp.Controls[i].Enabled := False;
end;

procedure TfrmOptions.rbProxyManualConfClick(Sender: TObject);
begin
  edtProxyServer.Enabled     := (Sender as TRadioButton).Checked;
  lblProxyServerInfo.Enabled := (Sender as TRadioButton).Checked;
end;

procedure TfrmOptions.rbProxyQIPConfClick(Sender: TObject);
begin
  rbProxyManualConfClick(rbProxyManualConf);
end;

procedure TfrmOptions.rbNoProxyClick(Sender: TObject);
begin
  rbProxyManualConfClick(rbProxyManualConf);
end;

procedure TfrmOptions.rbPopUpPersonalSettingsClick(Sender: TObject);
var
  i: integer;
begin
  for i:=0 to gbPopUp.ControlCount-1 do
    gbPopUp.Controls[i].Enabled := True;
end;

procedure TfrmOptions.MeasureMenu(Sender: TObject;
  ACanvas: TCanvas; var Width, Height: Integer);
begin
  Menu_MeasureMenu(Sender, ACanvas, Width, Height);
end;

procedure TfrmOptions.DrawMenu(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
begin
  Menu_DrawMenu(Sender, ACanvas, ARect, Selected);
end;

end.

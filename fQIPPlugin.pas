unit fQIPPlugin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, StdCtrls,
  u_plugin_info, u_plugin_msg, u_common, ExtCtrls, Menus, ImgList;

type

  { TSpecCntUniq }
  TSpecCntUniq = record
    UniqID            : DWord;
    ItemType          : DWord;
    Index             : DWord;
  end;
  pSpecCntUniq = ^TSpecCntUniq;

  { FadeMsg }
  TFadeMsg = class
  public
    FadeType     : Byte;        //0 - message style, 1 - information style, 2 - warning style
    FadeIcon     : HICON;       //icon in the top left corner of the window
    FadeTitle    : WideString;
    FadeText     : WideString;
    TextCentered : Boolean;     //if true then text will be centered inside window
    NoAutoClose  : Boolean;     //if NoAutoClose is True then wnd will be always shown until user close it. Not recommended to set this param to True.
    CloseTime    : Integer;
    pData        : Integer;
  end;

  { FadeMsgClosing }
  TFadeMsgClosing = class
  public
    FadeID       : DWord;        //0 - message style, 1 - information style, 2 - warning style
    Time         : Integer;     // 1 jednotka 500 ms.
  end;


  TfrmQIPPlugin = class(TForm)
    tmrStep: TTimer;
    tmrStart: TTimer;
    pmContactMenu: TPopupMenu;
    miContactMenu_OnOff: TMenuItem;
    miContactMenu_Stations: TMenuItem;
    miContactMenu_Formats: TMenuItem;
    N1: TMenuItem;
    miContactMenu_Informations: TMenuItem;
    miContactMenu_Equalizer: TMenuItem;
    miContactMenu_Recording: TMenuItem;
    miContactMenu_EditStations: TMenuItem;
    miContactMenu_Options: TMenuItem;
    miContactMenu_Volume: TMenuItem;
    ImageList1: TImageList;
    miContactMenu_FastAddStation: TMenuItem;
    tmrDraw: TTimer;
    miContactMenu_CopySongName: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure tmrStepTimer(Sender: TObject);
    procedure tmrStartTimer(Sender: TObject);
    procedure miContactMenu_StationsClick(Sender: TObject);
    procedure miContactMenu_FormatsClick(Sender: TObject);
    procedure miContactMenu_InformationsClick(Sender: TObject);
    procedure miContactMenu_EqualizerClick(Sender: TObject);
    procedure miContactMenu_RecordingClick(Sender: TObject);
    procedure miContactMenu_VolumeClick(Sender: TObject);
    procedure miContactMenu_EditStationsClick(Sender: TObject);
    procedure miContactMenu_OptionsClick(Sender: TObject);
    procedure miContactMenu_OnOffClick(Sender: TObject);
    procedure CMAdvDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
      State: TOwnerDrawState);
    procedure ddrrr(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
      Selected: Boolean);

    procedure DrawMenu(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; Selected: Boolean);
    procedure MeasureMenu(Sender: TObject; ACanvas: TCanvas;
      var Width, Height: Integer);
    procedure miContactMenu_FastAddStationClick(Sender: TObject);
    procedure tmrDrawTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure miContactMenu_CopySongNameClick(Sender: TObject);
    procedure pmContactMenuChange(Sender: TObject; Source: TMenuItem;
      Rebuild: Boolean);
  private
    FPluginSvc : pIQIPPluginService;
    FDllHandle : Cardinal;
    FDllPath   : WideString;

    procedure WMHotKey(var msg:TWMHotKey);message WM_HOTKEY;
  public
    property PluginSvc : pIQIPPluginService read FPluginSvc write FPluginSvc;
    property DllHandle : Cardinal           read FDllHandle write FDllHandle;
    property DllPath   : WideString         read FDllPath   write FDllPath;


    procedure CreateControls;
    procedure FreeControls;

    procedure LoadPluginOptions;
    procedure SavePluginOptions;

    procedure ShowPluginOptions;

//    procedure SpellCheck(var PlugMsg: TPluginMessage);
//    procedure SpellPopup(var PlugMsg: TPluginMessage);
    procedure QipSoundChanged(PlugMsg: TPluginMessage);
    procedure AntiBoss(HideForms: Boolean);
    procedure CurrentLanguage(LangName: WideString);
    procedure DrawSpecContact(PlugMsg: TPluginMessage);
    procedure SpecContactDblClick(PlugMsg: TPluginMessage);
    procedure SpecContactRightClick(PlugMsg: TPluginMessage);
    procedure LeftClickOnFadeMsg(PlugMsg: TPluginMessage);
    procedure GetSpecContactHintSize(var PlugMsg: TPluginMessage);
    procedure DrawSpecContactHint(PlugMsg: TPluginMessage);
    procedure XstatusChangedByUser(PlugMsg: TPluginMessage);
    procedure InstantMsgRcvd(var PlugMsg: TPluginMessage);
    procedure InstantMsgSend(var PlugMsg: TPluginMessage);
    procedure NewMessageFlashing(PlugMsg: TPluginMessage);
    procedure NewMessageStopFlashing(PlugMsg: TPluginMessage);
    procedure AddNeededBtns(PlugMsg: TPluginMessage);
    procedure MsgBtnClicked(PlugMsg: TPluginMessage);
    procedure SpecMsgRcvd(PlugMsg: TPluginMessage);
    procedure StatusChanged(PlugMsg: TPluginMessage);
    procedure ImRcvdSuccess(PlugMsg: TPluginMessage);
    procedure ContactStatusRcvd(PlugMsg: TPluginMessage);
    procedure ChatTabAction(PlugMsg: TPluginMessage);
    procedure AddNeededChatBtns(PlugMsg: TPluginMessage);
    procedure ChatBtnClicked(PlugMsg: TPluginMessage);
    procedure ChatMsgRcvd(PlugMsg: TPluginMessage);
    procedure ChatMsgSending(var PlugMsg: TPluginMessage);
    procedure EnumInfo(PlugMsg: TPluginMessage);

    procedure DrawHint(Cnv: TCanvas; R : TRect; CalcRect: Boolean; var Width: Integer; var Height: Integer);

    function  FadeMsg(FType: Byte; FIcon: HICON; FTitle: WideString; FText: WideString; FTextCenter: Boolean; FNoAutoClose: Boolean; pData: Integer) : DWORD;
    procedure AddFadeMsg(
                                    FadeType     : Byte;        //0 - message style, 1 - information style, 2 - warning style
                                    FadeIcon     : HICON;       //icon in the top left corner of the window
                                    FadeTitle    : WideString;
                                    FadeText     : WideString;
                                    TextCentered : Boolean;     //if true then text will be centered inside window
                                    NoAutoClose  : Boolean;     //if NoAutoClose is True then wnd will be always shown until user close it. Not recommended to set this param to True.
                                    CloseTime_Sec: Integer;
                                    pData        : Integer
                                  );


    procedure AddSpecContact(var UniqID: DWord; HeightCnt: Integer = 19);
    procedure RedrawSpecContact(UniqID: DWord);
    procedure RemoveSpecContact(var UniqID: DWord);


    function GetLang(ID: Word) : WideString;

    procedure InfiumClose(itype: Word);

    procedure SetChangeVolume;

    procedure ShowContactMenu(pX, pY : Integer );

    procedure SaveSelectedRadio;
    procedure StationNext;
    procedure StationPrev;




  protected
    procedure CreateParams (var Params: TCreateParams); override;
  end;

var
  frmQIPPlugin: TfrmQIPPlugin;
  FadeMsgs        : TStringList;
  FadeMsgsClosing : TStringList;

implementation

uses General, uImage, Convs, UpdaterUnit, uLNG, HotKeyManager,
     DateUtils, BassPlayer, u_lang_ids, u_qip_plugin, uIcon, Drawing,
     uSuperReplace, uStatistics, uColors, uTheme, uEqualizer, uFileFolder, uINI,
     clipbrd;

{$R *.dfm}

procedure TfrmQIPPlugin.CreateParams (var Params: TCreateParams);
begin
  inherited;
    with Params do begin
      ExStyle := (ExStyle or WS_EX_TOOLWINDOW or WS_EX_NOACTIVATE);
    end;
end;

procedure TfrmQIPPlugin.WMHotKey(var msg:TWMHotKey);
var
  INI : TIniFile;
begin

  if msg.HotKey = 8801 then
    FBassPlayer.PlayStopRadio
  else if msg.HotKey = 8802 then
  begin
    Player_Volume := Player_Volume + 5;

    if Player_Volume > 100 then
      Player_Volume := 100;

    SetChangeVolume;
  end
  else if msg.HotKey = 8803 then
  begin
    Player_Volume := Player_Volume - 5;

    if Player_Volume < 0 then
      Player_Volume := 0;

    SetChangeVolume;
  end
  else if msg.HotKey = 8804 then
  begin
    if Player_Mute = False then
      Player_Mute := True
    else
      Player_Mute := False;

    SetChangeVolume;
  end
  else if msg.HotKey = 8805 then
  begin
    StationNext();
  end
  else if msg.HotKey = 8806 then
  begin
    StationPrev();
  end
  else if msg.HotKey = 8807 then  // Enable/Disable XStatus
  begin
    EnDisXStatus(-1);
  end;

end;

procedure TfrmQIPPlugin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  Unload_BASSDLL;
end;

procedure TfrmQIPPlugin.FormCreate(Sender: TObject);
begin

  FadeMsgs := TStringList.Create;
  FadeMsgs.Clear;

  FadeMsgsClosing := TStringList.Create;
  FadeMsgsClosing.Clear;

  Stations := TStringList.Create;
  Stations.Clear;

  Playlist := TStringList.Create;
  Playlist.Clear;

  DataImportExport := TStringList.Create;
  DataImportExport.Clear;

  EqualizerPreset := TStringList.Create;
  EqualizerPreset.Clear;

  PluginSkin.MenuIcons := TStringList.Create;
  PluginSkin.MenuIcons.Clear;

  PluginSkin.OptionsIcons := TStringList.Create;
  PluginSkin.OptionsIcons.Clear;


  DTFormatDATETIME.DateSeparator   := '-';
  DTFormatDATETIME.TimeSeparator   := ':';
  DTFormatDATETIME.ShortDateFormat := 'YYYY-MM-DD';
  DTFormatDATETIME.ShortTimeFormat := 'HH:MM:SS';
  DTFormatDATETIME.LongDateFormat := 'YYYY-MM-DD''  ''HH:MM:SS';


  FBassPlayer := TfrmBassPlayer.Create(nil);
//  FBassPlayer.Show;
  FBassPlayer.Height := 0;
  FBassPlayer.Width := 0;
  SetWindowPos(FBassPlayer.Handle,HWND_BOTTOM,0,0,0,0, SWP_NOACTIVATE {or SWP_SHOWWINDOW} or SWP_NOMOVE or SWP_NOSIZE);


end;


procedure TfrmQIPPlugin.CreateControls;
begin
  //
end;

procedure TfrmQIPPlugin.FreeControls;
var RepMsg : TPluginMessage;
    Repl_XStatus : TReplXStatus;
    xRP : Boolean;
begin

  xRP := False;

  try
    if Radio_Playing=True then
    begin
      xRP := True;
      FBassPlayer.PlayStopRadio
    end;
  except

  end;

  try

    if xRP = True then
    begin
      if (ActXstatusNum=11) or (XStatus_Type = 2)  then
      begin
        if Radio_Playing=True then
        begin
          //FwStatus and FwDescription have to be class members or global variables to stay in memory because we return PWideChar
          if Stations.Count - 1 >= Radio_StationID then
          begin
            Repl_XStatus.Station     := TStation(Stations.Objects[Radio_StationID]).Name;
            Repl_XStatus.Genre       := TStation(Stations.Objects[Radio_StationID]).Genre;

            if TStation(Stations.Objects[Radio_StationID]).Streams.Count - 1 >= Radio_StreamID then
              Repl_XStatus.Format      := TStream(TStation(Stations.Objects[Radio_StationID]).Streams.Objects[Radio_StreamID]).Format;

            Repl_XStatus.Language    := TStation(Stations.Objects[Radio_StationID]).Language;
            Repl_XStatus.StationWeb  := TStation(Stations.Objects[Radio_StationID]).URL;
          end;

          FwStatus      := ReplXStatus(XStatus_Title,Repl_XStatus);// 'Listenig radio:';   //max xstatus text length = 20 chars

          if Stations.Count - 1 < Radio_StationID then
            FwDescription := ''                 //max description text length = 512 chars
          else
            FwDescription := ReplXStatus(XStatus_Text,Repl_XStatus); //TSLStation(Stations.Objects[Radio_StationID]).Name; //max description text length = 512 chars

        end
        else
        begin
          FwStatus      :=  LastXStatusText ; {''; }                    //max xstatus text length = 20 chars
          FwDescription := LastXStatusDescription; {'';}                 //max description text length = 512 chars
        end;

        {Plugin msg to update xstatus}
        RepMsg.Msg       := PM_PLUGIN_XSTATUS_UPD;

        { WParam is number of xstatus picture in Core/Xstatuses/xstatuses.ini, if 0 then xstatus pic will be removed}
        {When changing music track you can change xstatus picture number, it will cauz all clients to request your new
         xstatus value, but better to make it optional, because it can be bothering for remote users}

        if (Radio_Playing=False) And (XStatus_Type = 2)  then
          RepMsg.WParam    := LastXStatusNumber { 0 }// Xstatus - not
        else
          RepMsg.WParam    := 11; // Xstatus - Music

        RepMsg.LParam    := LongInt(PWideChar(FwStatus));
        RepMsg.NParam    := LongInt(PWideChar(FwDescription));

        {when plugin sending msg to qip core it have to add self dllhandle, else your msg will be ignored}
        RepMsg.DllHandle := DllHandle;

        {send message to qip core. !!! Dont change xtatus too often, it can cauz disconnect}
        FPluginSvc.OnPluginMessage(RepMsg);
        {================================================================}
      end;

    end;
  except

  end;


  try
    if bBassLoadLibLoaded = True then
      FBassPlayer.BASSPlayer_AllFree;
  finally

  end;


  try
    UnregisterHotKey(QIPPlugin.Handle, 8801);
  except

  end;

  try
    UnregisterHotKey(QIPPlugin.Handle, 8802);
  except

  end;

  try
    UnregisterHotKey(QIPPlugin.Handle, 8803);
  except

  end;

  try
    UnregisterHotKey(QIPPlugin.Handle, 8804);
  except

  end;

  try
    UnregisterHotKey(QIPPlugin.Handle, 8805);
  except

  end;

  try
    UnregisterHotKey(QIPPlugin.Handle, 8806);
  except

  end;

  try
    UnregisterHotKey(QIPPlugin.Handle, 8807);
  except

  end;

  try
    if Assigned(FBassPlayer) then FreeAndNil(FBassPlayer);
  except

  end;

  try
    if Assigned(FAbout) then FreeAndNil(FAbout);
  except

  end;

  try
    if Assigned(FEqualizer) then FreeAndNil(FEqualizer);
  except

  end;

  try
    if Assigned(FFastAddStation) then FreeAndNil(FFastAddStation);
  except

  end;

  try
    if Assigned(FEditStations) then FreeAndNil(FEditStations);
  except

  end;

  try
    if Assigned(FInfo) then FreeAndNil(FInfo);
  except

  end;

  try
    if Assigned(FOptions) then FreeAndNil(FOptions);
  except

  end;

  try
    if Assigned(FRecording) then FreeAndNil(FRecording);
  except

  end;

  try
    if Assigned(FVolume) then FreeAndNil(FVolume);
  except

  end;



end;

procedure TfrmQIPPlugin.LoadPluginOptions;
var
    PlugMsg1: TPluginMessage;
    QipColors : pQipColors;

begin
  PlugMsg1.Msg       := PM_PLUGIN_GET_NAMES;
  PlugMsg1.DllHandle := DllHandle;

  FPluginSvc.OnPluginMessage(PlugMsg1);

  if Boolean(PlugMsg1.Result) then
  begin
    Account_DisplayName := PWideChar(PlugMsg1.WParam);
    Account_ProfileName := PWideChar(PlugMsg1.LParam);
  end;

  Account_FileName   := Account_ProfileName;

  // Profile path
  PlugMsg1.Msg       := PM_PLUGIN_GET_PROFILE_DIR;
  PlugMsg1.DllHandle := DllHandle;

  FPluginSvc.OnPluginMessage(PlugMsg1);

  if Boolean(PlugMsg1.Result) then
  begin
    ProfilePath := PWideChar(PlugMsg1.WParam) + PLUGIN_NAME + '\';;
  end;


  PlugMsg1.Msg       := PM_PLUGIN_GET_COLORS_FONT;
  PlugMsg1.DllHandle := DllHandle;

  FPluginSvc.OnPluginMessage(PlugMsg1);

  //get results
{  wFontName := PWideChar(PlugMsg1.WParam);
  iFontSize := PlugMsg1.LParam;}
  QipColors := pQipColors(PlugMsg1.NParam);

  QIP_Colors := QipColors^;


  CheckFolder( ProfilePath, False );


  tmrStart.Enabled := True;

end;

procedure TfrmQIPPlugin.miContactMenu_CopySongNameClick(Sender: TObject);
var
  A: array[0..65000] of char;
  Repl_XStatus : TReplXStatus;
  sCopyText : WideString;
begin

  if (Stations.Count - 1 < Radio_StationID) AND (Radio_StationID <> -1) then

  else
  begin
    Repl_XStatus.Station     := TStation(Stations.Objects[Radio_StationID]).Name;
    Repl_XStatus.Genre       := TStation(Stations.Objects[Radio_StationID]).Genre;

    if (TStation(Stations.Objects[Radio_StationID]).Streams.Count - 1 >= Radio_StreamID) AND  (Radio_StreamID <> -1) then
      Repl_XStatus.Format      := TStream(TStation(Stations.Objects[Radio_StationID]).Streams.Objects[Radio_StreamID]).Format;

    Repl_XStatus.Language    := TStation(Stations.Objects[Radio_StationID]).Language;
    Repl_XStatus.StationWeb  := TStation(Stations.Objects[Radio_StationID]).URL;

    sCopyText := ReplXStatus('%song%',Repl_XStatus);

    StrPCopy(A, sCopyText );
    Clipboard.SetTextBuf(A);
  end;

end;

procedure TfrmQIPPlugin.miContactMenu_EditStationsClick(Sender: TObject);
begin
  OpenEditStations;
end;

procedure TfrmQIPPlugin.miContactMenu_EqualizerClick(Sender: TObject);
begin
  OpenEqualizer;
end;

procedure TfrmQIPPlugin.miContactMenu_FastAddStationClick(Sender: TObject);
begin
  OpenFastAddStation;
end;

procedure TfrmQIPPlugin.miContactMenu_FormatsClick(Sender: TObject);

begin

  if Sender <> miContactMenu_Formats then
  begin
//    Radio_StationID := (Sender as TMenuItem).Tag;
    Radio_StreamID  := (Sender as TMenuItem).Tag;

    if SaveLastStream = True then
      TStation(Stations.Objects[Radio_StationID]).DefaultStream := Radio_StreamID;

    SaveSelectedRadio;

    if Radio_Playing = True then
    begin
      FBassPlayer.PlayStopRadio;

      Application.ProcessMessages;

      FBassPlayer.PlayStopRadio;
    end;

    RedrawSpecContact(UniqContactId);

  end;


end;

procedure TfrmQIPPlugin.miContactMenu_InformationsClick(Sender: TObject);
begin
  OpenInfo;
end;

procedure TfrmQIPPlugin.miContactMenu_OnOffClick(Sender: TObject);
begin
  FBassPlayer.PlayStopRadio;
end;

procedure TfrmQIPPlugin.MeasureMenu(Sender: TObject;
  ACanvas: TCanvas; var Width, Height: Integer);
begin
  Menu_MeasureMenu(Sender, ACanvas, Width, Height);
end;

procedure TfrmQIPPlugin.DrawMenu(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
begin
  Menu_DrawMenu(Sender, ACanvas, ARect, Selected);
end;

procedure TfrmQIPPlugin.miContactMenu_OptionsClick(Sender: TObject);
begin
  OpenOptions;
end;

procedure TfrmQIPPlugin.miContactMenu_RecordingClick(Sender: TObject);
begin
  OpenRecording;
end;

procedure TfrmQIPPlugin.miContactMenu_StationsClick(Sender: TObject);
begin
  if Sender <> miContactMenu_Stations then
  begin
    Radio_StationID := (Sender as TMenuItem).Tag;
    Radio_StreamID  := TStation(Stations.Objects[Radio_StationID]).DefaultStream;

    SaveSelectedRadio;

    if Radio_Playing = True then
    begin
      FBassPlayer.PlayStopRadio;

      Application.ProcessMessages;

      FBassPlayer.PlayStopRadio;
    end;

    RedrawSpecContact(UniqContactId);
  end;
end;

procedure TfrmQIPPlugin.miContactMenu_VolumeClick(Sender: TObject);
begin
  OpenVolume;
end;

procedure TfrmQIPPlugin.SavePluginOptions;
var
  INI : TIniFile;

begin

  INIGetProfileConfig(INI);

  if Assigned(Stations) then
  begin
    if Radio_StationID > Stations.Count - 1 then
      //dodelat
    else
    begin
      INIWriteStringUTF8(INI, 'Conf', 'StationID', TStation(Stations.Objects[ Radio_StationID ]).Name );
    end;

    INIWriteInteger(INI, 'Conf', 'StreamID', Radio_StreamID );
  end;

  INIFree(INI);

end;

procedure TfrmQIPPlugin.ShowPluginOptions;
begin
  OpenOptions;
end;

procedure OldSetToNewPLugin(INI: TINIFile);
var
  S: TextFile;
  Rec: TSearchRec;
  pom: String;
  idx: Integer;
  INI2: TINIFile;
begin

  if (UTF82WideString(INIReadStringUTF8(INI, 'Plugin', 'Version', PluginVersion)) >= '0.6.1') and (UTF82WideString(INIReadStringUTF8(INI, 'Plugin', 'Version', PluginVersion)) <= '0.6.1.99 beta') then
  begin
    INIGetProfileConfig(INI2);
    pom := INI2.ReadString('Equalizer', 'Values', '') + ', ';
    for idx := 10 to FrequencyCount do
      pom := pom + '0, ';
    Delete(pom, Length(pom) - 1, 2); // smazání poslední mezery s èárkou
    INI2.WriteString('Equalizer', 'Values', pom);
    INIFree(INI2);
  end;

  if (UTF82WideString(INIReadStringUTF8(INI, 'Plugin', 'Version', PluginVersion)) >= '0.6.0') and (UTF82WideString(INIReadStringUTF8(INI, 'Plugin', 'Version', PluginVersion)) <= '0.6.0 beta 8') then
  begin
    CopyFileIfExists(PluginDllPath+Account_FileName+'.ini',PluginDllPath + 'Profiles\' + Account_FileName + '\config.ini');
    CopyFileIfExists(PluginDllPath+'statistic_'+Account_FileName+'.ini',PluginDllPath + 'Profiles\' + Account_FileName + '\statistic.ini');
    CopyFileIfExists(PluginDllPath+'stations.ftx',PluginDllPath + 'Profiles\' + Account_FileName + '\stations.ftx');
    DeleteFileIfExists(PluginDllPath+Account_FileName+'.ini');
    DeleteFileIfExists(PluginDllPath+'statistic_'+Account_FileName+'.ini');
    DeleteFileIfExists(PluginDllPath+'stations.ftx');
    DeleteFileIfExists(PluginDllPath+'Skins\FMtune Big\skin.ini');
    DeleteFileIfExists(PluginDllPath+'Skins\FMtune Big\graph.dll');
    RemoveFolderIfExists(PluginDllPath+'Skins\FMtune Big');
    INIGetProfileConfig(INI2);
    INI2.DeleteKey('Conf', 'ScrollText');
    INIFree(INI2);
  end;

  if (UTF82WideString(INIReadStringUTF8(INI, 'Plugin', 'Version', PluginVersion)) < '0.6.0') then
  begin
    DeleteFileIfExists(PluginDllPath+'Skins\FMtune\error.ico');
    DeleteFileIfExists(PluginDllPath+'Skins\FMtune\icon.ico');
    DeleteFileIfExists(PluginDllPath+'Skins\FMtune\pause.ico');
    DeleteFileIfExists(PluginDllPath+'Skins\FMtune\play.ico');
    DeleteFileIfExists(PluginDllPath+'Skins\FMtune\record.ico');
    DeleteFileIfExists(PluginDllPath+'Skins\FMtune\stop.ico');
    DeleteFileIfExists(PluginDllPath+'Skins\FMtune Big\error.ico');
    DeleteFileIfExists(PluginDllPath+'Skins\FMtune Big\icon.ico');
    DeleteFileIfExists(PluginDllPath+'Skins\FMtune Big\pause.ico');
    DeleteFileIfExists(PluginDllPath+'Skins\FMtune Big\play.ico');
    DeleteFileIfExists(PluginDllPath+'Skins\FMtune Big\record.ico');
    DeleteFileIfExists(PluginDllPath+'Skins\FMtune Big\stop.ico');
    DeleteFileIfExists(PluginDllPath+'Skins\FMtune Big\skin.ini');
    RemoveFolderIfExists(PluginDllPath+'Skins\FMtune Big');
    DeleteFileIfExists(PluginDllPath+'Skins\iSimple\error.ico');
    DeleteFileIfExists(PluginDllPath+'Skins\iSimple\icon.ico');
    DeleteFileIfExists(PluginDllPath+'Skins\iSimple\pause.ico');
    DeleteFileIfExists(PluginDllPath+'Skins\iSimple\play.ico');
    DeleteFileIfExists(PluginDllPath+'Skins\iSimple\record.ico');
    DeleteFileIfExists(PluginDllPath+'Skins\iSimple\record2.ico');
    DeleteFileIfExists(PluginDllPath+'Skins\iSimple\stop.ico');
    DeleteFileIfExists(PluginDllPath+'Skins\iSimple\sound.ico');
    DeleteFileIfExists(PluginDllPath+'icon.ico');

    pom := '';
    pom := pom + INIReadStringUTF8(INI, 'Equalizer', 'f70', '0');
    INI.DeleteKey('Equalizer', 'f70');
    pom := pom + ', ' + INIReadStringUTF8(INI, 'Equalizer', 'f180', '0');
    INI.DeleteKey('Equalizer', 'f180');
    pom := pom + ', ' + INIReadStringUTF8(INI, 'Equalizer', 'f320', '0');
    INI.DeleteKey('Equalizer', 'f320');
    pom := pom + ', ' + INIReadStringUTF8(INI, 'Equalizer', 'f600', '0');
    INI.DeleteKey('Equalizer', 'f600');
    pom := pom + ', ' + INIReadStringUTF8(INI, 'Equalizer', 'f1k', '0');
    INI.DeleteKey('Equalizer', 'f1k');
    pom := pom + ', ' + INIReadStringUTF8(INI, 'Equalizer', 'f3k', '0');
    INI.DeleteKey('Equalizer', 'f3k');
    pom := pom + ', ' + INIReadStringUTF8(INI, 'Equalizer', 'f6k', '0');
    INI.DeleteKey('Equalizer', 'f6k');
    pom := pom + ', ' + INIReadStringUTF8(INI, 'Equalizer', 'f12k', '0');
    INI.DeleteKey('Equalizer', 'f12k');
    pom := pom + ', ' + INIReadStringUTF8(INI, 'Equalizer', 'f14k', '0');
    INI.DeleteKey('Equalizer', 'f14k');
    pom := pom + ', ' + INIReadStringUTF8(INI, 'Equalizer', 'f16k', '0');
    INI.DeleteKey('Equalizer', 'f16k');

    INIWriteStringUTF8(INI, 'Equalizer', 'Values', pom);
    INIWriteStringUTF8(INI, 'Conf', 'Skin', 'FMtune');
    INI.DeleteKey('Conf', 'Language');
    INI.EraseSection('Plugin');

    if FindFirst(QIPInfiumPath + 'Profiles\*.*', faDirectory, Rec) = 0 then
    begin
      While FindNext(Rec) = 0 do
      begin
        if ExtractFileExt(Rec.Name) <> '' then
           Rec.Name := '';

        if Rec.Name = '' then
        else if Rec.Name = '.' then
        else if Rec.Name = '..' then
        else
        begin

          {if not DirectoryExists(PluginDllPath + 'Profiles\'+Copy(Rec.Name, 1, Length(Rec.Name))) then
            CreateDir(PluginDllPath + 'Profiles\'+Copy(Rec.Name, 1, Length(Rec.Name)));}
          CheckFolder( PluginDllPath + 'Profiles\'+Copy(Rec.Name, 1, Length(Rec.Name)) , False );

          CopyFileIfExists(PluginDllPath+'FMtune.ini',PluginDllPath + 'Profiles\' + Copy(Rec.Name, 1, Length(Rec.Name)) + '\config.ini');
          CopyFileIfExists(PluginDllPath+'stations.ftx',PluginDllPath + 'Profiles\' + Copy(Rec.Name, 1, Length(Rec.Name)) + '\stations.ftx');
//showmessage (  PluginDllPath+ Copy(Rec.Name, 1, Length(Rec.Name)) + '.ini'  ) ;
//          AssignFile(S,{PChar(}PluginDllPath+ Copy(Rec.Name, 1, Length(Rec.Name)) + '.ini'{)});
//          Reset(S);
//          WriteLn(S,'; Code page: UTF-8');
//          WriteLn(S);
//          CloseFile(S);
        end;
      end;
    end;
    FindClose(Rec);

    DeleteFileIfExists(PluginDllPath+'stations.ftx');

    AssignFile(S,PluginDllPath + PLUGIN_NAME + '.ini');
    Rewrite(S);
    CloseFile(S);
  end;


  if (UTF82WideString(INIReadStringUTF8(INI, 'Plugin', 'Version', PluginVersion)) <= '0.6.3') then
  begin
    INI.EraseSection('Proxy');
    INIGetProfileConfig(INI2);
    if INIReadBool(INI2, 'Proxy', 'Enabled', false) = false then
      INIWriteInteger(INI2, 'Proxy', 'Mode', 0)
    else
      INIWriteInteger(INI2, 'Proxy', 'Mode', 2);
    INIDeleteKey(INI2, 'Proxy', 'Enabled');
    INIFree(INI2);
  end;


  // --- pøevod aktuální profilu, pøevádí vždy pokud nebylo pøevedeno
  if DirectoryExists( PluginDllPath + 'Profiles\' + Account_FileName ) = True then
  begin
    //presunout do noveho umisteni
    MoveFileIfExists( PluginDllPath + 'Profiles\' + Account_FileName + '\config.ini',    ProfilePath + 'config.ini' );
    MoveFileIfExists( PluginDllPath + 'Profiles\' + Account_FileName + '\statistic.ini', ProfilePath + 'statistic.ini' );
    MoveFileIfExists( PluginDllPath + 'Profiles\' + Account_FileName + '\stations.ftx',  ProfilePath + 'stations.ftx' );

    //odstrani starou slozku profilu
    RemoveFolderIfExists( PluginDllPath + 'Profiles\' + Account_FileName );

    //odstrani slozku starou Profiles (pouze pokud je prazdna)
    RemoveFolderIfExists( PluginDllPath + 'Profiles' );
  end;

end;

procedure TfrmQIPPlugin.tmrDrawTimer(Sender: TObject);
var bCntRedraw : Boolean;
    Repl_XStatus : TReplXStatus;
begin
  tmrDraw.Enabled := False;
  bCntRedraw := False;

  if SpecCntInfoTextScroll = True then
  begin
    Dec(SpecCntInfoTextX, 1);

    if SpecCntInfoTextX = -SpecCntInfoTextWidth then
      SpecCntInfoTextX := SpecCntInfoMaxWidth;

    bCntRedraw := True;
  end;

  if SpecCntInfo2TextScroll = True then
  begin
    Dec(SpecCntInfo2TextX, 1);

    if SpecCntInfo2TextX = -SpecCntInfo2TextWidth then
      SpecCntInfo2TextX := SpecCntInfo2MaxWidth;

    bCntRedraw := True;
  end;

//showmessage( inttostr(Radio_StationID ) +#13 + inttostr(Radio_StreamID ) );

  if (Stations.Count - 1 >= Radio_StationID) AND  (Radio_StationID <> -1) then
  begin

    //if (Radio_StationID <> -1) AND (Radio_StreamID <> -1) then
    if (TStation(Stations.Objects[Radio_StationID]).Streams.Count - 1 >= Radio_StreamID) AND  (Radio_StreamID <> -1) then
    begin

      Repl_XStatus.Station     := TStation(Stations.Objects[Radio_StationID]).Name;
      Repl_XStatus.Genre       := TStation(Stations.Objects[Radio_StationID]).Genre;
      Repl_XStatus.Format      := TStream(TStation(Stations.Objects[Radio_StationID]).Streams.Objects[Radio_StreamID]).Format;
      Repl_XStatus.Language    := TStation(Stations.Objects[Radio_StationID]).Language;
      Repl_XStatus.StationWeb  := TStation(Stations.Objects[Radio_StationID]).URL;
    end

  end
  else
  begin
    Repl_XStatus.Station     := '';
    Repl_XStatus.Genre       := '';
    Repl_XStatus.Format      := '';
    Repl_XStatus.Language    := '';
    Repl_XStatus.StationWeb  := '';
  end;


  if ReplXStatus(SpecCntLine1Text,Repl_XStatus) <> SpecCntInfoText then
    bCntRedraw := True;

  if ReplXStatus(SpecCntLine2Text,Repl_XStatus) <> SpecCntInfo2Text then
    bCntRedraw := True;

  if bCntRedraw = True then
    RedrawSpecContact(UniqContactId);

  tmrDraw.Enabled := True;

end;

procedure TfrmQIPPlugin.tmrStartTimer(Sender: TObject);
var
  hLibraryPics    : THandle;
  F : TextFile;
  FName : WideString;
  INI : TINIFile;
  sXStatusTitle,sXStatusText, sPopupText, sL1Text, sL2Text: WideString;
  PlugMsg1: TPluginMessage;
  idx : Integer;
//  iMod, iKey: Word;
//  hIndex: Integer;
  sColor: WideString;
  NetParams : pNetParams;

begin
  tmrStart.Enabled := False;
  StatisticsRadioTime := 0; // nastavení pøehrávání rádia na 0

(*  //// Tato vìc je prozatím k nièemu :D           ale vypadá hezky :D
  osVerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo) ;
  if GetVersionEx(osVerInfo) then;
  if osVerInfo.dwMajorVersion < 6 then
    pmContactMenu.Images := ImageList1
  else
    pmContactMenu.Images := nil;
  ///////////////*)

(*  // Tvorba složky profilù, pokud neexistují
  if not DirectoryExists(PluginDllPath + 'Profiles') then
  begin
    CreateDir(PluginDllPath + 'Profiles');
  end;

  if not DirectoryExists(PluginDllPath + 'Profiles\'+Account_FileName) then
  begin
    CreateDir(PluginDllPath + 'Profiles\'+Account_FileName);
  end;
  // ---*)

  INI := TiniFile.Create(PluginDllPath + PLUGIN_NAME + '.ini');

  // Pøevod starého nastavení uživatelù pro novou verzi
  OldSetToNewPlugin(INI);

  INIWriteStringUTF8(INI, 'Plugin', 'Version', PluginVersion);
  INIWriteStringUTF8(INI, 'SDK', 'Version', IntToStr(QIP_SDK_VER_MAJOR) + '.' + IntToStr(QIP_SDK_VER_MINOR));

  //// Naètení barev
  sColor     := INIReadStringUTF8(INI, 'Colors', '1', 'F0F0F0');  //frmBgColor = $00F0F0F0;//$00FFEEDD;
  frmBgColor := RGB( StrToInt('$' + Copy(sColor,1,2)),
                     StrToInt('$' + Copy(sColor,3,2)),
                     StrToInt('$' + Copy(sColor,5,2)));
  INIWriteStringUTF8(INI, 'Colors', '1', sColor);
  INIFree(INI);


  INIGetProfileConfig(INI);

  PluginLanguage := INIReadStringUTF8(INI, 'Conf', 'Language', '<default>');

  CheckUpdates := INIReadBool(INI, 'Conf', 'CheckUpdates', True );
  CheckUpdatesInterval := INIReadInteger(INI, 'Conf', 'CheckUpdatesInterval', 6);
  CheckBetaUpdates := INIReadBool(INI, 'Conf', 'CheckBetaUpdates', False );

  // pokud je plugin v testovací fázi, jsou zapnuty beta aktualizace
  if Trim(PLUGIN_VER_BETA) <> '' then
    begin
      CheckBetaUpdates := True;
    end;

  PluginTheme.Name := INIReadStringUTF8(INI, 'Conf', 'Skin', 'FMtune');

  OpenTheme;

  sNStationID     := INIReadStringUTF8(INI, 'Conf', 'StationID', '');
  Radio_StreamID  := INIReadInteger(INI, 'Conf', 'StreamID', 0);

  UseQIPMute := INIReadBool(INI, 'Conf', 'UseQIPMute', false );
  ShowComments := INIReadBool(INI, 'Conf', 'ShowComments', true);
  LoadSongsExternal := INIReadBool(INI, 'Conf', 'LoadSongsExternal', true);
  ShowCover := INIReadBool(INI, 'Conf', 'ShowCover', true);
  SaveCover := INIReadBool(INI, 'Conf', 'SaveCover', false);


  PlayOnStart := INIReadBool(INI, 'Conf', 'PlayOnStart', false);

  Player_Volume := INIReadInteger(INI, 'Conf', 'Volume', 50);

  SetChangeVolume;

  SaveLastStream := INIReadBool(INI, 'Conf', 'SaveLastStream', false);

  HotKeyEnabled     := INIReadBool(INI, 'Conf', 'HotKey', false);
  HotKeyFMtune      := INIReadInteger(INI, 'Conf', 'HotKeyFMtune', 49222) ;
  HotKeyVolumeUp    := INIReadInteger(INI, 'Conf', 'HotKeyVolumeUp', 49342) ;
  HotKeyVolumeDown  := INIReadInteger(INI, 'Conf', 'HotKeyVolumeDown', 49340) ;
  HotKeyMute        := INIReadInteger(INI, 'Conf', 'HotKeyMute', 49240) ;
  HotKeyStationNext := INIReadInteger(INI, 'Conf', 'HotKeyStationNext', 49228) ;
  HotKeyStationPrev := INIReadInteger(INI, 'Conf', 'HotKeyStationPrev', 49227) ;
  HotKeyEnableDisableXStatus := INIReadInteger(INI, 'Conf', 'HotKeyEnableDisableXStatus', 49235);

  XStatus_Boolean := INIReadBool(INI, 'XStatus', 'Enabled', false) ;

  XStatus_Type := INIReadInteger(INI, 'XStatus', 'Type', 2) ;

  sXStatusTitle:= LNG('DEFAULT', 'XStatus.Title', 'I am listening to radio');
  sXStatusText :=  LNG('DEFAULT', 'XStatus.Text', '%station%');

  XStatus_Title := INIReadStringUTF8(INI, 'XStatus', 'Title', sXStatusTitle);
  XStatus_Text  := INIReadStringUTF8(INI, 'XStatus', 'Text', sXStatusText );

  ShowPopups := INIReadBool(INI, 'Popup', 'Enabled', false);
  PopupType :=  INIReadInteger(INI, 'Popup', 'Type', 2) ;

  sPopupText := LNG('DEFAULT', 'PopUp.Text', '%station%');
  PopupText := INIReadStringUTF8(INI, 'Popup', 'Text', sPopupText);
  ShowPopUpIfChangeInfo := INIReadBool(INI, 'Popup', 'ShowPopUpIfChangeInfo', false);

  EqualizerEnabled := INIReadBool(INI, 'Equalizer', 'Enabled', false);

  LoadEqualizerSettings;

  Proxy_Mode := INIReadInteger(INI, 'Proxy', 'Mode', 0);
  case Proxy_Mode of
  0: ;
  1: begin
       PlugMsg1.Msg       := PM_PLUGIN_GET_NET_SET;
       PlugMsg1.DllHandle := DllHandle;
       FPluginSvc.OnPluginMessage(PlugMsg1);
       if Boolean(PlugMsg1.Result) then
       begin
         NetParams := pNetParams(PWideChar(PlugMsg1.WParam)); // Získání parametrù o pøipojení
         case NetParams.ConType of
         0: ;     // pøímé spojení
         1,       // automatické nastavení
         2: begin // ruèní nastavení
              Proxy_Server := '[' +     NetParams.PrxUser + ':'  +
                                        NetParams.PrxPass + ']@' +
                                        NetParams.PrxHost + ':'  +
                              IntToStr( NetParams.PrxPort ) ;
            end;
         end;
       end
       else
         ShowMessage('Proxy wasn''t configured');
     end;
  2: Proxy_Server := INIReadStringUTF8(INI, 'Proxy', 'Server', '');
  end;

  AutoUseWherePlaying := INIReadBool(INI, 'Conf', 'AutoOnOffUseWherePlaying', true );

  AutoStatusFFC := INIReadInteger(INI, 'Conf', 'AutoOnOffFFC', 0 );
  AutoStatusEvil := INIReadInteger(INI, 'Conf', 'AutoOnOffEvil', 0 );
  AutoStatusDepres := INIReadInteger(INI, 'Conf', 'AutoOnOffDepres', 0 );
  AutoStatusAtHome := INIReadInteger(INI, 'Conf', 'AutoOnOffAtHome', 0 );
  AutoStatusAtWork := INIReadInteger(INI, 'Conf', 'AutoOnOffAtWork', 0 );
  AutoStatusLunch := INIReadInteger(INI, 'Conf', 'AutoOnOffLunch', 0 );
  AutoStatusAway := INIReadInteger(INI, 'Conf', 'AutoOnOffAway', 0 );
  AutoStatusNA := INIReadInteger(INI, 'Conf', 'AutoOnOffNA', 0 );
  AutoStatusOccupied := INIReadInteger(INI, 'Conf', 'AutoOnOffOccupied', 0 );
  AutoStatusDND := INIReadInteger(INI, 'Conf', 'AutoOnOffDND', 0 );
  AutoStatusOnline := INIReadInteger(INI, 'Conf', 'AutoOnOffOnline', 0 );
  AutoStatusInvisible := INIReadInteger(INI, 'Conf', 'AutoOnOffInvisible', 0 );
  AutoStatusOffline := INIReadInteger(INI, 'Conf', 'AutoOnOffOffline', 0 );


  sL1Text := WideString2UTF8( LNG('DEFAULT', 'SpecCnt.Line1', '%station%') );
  sL2Text := WideString2UTF8( LNG('DEFAULT', 'SpecCnt.Line2', '%song%') );

  SpecCntShowLine2 := INIReadBool(INI, 'SpecCnt', 'ShowLine2', false );

  SpecCntLine1Text := INIReadStringUTF8(INI, 'SpecCnt', 'L1Text', sL1Text);
  SpecCntLine2Text := INIReadStringUTF8(INI, 'SpecCnt', 'L2Text', sL2Text );

  SpecCntLine1ScrollText := INIReadBool(INI, 'SpecCnt', 'L1ScrollText', true );
  SpecCntLine2ScrollText := INIReadBool(INI, 'SpecCnt', 'L2ScrollText', false );


  INIFree(INI);

  Pics := PluginDllPath + 'pics.dll';
  hLibraryPics := LoadLibrary(PChar(Pics));

  if hLibraryPics=0 then
  begin
    ShowMessage( TagsReplace( StringReplace(LNG('Texts', 'LibraryNotLoad', 'Can''t load library %file%.[br]Plugin can be unstable.'), '%file%', 'pics.dll', [rfReplaceAll, rfIgnoreCase]) ) );
    Exit;
  end;

  PluginSkin.PluginIconBig        := LoadImageFromResource(10, hLibraryPics);

  PluginSkin.PluginIcon.Image     := LoadImageFromResource(11, hLibraryPics);
  PluginSkin.PluginIcon.Icon      := LoadImageAsIconFromResource(11, hLibraryPics);

  PluginSkin.Options.Image        := LoadImageFromResource(12, hLibraryPics);
  PluginSkin.Options.Icon         := LoadImageAsIconFromResource(12, hLibraryPics);

  PluginSkin.Volume.Image         := LoadImageFromResource(13, hLibraryPics);
  PluginSkin.Volume.Icon          := LoadImageAsIconFromResource(13, hLibraryPics);

  PluginSkin.Equalizer.Image      := LoadImageFromResource(14, hLibraryPics);
  PluginSkin.Equalizer.Icon       := LoadImageAsIconFromResource(14, hLibraryPics);

  PluginSkin.Info.Image           := LoadImageFromResource(15, hLibraryPics);
  PluginSkin.Info.Icon            := LoadImageAsIconFromResource(15, hLibraryPics);

  PluginSkin.Recording.Image      := LoadImageFromResource(16, hLibraryPics);
  PluginSkin.Recording.Icon       := LoadImageAsIconFromResource(16, hLibraryPics);

  PluginSkin.Stations.Image       := LoadImageFromResource(17, hLibraryPics);
  PluginSkin.Stations.Icon        := LoadImageAsIconFromResource(17, hLibraryPics);

  PluginSkin.Formats.Image        := LoadImageFromResource(18, hLibraryPics);
  PluginSkin.Formats.Icon         := LoadImageAsIconFromResource(18, hLibraryPics);

  PluginSkin.EditStations.Image   := LoadImageFromResource(19, hLibraryPics);
  PluginSkin.EditStations.Icon    := LoadImageAsIconFromResource(19, hLibraryPics);

  PluginSkin.FastAddStation.Image := LoadImageFromResource(20, hLibraryPics);
  PluginSkin.FastAddStation.Icon  := LoadImageAsIconFromResource(20, hLibraryPics);

  PluginSkin.Copy.Image           := LoadImageFromResource(21, hLibraryPics);
  PluginSkin.Copy.Icon            := LoadImageAsIconFromResource(21, hLibraryPics);


  PluginSkin.ItemAdd.Image        := LoadImageFromResource(22, hLibraryPics);
  PluginSkin.ItemRemove.Image     := LoadImageFromResource(23, hLibraryPics);
  PluginSkin.ItemUp.Image         := LoadImageFromResource(24, hLibraryPics);
  PluginSkin.ItemDown.Image       := LoadImageFromResource(25, hLibraryPics);


  PluginSkin.ST_online.Image      := LoadImageFromResource(26, hLibraryPics);
  PluginSkin.ST_online.Icon       := LoadImageAsIconFromResource(26, hLibraryPics);

  PluginSkin.ST_ffc.Image         := LoadImageFromResource(27, hLibraryPics);
  PluginSkin.ST_ffc.Icon          := LoadImageAsIconFromResource(27, hLibraryPics);

  PluginSkin.ST_away.Image        := LoadImageFromResource(28, hLibraryPics);
  PluginSkin.ST_away.Icon         := LoadImageAsIconFromResource(28, hLibraryPics);

  PluginSkin.ST_na.Image          := LoadImageFromResource(29, hLibraryPics);
  PluginSkin.ST_na.Icon           := LoadImageAsIconFromResource(29, hLibraryPics);

  PluginSkin.ST_occ.Image         := LoadImageFromResource(30, hLibraryPics);
  PluginSkin.ST_occ.Icon          := LoadImageAsIconFromResource(30, hLibraryPics);

  PluginSkin.ST_dnd.Image         := LoadImageFromResource(31, hLibraryPics);
  PluginSkin.ST_dnd.Icon          := LoadImageAsIconFromResource(31, hLibraryPics);

  PluginSkin.ST_invisible.Image   := LoadImageFromResource(32, hLibraryPics);
  PluginSkin.ST_invisible.Icon    := LoadImageAsIconFromResource(32, hLibraryPics);

  PluginSkin.ST_lunch.Image       := LoadImageFromResource(33, hLibraryPics);
  PluginSkin.ST_lunch.Icon        := LoadImageAsIconFromResource(33, hLibraryPics);

  PluginSkin.ST_depression.Image  := LoadImageFromResource(34, hLibraryPics);
  PluginSkin.ST_depression.Icon   := LoadImageAsIconFromResource(34, hLibraryPics);

  PluginSkin.ST_evil.Image        := LoadImageFromResource(35, hLibraryPics);
  PluginSkin.ST_evil.Icon         := LoadImageAsIconFromResource(35, hLibraryPics);

  PluginSkin.ST_at_home.Image     := LoadImageFromResource(36, hLibraryPics);
  PluginSkin.ST_at_home.Icon      := LoadImageAsIconFromResource(36, hLibraryPics);

  PluginSkin.ST_at_work.Image     := LoadImageFromResource(37, hLibraryPics);
  PluginSkin.ST_at_work.Icon      := LoadImageAsIconFromResource(37, hLibraryPics);

  PluginSkin.ST_offline.Image     := LoadImageFromResource(38, hLibraryPics);
  PluginSkin.ST_offline.Icon      := LoadImageAsIconFromResource(38, hLibraryPics);


  PluginSkin.Mute.Icon            := LoadImageAsIconFromResource(39, hLibraryPics);
  PluginSkin.Unmute.Icon          := LoadImageAsIconFromResource(40, hLibraryPics);
  PluginSkin.Export.Icon          := LoadImageAsIconFromResource(41, hLibraryPics);
  PluginSkin.Import.Icon          := LoadImageAsIconFromResource(42, hLibraryPics);


  PluginSkin.CheckMenuItem        := LoadImageAsIconFromResource(43, hLibraryPics);
  PluginSkin.Update.Icon          := LoadImageAsIconFromResource(44, hLibraryPics);

  PluginSkin.Comment.Image        := LoadImageFromResource(45, hLibraryPics);
  PluginSkin.Comment.Icon         := LoadImageAsIconFromResource(45, hLibraryPics);

  PluginSkin.Folder.Image         := LoadImageFromResource(46, hLibraryPics);
  PluginSkin.Folder.Icon          := LoadImageAsIconFromResource(46, hLibraryPics);

  PluginSkin.Favourite.Image      := LoadImageFromResource(47, hLibraryPics);
  PluginSkin.Favourite.Icon       := LoadImageAsIconFromResource(47, hLibraryPics);

  FreeLibrary(hLibraryPics);

  AddIconToStringList(PluginSkin.MenuIcons, PluginTheme.State.PictureStop.Icon);
  AddIconToStringList(PluginSkin.MenuIcons, PluginSkin.Stations.Icon);
  AddIconToStringList(PluginSkin.MenuIcons, PluginSkin.Formats.Icon);
  AddIconToStringList(PluginSkin.MenuIcons, PluginSkin.Info.Icon);
  AddIconToStringList(PluginSkin.MenuIcons, PluginSkin.Equalizer.Icon);
  AddIconToStringList(PluginSkin.MenuIcons, PluginSkin.Recording.Icon);
  AddIconToStringList(PluginSkin.MenuIcons, PluginSkin.Volume.Icon);
  AddIconToStringList(PluginSkin.MenuIcons, PluginSkin.EditStations.Icon);
  AddIconToStringList(PluginSkin.MenuIcons, PluginSkin.FastAddStation.Icon);
  AddIconToStringList(PluginSkin.MenuIcons, PluginSkin.Options.Icon);
  AddIconToStringList(PluginSkin.MenuIcons, PluginSkin.Folder.Icon);
  AddIconToStringList(PluginSkin.MenuIcons, PluginSkin.Favourite.Icon);
  AddIconToStringList(PluginSkin.MenuIcons, PluginSkin.Copy.Icon);

  GetEqualizerPreset;

  GetLangs;

  LoadStations(Stations,'');

  showmessage(inttostr(Stations.count));

  GetStatistics;

  idx:=0;
  while ( idx <= Stations.Count - 1 ) do
  begin
    Application.ProcessMessages;

    if TStation(Stations.Objects[idx]).Name = sNStationID then
      begin
        Radio_StationID := idx;
        break;
      end;

    Inc(idx);
  end;


  if HotKeyEnabled = True then
    begin
      HotKeysActivate;
    end;



  QIPPlugin.AddSpecContact( UniqContactId, SpecCntHeight );


  {=== Sound switch on/off test ===================================}
  {getting sound option enabled/disbaled}
  PlugMsg1.Msg := PM_PLUGIN_SOUND_GET;
  {when plugin sending msg to qip core it have to add self dllhandle, else your msg will be ignored}
  PlugMsg1.DllHandle := DllHandle;

  FPluginSvc.OnPluginMessage(PlugMsg1);

  {if sound enabled then disabling it}
  if Boolean(PlugMsg1.WParam) then
    QIPSound := True
  else
    QIPSound := False;

  if UseQIPMute = True then
  begin
    Player_Mute := not QIPSound;
    SetChangeVolume;
  end;
  {================================================================}


  UpdaterWebIndex := -1;

  UpdaterWeb  := TStringList.Create;
  UpdaterWeb.Clear;

  UpdaterWeb.Add('http://lmscze7.ic.cz/');
  UpdaterWeb.Add('http://lmscze7.wz.cz/');

  NextCheckVersion := Now + ( 5 * (1/(24*60*60) ) );

  tmrStep.Enabled := True;

  tmrDraw.Enabled := True;

  if PlayOnStart = True then
  begin
    FBassPlayer.PlayStopRadio;
  end;

end;

procedure TfrmQIPPlugin.tmrStepTimer(Sender: TObject);
var
  fmFadeMsg  : TFadeMsg;
  fmcFadeMsgClosing: TFadeMsgClosing;
  i : Integer;
  fid: DWord;
  PlugMsg1, RepMsg  : TPluginMessage;
  Repl_XStatus: TReplXStatus;
  sText : WideString;


  QipColors : pQipColors;
begin

  PlugMsg1.Msg       := PM_PLUGIN_GET_COLORS_FONT;
  PlugMsg1.DllHandle := DllHandle;

  FPluginSvc.OnPluginMessage(PlugMsg1);

  //get results
{  wFontName := PWideChar(PlugMsg1.WParam);
  iFontSize := PlugMsg1.LParam;}
  QipColors := pQipColors(PlugMsg1.NParam);

  QIP_Colors := QipColors^;


  //--- Poèítání doby hraní písnièky/rádia
  if Radio_Playing then
  begin
    iTime := iTime + tmrStep.Interval/1000;

    if (iTime > 10) and (iRadio = LNG('PLAYER', 'Connecting', 'Connecting...')) then
    begin
      iRadio := LNG('PLAYER', 'NotInformation', 'Information not available');
    end;
  end;

  if iTime > 359999 then // 99:59:59 - hh:mm:ss
    iTime := 0;
  //---

  // Statistika - doba hraní
  if Radio_Playing then
  begin
    StatisticsRadioTime := StatisticsRadioTime + tmrStep.Interval/1000;
    if StatisticsRadioTime > 11 then // aktualizuj dobu pøehrávání rádia (každých 11 sekund, klidnì bych tam dal i každou sekundu, ale nevim jak je to se zátìží PC)
    begin
      if (Radio_StationID <> -1) and (Radio_StreamID <> -1) then
      begin
        Statistics_PlayTime_Add( TStream(TStation(Stations.Objects[Radio_StationID]).Streams.Objects[Radio_StreamID]).URL,  StatisticsRadioTime );
      end;
    end;

  end;


  if FadeMsgsClosing.Count > 0 then
  begin
    i:=0;
    while ( i<= FadeMsgsClosing.Count - 1 ) do
    begin
      Application.ProcessMessages;

      Dec(TFadeMsgClosing(FadeMsgsClosing.Objects[i]).Time);

      if TFadeMsgClosing(FadeMsgsClosing.Objects[i]).Time <= 0  then
      begin
        PlugMsg1.Msg    := PM_PLUGIN_FADE_CLOSE;
        PlugMsg1.WParam := TFadeMsgClosing(FadeMsgsClosing.Objects[i]).FadeID;

        PlugMsg1.DllHandle := DllHandle;
        FPluginSvc.OnPluginMessage(PlugMsg1);

        FadeMsgsClosing.Delete(i);
        Dec(i);
      end;

      Inc(i);
    end;

  end;

  if FadeMsgs.Count > 0 then
  begin
    fmFadeMsg := TFadeMsg(FadeMsgs.Objects[0]);
    FadeMsgs.Delete(0);

    if fmFadeMsg.CloseTime <> 0 then
      fmFadeMsg.NoAutoClose := True;

    fid := FadeMsg(fmFadeMsg.FadeType,
            fmFadeMsg.FadeIcon,
            fmFadeMsg.FadeTitle,
            fmFadeMsg.FadeText,
            fmFadeMsg.TextCentered,
            fmFadeMsg.NoAutoClose,
            fmFadeMsg.pData
            );

    if fmFadeMsg.CloseTime <> 0 then
    begin

      fmcFadeMsgClosing := TFadeMsgClosing.Create;
      fmcFadeMsgClosing.FadeID      := fid;
      fmcFadeMsgClosing.Time        := fmFadeMsg.CloseTime * 2;

      FadeMsgsClosing.Add('FADEMSG');
      FadeMsgsClosing.Objects[FadeMsgsClosing.Count - 1] := fmcFadeMsgClosing.Create;

    end;

    if fmFadeMsg.pData=255 then
      Updater_NewVersionFadeID := fid;

  end;


  if Stations.Count - 1 < Radio_StationID then
  begin
    Radio_StationID := 0;
    if Radio_Playing=True then FBassPlayer.PlayStopRadio;
  end
  else
  begin
    if Radio_StationID <> -1 then
    begin
      if TStation(Stations.Objects[Radio_StationID]).Streams.Count - 1 < Radio_StreamID then
      begin
        Radio_StreamID := 0;
        if Radio_Playing=True then FBassPlayer.PlayStopRadio;
      end;
    end;
  end;

  if ExtraTextTime<>0 then
  begin
    ExtraTextTime := ExtraTextTime - 1;

    if ExtraTextTime = 0 then
    begin
//      SpecCntInfoTextX := 0;
//      SpecCntInfoTextScroll := False;
//      SpecCntInfo2TextX := 0;
//      SpecCntInfo2TextScroll := False;
      RedrawSpecContact(UniqContactId);
    end;
  end;

  // ---- Check new version ----
  CheckNewVersion(False);


  if ShowPopups = True then
  begin
    if Radio_Playing = True then
    begin
      if Stations.Count - 1 >= Radio_StationID then
      begin
        Repl_XStatus.Station     := TStation(Stations.Objects[Radio_StationID]).Name;
        Repl_XStatus.Genre       := TStation(Stations.Objects[Radio_StationID]).Genre;

        if TStation(Stations.Objects[Radio_StationID]).Streams.Count - 1 >= Radio_StreamID then
          Repl_XStatus.Format      := TStream(TStation(Stations.Objects[Radio_StationID]).Streams.Objects[Radio_StreamID]).Format;

        Repl_XStatus.Language    := TStation(Stations.Objects[Radio_StationID]).Language;
        Repl_XStatus.StationWeb  := TStation(Stations.Objects[Radio_StationID]).URL;
      end;

      if PopupType = 1 then
        sText := ReplXStatus(XStatus_Text,Repl_XStatus)
      else if PopupType = 2 then
        sText := ReplXStatus(PopupText,Repl_XStatus);

      if (LastRadioFadeMsg <> sText) and (sText <> ' ') then
      begin
        QIPPlugin.AddFadeMsg(1, PluginSkin.PluginIcon.Icon.Handle, PLUGIN_NAME, sText, True, False, 0, 0);
      end;

      LastRadioFadeMsg := sText;
    end;
  end;


  if RemoveXstatus = True then
  begin
    RemoveXstatus := False;

    FwStatus      :=  LastXStatusText ;
    FwDescription := LastXStatusDescription;

    RepMsg.Msg       := PM_PLUGIN_XSTATUS_UPD;

    RepMsg.WParam    := LastXStatusNumber;

    RepMsg.LParam    := LongInt(PWideChar(FwStatus));
    RepMsg.NParam    := LongInt(PWideChar(FwDescription));

    RepMsg.DllHandle := DllHandle;
    FPluginSvc.OnPluginMessage(RepMsg);
  end;


  //XStatus - musí být nakonci tmrStep
  if ChangeXstatusPos = 1 then
  begin
    //Zrusit XStatus
    RepMsg.WParam    := 0;
    FwStatus         := '';
    FwDescription    := '';
    RepMsg.Msg       := PM_PLUGIN_XSTATUS_UPD;
    RepMsg.LParam    := LongInt(PWideChar(FwStatus));
    RepMsg.NParam    := LongInt(PWideChar(FwDescription));
    RepMsg.DllHandle := DllHandle;
    FPluginSvc.OnPluginMessage(RepMsg);
    Inc(ChangeXstatusPos);
    Exit;
  end;

  if XStatus_Boolean = True then
  begin
    if ChangeXstatus=True then
    begin

      if (ActXstatusNum=11) or (XStatus_Type = 2)  then
      begin
        Inc(ChangeXstatusPos);

        if ChangeXstatusPos = 1 then    //Odstraneni XStatusu
          Exit;

        if ChangeXstatusPos < 2  then   // Cekani na nastaveni XStatusu
          Exit;

        if Radio_Playing=True then
        begin
          //FwStatus and FwDescription have to be class members or global variables to stay in memory because we return PWideChar
          if Stations.Count - 1 >= Radio_StationID then
          begin
            Repl_XStatus.Station     := TStation(Stations.Objects[Radio_StationID]).Name;
            Repl_XStatus.Genre       := TStation(Stations.Objects[Radio_StationID]).Genre;

            if TStation(Stations.Objects[Radio_StationID]).Streams.Count - 1 >= Radio_StreamID then
              Repl_XStatus.Format      := TStream(TStation(Stations.Objects[Radio_StationID]).Streams.Objects[Radio_StreamID]).Format;

            Repl_XStatus.Language    := TStation(Stations.Objects[Radio_StationID]).Language;
            Repl_XStatus.StationWeb  := TStation(Stations.Objects[Radio_StationID]).URL;
          end;

          FwStatus      := ReplXStatus(XStatus_Title,Repl_XStatus);// 'Listenig radio:';   //max xstatus text length = 20 chars

          if Stations.Count - 1 < Radio_StationID then
            FwDescription := ''                 //max description text length = 512 chars
          else
            FwDescription := ReplXStatus(XStatus_Text,Repl_XStatus); //TSLStation(Stations.Objects[Radio_StationID]).Name; //max description text length = 512 chars

        end
        else
        begin
          FwStatus      :=  LastXStatusText ; {''; }                    //max xstatus text length = 20 chars
          FwDescription := LastXStatusDescription; {'';}                 //max description text length = 512 chars
        end;

        {Plugin msg to update xstatus}
        RepMsg.Msg       := PM_PLUGIN_XSTATUS_UPD;

        { WParam is number of xstatus picture in Core/Xstatuses/xstatuses.ini, if 0 then xstatus pic will be removed}
        {When changing music track you can change xstatus picture number, it will cauz all clients to request your new
         xstatus value, but better to make it optional, because it can be bothering for remote users}

        if (Radio_Playing=False) And (XStatus_Type = 2)  then
          RepMsg.WParam    := LastXStatusNumber { 0 }// Xstatus - not
        else
          RepMsg.WParam    := 11; // Xstatus - Music

        RepMsg.LParam    := LongInt(PWideChar(FwStatus));
        RepMsg.NParam    := LongInt(PWideChar(FwDescription));

        {when plugin sending msg to qip core it have to add self dllhandle, else your msg will be ignored}
        RepMsg.DllHandle := DllHandle;

        {send message to qip core. !!! Dont change xtatus too often, it can cauz disconnect}
        FPluginSvc.OnPluginMessage(RepMsg);
        {================================================================}

        ChangeXstatusPos := 0;
      end;
    end;

    ChangeXstatus:=False;
  end;

end;

////////////////////////////////////////////////////////////////////////////////
{procedure TfrmQIPPlugin.SpellCheck(var PlugMsg: TPluginMessage);
begin
  //
end;}

{******************************************************************************}
{procedure TfrmQIPPlugin.SpellPopup(var PlugMsg: TPluginMessage);
begin
  //
end;}

{******************************************************************************}
procedure TfrmQIPPlugin.QipSoundChanged(PlugMsg: TPluginMessage);
begin
  if Boolean(PlugMsg.WParam) then
    QIPSound := True
  else
    QIPSound := False;

  if UseQIPMute = True then
  begin
    Player_Mute := not QIPSound;
    SetChangeVolume;
  end;

end;

{******************************************************************************}
procedure TfrmQIPPlugin.AntiBoss(HideForms: Boolean);
begin
  if HideForms then
    /// AntiBoss: activated
  else
    /// AntiBoss: deactivated
end;

{******************************************************************************}
procedure TfrmQIPPlugin.CurrentLanguage(LangName: WideString);
var
  INI : TINIFile;
begin
  //  ShowMessage(LangName);
  QIPInfiumLanguage := LangName;

  INI := TiniFile.Create(PluginDllPath + PLUGIN_NAME + '.ini');
  INIWriteStringUTF8(INI, 'Language', 'QIP', QIPInfiumLanguage );
  INIFree(INI);
end;

procedure TfrmQIPPlugin.ddrrr(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
  Selected: Boolean);
begin

end;

{******************************************************************************}
procedure TfrmQIPPlugin.DrawSpecContact(PlugMsg: TPluginMessage);
var ContactId : DWord;
    //Data      : Pointer;
    Cnv       : TCanvas;
    R         : PRect;
    wStr      : WideString;
    R1, R2, RCalc : TRect;
    RRight, RBottom, RRight2, RBottom2, iAlign, iLeft : Integer;
    RLeft, RTop : Integer;
    Repl_XStatus : TReplXStatus;
    Params: TDrawTextParams;
begin

  //get unique contact id from msg
  ContactId := PlugMsg.WParam;

  //actually all incoming ContactIDs will be only of your plugin, but here i made condition just for example
//  if (ContactId <> FfrmTest.UniqContactId) then Exit;

  //get your Data pointer which you added when sent PM_PLUGIN_SPEC_ADD_CNT.
  //IMPORTANT!!! Do NOT make here any heavy loading actions, like cycles FOR, WHILE etc.
  //That's why you have to add Data pointer to PM_PLUGIN_SPEC_ADD_CNT, to get quick access to your data.
  //Data not used here in this example because plugin added only one contact
  //Data      := Pointer(PlugMsg.LParam);

  //create temporary canvas to draw the contact
  Cnv       := TCanvas.Create;
  try
    //get canvas handle from msg
    Cnv.Handle := PlugMsg.NParam;

    //get drawing rectangle pointer from msg
    R := PRect(PlugMsg.Result);

    //this needed to draw text over contact list backgroud
    SetBkMode(Cnv.Handle, TRANSPARENT);

    if ExtraTextTime <> 0 then
    begin

      if SpecCntShowLine2 then
        SpecCntInfo2Text := ExtraText
      else
        SpecCntInfoText  := ExtraText;

    end
    else
    begin
      if (Stations.Count - 1 < Radio_StationID) AND (Radio_StationID <> -1) then
        SpecCntInfoText := ''
      else
      begin
        Repl_XStatus.Station     := TStation(Stations.Objects[Radio_StationID]).Name;
        Repl_XStatus.Genre       := TStation(Stations.Objects[Radio_StationID]).Genre;

        if (TStation(Stations.Objects[Radio_StationID]).Streams.Count - 1 >= Radio_StreamID) AND  (Radio_StreamID <> -1) then
          Repl_XStatus.Format      := TStream(TStation(Stations.Objects[Radio_StationID]).Streams.Objects[Radio_StreamID]).Format;

        Repl_XStatus.Language    := TStation(Stations.Objects[Radio_StationID]).Language;
        Repl_XStatus.StationWeb  := TStation(Stations.Objects[Radio_StationID]).URL;

        SpecCntInfoText := ReplXStatus(SpecCntLine1Text,Repl_XStatus);
        SpecCntInfo2Text := ReplXStatus(SpecCntLine2Text,Repl_XStatus);
      end;
    end;



    if SpecCntLine1TextLast <> SpecCntInfoText then
    begin
      SpecCntInfoTextX := 0;
      SpecCntInfoTextScroll := False;
    end;

    if SpecCntLine2TextLast <> SpecCntInfo2Text then
    begin
      SpecCntInfo2TextX := 0;
      SpecCntInfo2TextScroll := False;
    end;

    SpecCntLine1TextLast := SpecCntInfoText;
    SpecCntLine2TextLast := SpecCntInfo2Text;



    if PluginTheme.Info.Right > 0 then
      RRight := R^.Right - PluginTheme.Info.Right
    else
      RRight := R^.Right + PluginTheme.Info.Right;

    if StreamRecording then
      RRight := RRight - 16;

    if PluginTheme.Info.Bottom > 0 then
      RBottom := R^.Bottom - PluginTheme.Info.Bottom
    else
      RBottom := R^.Bottom + PluginTheme.Info.Bottom;


    if PluginTheme.Info2.Right > 0 then
      RRight2 := R^.Right - PluginTheme.Info2.Right
    else
      RRight2 := R^.Right + PluginTheme.Info2.Right;

    if PluginTheme.Info2.Bottom > 0 then
      RBottom2 := R^.Bottom - PluginTheme.Info2.Bottom
    else
      RBottom2 := R^.Bottom + PluginTheme.Info2.Bottom;


    // === Info 1 ===
    Cnv.Font.Name  := PluginTheme.Info.Font.Name;
    Cnv.Font.Color := TextToColor( PluginTheme.Info.Font.Color, QIP_Colors );
    Cnv.Font.Size  := PluginTheme.Info.Font.Size;
    Cnv.Font.Style := PluginTheme.Info.Font.Style;

    if SpecCntLine1ScrollText = True then
    begin

      if PluginTheme.Title.Show then
        iLeft := PluginTheme.Info.Left
      else
        iLeft := PluginTheme.Title.Left;

      SpecCntInfoMaxWidth := RRight - (iLeft + R^.Left);
      RCalc.Left := 0;
      RCalc.Top := 0;
      DrawTextW(Cnv.Handle, PWideChar(SpecCntInfoText), Length(SpecCntInfoText), RCalc, PluginTheme.Info.TextAlign + DT_CALCRECT + DT_NOPREFIX + DT_SINGLELINE);
      SpecCntInfoTextWidth := RCalc.Right - RCalc.Left;

      if SpecCntInfoTextWidth > SpecCntInfoMaxWidth then
      begin
        SpecCntInfoTextScroll := True;
        iAlign := 0;
      end
      else
      begin
        SpecCntInfoTextX := 0;
        SpecCntInfoTextScroll := False;
        iAlign := PluginTheme.Info.TextAlign;
      end;

      Params.cbSize := SizeOf(Params);
      Params.iLeftMargin := SpecCntInfoTextX;
      Params.iRightMargin := 0;
      Params.uiLengthDrawn := Length(SpecCntInfoText);

      R1 := Rect(R^.Left + iLeft, R^.Top + PluginTheme.Info.Top, RRight, RBottom);
      DrawTextExW(Cnv.Handle, PWideChar(SpecCntInfoText), Length(SpecCntInfoText), R1, iAlign + DT_NOPREFIX + DT_SINGLELINE, @Params);

    end
    else
    begin
      if PluginTheme.Title.Show then
        iLeft := PluginTheme.Info.Left
      else
        iLeft := PluginTheme.Title.Left;
      R1 := Rect(R^.Left + iLeft, R^.Top + PluginTheme.Info.Top, RRight, RBottom);
      DrawTextW(Cnv.Handle, PWideChar(SpecCntInfoText), Length(SpecCntInfoText)+1, R1, PluginTheme.Info.TextAlign + DT_NOPREFIX + DT_SINGLELINE);            
    end;


    // === Info 2 ===
    Cnv.Font.Name  := PluginTheme.Info2.Font.Name;
    Cnv.Font.Color := TextToColor( PluginTheme.Info2.Font.Color, QIP_Colors );
    Cnv.Font.Size  := PluginTheme.Info2.Font.Size;
    Cnv.Font.Style := PluginTheme.Info2.Font.Style;

    if (SpecCntLine2ScrollText = True) and (SpecCntShowLine2 = True) then
    begin

      SpecCntInfo2MaxWidth := RRight2 - (PluginTheme.Info2.Left + R^.Left);
      RCalc.Left := 0;
      RCalc.Top := 0;
      DrawTextW(Cnv.Handle, PWideChar(SpecCntInfo2Text), Length(SpecCntInfo2Text), RCalc, PluginTheme.Info2.TextAlign + DT_CALCRECT + DT_NOPREFIX + DT_SINGLELINE);
      SpecCntInfo2TextWidth := RCalc.Right - RCalc.Left + 1;

      if SpecCntInfo2TextWidth > SpecCntInfo2MaxWidth then
      begin
        SpecCntInfo2TextScroll := True;
        iAlign := 0;
      end
      else
      begin
        SpecCntInfo2TextX := 0;
        SpecCntInfo2TextScroll := False;
        iAlign := PluginTheme.Info2.TextAlign;
      end;

      Params.cbSize := SizeOf(Params);
      Params.iLeftMargin := SpecCntInfo2TextX;
      Params.iRightMargin := 0;
      Params.uiLengthDrawn := Length(SpecCntInfo2Text);

      R1 := Rect(R^.Left + PluginTheme.Info2.Left, R^.Top + PluginTheme.Info2.Top, RRight2, RBottom2);
      DrawTextExW(Cnv.Handle, PWideChar(SpecCntInfo2Text), Length(SpecCntInfo2Text), R1, iAlign + DT_NOPREFIX + DT_SINGLELINE, @Params);
    end
    else
    begin
      R1 := Rect(R^.Left + PluginTheme.Info2.Left, R^.Top + PluginTheme.Info2.Top, RRight2, RBottom2);
      DrawTextW(Cnv.Handle, PWideChar(SpecCntInfo2Text), Length(SpecCntInfo2Text), R1, PluginTheme.Info2.TextAlign + DT_NOPREFIX + DT_SINGLELINE);
    end;


    ///////////////
    DrawIconEx(Cnv.Handle, PluginTheme.Icon.Left, PluginTheme.Icon.Top, PluginTheme.Icon.Picture.Handle,16, 16, 0, 0, DI_NORMAL);


    if PluginTheme.State.First.Right > 0 then
      RLeft := R^.Right - PluginTheme.State.First.Right
    else
      RLeft := -PluginTheme.State.First.Right;

    if PluginTheme.State.First.Top <=0 then
      RTop := R^.Bottom + PluginTheme.State.First.Top
    else
      RTop := PluginTheme.State.First.Top;


    if Radio_Playing=True then
      DrawIconEx(Cnv.Handle, RLeft, RTop,  PluginTheme.State.PicturePlay.Icon.Handle, 16, 16, 0, 0, DI_NORMAL)
    else
      DrawIconEx(Cnv.Handle, RLeft, RTop,  PluginTheme.State.PictureStop.Icon.Handle, 16, 16, 0, 0, DI_NORMAL);

    if Radio_PlayingError = true then
      DrawIconEx(Cnv.Handle, RLeft, RTop,  PluginTheme.State.PictureError.Icon.Handle, 16, 16, 0, 0, DI_NORMAL);


    if StreamRecording=True then
    begin
      if PluginTheme.State.Second.Right > 0 then
        RLeft := R^.Right - PluginTheme.State.Second.Right
      else
        RLeft := -PluginTheme.State.Second.Right;

      if PluginTheme.State.Second.Top <= 0 then
        RTop := R^.Bottom + PluginTheme.State.Second.Top
      else
        RTop := PluginTheme.State.Second.Top;

      DrawIconEx(Cnv.Handle, RLeft, RTop, PluginTheme.State.PictureRecord.Icon.Handle, 16, 16, 0, 0, DI_NORMAL);
    end;


    wStr := 'FMtune';


    //== Font ==
    Cnv.Font.Name  := PluginTheme.Title.Font.Name;
    Cnv.Font.Color := TextToColor( PluginTheme.Title.Font.Color, QIP_Colors);
    Cnv.Font.Size  := PluginTheme.Title.Font.Size;
    Cnv.Font.Style := PluginTheme.Title.Font.Style;

    if PluginTheme.Title.Right > 0 then
      RRight := R^.Right - PluginTheme.Title.Right
    else
      RRight := R^.Right + PluginTheme.Title.Right;

    if PluginTheme.Title.Bottom > 0 then
      RBottom := R^.Bottom - PluginTheme.Title.Bottom
    else
      RBottom := R^.Bottom + PluginTheme.Title.Bottom;

    if PluginTheme.Title.Show then
    begin
      R1 := Rect(R^.Left + PluginTheme.Title.Left, R^.Top + PluginTheme.Title.Top, RRight, RBottom);
      DrawTextW(Cnv.Handle, PWideChar(wStr), Length(wStr), R1, PluginTheme.Title.TextAlign + DT_NOPREFIX + DT_SINGLELINE);
    end;

  finally
    //free canvas
    Cnv.Free;
  end;
end;

{******************************************************************************}
procedure TfrmQIPPlugin.SpecContactDblClick(PlugMsg: TPluginMessage);
var ContactId : DWord;
begin
  ContactId := PlugMsg.WParam;

  FBassPlayer.PlayStopRadio;
end;

{******************************************************************************}
procedure TfrmQIPPlugin.SpecContactRightClick(PlugMsg: TPluginMessage);
var ContactId : DWord;
    //Data      : Pointer;
    Pt        : PPoint;
begin
  //get right clicked contact id from msg
  ContactId := PlugMsg.WParam;

  //get data pointer if added
  //Data      := Pointer(PlugMsg.LParam);

  //get popup screen coordinates
  Pt        := PPoint(PlugMsg.NParam);

  QIPPlugin.ShowContactMenu(Pt.X, Pt.Y);
end;

{******************************************************************************}
procedure TfrmQIPPlugin.LeftClickOnFadeMsg(PlugMsg: TPluginMessage);
var PlugMsg1 : TPluginMessage;
    FadeMsgID: integer;
    //spec : Integer;
begin

  FadeMsgID := PlugMsg.WParam;

  if Updater_NewVersionFadeID = FadeMsgID then
  begin
    PlugMsg1.Msg    := PM_PLUGIN_FADE_CLOSE;

    PlugMsg1.WParam := FadeMsgID;

    PlugMsg1.DllHandle := DllHandle;
    FPluginSvc.OnPluginMessage(PlugMsg1);

    OpenUpdater;
  end;
end;

procedure TfrmQIPPlugin.DrawHint(Cnv: TCanvas; R : TRect; CalcRect: Boolean; var Width: Integer; var Height: Integer);
var
  PlugMsg1  : TPluginMessage;
  wFontName : WideString;
  iFontSize : Integer;
  QipColors : pQipColors;

  R1, RTitle : TRect;

  sBitrateKBPS: WideString;
  sTextInfo, sTextInfoTitle : WideString;
  iWidth : Integer;
begin

  SetBkMode(Cnv.Handle, TRANSPARENT);

  PlugMsg1.Msg       := PM_PLUGIN_GET_COLORS_FONT;
  PlugMsg1.DllHandle := DllHandle;
  FPluginSvc.OnPluginMessage(PlugMsg1);
  wFontName := PWideChar(PlugMsg1.WParam);
  iFontSize := PlugMsg1.LParam;
  QipColors := pQipColors(PlugMsg1.NParam);
  
  QIP_Colors := QipColors^;  

  if iBitrate <> '' then
    sBitrateKBPS := iBitrate + ' kbps';

  sTextInfoTitle := QIPPlugin.GetLang(LI_INFORMATION);
  sTextInfo      := LNG('FORM Info', 'Song', 'Song') + ': ' + iSong + #13#10 +
                    LNG('FORM Info', 'Radio', 'Radio') + ': ' + iRadio + #13#10 +
                    LNG('FORM Info', 'Bitrate', 'Bitrate') + ': ' + sBitrateKBPS;

  sTextInfo      := #13#10+sTextInfo;

  //Cnv.Font.Color := QipColors.AccBtnText;
  Cnv.Font.Style := [fsBold];
  DrawTextW(Cnv.Handle, PWideChar(sTextInfoTitle), Length(sTextInfoTitle), RTitle, DT_LEFT + DT_CALCRECT );

  if CalcRect = True then
  begin
    Cnv.Font.Style := [];
    DrawTextW(Cnv.Handle, PWideChar(sTextInfo), Length(sTextInfo), R1, DT_LEFT + DT_CALCRECT );

    iWidth := 100;

    if iWidth < RTitle.Right - RTitle.Left then
      iWidth := RTitle.Right - RTitle.Left;

    if iWidth < R1.Right - R1.Left then
      iWidth := R1.Right - R1.Left;

    Width := iWidth + 10;
    Height := (R1.Bottom - R1.Top) - 10;
  end
  else
  begin
    R1 := Rect(R.Left + 5, R.Top + 5, R.Right, R.Bottom);

    Cnv.Font.Style := [fsBold];
    DrawTextW(Cnv.Handle, PWideChar(sTextInfoTitle), Length(sTextInfoTitle), R1, DT_LEFT );

    //    R2.Top := R1.Top + (RTitle.Bottom - RTitle.Top);
    Cnv.Font.Style := [];
    DrawTextW(Cnv.Handle, PWideChar(sTextInfo), Length(sTextInfo), R1, DT_LEFT );

  end;


end;

{******************************************************************************}
procedure TfrmQIPPlugin.GetSpecContactHintSize(var PlugMsg: TPluginMessage);
var ContactId : DWord;
    //Data      : Pointer;
    Img : TImage;
    Rx : TRect;
begin
  ContactId := PlugMsg.WParam;

  Img := TImage.Create(Self);
  try
    DrawHint( Img.Canvas, Rx, True, PlugMsg.LParam, PlugMsg.NParam);
  finally
    Img.Free;
  end;
end;

{******************************************************************************}
procedure TfrmQIPPlugin.DrawSpecContactHint(PlugMsg: TPluginMessage);
var ContactId : DWord;
    //Data      : Pointer;
    Cnv       : TCanvas;
    R         : PRect;
    tmpI : Integer;
begin
  ContactId := PlugMsg.WParam;

  Cnv       := TCanvas.Create;
  try
    Cnv.Handle := PlugMsg.LParam;
    R := PRect(PlugMsg.NParam);

    DrawHint( Cnv, R^, False, tmpI, tmpI);
  finally
    Cnv.Free;
  end;

end;

{******************************************************************************}
procedure TfrmQIPPlugin.XstatusChangedByUser(PlugMsg: TPluginMessage);
begin
  LastXStatusText         := PWideChar(PlugMsg.LParam);
  LastXStatusDescription  := PWideChar(PlugMsg.NParam);
  LastXStatusNumber       := PlugMsg.WParam;

  if XStatus_Boolean = True then
  begin
    {=== XStatus picture/text changed msg example ===================}
    ActXstatusNum := PlugMsg.WParam;

    if ActXstatusNum=11 then
      ChangeXstatus:=True;
  end;
end;

{******************************************************************************}
procedure TfrmQIPPlugin.InstantMsgRcvd(var PlugMsg: TPluginMessage);

begin

end;

{******************************************************************************}
procedure TfrmQIPPlugin.InstantMsgSend(var PlugMsg: TPluginMessage);

begin

end;

{******************************************************************************}
procedure TfrmQIPPlugin.NewMessageFlashing(PlugMsg: TPluginMessage);
//var wAccName, wNickName : WideString;
begin
//  {getting aaccount name and nick name of contact whose msg was received but not read yet}
//  wAccName  := PWideChar(PlugMsg.WParam);
//  wNickName := PWideChar(PlugMsg.LParam);
end;

{******************************************************************************}
procedure TfrmQIPPlugin.NewMessageStopFlashing(PlugMsg: TPluginMessage);
begin

end;

procedure TfrmQIPPlugin.pmContactMenuChange(Sender: TObject; Source: TMenuItem;
  Rebuild: Boolean);
begin

end;

{******************************************************************************}
procedure TfrmQIPPlugin.AddNeededBtns(PlugMsg: TPluginMessage);

begin

end;

{******************************************************************************}
procedure TfrmQIPPlugin.MsgBtnClicked(PlugMsg: TPluginMessage);

begin

end;

{******************************************************************************}
procedure TfrmQIPPlugin.SpecMsgRcvd(PlugMsg: TPluginMessage);

begin

end;

{******************************************************************************}
procedure TfrmQIPPlugin.StatusChanged(PlugMsg: TPluginMessage);
var iStatus, iPrivStatus : integer;
    iAuto: Integer;
begin
  //Core sends this msg everytime on global or privacy status change by user or by plugin
  iStatus     := PlugMsg.WParam;
  iPrivStatus := PlugMsg.LParam;

  if (iStatus <> -1) then
  begin

  {  if (Radio_Playing = True) or ((Radio_Playing = False) and (AutoUseWherePlaying = False)) then
    begin  }
      iAuto := -1;

	    if (iStatus = QIP_STATUS_INVISIBLE) or (iStatus = QIP_STATUS_INVISFORALL)  then
        iAuto := AutoStatusInvisible;
      if iStatus = QIP_STATUS_FFC then
        iAuto := AutoStatusFFC;
      if iStatus = QIP_STATUS_EVIL then
        iAuto := AutoStatusEvil;
      if iStatus = QIP_STATUS_DEPRES then
        iAuto := AutoStatusDepres;
      if iStatus = QIP_STATUS_ATHOME then
        iAuto := AutoStatusAtHome;
      if iStatus = QIP_STATUS_ATWORK then
        iAuto := AutoStatusAtWork;
      if iStatus = QIP_STATUS_OCCUPIED then
        iAuto := AutoStatusOccupied;
	    if iStatus = QIP_STATUS_DND then
        iAuto := AutoStatusDND;
      if iStatus = QIP_STATUS_LUNCH then
        iAuto := AutoStatusLunch;
      if iStatus = QIP_STATUS_AWAY then
        iAuto := AutoStatusAway;
      if iStatus = QIP_STATUS_NA then
        iAuto := AutoStatusNA;
      if (iStatus = QIP_STATUS_OFFLINE) or (iStatus = QIP_STATUS_CONNECTING) then
        iAuto := AutoStatusOffline;
      if (iStatus = QIP_STATUS_ONLINE) or (iAuto = -1) then
        iAuto := AutoStatusOnline;

      if iAuto = 0 then   // NIC
      begin
          // nic
      end
      else if iAuto = 1 then    //SPUSTIT
      begin
        if Radio_Playing = False then
          FBassPlayer.PlayStopRadio;
      end
      else if iAuto = 2 then    //VYPNOUT
      begin
        if Radio_Playing = True then
          FBassPlayer.PlayStopRadio;
      end;
 {
    end;
            }
  end;

end;

{******************************************************************************}
procedure TfrmQIPPlugin.ImRcvdSuccess(PlugMsg: TPluginMessage);

begin

end;

{******************************************************************************}
procedure TfrmQIPPlugin.ContactStatusRcvd(PlugMsg: TPluginMessage);

begin

end;

{******************************************************************************}
procedure TfrmQIPPlugin.ChatTabAction(PlugMsg: TPluginMessage);

begin

end;

procedure TfrmQIPPlugin.CMAdvDrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; State: TOwnerDrawState);
begin


end;

{******************************************************************************}
procedure TfrmQIPPlugin.AddNeededChatBtns(PlugMsg: TPluginMessage);

begin

end;


{******************************************************************************}
procedure TfrmQIPPlugin.ChatBtnClicked(PlugMsg: TPluginMessage);

begin

end;

{******************************************************************************}
procedure TfrmQIPPlugin.ChatMsgRcvd(PlugMsg: TPluginMessage);

begin

end;

{******************************************************************************}
procedure TfrmQIPPlugin.ChatMsgSending(var PlugMsg: TPluginMessage);

begin

end;

{******************************************************************************}
procedure TfrmQIPPlugin.EnumInfo(PlugMsg: TPluginMessage);
begin

end;

////////////////////////////////////////////////////////////////////////////////

function TfrmQIPPlugin.FadeMsg(FType: Byte; FIcon: HICON; FTitle: WideString; FText: WideString; FTextCenter: Boolean; FNoAutoClose: Boolean; pData: Integer) : DWORD;
var PlugMsg1 : TPluginMessage;
    aFadeWnd: TFadeWndInfo;
begin

  //0 - message style, 1 - information style, 2 - warning style
  aFadeWnd.FadeType  := FType;//1;
  //its better to use ImageList of icons if you gonna show more than one icon everytime,
  //else you have to care about destroying your HICON after showing fade window, cauz core makes self copy of HICON
//  aFadeWnd.FadeIcon  := LoadImage(0, IDI_INFORMATION, IMAGE_ICON, 16, 16, LR_DEFAULTCOLOR or LR_SHARED);


  aFadeWnd.FadeIcon  := FIcon;

  aFadeWnd.FadeTitle := FTitle;
  aFadeWnd.FadeText  := FText;

  //if your text is too long, then you have to set this param to False
  aFadeWnd.TextCentered := FTextCenter;

  //it's recommended to set this parameter = False if your fade window is not very important
  aFadeWnd.NoAutoClose := FNoAutoClose;

  //send msg to qip core
  PlugMsg1.Msg       := PM_PLUGIN_FADE_MSG;
  PlugMsg1.WParam    := LongInt(@aFadeWnd);


  PlugMsg1.LParam    := 0; //vlastni Pointer

  PlugMsg1.DllHandle := DllHandle;
  FPluginSvc.OnPluginMessage(PlugMsg1);


  //if your window was successfuly shown then core returns Result = True (Result is unique id of fade msg),
  //else you should try later to show it again
  if Boolean(PlugMsg1.Result) then
    //LogAdd('Fading popup window successefuly shown: FadeMsg ID is '+ IntToStr(PlugMsg1.Result))
    Result := PlugMsg1.Result
  else
    //LogAdd('Fading popup window was NOT shown');
    Result := 0;


end;

procedure TfrmQIPPlugin.AddFadeMsg(
                                    FadeType     : Byte;        //0 - message style, 1 - information style, 2 - warning style
                                    FadeIcon     : HICON;       //icon in the top left corner of the window
                                    FadeTitle    : WideString;
                                    FadeText     : WideString;
                                    TextCentered : Boolean;     //if true then text will be centered inside window
                                    NoAutoClose  : Boolean;     //if NoAutoClose is True then wnd will be always shown until user close it. Not recommended to set this param to True.
                                    CloseTime_Sec: Integer;
                                    pData        : Integer
                                  );
var fmFadeMsg  : TFadeMsg;
begin
  fmFadeMsg := TFadeMsg.Create;
  fmFadeMsg.FadeType      := FadeType ;
  fmFadeMsg.FadeIcon      := FadeIcon;
  fmFadeMsg.FadeTitle     := FadeTitle;
  fmFadeMsg.FadeText      := FadeText;
  fmFadeMsg.TextCentered  := TextCentered;
  fmFadeMsg.NoAutoClose   := NoAutoClose;
  fmFadeMsg.CloseTime     := CloseTime_Sec;
  fmFadeMsg.pData         := pData;

  FadeMsgs.Add('FADEMSG');
  FadeMsgs.Objects[FadeMsgs.Count - 1] := fmFadeMsg.Create;

end;

////////////////////////////////////////////////////////////////////////////////
procedure TfrmQIPPlugin.AddSpecContact(var UniqID: DWord; HeightCnt: Integer = 19);
var PlugMsg1 : TPluginMessage;
begin
  PlugMsg1.Msg    := PM_PLUGIN_SPEC_ADD_CNT;

  //set height of your contact here, min 8, max 100.
  PlugMsg1.WParam := HeightCnt;

  //Pointer
  PlugMsg1.LParam := LongInt(@UniqID);

  PlugMsg1.DllHandle := DllHandle;
  FPluginSvc.OnPluginMessage(PlugMsg1);

  UniqID := PlugMsg1.Result;
end;


procedure TfrmQIPPlugin.RedrawSpecContact(UniqID: DWord);
var
  PlugMsg1 : TPluginMessage;
begin
  if UniqID = 0 then Exit;

  PlugMsg1.Msg    := PM_PLUGIN_SPEC_REDRAW;
  PlugMsg1.WParam := UniqID;
  PlugMsg1.DllHandle := DllHandle;
  FPluginSvc.OnPluginMessage(PlugMsg1);
end;

procedure TfrmQIPPlugin.RemoveSpecContact(var UniqID: DWord);
var
  PlugMsg1 : TPluginMessage;
begin
  if UniqID = 0 then Exit;

  PlugMsg1.Msg    := PM_PLUGIN_SPEC_DEL_CNT;
  PlugMsg1.WParam := UniqID;

  PlugMsg1.DllHandle := DllHandle;
  FPluginSvc.OnPluginMessage(PlugMsg1);

  if Boolean(PlugMsg1.Result) then
    UniqID := 0;
end;

function TfrmQIPPlugin.GetLang(ID: Word) : WideString;
var
  PlugMsg1 : TPluginMessage;
begin
  PlugMsg1.Msg       := PM_PLUGIN_GET_LANG_STR;
  PlugMsg1.WParam    := ID;
  PlugMsg1.DllHandle := DllHandle;
  FPluginSvc.OnPluginMessage(PlugMsg1);
  Result := PWideChar(PlugMsg1.Result);
end;


procedure TfrmQIPPlugin.InfiumClose(itype: Word);
var PlugMsg1 : TPluginMessage;
begin
  // 0 - close; 1 - restart

  PlugMsg1.Msg    := PM_PLUGIN_INFIUM_CLOSE;
  PlugMsg1.WParam := itype;
  PlugMsg1.DllHandle := DllHandle;
  FPluginSvc.OnPluginMessage(PlugMsg1);
end;

procedure TfrmQIPPlugin.StationNext();
begin
  LastRadioFadeMsg := '';

    if Radio_StationID >= Stations.Count - 1 then
      Radio_StationID := 0
    else
      Inc(Radio_StationID);

    Radio_StreamID  := TStation(Stations.Objects[Radio_StationID]).DefaultStream;

    SaveSelectedRadio;

    if Radio_Playing = True then
    begin
      FBassPlayer.PlayStopRadio;
      Application.ProcessMessages;
      FBassPlayer.PlayStopRadio;
    end;

    RedrawSpecContact(UniqContactId);
end;

procedure TfrmQIPPlugin.StationPrev();
begin
  LastRadioFadeMsg := '';

    if Radio_StationID <= 0 then
      Radio_StationID := Stations.Count - 1
    else
      Dec(Radio_StationID);

    Radio_StreamID  := TStation(Stations.Objects[Radio_StationID]).DefaultStream;

    SaveSelectedRadio;

    if Radio_Playing = True then
    begin
      FBassPlayer.PlayStopRadio;
      Application.ProcessMessages;
      FBassPlayer.PlayStopRadio;
    end;

    RedrawSpecContact(UniqContactId);
end;

procedure TfrmQIPPlugin.ShowContactMenu(pX, pY : Integer );
var
  NewItem, NewItemTop10Folder, NewItemTop10: TMenuItem;

  i: Integer;
  StationsPlayCount, MenuGroups : TStringlist;
  idxGroup: Integer;
  bTop10Items : Boolean;
begin
  if not (Radio_Playing and StreamRecording) then
  begin
    MenuGroups := TStringList.Create;
    MenuGroups.Clear;

    StationsPlayCount := TStringList.Create;
    StationsPlayCount.Clear;

    for i:=1 to miContactMenu_Stations.Count do miContactMenu_Stations.Delete(0);

    bTop10Items := False;

    //Sekce - Nejpøehrávanìjších rádíí
    NewItemTop10Folder := TMenuItem.Create(Self);
    NewItemTop10Folder.Caption := LNG('MENU ContactMenu', 'Favourites', 'Favourites');
    NewItemTop10Folder.Tag     := -1;
    //NewItemTop10Folder.OnClick := miContactMenu_StationsClick;
    NewItemTop10Folder.OnDrawItem := DrawMenu;
    NewItemTop10Folder.OnMeasureItem := MeasureMenu;
    NewItemTop10Folder.ImageIndex := 11;
    miContactMenu_Stations.Add(NewItemTop10Folder);

    NewItem := TMenuItem.Create(Self);
    NewItem.Caption := '-';
    NewItem.Tag     := -1;
    NewItem.OnDrawItem := DrawMenu;
    miContactMenu_Stations.Add(NewItem);

    StationsPlayCount.Assign(Stations);


    //StationsPlayCount := SortStationsPlayCount(StationsPlayCount);
    StationsPlayCount := SortStationsPlayTime(StationsPlayCount);


    for i := 0 to StationsPlayCount.Count - 1 do
    begin
      if (TStation(StationsPlayCount.Objects[i]).PlayCount = 0) or (i > 9)  then
        break;

      NewItemTop10 := TMenuItem.Create(Self);
      NewItemTop10.Caption := TStation(StationsPlayCount.Objects[i]).Name;
      NewItemTop10.Tag     := Stations.IndexOfObject(StationsPlayCount.Objects[i]);
      NewItemTop10.OnClick := miContactMenu_StationsClick;
      NewItemTop10.OnDrawItem := DrawMenu;
      NewItemTop10.OnMeasureItem := MeasureMenu;

      if Radio_StationID = NewItemTop10.Tag then NewItemTop10.Checked := True;

      NewItemTop10Folder.Add(NewItemTop10);

      bTop10Items := True;

      application.ProcessMessages;
    end;

    if bTop10Items = False then
    begin
      NewItemTop10 := TMenuItem.Create(Self);
      NewItemTop10.Caption := QIPPlugin.GetLang(LI_NO_ACCOUNT);
      NewItemTop10.Enabled := False;
      NewItemTop10.Tag     := 0;
      NewItemTop10.OnClick := miContactMenu_StationsClick;
      NewItemTop10.OnDrawItem := DrawMenu;
      NewItemTop10.OnMeasureItem := MeasureMenu;
      NewItemTop10Folder.Add(NewItemTop10);
    end;


    for i := 0 to Stations.Count - 1 do
    begin
      if TStation(Stations.Objects[i]).Group='' then
      begin
        NewItem := TMenuItem.Create(Self);
        NewItem.Caption := TStation(Stations.Objects[i]).Name;
        NewItem.Tag     := i;
        NewItem.OnClick := miContactMenu_StationsClick;
        NewItem.OnDrawItem := DrawMenu;
        NewItem.OnMeasureItem := MeasureMenu;

        if Radio_StationID = i then NewItem.Checked := True;

        miContactMenu_Stations.Add(NewItem);
      end
      else
      begin
        idxGroup := MenuGroups.IndexOf(TStation(Stations.Objects[i]).Group);

        if idxGroup = -1 then
        begin
          MenuGroups.Add(TStation(Stations.Objects[i]).Group);
          idxGroup := MenuGroups.Count - 1;
          MenuGroups.Objects[idxGroup] := TMenuItem.Create(Self);

          TMenuItem(MenuGroups.Objects[idxGroup]).Caption := TStation(Stations.Objects[i]).Group;
          TMenuItem(MenuGroups.Objects[idxGroup]).Tag     := -1;
          //TMenuItem(MenuGroups.Objects[idxGroup]).OnClick := miContactMenu_StationsClick;
          TMenuItem(MenuGroups.Objects[idxGroup]).OnDrawItem := DrawMenu;
          TMenuItem(MenuGroups.Objects[idxGroup]).OnMeasureItem := MeasureMenu;
          TMenuItem(MenuGroups.Objects[idxGroup]).ImageIndex := 10;
          miContactMenu_Stations.Add(TMenuItem(MenuGroups.Objects[idxGroup]));
        end;

        NewItem := TMenuItem.Create(Self);
        NewItem.Caption := TStation(Stations.Objects[i]).Name;
        NewItem.Tag     := i;
        NewItem.OnClick := miContactMenu_StationsClick;
        NewItem.OnDrawItem := DrawMenu;
        NewItem.OnMeasureItem := MeasureMenu;

        if Radio_StationID = i then NewItem.Checked := True;

        TMenuItem(MenuGroups.Objects[idxGroup]).Add(NewItem);

  //        TMenuItem(MenuGroups.Objects[idxGroup]).
      end;

      application.ProcessMessages;
    end;





    for i:=1 to miContactMenu_Formats.Count do miContactMenu_Formats.Delete(0);
    if Radio_StationID > Stations.Count - 1 then
      //dodelat
    else
    begin
      for i := 0 to TStation(Stations.Objects[Radio_StationID]).Streams.Count - 1 do
      begin
        NewItem := TMenuItem.Create(Self);
        NewItem.Caption := TStream(TStation(Stations.Objects[Radio_StationID]).Streams.Objects[i]).Format;
        NewItem.Tag     := i;
        NewItem.OnClick := miContactMenu_FormatsClick;
        NewItem.OnDrawItem := DrawMenu;
        NewItem.OnMeasureItem := MeasureMenu;

        if Radio_StreamID = i then NewItem.Checked := True;

        miContactMenu_Formats.Add(NewItem);
      end;

    end;

    miContactMenu_Stations.Caption := LNG('MENU ContactMenu', 'Stations', 'Stations');
    miContactMenu_Formats.Caption := LNG('MENU ContactMenu', 'Format', 'Format');

    miContactMenu_CopySongName.Caption := LNG('MENU ContactMenu', 'CopySongName', 'Copy song name');
    miContactMenu_Informations.Caption := QIPPlugin.GetLang(LI_INFORMATION);
    miContactMenu_Equalizer.Caption := LNG('MENU ContactMenu', 'Equalizer', 'Equalizer');
    miContactMenu_Recording.Caption := LNG('MENU ContactMenu', 'Recording', 'Recording');
    miContactMenu_Volume.Caption := LNG('MENU ContactMenu', 'Volume', 'Volume');
    miContactMenu_EditStations.Caption := LNG('MENU ContactMenu', 'EditStations', 'Edit stations');
    miContactMenu_FastAddStation.Caption := LNG('MENU ContactMenu', 'FastAddStation', 'Fast add station');
    miContactMenu_Options.Caption := QIPPlugin.GetLang(LI_OPTIONS);

    if Radio_Playing = False then
    begin
      miContactMenu_OnOff.Caption := LNG('MENU ContactMenu', 'RadioOn', 'Radio on');
      TIcon(PluginSkin.MenuIcons.Objects[0]).Assign(PluginTheme.State.PicturePlay.Icon);
    end
    else
    begin
      miContactMenu_OnOff.Caption := LNG('MENU ContactMenu', 'RadioOff', 'Radio off');
      TIcon(PluginSkin.MenuIcons.Objects[0]).Assign(PluginTheme.State.PictureStop.Icon);
    end;

    pmContactMenu.Popup(pX,pY);
  end;
end;


procedure TfrmQIPPlugin.SetChangeVolume;
var INI : TIniFile;
begin

  INIGetProfileConfig(INI);
  INIWriteInteger(INI, 'Conf','Volume', Player_Volume );
  INIFree(INI);


  if Player_Mute=True then
  begin
    FBassPlayer.Player_ChangeVolume( 0 );

    ExtraText     := LNG('PLAYER', 'VolumeMute', 'Volume: Mute');
    ExtraTextTime := 4;
  end
  else
  begin
    FBassPlayer.Player_ChangeVolume( Player_Volume );

    ExtraText     := LNG('PLAYER', 'Volume', 'Volume:') + ' ' + IntToStr(Player_Volume) + '%';
    ExtraTextTime := 4;
  end;

  RedrawSpecContact(UniqContactId);

end;


procedure TfrmQIPPlugin.SaveSelectedRadio;
var INI : TIniFile;

begin
  INIGetProfileConfig(INI);

  if Radio_StationID > Stations.Count - 1 then
      //dodelat
  else
  begin
    INIWriteStringUTF8(INI, 'Conf','StationID', TStation(Stations.Objects[ Radio_StationID ]).Name );
  end;

  INIWriteInteger(INI, 'Conf','StreamID', Radio_StreamID );

  INIFree(INI);

end;

end.

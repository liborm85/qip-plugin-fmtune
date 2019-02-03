unit General;

interface

uses
  SysUtils, Classes, Dialogs, Graphics, Windows, Forms, ExtCtrls, Controls,
  fQIPPlugin, u_common, IniFiles,
  About, Options, BassPlayer, Info, Volume, Recording, Equalizer, EditStations,
  FastAddStation,
  DownloadFile,
  XMLFiles;

type

  { ReplXStatus }
  TReplXStatus  = record
    Station           : WideString;
    Genre             : WideString;
    Format            : WideString;
    Language          : WideString;
    StationWeb        : WideString;
    Song              : WideString;
  end;

  {Stream}
  TStream = class
  public
    Format              : WideString;
    URL                 : WideString;
    PlayCount           : Int64;
    PlayTime            : Int64;  //Minutes
  end;

  {Station}
  TStation = class
  public
    Name                : WideString;
    Genre               : WideString;
    Language            : WideString;
    URL                 : WideString;
    DefaultStream       : Integer;
    Group               : WideString;
    Streams             : TStringList;
    PlayCount           : Int64;
    PlayTime            : Int64; //Minutes
  end;

  { Langs }
  TLangs = class
  public
    QIPID : DWORD;
    Name  : WideString;
    Trans : WideString;
  end;

  { Recording - Stream formats }
  TStreamFormat = record
  public
    Name   : WideString;
    Format : WideString;
  end;

  TImageIcon = record
    Image             : TImage;
    Icon              : TIcon;
  end;

  { PluginSkin }
  TPluginSkin = record
    PluginIconBig      : TImage;
    PluginIcon         : TImageIcon;

    Options            : TImageIcon;
    Volume             : TImageIcon;
    Equalizer          : TImageIcon;
    Info               : TImageIcon;
    Recording          : TImageIcon;
    Stations           : TImageIcon;
    Formats            : TImageIcon;
    EditStations       : TImageIcon;
    FastAddStation     : TImageIcon;

    ItemAdd            : TImageIcon;
    ItemRemove         : TImageIcon;
    ItemUp             : TImageIcon;
    ItemDown           : TImageIcon;

    ST_online          : TImageIcon;
    ST_ffc             : TImageIcon;
    ST_away            : TImageIcon;
    ST_na              : TImageIcon;
    ST_occ             : TImageIcon;
    ST_dnd             : TImageIcon;
    ST_invisible       : TImageIcon;
    ST_lunch           : TImageIcon;
    ST_depression      : TImageIcon;
    ST_evil            : TImageIcon;
    ST_at_home         : TImageIcon;
    ST_at_work         : TImageIcon;
    ST_offline         : TImageIcon;

    Mute               : TImageIcon;
    Unmute             : TImageIcon;
    Export             : TImageIcon;
    Import             : TImageIcon;
    General            : TImageIcon;
    Advanced           : TImageIcon;
    Skin               : TImageIcon;
    HotKeys            : TImageIcon;
    Connect            : TImageIcon;
    PopUp              : TImageIcon;
    ExtSource          : TImageIcon;

    MenuIcons          : TStringList;
    OptionsIcons       : TStringList;

    CheckMenuItem      : TIcon;
    Update             : TImageIcon;
    Comment            : TImageIcon;

    Folder             : TImageIcon;
    Favourite          : TImageIcon;

    Copy               : TImageIcon;


  end;

  procedure OpenAbout;
  procedure OpenOptions;

  procedure OpenVolume;
  procedure OpenRecording;
  procedure OpenEqualizer;
  procedure OpenInfo;
  procedure OpenEditStations;
  procedure OpenFastAddStation;

  function GetRecordTempFile : String;

  procedure SaveStations(DATA : TStringList; sFileName: WideString; bAdd: Boolean);
  procedure LoadStations(var DATA: TStringList; sFileName: WideString);

  function ReplXStatus(sText: WideString; Repl: TReplXStatus): WideString;

  procedure GetLangs;

  procedure HotKeysActivate;
  procedure HotKeysDeactivate;

  function GetSupportStreamFormat(ID: WideString): TStreamFormat; overload;
  function GetSupportStreamFormat(ID: Integer): TStreamFormat; overload;

  procedure AddLog(sText : WideString);

  const
    XSTATUS_MODE_SILENCE = 0; // Nezobrazí se okno s informcí, zda byl zapnut èi vypnut X-Status
    XSTATUS_MODE_NORMAL  = 1; // (defaultnì) Standartnì zobrazuje okno
  (*
  Vstup funkce:
  Act = -1 (defaultnì)... X-Status se nastaví podle toho, jak je na tom aktuálnì (je vyplej, zapne se...);
  Act = 0  ... X-Status bude vypnut;
  Act = 1  ... X-Status bude zapnut;
  Výstup funkce:
  Result = 1 ... X-Status byl zapnut
  Result = 0 ... X-Status byl vypnut;
  *)
  function EnDisXStatus(Act: Integer = -1; Mode: DWORD = XSTATUS_MODE_NORMAL): Integer;

const
  FrequencyCount = 18;

var
  QIPPlugin       : TfrmQIPPlugin;
  PluginDllPath,
  QIPInfiumPath,
  ProfilePath,
  PluginVersion,
  PluginVersionWithoutBuild,
  PluginLanguage,
  QIPInfiumLanguage : WideString;
  PluginSkin      : TPluginSkin;
  Account_DisplayName, Account_ProfileName, Account_FileName : WideString;

  INT_PLUGIN_HINT, INT_PLUGIN_DESC : WideString;

  frmBgColor : TColor;
  Stations: TStringList;
  Playlist : TStringList;

  Langs : TStringList;


  FBassPlayer      : TfrmBassPlayer;
  FAbout           : TfrmAbout;
  FOptions         : TfrmOptions;
  FInfo            : TfrmInfo;
  FRecording       : TfrmRecording;
  FEqualizer       : TfrmEqualizer;
  FVolume          : TfrmVolume;
  FEditStations    : TfrmEditStations;
  FFastAddStation  : TfrmFastAddStation;

  AboutIsShow, OptionsIsShow, InfoIsShow, VolumeIsShow, EqualizerIsShow,
  RecordingIsShow, EditStationsIsShow, ImportExportIsShow, FastAddStationIsShow
   : Boolean;


  Radio_StationID,
  Radio_StreamID     : Integer;
  Radio_Playing,
  Radio_PlayingError : Boolean;

  StreamRecording: Boolean;
  RecordingBufferSize: Int64;

  ExtraText: WideString;
  ExtraTextTime: Integer;  // 1 jednota = 1/2 vteriny

  Proxy_Mode    : Byte;
  Proxy_Server  : WideString;

  UniqContactId      : DWord;

  bBassLoadLibLoaded : Boolean;

  PlayURL: AnsiString;

  EqualizerEnabled, EqualizerToRadioGenre: Boolean;
  EqualizerReverb     : Integer;
  ReverbEnabled       : Boolean;
  EqualizerOption, Eq : WideString;
  EqualizerPreset     : TStringList;
  slFreqs             : TStringList;

  sNStationID : WideString;

  UseQIPMute, PlayOnStart, QIPSound, ShowComments, RadioExternalInfo: Boolean;

  LoadSongsExternal, ShowCover, SaveCover: Boolean;

  Player_Volume : Integer;
  Player_Mute   : Boolean;

  HotKeyEnabled : Boolean;
  HotKeyFMtune,
  HotKeyVolumeUp,
  HotKeyVolumeDown,
  HotKeyMute,
  HotKeyStationNext,
  HotKeyStationPrev,
  HotKeyEnableDisableXStatus : Integer;

  XStatus_Boolean : Boolean;
  XStatus_Type    : Integer;
  XStatus_Title, XStatus_Text : WideString;

  AutoStatusFFC, AutoStatusEvil, AutoStatusDepres, AutoStatusAtHome,
  AutoStatusAtWork, AutoStatusLunch, AutoStatusAway, AutoStatusNA,
  AutoStatusOccupied, AutoStatusDND, AutoStatusOnline, AutoStatusInvisible,
  AutoStatusOffline : Integer;
  AutoUseWherePlaying: Boolean;

  LastXStatusText, LastXStatusDescription: WideString;
  LastXStatusNumber: Integer;

  ActXstatusNum         : Integer;
  ChangeXstatus         : Boolean;
  ChangeXstatusPos      : Integer;

  RemoveXstatus : Boolean;

  ShowPopups : Boolean;

  PopupText : WideString;
  PopupType : Integer;
  ShowPopUpIfChangeInfo : Boolean;

  // Informace - popis streamu
  iSong, iRadio, iBitrate, CoverFile, iCover : WideString;
  iTime: real;

  FwStatus        : WideString;
  FwDescription   : WideString;

  DownloadingInfo : TPositionInfo;

  DataImportExport: TStringList;

  ImportExport_Type: Integer;

  QIP_Colors : TQipColors;

  osVerInfo: TOSVersionInfo;

  SaveLastStream : Boolean;

  LastRadioFadeMsg : WideString;

  SpecCntInfoTextScroll : Boolean;
  SpecCntInfoText  : WideString;
  SpecCntInfoTextX, SpecCntInfoTextWidth, SpecCntInfoMaxWidth : Integer;

  SpecCntInfo2TextScroll : Boolean;
  SpecCntInfo2Text  : WideString;
  SpecCntInfo2TextX, SpecCntInfo2TextWidth, SpecCntInfo2MaxWidth : Integer;

  SpecCntLine1Text, SpecCntLine2Text : WideString;
  SpecCntLine1TextLast, SpecCntLine2TextLast : WideString;
  SpecCntLine1ScrollText, SpecCntLine2ScrollText : Boolean;
  SpecCntShowLine2: Boolean;

  Pics: WideString;

implementation

uses u_lang_ids, Convs, uLNG, uImage, uSuperReplace, HotKeyManager,
     TextSearch, uFileFolder, uINI, u_qip_plugin;


procedure OpenAbout;
begin
  if AboutIsShow = False then
  begin
    FAbout := TfrmAbout.Create(nil);
    FAbout.Show;
  end;
end;

procedure OpenOptions;
begin
  if OptionsIsShow = False then
  begin
    FOptions := TfrmOptions.Create(nil);
    FOptions.Show;
  end;
end;


procedure OpenInfo;
begin
  if InfoIsShow = False then
  begin
    FInfo := TfrmInfo.Create(nil);
    FInfo.Show;
  end;
end;

procedure OpenEqualizer;
begin
  if EqualizerIsShow = False then
  begin
    FEqualizer := TfrmEqualizer.Create(nil);
    FEqualizer.Show;
  end;
end;


procedure OpenRecording;
begin
  if RecordingIsShow = False then
  begin
    FRecording := TfrmRecording.Create(nil);
    FRecording.Show;
  end;
end;

procedure OpenVolume;
var
  where: TPoint;
begin
  if VolumeIsShow = False then
  begin
    FVolume := TfrmVolume.Create(nil);

    where := Mouse.CursorPos;

    FVolume.Left := where.X;
    FVolume.Top  := where.Y - FVolume.Height;
    if (FVolume.Left < 0) then
      FVolume.Left := 0;
    if (FVolume.Left > Screen.Width) then
      FVolume.Left := Screen.Width - FVolume.Width;
    if (FVolume.Top < 0) then
      FVolume.Top := 0;
    if (FVolume.Left > Screen.Width) then
      FVolume.Top := Screen.Height - FVolume.Height;

    FVolume.Show;
  end;
end;

procedure OpenEditStations;
begin
  if EditStationsIsShow = False then
  begin
    FEditStations := TfrmEditStations.Create(nil);
    FEditStations.Show;
  end;
end;

procedure OpenFastAddStation;
begin
  if FastAddStationIsShow = False then
  begin
    FFastAddStation := TfrmFastAddStation.Create(nil);
    FFastAddStation.Show;
  end;
end;


function GetRecordTempFile : String;
begin
  Result := ExtractFilePath(PluginDllPath) + 'TMP_Audio_File.tmp';
end;


function DecXML(offset: Integer; sName: WideString; sLine: WideString; var sText: WideString): Boolean;
begin
  sText := '';

  Result := False;
  if AnsiUpperCase(Copy(sLine, offset + 1, Length(sName) + 2 )) = '<'+AnsiUpperCase(sName)+'>'  then
  begin
    if AnsiUpperCase(Copy(sLine, Length(sLine) - (Length(sName) + 2), Length(sName) + 2 + 1)) ='</'+AnsiUpperCase(sName)+'>'  then
      sText := Trim( Copy(sLine, offset + 1 + Length(sName) + 2, Length(sLine) - (offset + 1 + (Length(sName) * 2) + 2 + 2 )  )   );

    if (Copy(sText,1,1)='"') and (Copy(sText,Length(sText),1)='"') then
      sText := Copy(sText,2,Length(sText)-2);

    Result := True;
  end;
end;

procedure LoadStations(var DATA: TStringList; sFileName: WideString);
var
    F: TextFile;
    sLine, sPart, sPart2, sReturn : WideString;
    utf8Line: UTF8String;
    hIndex2 : Integer;
    bAdded: Boolean;
    iReturn, k, hIndex: Integer;
begin
  if sFileName='' then
    INIGetProfileStations(sFileName);

  DATA.Clear;


  if FileExists( sFileName ) = False then Exit;

  LoadXMLStations(sFileName, DATA);

(*
  AssignFile(F, sFileName );
  Reset(F);
  while not eof(F) do
  begin
    Readln(F, utf8Line );

    sLine:= UTF82WideString(utf8Line);


    if Copy(sLine,1,1)='<'  then
    begin
      if Copy(sLine, Length(sLine) , 1)='>' then
      begin

        sPart:=Copy(sLine, 2 , Length(sLine) - 2 );
        if Copy(sPart,1,1)='/' then sPart:='';

        if AnsiUpperCase(sPart) = 'STATION' then
        begin
          DATA.Add('ITEM');
          hIndex:= DATA.Count - 1;
          DATA.Objects[hIndex] := TStation.Create;
          TStation(DATA.Objects[hIndex]).Name     := '';
          TStation(DATA.Objects[hIndex]).Genre    := '';
          TStation(DATA.Objects[hIndex]).Language := '';
          TStation(DATA.Objects[hIndex]).URL      := '';

          TStation(DATA.Objects[hIndex]).Streams := TStringList.Create;
          TStation(DATA.Objects[hIndex]).Streams.Clear;

        end;


      end;

    end {< }

    else
    begin

      if AnsiUpperCase(sPart) = 'STATION' then
      begin
        bAdded := False;

        if DecXML(1, 'Name', sLine, sReturn) = True then
        begin
          TStation(DATA.Objects[hIndex]).Name := sReturn;
          bAdded := True
        end;

        if DecXML(1, 'Genre', sLine, sReturn) = True then
        begin
          TStation(DATA.Objects[hIndex]).Genre := sReturn;
          bAdded := True
        end;

        if DecXML(1, 'Language', sLine, sReturn) = True then
        begin
          TStation(DATA.Objects[hIndex]).Language := sReturn;
          bAdded := True
        end;

        if DecXML(1, 'URL', sLine, sReturn) = True then
        begin
          TStation(DATA.Objects[hIndex]).URL := sReturn;
          bAdded := True
        end;

        if DecXML(1, 'Group', sLine, sReturn) = True then
        begin
          TStation(DATA.Objects[hIndex]).Group := sReturn;
          bAdded := True
        end;

        if DecXML(1, 'DefaultStream', sLine, sReturn) = True then
        begin
          val(sReturn, iReturn, k);

          if k=0 then
            TStation(DATA.Objects[hIndex]).DefaultStream := iReturn
          else
            TStation(DATA.Objects[hIndex]).DefaultStream := 0;

          bAdded := True
        end;

      if bAdded = False then
      begin


        if Copy(sLine,1,2)=' <'  then
        begin

          if Copy(sLine, Length(sLine) , 1)='>' then
          begin
            sPart2:=Copy(sLine, 3 , Length(sLine) - 3 );

            if Copy(sPart2,1,1)='/' then sPart2:='';

            if AnsiUpperCase(sPart2) = 'STREAM' then
            begin

              TStation(DATA.Objects[hIndex]).Streams.Add('STREAM');
              hIndex2:= TStation(DATA.Objects[hIndex]).Streams.Count - 1;
              TStation(DATA.Objects[hIndex]).Streams.Objects[hIndex2] := TStream.Create;
              TStream(TStation(DATA.Objects[hIndex]).Streams.Objects[hIndex2]).Format := '';
              TStream(TStation(DATA.Objects[hIndex]).Streams.Objects[hIndex2]).URL    := '';

            end

          end;

        end else
        begin
          if AnsiUpperCase(sPart2) = 'STREAM' then
          begin

            if DecXML(2, 'Format', sLine, sReturn) = True then
              TStream(TStation(DATA.Objects[hIndex]).Streams.Objects[hIndex2]).Format := sReturn;

            if DecXML(2, 'URL', sLine, sReturn) = True then
              TStream(TStation(DATA.Objects[hIndex]).Streams.Objects[hIndex2]).URL := sReturn;

          end;

        end;
     end;

      end; {else <}
    end;
  end; {while not eof}

  CloseFile(F);
*)


end;

procedure SaveStations(DATA : TStringList; sFileName: WideString; bAdd: Boolean);
var i,ii: Integer;
    F: TextFile;
    utf8Line: UTF8String;

begin
  if sFileName='' then
    INIGetProfileStations(sFileName);

  if FileExists( sFileName ) = True then
  begin
    AssignFile(F,  sFileName );

    if bAdd = True then
      Append(F)
    else
      Rewrite(F);
  end
  else
  begin
    AssignFile(F,  sFileName );
    Rewrite(F);
  end;
(*
  i:=0;
  while ( i <= DATA.Count - 1 ) do
  begin
    Application.ProcessMessages;

    utf8Line := WideString2UTF8( '<Station>' );
    WriteLn(f, utf8Line );

    utf8Line := WideString2UTF8( ' <Name>'+TStation(DATA.Objects[i]).Name+'</Name>' );
    WriteLn(f, utf8Line );

    utf8Line := WideString2UTF8( ' <Genre>'+TStation(DATA.Objects[i]).Genre+'</Genre>' );
    WriteLn(f, utf8Line );

    utf8Line := WideString2UTF8( ' <Language>'+TStation(DATA.Objects[i]).Language+'</Language>' );
    WriteLn(f, utf8Line );

    utf8Line := WideString2UTF8( ' <Group>'+TStation(DATA.Objects[i]).Group+'</Group>' );
    WriteLn(f, utf8Line );

    utf8Line := WideString2UTF8( ' <URL>'+TStation(DATA.Objects[i]).URL+'</URL>' );
    WriteLn(f, utf8Line );

    utf8Line := WideString2UTF8( ' <DefaultStream>'+IntToStr(TStation(DATA.Objects[i]).DefaultStream)+'</DefaultStream>' );
    WriteLn(f, utf8Line );


    ii:=0;
    while ( ii <= TStation(DATA.Objects[i]).Streams.Count - 1 ) do
    begin
      Application.ProcessMessages;

      utf8Line := WideString2UTF8( ' <Stream>' );
      Write(f, utf8Line );

      utf8Line := WideString2UTF8( ' <Format>'+TStream(TStation(DATA.Objects[i]).Streams.Objects[ii]).Format+'</Format>' );
      Write(f, utf8Line );

      utf8Line := WideString2UTF8( ' <URL>'+TStream(TStation(DATA.Objects[i]).Streams.Objects[ii]).URL+'</URL>' );
      Write(f, utf8Line );

      utf8Line := WideString2UTF8( ' </Stream>' );
      WriteLn(f, utf8Line );
      Inc(ii);
    end;



    utf8Line := WideString2UTF8( '</Station>' );
    WriteLn(f, utf8Line );

    utf8Line := WideString2UTF8( '' );
    WriteLn(f, utf8Line );

    Inc(i);
  end;

  CloseFile(F);    *)



(*
// oddìlené øádky
  utf8Line := WideString2UTF8( '<?xml version="1.0" encoding="UTF-8" ?>' );
  WriteLn(f, utf8Line );

  utf8Line := WideString2UTF8( '<stationslist>' );
  WriteLn(f, utf8Line );

  i:=0;
  while ( i <= DATA.Count - 1 ) do
  begin
    Application.ProcessMessages;

    utf8Line := WideString2UTF8( ' <station name="'+TStation(DATA.Objects[i]).Name+'"'+
                                          ' genre="'+TStation(DATA.Objects[i]).Genre+'"'+
                                          ' language="'+TStation(DATA.Objects[i]).Language+'"'+
                                          ' group="'+TStation(DATA.Objects[i]).Group+'"'+
                                 '>' );
    WriteLn(f, utf8Line );

    utf8Line := WideString2UTF8( '  <streams default="'+IntToStr(TStation(DATA.Objects[i]).DefaultStream)+'">' );
    WriteLn(f, utf8Line );


    ii:=0;
    while ( ii <= TStation(DATA.Objects[i]).Streams.Count - 1 ) do
    begin
      Application.ProcessMessages;

      utf8Line := WideString2UTF8( '   <stream format="'+TStream(TStation(DATA.Objects[i]).Streams.Objects[ii]).Format+'">'+
                                    TStream(TStation(DATA.Objects[i]).Streams.Objects[ii]).URL+
                                      '</stream>' );
      WriteLn(f, utf8Line );

      Inc(ii);
    end;

    utf8Line := WideString2UTF8( '  </streams>' );
    WriteLn(f, utf8Line );

    utf8Line := WideString2UTF8( ' </station>' );
    WriteLn(f, utf8Line );

    utf8Line := WideString2UTF8( '' );
    WriteLn(f, utf8Line );

    Inc(i);
  end;

  utf8Line := WideString2UTF8( '</stationslist>' );
  WriteLn(f, utf8Line );

  CloseFile(F);                        *)

(* nenjaky bug, uklada jen nektere stanice     -- nepouziva #13+#10
  utf8Line := WideString2UTF8( '<?xml version="1.0" encoding="UTF-8" ?>' );
  Write(f, utf8Line );

  utf8Line := WideString2UTF8( '<stationslist>' );
  Write(f, utf8Line );

  i:=0;
  while ( i <= DATA.Count - 1 ) do
  begin
    Application.ProcessMessages;

    utf8Line := WideString2UTF8( '<station name="'+TStation(DATA.Objects[i]).Name+'"'+
                                          ' genre="'+TStation(DATA.Objects[i]).Genre+'"'+
                                          ' language="'+TStation(DATA.Objects[i]).Language+'"'+
                                          ' group="'+TStation(DATA.Objects[i]).Group+'"'+
                                 '>' );
    Write(f, utf8Line );

    utf8Line := WideString2UTF8( '<streams default="'+IntToStr(TStation(DATA.Objects[i]).DefaultStream)+'">' );
    Write(f, utf8Line );


    ii:=0;
    while ( ii <= TStation(DATA.Objects[i]).Streams.Count - 1 ) do
    begin
      Application.ProcessMessages;

      utf8Line := WideString2UTF8( '<stream format="'+TStream(TStation(DATA.Objects[i]).Streams.Objects[ii]).Format+'"'+
                                             ' url="'+TStream(TStation(DATA.Objects[i]).Streams.Objects[ii]).URL+'"'
                                      +' />' );
      Write(f, utf8Line );

      Inc(ii);
    end;

    utf8Line := WideString2UTF8( '</streams>' );
    Write(f, utf8Line );

    utf8Line := WideString2UTF8( '</station>' );
    Write(f, utf8Line );


    Inc(i);
  end;

  utf8Line := WideString2UTF8( '</stationslist>' );
  Write(f, utf8Line );

  CloseFile(F);   *)



(*
  utf8Line := WideString2UTF8( '<?xml version="1.0" encoding="UTF-8" ?>' );
  WriteLn(f, utf8Line );

  utf8Line := WideString2UTF8( '<stationslist>' );
  WriteLn(f, utf8Line );

  i:=0;
  while ( i <= DATA.Count - 1 ) do
  begin
    Application.ProcessMessages;

    utf8Line := WideString2UTF8( ' <station name="'+TStation(DATA.Objects[i]).Name+'"'+
                                          ' genre="'+TStation(DATA.Objects[i]).Genre+'"'+
                                          ' language="'+TStation(DATA.Objects[i]).Language+'"'+
                                          ' group="'+TStation(DATA.Objects[i]).Group+'"'+
                                 '>' );
    WriteLn(f, utf8Line );

    utf8Line := WideString2UTF8( '  <streams default="'+IntToStr(TStation(DATA.Objects[i]).DefaultStream)+'">' );
    WriteLn(f, utf8Line );


    ii:=0;
    while ( ii <= TStation(DATA.Objects[i]).Streams.Count - 1 ) do
    begin
      Application.ProcessMessages;

      utf8Line := WideString2UTF8( '   <stream format="'+TStream(TStation(DATA.Objects[i]).Streams.Objects[ii]).Format+'"'+
                                             ' url="'+TStream(TStation(DATA.Objects[i]).Streams.Objects[ii]).URL+'"'
                                      +' />' );
      WriteLn(f, utf8Line );

      Inc(ii);
    end;

    utf8Line := WideString2UTF8( '  </streams>' );
    WriteLn(f, utf8Line );

    utf8Line := WideString2UTF8( ' </station>' );
    WriteLn(f, utf8Line );

    utf8Line := WideString2UTF8( '' );
    WriteLn(f, utf8Line );

    Inc(i);
  end;

  utf8Line := WideString2UTF8( '</stationslist>' );
  WriteLn(f, utf8Line );

  CloseFile(F);   *)

  utf8Line := WideString2UTF8( '<?xml version="1.0" encoding="UTF-8" ?>' );
  WriteLn(f, utf8Line );

  utf8Line := WideString2UTF8( '<stationslist>' );
  WriteLn(f, utf8Line );

  i:=0;
  while ( i <= DATA.Count - 1 ) do
  begin
    Application.ProcessMessages;


    utf8Line := ' <station name="'+{MIMEBase64Encode(}WideString2UTF8(TStation(DATA.Objects[i]).Name){)}+'"'+
                        ' genre="'+{MIMEBase64Encode(}WideString2UTF8(TStation(DATA.Objects[i]).Genre){)}+'"'+
                     ' language="'+{MIMEBase64Encode(}WideString2UTF8(TStation(DATA.Objects[i]).Language){)}+'"'+
                        ' group="'+{MIMEBase64Encode(}WideString2UTF8(TStation(DATA.Objects[i]).Group){)}+'"'+
                '>';
    WriteLn(f, utf8Line );

    utf8Line := WideString2UTF8( '  <streams default="'+IntToStr(TStation(DATA.Objects[i]).DefaultStream)+'">' );
    WriteLn(f, utf8Line );


    ii:=0;
    while ( ii <= TStation(DATA.Objects[i]).Streams.Count - 1 ) do
    begin
      Application.ProcessMessages;

      utf8Line := '   <stream format="'+{MIMEBase64Encode(}WideString2UTF8(TStream(TStation(DATA.Objects[i]).Streams.Objects[ii]).Format){)}+'"'+
                               ' url="'+{MIMEBase64Encode(}WideString2UTF8(TStream(TStation(DATA.Objects[i]).Streams.Objects[ii]).URL){)}+'"'
                 +' />';
      WriteLn(f, utf8Line );

      Inc(ii);
    end;

    utf8Line := WideString2UTF8( '  </streams>' );
    WriteLn(f, utf8Line );

    utf8Line := WideString2UTF8( ' </station>' );
    WriteLn(f, utf8Line );
{
    utf8Line := WideString2UTF8( '' );
    WriteLn(f, utf8Line );
}
    Inc(i);
  end;

  utf8Line := WideString2UTF8( '</stationslist>' );
  WriteLn(f, utf8Line );

  CloseFile(F);



end;

function ReplXStatus(sText: WideString; Repl: TReplXStatus): WideString;
var r : Integer;
begin

  sText := StringReplace(sText, '%STATION%', Repl.Station, [rfReplaceAll, rfIgnoreCase]);
  sText := StringReplace(sText, '%GENRE%', Repl.Genre, [rfReplaceAll, rfIgnoreCase]);
  sText := StringReplace(sText, '%SONG%', isong, [rfReplaceAll, rfIgnoreCase]);
  sText := StringReplace(sText, '%FORMAT%', Repl.Format, [rfReplaceAll, rfIgnoreCase]);
  sText := StringReplace(sText, '%BITRATE%', iBitrate, [rfReplaceAll, rfIgnoreCase]);

  r := Langs.IndexOf(Repl.Language);
  if r=-1 then
    sText := StringReplace(sText, '%LANGUAGE%', '', [rfReplaceAll, rfIgnoreCase])
  else
    sText := StringReplace(sText, '%LANGUAGE%', TLangs(Langs.Objects[r]).Trans, [rfReplaceAll, rfIgnoreCase]);


  sText := StringReplace(sText, '%STATIONWEB%', Repl.StationWeb, [rfReplaceAll, rfIgnoreCase]);

  sText := ReplCondBlocks(sText);

  Result := sText;

end;

procedure AddLang(QIPID: DWord; Name: WideString);
var hIndex: Integer;
begin
  Langs.Add(Name);
  hIndex:= Langs.Count - 1;
  Langs.Objects[hIndex] := TLangs.Create;
  TLangs(Langs.Objects[hIndex]).QIPID  := QIPID;
  TLangs(Langs.Objects[hIndex]).Name   := Name;
  if QIPID<>0 then
    TLangs(Langs.Objects[hIndex]).Trans  := QIPPlugin.GetLang(QIPID);
end;

procedure GetLangs;
begin
  Langs := TStringList.Create;
  Langs.Clear;

  AddLang(0                   , '');
  AddLang(LI_LANG_ARABIC      , 'ARABIC');
  AddLang(LI_LANG_BHOJPURI    , 'BHOJPURI');
  AddLang(LI_LANG_BULGARIAN   , 'BULGARIAN');
  AddLang(LI_LANG_BURMESE     , 'BURMESE');
  AddLang(LI_LANG_CANTONESE   , 'CANTONESE');
  AddLang(LI_LANG_CATALAN     , 'CATALAN');
  AddLang(LI_LANG_CHINESE     , 'CHINESE');
  AddLang(LI_LANG_CROATIAN    , 'CROATIAN');
  AddLang(LI_LANG_CZECH       , 'CZECH');
  AddLang(LI_LANG_DANISH      , 'DANISH');
  AddLang(LI_LANG_DUTCH       , 'DUTCH');
  AddLang(LI_LANG_ENGLISH     , 'ENGLISH');
  AddLang(LI_LANG_ESPERANTO   , 'ESPERANTO');
  AddLang(LI_LANG_ESTONIAN    , 'ESTONIAN');
  AddLang(LI_LANG_FARSI       , 'FARSI');
  AddLang(LI_LANG_FINNISH     , 'FINNISH');
  AddLang(LI_LANG_FRENCH      , 'FRENCH');
  AddLang(LI_LANG_GAELIC      , 'GAELIC');
  AddLang(LI_LANG_GERMAN      , 'GERMAN');
  AddLang(LI_LANG_GREEK       , 'GREEK');
  AddLang(LI_LANG_HEBREW      , 'HEBREW');
  AddLang(LI_LANG_HINDI       , 'HINDI');
  AddLang(LI_LANG_HUNGARIAN   , 'HUNGARIAN');
  AddLang(LI_LANG_ICELANDIC   , 'ICELANDIC');
  AddLang(LI_LANG_INDONESIAN  , 'INDONESIAN');
  AddLang(LI_LANG_ITALIAN     , 'ITALIAN');
  AddLang(LI_LANG_JAPANESE    , 'JAPANESE');
  AddLang(LI_LANG_KHMER       , 'KHMER');
  AddLang(LI_LANG_KOREAN      , 'KOREAN');
  AddLang(LI_LANG_LAO         , 'LAO');
  AddLang(LI_LANG_LATVIAN     , 'LATVIAN');
  AddLang(LI_LANG_LITHUANIAN  , 'LITHUANIAN');
  AddLang(LI_LANG_MALAY       , 'MALAY');
  AddLang(LI_LANG_NORWEGIAN   , 'NORWEGIAN');
  AddLang(LI_LANG_POLISH      , 'POLISH');
  AddLang(LI_LANG_PORTUGUESE  , 'PORTUGUESE');
  AddLang(LI_LANG_ROMANIAN    , 'ROMANIAN');
  AddLang(LI_LANG_RUSSIAN     , 'RUSSIAN');
  AddLang(LI_LANG_SERBIAN     , 'SERBIAN');
  AddLang(LI_LANG_SLOVAK      , 'SLOVAK');
  AddLang(LI_LANG_SLOVENIAN   , 'SLOVENIAN');
  AddLang(LI_LANG_SOMALI      , 'SOMALI');
  AddLang(LI_LANG_SPANISH     , 'SPANISH');
  AddLang(LI_LANG_SWAHILI     , 'SWAHILI');
  AddLang(LI_LANG_SWEDISH     , 'SWEDISH');
  AddLang(LI_LANG_TAGALOG     , 'TAGALOG');
  AddLang(LI_LANG_TATAR       , 'TATAR');
  AddLang(LI_LANG_THAI        , 'THAI');
  AddLang(LI_LANG_TURKISH     , 'TURKISH');
  AddLang(LI_LANG_UKRAINIAN   , 'UKRAINIAN');
  AddLang(LI_LANG_URDU        , 'URDU');
  AddLang(LI_LANG_VIETNAMESE  , 'VIETNAMESE');
  AddLang(LI_LANG_YIDDISH     , 'YIDDISH');
  AddLang(LI_LANG_YORUBA      , 'YORUBA');
  AddLang(LI_LANG_AFRIKAANS   , 'AFRIKAANS');
  AddLang(LI_LANG_BOSNIAN     , 'BOSNIAN');
  AddLang(LI_LANG_PERSIAN     , 'PERSIAN');
  AddLang(LI_LANG_ALBANIAN    , 'ALBANIAN');
  AddLang(LI_LANG_ARMENIAN    , 'ARMENIAN');
  AddLang(LI_LANG_PUNJABI     , 'PUNJABI');
  AddLang(LI_LANG_CHAMORRO    , 'CHAMORRO');
  AddLang(LI_LANG_MONGOLIAN   , 'MONGOLIAN');
  AddLang(LI_LANG_MANDARIN    , 'MANDARIN');
  AddLang(LI_LANG_TAIWANESE   , 'TAIWANESE');
  AddLang(LI_LANG_MACEDONIAN  , 'MACEDONIAN');
  AddLang(LI_LANG_SINDHI      , 'SINDHI');
  AddLang(LI_LANG_WELSH       , 'WELSH');
  AddLang(LI_LANG_AZERBAIJANI , 'AZERBAIJANI');
  AddLang(LI_LANG_KURDISH     , 'KURDISH');
  AddLang(LI_LANG_GUJARATI    , 'GUJARATI');
  AddLang(LI_LANG_TAMIL       , 'TAMIL');
  AddLang(LI_LANG_BELORUSSIAN , 'BELORUSSIAN');
  AddLang(LI_LANG_UNKNOWN     , 'UNKNOWN');
end;

procedure HotKeysActivate;
var
  iMod, iKey: Word;
begin
  SeparateHotKey( HotKeyFMtune, iMod, iKey );
  RegisterHotKey( QIPPlugin.Handle, 8801, iMod, iKey );
  SeparateHotKey( HotKeyVolumeUp, iMod, iKey );
  RegisterHotKey( QIPPlugin.Handle, 8802, iMod, iKey );
  SeparateHotKey( HotKeyVolumeDown, iMod, iKey );
  RegisterHotKey( QIPPlugin.Handle, 8803, iMod, iKey );
  SeparateHotKey( HotKeyMute, iMod, iKey );
  RegisterHotKey( QIPPlugin.Handle, 8804, iMod, iKey );
  SeparateHotKey( HotKeyStationNext, iMod, iKey );
  RegisterHotKey( QIPPlugin.Handle, 8805, iMod, iKey );
  SeparateHotKey( HotKeyStationPrev, iMod, iKey );
  RegisterHotKey( QIPPlugin.Handle, 8806, iMod, iKey );
  SeparateHotKey( HotKeyEnableDisableXStatus, iMod, iKey );
  RegisterHotKey( QIPPlugin.Handle, 8807, iMod, iKey );
end;

procedure HotKeysDeactivate;
var
  iMod, iKey: Word;
begin
  UnregisterHotKey( QIPPlugin.Handle, 8801);
  UnregisterHotKey( QIPPlugin.Handle, 8802);
  UnregisterHotKey( QIPPlugin.Handle, 8803);
  UnregisterHotKey( QIPPlugin.Handle, 8804);
  UnregisterHotKey( QIPPlugin.Handle, 8805);
  UnregisterHotKey( QIPPlugin.Handle, 8806);
  UnregisterHotKey( QIPPlugin.Handle, 8807);
end;


function GetSupportStreamFormat(ID: WideString): TStreamFormat; overload;
begin
  try
    Result := GetSupportStreamFormat(StrToInt(ID));
  except
    Result.Name := ID;
    Result.Format := '';
  end;
end;

function GetSupportStreamFormat(ID: Integer): TStreamFormat; overload;
begin
  case ID of
    1: begin
        Result.Format := 'mp1';
        Result.Name := 'MPEG Layer-1';
       end;
    2: begin
        Result.Format := 'mp2';
        Result.Name := 'MPEG Layer-2';
       end;
    3: begin
        Result.Format := 'mp3';
        Result.Name := 'MPEG Layer-3';
       end;
    4: begin
        Result.Format := 'ogg';
        Result.Name := 'Ogg Vorbis';
       end;
    5: begin
        Result.Format := 'wav';
        Result.Name := 'PCM WAV';
       end;
    6: begin
        Result.Format := 'wav';
        Result.Name := 'Floating-point WAV';
       end;
    7: begin
        Result.Format := 'wav';
        Result.Name := 'WAV';
       end;
    8: begin
        Result.Format := 'aiff';
        Result.Name := 'Audio IFF';
       end;
    9: begin
        Result.Format := 'aac';
        Result.Name := 'Advanced Audio Coding';
       end
    else
      begin
        Result.Name := '';
        Result.Format := '';
      end;
  end;
end;


procedure AddLog(sText : WideString);
var
  F : TextFile;
begin

  if not FileExists(PluginDllPath+PLUGIN_NAME+'.log') then
  begin
    AssignFile(F, PluginDllPath+PLUGIN_NAME+'.log');
    ReWrite(F);
    WriteLn(F,'; Code page: UTF-8');
    WriteLn(F);
    CloseFile(F);
  end;


  AssignFile(F, PluginDllPath+PLUGIN_NAME+'.log');
  Append(F);

  WriteLn(F,   WideString2UTF8(FormatDateTime('yyyy-mm-dd hh:nn:ss',Now) + ' - ' + sText) );
  CloseFile(F);
end;


function EnDisXStatus(Act: Integer = -1; Mode: DWORD = XSTATUS_MODE_NORMAL): Integer;
var
  INI: TIniFile;
begin
  case Act of
    -1: XStatus_Boolean := not (XStatus_Boolean);
    0: XStatus_Boolean := False;
    1: XStatus_Boolean := True;
  end;

  if XStatus_Boolean = True then
    ChangeXstatus := True
  else
    RemoveXstatus := True;

  INIGetProfileConfig(INI);
  INIWriteBool(INI, 'XStatus', 'Enabled', XStatus_Boolean);
  INIFree(INI);

  if (Mode = XSTATUS_MODE_NORMAL) then  // pokud je normální mód
  begin
    if XStatus_Boolean = True then
      QIPPlugin.AddFadeMsg(1, PluginSkin.PluginIcon.Icon.Handle, PLUGIN_NAME, LNG('TEXTS', 'XStatus.Enabled', 'X-Status Enabled'), True, False, 3, 0)
    else
      QIPPlugin.AddFadeMsg(1, PluginSkin.PluginIcon.Icon.Handle, PLUGIN_NAME, LNG('TEXTS', 'XStatus.Disabled', 'X-Status Disabled'), True, False, 3, 0);
  end;

  Result := BoolToInt(XStatus_Boolean);
end;


end.

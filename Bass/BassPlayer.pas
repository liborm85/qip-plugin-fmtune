unit BassPlayer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dynamic_BASS, StdCtrls, ComCtrls, ExtCtrls, Math;

const
  WM_INFO_UPDATE = WM_USER + 101;
    {
type
  WAVHDR = packed record
    riff:			array[0..3] of Char;
    len:			DWord;
    cWavFmt:		array[0..7] of Char;
    dwHdrLen:		DWord;
    wFormat:		Word;
    wNumChannels:	Word;
    dwSampleRate:	DWord;
    dwBytesPerSec:	DWord;
    wBlockAlign:	Word;
    wBitsPerSample:	Word;
    cData:			array[0..3] of Char;
    dwDataLen:		DWord;
  end;
    }

type
  TfrmBassPlayer = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lvPlugins: TListView;
    Memo1: TMemo;
    lblMeta: TLabel;
    tmrLoadNowPlaying: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure tmrLoadNowPlayingTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    Sliding: boolean;



    procedure BASSPlayer_Play(sFileName: String);
    procedure BASSPlayer_Stop;
    procedure BASSPlayer_Pause;
    procedure BASSPlayer_Volume(value: Integer);

    procedure BASSPlayer_SetEq(index: Integer; value: Integer);
    procedure BASSPlayer_GetEq(index: Integer; var value: Integer);
    procedure BASSPlayer_SetReverb(index: Integer; value: Integer);
    procedure BASSPlayer_GetReverb(index: Integer; var value: Integer);

    procedure BASSPlayer_FileStreamFree;
    procedure BASSPlayer_AllFree;    

    procedure Error(const Text: string);
    function GetCTypeString(ctype: DWORD; plugin: HPLUGIN): string;

    procedure WndProc(var Msg: TMessage); override;

////////////////////////////////////

    procedure Player_Stop;
    procedure PlayStopRadio;
    procedure Player_ChangeVolume(value: Integer);


  protected
    procedure CreateParams (var Params: TCreateParams); override;
  end;

var
  frmBassPlayer: TfrmBassPlayer;

  Chan: HStream;

  cthread: DWORD = 0;
 // chan: HSTREAM = 0;
  win: hwnd;
{
  WaveHdr: WAVHDR;  // WAV header
  rchan:   HRECORD;	// recording channel
}

  Proxy: array [0..99] of char; //proxy server

  p: BASS_DX8_PARAMEQ;
  pR: BASS_DX8_REVERB;

    WaveStream: TMemoryStream;

  FileStream : TFileStream;

implementation

uses General, uLNG, Info, DownloadFile, u_qip_plugin, TextSearch, uStatistics,
     uEqualizer, uNowPlaying, uFileFolder;

var
  fx: array[1..EQ_REVERB] of integer;


{$R *.dfm}

procedure TfrmBassPlayer.CreateParams (var Params: TCreateParams);
begin
  inherited;
    with Params do begin
      ExStyle := (ExStyle or WS_EX_TOOLWINDOW or WS_EX_NOACTIVATE);
    end;
end;



procedure Error(es: string);
begin
  Radio_Playing := False;

  MessageBox(win, PChar(es + #13#10 + '(error code: ' + IntToStr(BASS_ErrorGetCode) +
    ')'), nil, 0);
end;


procedure TfrmBassPlayer.Error(const Text: string);
begin
  MessageBox(Handle, PChar(Text + '  Errorcode = ' +
    inttostr(Bass_ErrorGetCode)), PChar('Error'), 16);
end;


function ProgDir: string;
begin
  result := ExtractFilePath({ParamStr(0)}PluginDllPath);
end;







function TfrmBassPlayer.GetCTypeString(ctype: DWORD; plugin: HPLUGIN): string;
var
  pInfo: ^BASS_PLUGININFO;
  a: integer;
begin
  if plugin <> 0 then
  begin
    //pInfo := BASS_PluginGetInfo(plugin);
    pInfo := pointer(BASS_PluginGetInfo(plugin));
    for a := 0 to PInfo.formatc - 1 do
      if pInfo.Formats[a].ctype = cType then
        Result := pInfo.Formats[a].name;
  end;
  // check built-in stream formats...
  case cType of
    BASS_CTYPE_STREAM_MP1: Result := Result + '1';        // 'MPEG Layer-1'
    BASS_CTYPE_STREAM_MP2: Result := Result + '2';        // 'MPEG Layer-2'
    BASS_CTYPE_STREAM_MP3: Result := Result + '3';        // 'MPEG Layer-3'
    BASS_CTYPE_STREAM_OGG: Result := Result + '4';        // 'Ogg Vorbis'
    BASS_CTYPE_STREAM_WAV_PCM: Result := Result + '5';    // 'PCM WAV'
    BASS_CTYPE_STREAM_WAV_FLOAT: Result := Result + '6';  // 'Floating-point WAV'
    BASS_CTYPE_STREAM_WAV: Result := Result + '7';        // 'WAV'
    BASS_CTYPE_STREAM_AIFF: Result := Result + '8';       // 'Audio IFF'
  end;
  if Result = 'Advanced Audio Coding' then
    Result := '9';

end;

procedure DoMeta();
var
  meta: PAnsiChar;
  p: Integer;
begin
  meta := BASS_ChannelGetTags(chan, BASS_TAG_META);
  if (meta <> nil) then
  begin

    FBassPlayer.lblMeta.Caption := meta;

    p := Pos('StreamTitle=', meta);
    if (p = 0) then
      Exit;
    p := p + 13;
    SendMessage(win, WM_INFO_UPDATE, 7, DWORD(PAnsiChar(Copy(meta, p, Pos(';', meta) - p - 1))));
  end;
end;

procedure MetaSync(handle: HSYNC; channel, data, user: DWORD); stdcall;
begin
  DoMeta();
end;

procedure StatusProc(buffer: Pointer; len, user: DWORD); stdcall;
begin
  RecordingBufferSize := len;

//Creates a sample stream from an MP3, MP2, MP1, OGG, WAV, AIFF or plugin supported file on the internet, optionally receiving the downloaded data in a callback function.
try
  if StreamRecording = True then
  begin
    if (FileStream = nil) then
    begin
      //AddLog('Create FileStream');
      FileStream := TFileStream.Create(GetRecordTempFile, fmCreate); // create the  file
      //AddLog('Create FileStream Complete');
    end;


    if (buffer = nil) then
    begin
      //AddLog('FileStream.Free');
      FileStream.Free;  // finished  downloading
      //AddLog('FileStream.Free Complete');
    end
    else
    begin
      //AddLog('FileStream.WriteBuffer');
      FileStream.WriteBuffer(buffer^, len);
      //AddLog('FileStream.WriteBuffer Complete');
    end;

  end;
finally

end;

try
  if (buffer <> nil) and (len = 0) then
    SendMessage(win, WM_INFO_UPDATE, 8, DWORD(PAnsiChar(buffer)));
finally

end;


end;

procedure TfrmBassPlayer.WndProc(var Msg: TMessage);
// to be threadsave we are passing all Canvas Stuff(e.g. Labels) to this messages
begin
  inherited;
try
  if Msg.Msg = WM_INFO_UPDATE then
    begin
      case msg.WParam of
        0:
          begin
            ExtraText     := '';
            ExtraTextTime := 0;

            QIPPlugin.RedrawSpecContact(UniqContactId);

            if Radio_Playing then
              Label4.Caption := LNG('PLAYER', 'Connecting', 'Connecting...')
            else
              Label4.Caption := LNG('PLAYER', 'NoRadio', 'Nothing to play');;
            Label3.Caption := '';
            Label5.Caption := '';
          end;
        1:
          begin
            ExtraText     := LNG('PLAYER', 'NotPlaying', 'Not playing');
            ExtraTextTime := 4;

            QIPPlugin.RedrawSpecContact(UniqContactId);

            Label4.Caption := LNG('PLAYER', 'NotPlaying', 'Not playing');//'1  ' + 'not playing';
  //        Error('Can''t play the stream');
          end;
        2:
          begin
            ExtraText     := Format(LNG('PLAYER', 'Buffering', 'Buffering... %d%%'), [msg.LParam]);
            ExtraTextTime := 4;

            QIPPlugin.RedrawSpecContact(UniqContactId);

            Label4.Caption := Format(LNG('PLAYER', 'Buffering', 'Buffering... %d%%'), [msg.LParam]);//'2  ' + Format('buffering... %d%%', [msg.LParam]);

           end;
        3: begin
            ExtraText     := '';
            ExtraTextTime := 0;

            QIPPlugin.RedrawSpecContact(UniqContactId);

            Label4.Caption := PAnsiChar(msg.LParam);
           end;
        4,5,6: Label5.Caption := PAnsiChar(msg.LParam);
        7: Label3.Caption := PAnsiChar(msg.LParam);
        8: Label5.Caption := PAnsiChar(msg.LParam); //icy info
      end;
      ChangeXstatus := True;

      iSong := Label3.Caption;
      iRadio := Label4.Caption;
      iBitrate := Label5.Caption;
      iCover := '';
      iBitrate := Trim(StringReplace(iBitrate, 'bitrate:', '', []));
      iTime := 0;
    end;

finally

end;

try
  if InfoIsShow=True then
  begin
    FInfo.lbleRadio.Text := iRadio;
  end;
finally

end;

end;


procedure TfrmBassPlayer.FormCreate(Sender: TObject);
var
  fd: TWin32FindData;
  fh: THandle;
  plug: HPLUGIN;
  Info: ^Bass_PluginInfo;
  s: string;
  a: integer;
  ListItem: TListItem;

  i: Integer;
  MyString, fnn: AnsiString;

begin
  if FileExists(PluginDllPath+'bass.dll')=True then
    MoveFileIfExists(PluginDllPath+'bass.dll', PluginDllPath+'Plugins\', True);

  //BassLoadLib( PluginDllPath );
  Load_BASSDLL( PluginDllPath + 'Plugins\' + 'bass.dll' );
  //Load_BASSDLL( PluginDllPath + 'bass.dll' );

  bBassLoadLibLoaded := True;

	WaveStream := TMemoryStream.Create;

  // check the correct BASS was loaded
  win := handle;
  if (HIWORD(BASS_GetVersion) <> BASSVERSION) then
  begin
    MessageBox(0, 'An incorrect version of BASS.DLL was loaded', nil, MB_ICONERROR);
    Halt;
  end;

  if not Bass_Init(-1, 44100, 0, handle, nil) then
  begin
    Error('Can''t initialize device');
    Application.Terminate;
  end;

  BASS_SetConfig(BASS_CONFIG_NET_PLAYLIST, 1); // enable playlist processing
  BASS_SetConfig(BASS_CONFIG_NET_PREBUF, 0); // minimize automatic pre-buffering, so we can do it (and display it) instead


  if Proxy_Mode in [1, 2] then
    BASS_SetConfigPtr(BASS_CONFIG_NET_PROXY, @proxy[0]) // setup proxy server location
  else
    BASS_SetConfigPtr(BASS_CONFIG_NET_PROXY, nil); // no proxy!

  // Set The OpenDialog Filter to the Bass build In Formats
{  Open1.Filter :=
    'BASS built-in *.mp3;*.mp2;*.mp1;*.ogg;*.wav;*.aif)\0*.mp3;*.mp2;*.mp1;*.ogg;*.wav;*.aif' + '|'
    + '*.mp3;*.mp2;*.mp1;*.ogg;*.wav*;*.aif';   }

  // get the Modules from the currentDirectory

//  showmessage(ProgDir);


//  fh := FindFirstFile(PChar(ProgDir + 'bass*.dll'), fd);

//label1.Caption := PluginDllPath + 'bass*.dll';
  fh := FindFirstFile(PChar(PluginDllPath + 'Plugins\' + 'bass*.dll'), fd);
  if (fh <> INVALID_HANDLE_VALUE) then
 try
    repeat
      for i:=1 to 260 do
        MyString := MyString + ' ';

      for i:=0 to 259 do
        MyString[ i + 1]:= AnsiChar(fd.cFileName[ i]);

//       fnn := PChar(PluginDllPath )+ PChar(fd.cFileName);
       fnn := PluginDllPath + 'Plugins\' + Trim(MyString);

       memo1.Text := memo1.Text + #13#10 +  fnn;//fd.cFileName;
//       fnn := fnn +

      plug := BASS_PluginLoad(PAnsiChar(fnn), 0);
//      plug := BASS_PluginLoad(fd.cFileName, 0);

       memo1.Text := memo1.Text +'  ' +   inttostr(plug);
      if Plug <> 0 then
      begin
//        Info := BASS_PluginGetInfo(Plug); // get plugin info to add to the file selector filter...
        Info := pointer(BASS_PluginGetInfo(Plug)); // get plugin info to add to the file selector filter...
        for a := 0 to Info.formatc - 1 do
        begin

          // Set The OpenDialog additional, to the supported PlugIn Formats
{          open1.Filter := Open1.Filter + '|' + Info.Formats[a].name + ' ' + '(' +
            Info.Formats[a].exts + ') , ' + fd.cFileName + '|' + Info.Formats[a].exts;
 }         // Lets Show in the Listview the supported Formats

          if (Info.Formats[a].name <> nil) then
            if (a = 0) then
              s :=Info.Formats[a].name
            else
              s := s + ',' + Info.Formats[a].name;
        end;
        ListItem := LvPlugIns.Items.Add;
        ListItem.Caption := fd.cFileName;
        ListItem.SubItems.Add(s);
      end;
    until FindNextFile(fh, fd) = false;
  finally
    Windows.FindClose(fh);
  end;
  {
  if LvPlugIns.Items.Count = 0 then
  begin
    ListItem := LvPlugIns.Items.Add;
    ListItem.SubItems.Add('no plugins found - visit the BASS webpage to get some');
  end;
  }
end;



function OpenURL(url: PAnsiChar): Integer;
var
  Info: Bass_ChannelInfo;
 // url: Pansichar;
  icy: PAnsiChar;
  Len, Progress: DWORD;
  index, value, i: Integer;
begin
{  if open1.Execute then
  begin   }
//    Timer1.Enabled := false;
//    Bass_StreamFree(Chan);

//icyx:/85.248.7.162:8000/48.aac


  Result := 0;
  BASS_StreamFree(chan); // close old stream
  progress := 0;
  SendMessage(win, WM_INFO_UPDATE, 0, 0); // reset the Labels and trying connecting

//  url := 'mms://netshow4.play.cz/cro1-128';
// url := 'icyx://85.248.7.162:8000/48.aac';
// url := 'http://85.248.7.162:8000/48.aac';
//url := 'http://www.play.cz/radio/frekvence1-128.asx';

//showmessage(url);
url := PAnsiChar(PlayURL);

//showmessage(url);

////////////// RECORD
{	with WaveHdr do
    begin
		riff := 'RIFF';
		len := 36;
		cWavFmt := 'WAVEfmt ';
		dwHdrLen := 16;
		wFormat := 1;
		wNumChannels := 2;
		dwSampleRate := 44100;
		wBlockAlign := 4;
		dwBytesPerSec := 176400;
		wBitsPerSample := 16;
		cData := 'data';
		dwDataLen := 0;
    end;
	WaveStream.Write(WaveHdr, SizeOf(WAVHDR));  }
///////////////END RECORD
///
///

//iHandle = Bass_StreamCreateFile(sFileName, 00, 00, BASSStream.BASS_DEFAULT | BASSStream.BASS_SAMPLE_MONO | BASSStream.BASS_SPEAKER_CENTER | BASSStream.BASS_SPEAKER_LFE | BASSStream.BASS_SPEAKER_REAR2RIGHT | BASSStream.BASS_SPEAKER_REAR2LEFT );

    chan := BASS_StreamCreateURL(url, 0, BASS_STREAM_STATUS{BASS_STREAM_RESTRATE}  { +  BASS_SPEAKER_CENTER + BASS_SPEAKER_LFE} {+ BASS_SPEAKER_REAR2RIGHT + BASS_SPEAKER_REAR2LEFT}, @StatusProc, 0);

//    chan := BASS_StreamCreateURL(url, 0, BASS_STREAM_STATUS{BASS_STREAM_RESTRATE}, @StatusProc, 0);

//    BASS_ChannelGetData(
////////////// RECORD
(*//BASS_RecordInit(chan);
//  BASS_RecordSetDevice(chan);
    BASS_ChannelSetDevice(chan,400);
  BASS_RecordSetDevice(400);

rchan := BASS_RecordStart(44100, 2, 0, @RecordingCallback, nil);
	if rchan = 0 then
	begin
		MessageDlg('Couldn''t start recording!', mtError, [mbOk], 0);
		WaveStream.Clear;
	end
    else
    begin
{		bRecord.Caption := 'Stop';
		bPlay.Enabled := False;
		bSave.Enabled := False;}
    end;
                          *)
///////////////END RECORD
///
//  BASS_ChannelSetDevice(()
//  BASS_RecordGetInputName()

//  Chan := Bass_StreamCreateFile(false, PChar(open1.FileName), 0, 0, BASS_SAMPLE_LOOP);
    if CHan <> 0 then
    begin
    //  BASS_ChannelGetInfo(chan, info);
//      Button1.Caption := open1.FileName;
(*     lblInfo.Caption := 'channel type = ' + inttostr(info.ctype) + ' ' +
        getCTypeString(info.ctype, info.plugin);*)
//      Scrollbar1.Max := round(BASS_ChannelBytes2Seconds(chan, BASS_ChannelGetLength(chan, BASS_POS_BYTE)));
    //  Bass_ChannelPlay(Chan, false);
//      Timer1.Enabled := true;





    // Progress
    repeat
      len := BASS_StreamGetFilePosition(chan, BASS_FILEPOS_END);
      if (len = DW_Error) then
        break; // something's gone wrong! (eg. BASS_Free called)
      progress := (BASS_StreamGetFilePosition(chan, BASS_FILEPOS_DOWNLOAD) -
        BASS_StreamGetFilePosition(chan, BASS_FILEPOS_CURRENT)) * 100 div len;
      // percentage of buffer filled
      SendMessage(win, WM_INFO_UPDATE, 2, progress); // show the Progess value in the label

    until
      progress > 75;

    // get the broadcast name and bitrate
    icy := BASS_ChannelGetTags(chan, BASS_TAG_ICY);
    if (icy = nil) then
      icy := BASS_ChannelGetTags(chan, BASS_TAG_HTTP); // no ICY tags, try HTTP
    if (icy <> nil) then
      while (icy^ <> #0) do
      begin
        if (Copy(icy, 1, 9) = 'icy-name:') then
          SendMessage(win, WM_INFO_UPDATE, 3, DWORD(PAnsiChar(Copy(icy, 10, MaxInt))))

        else if (Copy(icy, 1, 7) = 'icy-br:') then

          SendMessage(win, WM_INFO_UPDATE, 4, DWORD(PAnsiChar('bitrate: ' + Copy(icy, 8, MaxInt))));
        icy := icy + Length(icy) + 1;
      end;
    // get the stream title and set sync for subsequent titles
    DoMeta();
    BASS_ChannelSetSync(chan, BASS_SYNC_META, 0, @MetaSync, 0);


    for i := 1 to FrequencyCount do
    begin
      fx[i] := BASS_ChannelSetFX(chan, BASS_FX_DX8_PARAMEQ, 1)
    end;

    //Reverb
    fx[EQ_REVERB] := BASS_ChannelSetFX(chan, BASS_FX_DX8_REVERB, 1);


    // Set equalizer to flat and reverb off to start
    p.fGain := 0;

    p.fBandwidth := 4;

    for i := 1 to FrequencyCount do
      begin
        p.fCenter := StrToInt(slFreqs.Strings[i-1]);
        BASS_FXSetParameters(fx[i], @p);
      end;



    BASS_FXGetParameters(fx[i+1], @pR);
    pR.fReverbMix := -96;
    pR.fReverbTime := 1200;
    pR.fHighFreqRTRatio := 0.1;
    BASS_FXSetParameters(fx[i+1], @pR);

    // equalizer enabled?
    if EqualizerEnabled then
    begin
      if EqualizerToRadioGenre then
        ActiveEqualizer(TStation(Stations.Objects[Radio_StationID]).Genre)
      else
        ActiveEqualizer(EqualizerOption);
    end
    else
    begin
      DeactiveEqualizer;
    end;

    // play it!
    BASS_ChannelPlay(chan, FALSE);

    end
    else
    begin
      SendMessage(win, WM_INFO_UPDATE, 1, 0); // Oops Error
(*      Button1.Caption := 'Click here to open a file';*)
(*      Error('Can''t play the file');*)
    end;
 { end;   }


  cthread := 0;
end;


procedure TfrmBassPlayer.BASSPlayer_Play(sFileName: String);
var x: Boolean;
    ThreadId: Cardinal;
begin
//showmessage(AnsiUpperCase(Copy(sFileName,7)));
//icyx://85.248.7.162:8000/48.aac
  if AnsiUpperCase(Copy(sFileName,1,7))=AnsiUpperCase('icyx://') then
    PlayURL := 'http://' + Copy(sFileName,8)
  else if AnsiUpperCase(Copy(sFileName,1,6))=AnsiUpperCase('icyx:/') then
    PlayURL := 'http://' + Copy(sFileName,7)
  else
    PlayURL := sFileName;

//    showmessage(PlayURL);

//showmessage(sFileName);
  StrPCopy(proxy,Proxy_Server); // copy the Servertext to the Proxy array
  if (cthread <> 0) then
    MessageBeep(0)
  else
    cthread := BeginThread(nil, 0, @OpenURL, PAnsiChar('not'), 0, ThreadId);

end;

procedure TfrmBassPlayer.BASSPlayer_Stop;
var x: Boolean;
begin

 { x := BASS_Stop;     }

  try
    BASS_StreamFree(chan); // close old stream

    SendMessage(win, WM_INFO_UPDATE, 0, 0);
  finally

  end;

{if savedialog.Execute then
   begin
      StartRecord.enabled := false;
      CopyFile(PAnsiChar(GetTempFile),PAnsiChar(savedialog1.FileName),false);
      StartRecord.enabled := true;
   end;     }



end;

procedure TfrmBassPlayer.BASSPlayer_Pause;
var x: Boolean;
begin

  x := BASS_Pause;

end;

procedure TfrmBassPlayer.BASSPlayer_Volume(value: Integer);
//var f: Float;
var v: Cardinal;
begin

//   BassPlayer1.Volume := value;
//  f := value / 100;
  v := round(value * (10000 / 100)) ;

  //BASS_SetVolume (f);

//  BASS_ChannelSetAttribute(chan, BASS_ATTRIB_MUSIC_VOL_GLOBAL, 0);
//  BASS_ChannelSetAttribute(chan, BASS_ATTRIB_MUSIC_VOL_CHAN, 0);


//  BASS_ChannelSetAttribute(chan, BASS_ATTRIB_PAN, 100);
//  BASS_ChannelSetAttribute(chan, BASS_ATTRIB_VOL, 100);

//showmessage(  floattostr(  BASS_GetVolume)  );

      BASS_SetConfig(BASS_CONFIG_GVOL_MUSIC, v );
      BASS_SetConfig(BASS_CONFIG_GVOL_STREAM, v );

end;

procedure TfrmBassPlayer.BASSPlayer_SetEq(index: Integer; value: Integer);
begin
  BASS_FXGetParameters(fx[index], @p);
  p.fGain := value;
  BASS_FXSetParameters(fx[index], @p);
end;

procedure TfrmBassPlayer.BASSPlayer_GetEq(index: Integer; var value: Integer);
begin
  BASS_FXGetParameters(fx[index], @p);
  value := Round(p.fGain);
end;

procedure TfrmBassPlayer.BASSPlayer_SetReverb(index: Integer; value: Integer);
begin
  BASS_FXGetParameters(fx[index], @pR);
  // give exponential quality to trackbar as Bass more sensitive near 0
  pR.fReverbMix := -0.012*value*value*value; // gives -96 when bar at 20
  BASS_FXSetParameters(fx[index], @pR);
end;

procedure TfrmBassPlayer.BASSPlayer_GetReverb(index: Integer; var value: Integer);
begin
  BASS_FXGetParameters(fx[index], @pR);
  value := Round( Power( pR.fReverbMix / (-0.012), 1/3 ) );
end;

procedure TfrmBassPlayer.BASSPlayer_FileStreamFree;
begin

 try
   FileStream.Destroy; // finished  downloading
 finally

 end;


end;

procedure TfrmBassPlayer.BASSPlayer_AllFree;
begin

 try
  Bass_Free();
  BASS_PluginFree(0);
 finally

 end;


end;


procedure TfrmBassPlayer.Player_Stop;
begin
  FBassPlayer.BASSPlayer_Stop;
end;


procedure TfrmBassPlayer.PlayStopRadio;
var HTMLData: TResultData;
    iFS, iFS1, iFS2: Integer;
    sPlayURL, sExt, sURL: WideString;
//    F: TextFile;
//    s : string;

//    i : integer;


//    sTempFileName: WideString;

    sToken, sStream, smyAdID : WideString;


label 1,2,3,4,5,0;

begin
  if Stations.Count = 0 then
  begin
    QIPPlugin.AddFadeMsg(1, PluginSkin.PluginIcon.Icon.Handle, PLUGIN_NAME, LNG('PLAYER', 'NoRadio', 'Nothing to play.'), True, False, 0, 0);

    Exit;
  end;

  if (Stations.Count - 1 < Radio_StationID) AND (Radio_StationID <> -1) then
    begin
     { if Radio_Playing = False then
      begin

      end
      else
      begin

      end;  }
    end
  else if TStation(Stations.Objects[Radio_StationID]).Streams.Count - 1 < Radio_StreamID then
    begin
      //
    end;
  begin
    if TStream(TStation(Stations.Objects[Radio_StationID]).Streams.Objects[Radio_StreamID]).URL = '' then
    begin

      Radio_Playing := False;

      Radio_PlayingError := True;

      QIPPlugin.AddFadeMsg(1, PluginSkin.PluginIcon.Icon.Handle, PLUGIN_NAME, LNG('PLAYER', 'NoRadio', 'Nothing to play.'), True, False, 0, 0);


      Exit;
    end;
  end;

  if Radio_Playing = False then
    begin
      if Stations.Count - 1 < Radio_StationID then
        begin
          QIPPlugin.AddFadeMsg(1, PluginSkin.PluginIcon.Icon.Handle, PLUGIN_NAME, LNG('PLAYER', 'NoRadio', 'Nothing to play.'), True, False, 0, 0);
        end
      else
        begin
          Playlist.Clear;

           Statistics_PlayCount_Add( TStream(TStation(Stations.Objects[Radio_StationID]).Streams.Objects[Radio_StreamID]).URL );

          sExt := AnsiUpperCase(ExtractFileExt(TStream(TStation(Stations.Objects[Radio_StationID]).Streams.Objects[Radio_StreamID]).URL));
          sURL := TStream(TStation(Stations.Objects[Radio_StationID]).Streams.Objects[Radio_StreamID]).URL;

         if (sExt='.ASX') and (Proxy_Mode = 0) then  //result:='Windows Media ASX Playlist';
          begin
            try
              HTMLData := GetHTML(TStream(TStation(Stations.Objects[Radio_StationID]).Streams.Objects[Radio_StreamID]).URL, '', '', 5000, NO_CACHE, DownloadingInfo);
            except

            end;

            if HTMLData.OK = True then
            begin
              sPlayURL := FoundStr(HTMLData.parString, '<entry>', '</entry>', 1, iFS, iFS1, iFS2);
              sPlayURL := FoundStr(sPlayURL, '<Ref', '>', 1, iFS, iFS1, iFS2);
              sPlayURL := FoundStr(sPlayURL, '"', '"', 1, iFS, iFS1, iFS2);

              //Playlist.Add(sPlayURL);
            end;
          end
          else if (AnsiUpperCase(Copy(sURL,1,Length('http://lsd.newmedia.tiscali-business.com') )) = AnsiUpperCase( 'http://lsd.newmedia.tiscali-business.com' )) or
                  (AnsiUpperCase(Copy(sURL,1,Length('http://213.200.64.229/') )) = AnsiUpperCase( 'http://213.200.64.229/' ) ) then  //nacamar  or nacmar ip (redirect)
          begin


            if AnsiUpperCase(Copy(sURL,Length(sURL) - Length('frameset.html') + 1)) = AnsiUpperCase('frameset.html') then
            begin
              sURL := Copy(sURL,1, Length(sURL) - Length('frameset.html')) + 'forwarder_wmt.html';
            end
            else if AnsiUpperCase(Copy(sURL,Length(sURL) - Length('frameset_wmt.html') + 1)) = AnsiUpperCase('frameset_wmt.html') then
            begin
              sURL := Copy(sURL,1, Length(sURL) - Length('frameset_wmt.html')) + 'forwarder_wmt.html';
            end
            else if AnsiUpperCase(Copy(sURL,Length(sURL) - Length('frameset_real.html') + 1)) = AnsiUpperCase('frameset_real.html') then
            begin
              sURL := Copy(sURL,1, Length(sURL) - Length('frameset_real.html')) + 'forwarder.html';
            end;

            HTMLData.parString := '';

            try
              HTMLData := GetHTML(sURL, '', '', 5000, NO_CACHE, DownloadingInfo);
            except

            end;

            if HTMLData.OK = True then
            begin

              sURL  := FoundStr(HTMLData.parString, 'url=', '"',1, iFS , iFS1, iFS2 );

              HTMLData.parString := '';

              try
                HTMLData := GetHTML(sURL, '', '', 5000, NO_CACHE, DownloadingInfo);
              except

              end;

              if HTMLData.OK = True then
              begin

                sToken := FoundStr(HTMLData.parString, 'var token', ';',1, iFS , iFS1, iFS2 );
                sToken := FoundStr(sToken, '"', '"',1, iFS , iFS1, iFS2 );


                sStream := FoundStr(HTMLData.parString, 'var stream', ';',1, iFS , iFS1, iFS2 );
                sStream := FoundStr(sStream, '"', '"',1, iFS , iFS1, iFS2 );

                smyAdID := '0';

                sPlayURL := 'http://lsd.newmedia.tiscali-business.com/bb/redirect.lsc?adid='+smyAdID+'&stream='+sStream+'&content=live&media=ms&token='+sToken;
              end;

            end;



          end
          else
          begin
            sPlayURL := TStream(TStation(Stations.Objects[Radio_StationID]).Streams.Objects[Radio_StreamID]).URL;
          end;

{

http://lsd.newmedia.tiscali-business.com/bb/redirect.lsc?content=download&media=http&stream=freestream/radiotop40/frameset.html

forwarder_wmt.html

http://213.200.64.229/freestream/download/radiotop40/forwarder_wmt.html


http://lsd.newmedia.tiscali-business.com/bb/redirect.lsc?content=download&media=http&stream=freestream/radiotop40/forwarder_wmt.html

}


(*          else if sExt='.WAX' then  //result:='WAX';
          begin
            try
              HTMLData := GetHTML(TSLStream(TSLStation(Stations.Objects[Radio_StationID]).Streams.Objects[Radio_StreamID]).URL, Info);
            except

            end;

            if HTMLData.OK = True then
            begin
              sPlayURL := Trim(HTMLData.parString);

              Playlist.Add(sPlayURL);
            end;
          end
          else
          begin
            Playlist.Add( TSLStream(TSLStation(Stations.Objects[Radio_StationID]).Streams.Objects[Radio_StreamID]).URL );
          end;

        {  showmessage(INTTOSTR( Playlist.Count ));
          for i := 0 to Playlist.Count - 1 do
              showmessage(Playlist.Strings[i]);  }

          PlaylistNow := -1;      *)
        ;



          FBassPlayer.BASSPlayer_Play(sPlayURL);//( TSLStream(TSLStation(Stations.Objects[Radio_StationID]).Streams.Objects[Radio_StreamID]).URL );



{            if sPlayURL<>'' then
            begin
              FfrmBassPlayer.BASSPlayer_Play( TSLStream(TSLStation(Stations.Objects[Radio_StationID]).Streams.Objects[Radio_StreamID]).URL );
            end
            else
            begin
              FfrmBassPlayer.BASSPlayer_Play(TSLStream(TSLStation(Stations.Objects[Radio_StationID]).Streams.Objects[Radio_StreamID]).URL);
            end;  }


//              FfrmBassPlayer.BASSPlayer_Play('mms://netshow3.play.cz/jih48');

//          WindowsMediaPlayer1.URL := TSLStream(TSLStation(Stations.Objects[Radio_StationID]).Streams.Objects[Radio_StreamID]).URL;


          Radio_Playing := True;

          Radio_PlayingError := False;

          ChangeXstatus := True;

        end;
      QIPPlugin.RedrawSpecContact(UniqContactId);
      //RedrawSpecCnt := True;
    end
  else
  begin
    //WindowsMediaPlayer1.controls.stop;

    Radio_Playing := False;

    Radio_PlayingError := False;


    Player_Stop;

    LastRadioFadeMsg := '';

    QIPPlugin.RedrawSpecContact(UniqContactId);
    //RedrawSpecCnt := True;

    ChangeXstatus := True;
  end;

{showmessage(BoolToStr(  XStatus_Boolean) + #13 +
BoolToStr(  ChangeXstatus));                     }

//    showmessage(INTTOSTR(WindowsMediaPlayer1.settings.volume))
end;


procedure TfrmBassPlayer.Player_ChangeVolume(value: Integer);
begin

  FBassPlayer.BASSPlayer_Volume(value);

end;

procedure LoadNowPlaying;
var
  s: WideString;
begin

    try
      if (Radio_StationID <> -1) or (Radio_StreamID <> -1) then
      begin
        if TStation(Stations.Objects[Radio_StationID]).Streams.Count - 1 >= Radio_StreamID then
          s := GetNowPlaying( TStream(TStation(Stations.Objects[Radio_StationID]).Streams.Objects[Radio_StreamID]).URL );

        if s<>'' then
        begin
          if iSong <> s then // pokud se zmìnila písnièka...
          begin
            iTime := 0;      // ...tak resetuj poèítadlo
            ChangeXstatus := True;
          end;
          RadioExternalInfo := True;
          iSong := s;
          iRadio := TStation(Stations.Objects[Radio_StationID]).Name;
        end
        else
          RadioExternalInfo := False;
      end;
    except

    end;


  LoadNowPlayingThread := 0;

end;

procedure TfrmBassPlayer.tmrLoadNowPlayingTimer(Sender: TObject);
var
  ThreadId: Cardinal;
begin
  if LoadSongsExternal = True then
  begin
    if Radio_Playing = True then
    begin
      LoadNowPlayingThread := BeginThread(nil, 0, @LoadNowPlaying, nil, 0, ThreadId);
    end;
  end;
end;




end.

unit Recording;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Buttons, ToolWin, ImgList, CommCtrl,
  INIFiles, ID3v2LibraryDefs;

type
  TfrmRecording = class(TForm)
    lblInfo: TLabel;
    pbBuffer: TProgressBar;
    SaveDialog: TSaveDialog;
    Timer: TTimer;
    lblVersion: TLabel;
    lblBuffer: TLabel;
    lblInfo2: TLabel;
    StatusBar: TStatusBar;
    tbButtons: TToolBar;
    ilButtons: TImageList;
    pnlInfo: TPanel;
    imgInfo: TImage;
    tbtnRecord: TToolButton;
    tbtnPause: TToolButton;
    tbtnStop: TToolButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerTimer(Sender: TObject);
    procedure StreamInfo;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tbtnRecordClick(Sender: TObject);
    procedure tbtnPauseClick(Sender: TObject);
    procedure tbtnStopClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure EnableDisable;
  end;

const
  VersionRecord : WideString = '0.1.0.2 beta';

var
  frmRecording  : TfrmRecording;
  LastURL       : AnsiString;


function GenreToByte(Genre: WideString): Byte;


implementation

uses General, uLNG, uComments, dynamic_BASS, BassPlayer, uFileFolder, uIcon, uTheme,
     u_lang_ids, uToolTip, uINI, Convs;

const TotalGenre = 147;

ID3genre: array[0..TotalGenre] of string = (
    'Blues', 'Classic Rock', 'Country', 'Dance', 'Disco', 'Funk', 'Grunge',
    'Hip-Hop', 'Jazz', 'Metal', 'New Age', 'Oldies', 'Other', 'Pop', 'R&B',
    'Rap', 'Reggae', 'Rock', 'Techno', 'Industrial', 'Alternative', 'Ska',
    'Death Metal', 'Pranks', 'Soundtrack', 'Euro-Techno', 'Ambient',
    'Trip-Hop', 'Vocal', 'Jazz+Funk', 'Fusion', 'Trance', 'Classical',
    'Instrumental', 'Acid', 'House', 'Game', 'Sound Clip', 'Gospel',
    'Noise', 'AlternRock', 'Bass', 'Soul', 'Punk', 'Space', 'Meditative',
    'Instrumental Pop', 'Instrumental Rock', 'Ethnic', 'Gothic',
    'Darkwave', 'Techno-Industrial', 'Electronic', 'Pop-Folk',
    'Eurodance', 'Dream', 'Southern Rock', 'Comedy', 'Cult', 'Gangsta',
    'Top 40', 'Christian Rap', 'Pop/Funk', 'Jungle', 'Native American',
    'Cabaret', 'New Wave', 'Psychadelic', 'Rave', 'Showtunes', 'Trailer',
    'Lo-Fi', 'Tribal', 'Acid Punk', 'Acid Jazz', 'Polka', 'Retro',
    'Musical', 'Rock & Roll', 'Hard Rock', 'Folk', 'Folk-Rock',
    'National Folk', 'Swing', 'Fast Fusion', 'Bebob', 'Latin', 'Revival',
    'Celtic', 'Bluegrass', 'Avantgarde', 'Gothic Rock', 'Progressive Rock',
    'Psychedelic Rock', 'Symphonic Rock', 'Slow Rock', 'Big Band',
    'Chorus', 'Easy Listening', 'Acoustic', 'Humour', 'Speech', 'Chanson',
    'Opera', 'Chamber Music', 'Sonata', 'Symphony', 'Booty Bass', 'Primus',
    'Porn Groove', 'Satire', 'Slow Jam', 'Club', 'Tango', 'Samba',
    'Folklore', 'Ballad', 'Power Ballad', 'Rhythmic Soul', 'Freestyle',
    'Duet', 'Punk Rock', 'Drum Solo', 'Acapella', 'Euro-House', 'Dance Hall',
    'Goa', 'Drum & Bass', 'Club-House', 'Hardcore', 'Terror', 'Indie',
    'BritPop', 'Negerpunk', 'Polsk Punk', 'Beat', 'Christian Gangsta Rap',
    'Heavy Metal', 'Black Metal', 'Crossover', 'Contemporary Christian',
    'Christian Rock', 'Merengue', 'Salsa', 'Trash Metal', 'Anime', 'Jpop',
    'Synthpop'
  );

var
  StreamFormat  : TStreamFormat;

{$R *.dfm}

procedure TfrmRecording.EnableDisable;
begin
  if StreamRecording = True then
  begin
    tbtnRecord.Enabled := False;
    tbtnPause.Enabled := True;
    tbtnStop.Enabled := True;
  end
  else
  begin
    tbtnRecord.Enabled := True;
    tbtnPause.Enabled := False;
    tbtnStop.Enabled := False;
  end;
end;

procedure TfrmRecording.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  RecordingIsShow := False;
  FRecording.Destroy;
end;

procedure TfrmRecording.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if StreamRecording then
    ShowMessage(LNG('FORM Recording', 'CloseFormError', 'You can''t close window until you stop recording'));
  CanClose := not StreamRecording;
end;

procedure TfrmRecording.FormShow(Sender: TObject);
var
  I: Integer;
  sSuppFormats: WideString;
begin
  Color := frmBgColor;

  Icon := PluginSkin.Recording.Icon;

  Caption             := LNG('FORM Recording', 'Caption', 'Recording');
  tbtnRecord.Hint      := LNG('FORM Recording', 'Record', 'Record');
  tbtnPause.Hint       := LNG('FORM Recording', 'Pause', 'Pause');
  tbtnStop.Hint        := LNG('FORM Recording', 'Stop', 'Stop');

  imgInfo.Picture.Assign(PluginSkin.Info.Image.Picture);

  //32 bit support - transparent atd....
  ilButtons.Handle := ImageList_Create(ilButtons.Width, ilButtons.Height, ILC_COLOR32 or ILC_MASK, ilButtons.AllocBy, ilButtons.AllocBy);

  ilButtons.AddIcon(PluginTheme.State.PictureRecord.Icon);
  ilButtons.AddIcon(PluginTheme.State.PicturePause.Icon);
  ilButtons.AddIcon(PluginTheme.State.PictureStop.Icon);


  lblInfo2.Caption := LNG('FORM Recording', 'NotRecording', 'Can''t record this format');

//  lblSupportFormats.Caption := LNG('FORM Recording', 'SupportedFormats', 'Supported recording stream formats') + ': ' + #13;
  I := 1;
  StreamFormat.Name := '';
  sSuppFormats := '';
  repeat
    StreamFormat := GetSupportStreamFormat(I);

    if sSuppFormats<>'' then
    begin
      if StreamFormat.Format <> '' then
      begin
        sSuppFormats := sSuppFormats + ', ';

        if ((I-1) mod 2)=0 then
          sSuppFormats := sSuppFormats + #13+#10;
      end;
    end;

    if StreamFormat.Format='' then
      sSuppFormats := sSuppFormats + StreamFormat.Name
    else
      sSuppFormats := sSuppFormats + StreamFormat.Name + ' ('+StreamFormat.Format+')';


    Inc(I);
  until StreamFormat.Format = '';

  CreateToolTips(Handle);
  AddToolTip(pnlInfo.Handle, @ti, 1, PWideChar(sSuppFormats), PWideChar(LNG('FORM Recording', 'SupportedFormats', 'Supported recording stream formats') + ':'));

  EnableDisable;

  LastURL := '';

  lblVersion.Caption := QIPPlugin.GetLang(LI_VERSION) + ' ' + VersionRecord;



  AddComments(FRecording);
  TimerTimer(nil);
  RecordingIsShow := True;
end;



procedure TfrmRecording.TimerTimer(Sender: TObject);
var
  Chan         : DWORD;
  Info         : BASS_CHANNELINFO;
  URL          : AnsiString;

begin
  // ZjiötÏnÌ streamovanÈho form·tu
  URL := PlayURL;

  if URL <> LastURL then // zjisti pouze, pokud bude zmÏnÏn stream
  begin
    LastURL := URL;
    Chan := BASS_StreamCreateURL(PAnsiChar(URL), 0, BASS_STREAM_STATUS, nil, 0);
    BASS_ChannelGetInfo(Chan, Info);
    StreamFormat := GetSupportStreamFormat( fBassPlayer.GetCTypeString(Info.CType, Info.Plugin) );
    BASS_StreamFree(Chan);
  end;
  // konec zjiöùov·nÌ

  if not Radio_Playing then PlayURL := ''; // pokud nic neph¯ev·m·me, tak nelze nahr·vat

  tbtnRecord.Enabled := not (StreamFormat.Format = '') and not StreamRecording; // m˘ûem nahr·vat ?

  lblInfo2.Visible := StreamFormat.Format = '';

  if pbBuffer.Max < RecordingBufferSize then pbBuffer.Max := RecordingBufferSize;

  pbBuffer.Position := RecordingBufferSize;

  if StreamRecording then
    StatusBar.SimpleText := LNG('FORM Recording', 'Recording', 'Recording...')//(filesize: ' + FileSize( GetRecordTempFile ) +')'
  else
    StatusBar.SimpleText := '';

  StreamInfo;
end;

procedure TfrmRecording.StreamInfo;
var
  Info       : BASS_RECORDINFO;
  InfoFormat : WideString;
begin

  if StreamFormat.Format = 'wav' then
  begin
    BASS_RecordGetInfo(Info);
    case Info.formats of
      WAVE_FORMAT_1M08 : InfoFormat := '11.025 kHz, Mono,   8-bit';
      WAVE_FORMAT_1S08 : InfoFormat := '11.025 kHz, Stereo, 8-bit';
      WAVE_FORMAT_1M16 : InfoFormat := '11.025 kHz, Mono,   16-bit';
      WAVE_FORMAT_1S16 : InfoFormat := '11.025 kHz, Stereo, 16-bit';
      WAVE_FORMAT_2M08 : InfoFormat := '22.05  kHz, Mono,   8-bit';
      WAVE_FORMAT_2S08 : InfoFormat := '22.05  kHz, Stereo, 8-bit';
      WAVE_FORMAT_2M16 : InfoFormat := '22.05  kHz, Mono,   16-bit';
      WAVE_FORMAT_2S16 : InfoFormat := '22.05  kHz, Stereo, 16-bit';
      WAVE_FORMAT_4M08 : InfoFormat := '44.1   kHz, Mono,   8-bit';
      WAVE_FORMAT_4S08 : InfoFormat := '44.1   kHz, Stereo, 8-bit';
      WAVE_FORMAT_4M16 : InfoFormat := '44.1   kHz, Mono,   16-bit';
      WAVE_FORMAT_4S16 : InfoFormat := '44.1   kHz, Stereo, 16-bit';
    end;
    InfoFormat := StreamFormat.Name + '(' + InfoFormat + ')';
  end
  else
  begin
    InfoFormat := StreamFormat.Name;
  end;

  lblInfo.Caption := LNG('FORM Recording', 'Format', 'Format') + ': ' + InfoFormat;

end;

procedure TfrmRecording.tbtnPauseClick(Sender: TObject);
begin
//  TButton(Sender).ShowHint := False;

  StreamRecording := False;

  QIPPlugin.RedrawSpecContact(UniqContactId);

  EnableDisable;

//  TButton(Sender).ShowHint := True;
end;

procedure TfrmRecording.tbtnRecordClick(Sender: TObject);
begin
//  TButton(Sender).ShowHint := False;

  FileStream := TFileStream.Create(GetRecordTempFile, fmCreate); // create the  file


  StreamRecording := True;

  QIPPlugin.RedrawSpecContact(UniqContactId);

  EnableDisable;

//  TButton(Sender).ShowHint := True;
end;

procedure TfrmRecording.tbtnStopClick(Sender: TObject);
var
  ID3v1 : Pointer;
  INI   : TIniFile;
  FN    : String;
begin
//  TButton(Sender).ShowHint := False;

  StreamRecording := False;

  QIPPlugin.RedrawSpecContact(UniqContactId);

  EnableDisable;

  FBassPlayer.BASSPlayer_FileStreamFree;

  INIGetProfileConfig(INI);

  SaveDialog.InitialDir  := UTF82WideString( INI.ReadString('Record', 'Dir', '') );
  SaveDialog.Title       := LNG('FORM Recording', 'SaveAudioFile', 'Save audio file');
  SaveDialog.Filter      := StreamFormat.Name + '|*.' + StreamFormat.Format + '|' + LNG('FORM Recording', 'AllFormats', 'All') + '|*.*';
  SaveDialog.DefaultExt  := StreamFormat.Format;
  SaveDialog.FilterIndex := 1;
  DateTimeToString(FN, 'yyyy-mm-dd_hh-nn-ss', Now);
  SaveDialog.FileName    := StringReplace(TStation(Stations.Objects[Radio_StationID]).Name, ' ', '_', [rfReplaceAll]) + '_' + FN;

  if SaveDialog.Execute then
  begin
    CopyFile(PChar(GetRecordTempFile),PChar(SaveDialog.FileName),false);

(*    { z·pis do ID3 tagu }
    ShowMessage('01');
    InitID3v2Library(PluginDllPath);
    ID3v1 := nil;
    ShowMessage('02');
    ID3v1_SetTitle(ID3v1, PAnsiChar('x'));
    ShowMessage('03');
    ID3v1_SetArtist(ID3v1, PAnsiChar('x'));
    ID3v1_SetAlbum(ID3v1, PAnsiChar('x'));
    ID3v1_SetYear(ID3v1, PAnsiChar(FN));
    ID3v1_SetComment(ID3v1, PAnsiChar(TStation(Stations.Objects[Radio_StationID]).Name));
    ID3v1_SetGenre(ID3v1, GenreToByte(TStation(Stations.Objects[Radio_StationID]).Genre));
    ShowMessage('0x');
    ID3v1_Save(ID3v1, PAnsiChar(SaveDialog.FileName));
    {ID3v1.hlavicka := 'TAG';
    StrLCopy(ID3v1.skladba, PChar(''), SizeOf(ID3v1.skladba));
    StrLCopy(ID3v1.interpret, PChar(''), SizeOf(ID3v1.interpret));
    StrLCopy(ID3v1.album, PChar(''), SizeOf(ID3v1.album));
    StrLCopy(ID3v1.rok, PChar(FN), SizeOf(ID3v1.rok));
    StrLCopy(ID3v1.komentar, PChar(TStation(Stations.Objects[Radio_StationID]).Name), SizeOf(ID3v1.komentar));
    ID3v1.zanr := GenreToByte(TStation(Stations.Objects[Radio_StationID]).Genre);
    WriteTag(SaveDialog.FileName, ID3v1); // nic to nezapÌöe? PRO»?  }
    FreeID3v2Library;
    { konec z·pisu }*)
    INI.WriteString('Record', 'Dir', WideString2UTF8( ExtractFileDir(SaveDialog.FileName)) );
  end;

  INI.Free;

  DeleteFileIfExists(GetRecordTempFile);

//  TButton(Sender).ShowHint := True;
end;

function GenreToByte(Genre: WideString): Byte;
// kdyû nenÌ nelezen û·nr, tak vracÌ 255
var
  I: Integer;
begin
  for I := 0 to TotalGenre do
  begin
    if Genre = ID3genre[I] then
    begin
      Result := I;
      Break;
    end;
    Result := 255;
  end;

end;

end.

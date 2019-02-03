{*************************************}
{                                     }
{       QIP INFIUM SDK                }
{       Copyright(c) Ilham Z.         }
{       ilham@qip.ru                  }
{       http://www.qip.im             }
{                                     }
{*************************************}

library FMtune;

uses
  u_qip_plugin in 'u_qip_plugin.pas',
  u_common in 'QIP Infium SDK\u_common.pas',
  u_lang_ids in 'QIP Infium SDK\u_lang_ids.pas',
  u_plugin_info in 'QIP Infium SDK\u_plugin_info.pas',
  u_plugin_msg in 'QIP Infium SDK\u_plugin_msg.pas',
  fQIPPlugin in 'fQIPPlugin.pas' {frmQIPPlugin},
  About in 'Forms\About.pas' {frmAbout},
  Options in 'Forms\Options.pas' {frmOptions},
  EditStations in 'Forms\EditStations.pas' {frmEditStations},
  Equalizer in 'Forms\Equalizer.pas' {frmEqualizer},
  Info in 'Forms\Info.pas' {frmInfo},
  ImportExport in 'Forms\ImportExport.pas' {frmImportExport},
  Recording in 'Forms\Recording.pas' {frmRecording},
  Volume in 'Forms\Volume.pas' {frmVolume},
  FastAddStation in 'Forms\FastAddStation.pas' {frmFastAddStation},
  uTheme in 'Units\uTheme.pas',
  uEqualizer in 'Units\uEqualizer.pas',
  uNowPlaying in 'Units\uNowPlaying.pas',
  uStatistics in 'Units\uStatistics.pas',
  General in 'General.pas',
  DownloadFile in 'General\DownloadFile.pas',
  TextSearch in 'General\TextSearch.pas',
  GradientColor in 'General\GradientColor.pas',
  Convs in 'General\Convs.pas',
  Crypt in 'General\Crypt.pas',
  Hash in 'Updater\Hash.pas',
  KAZip in 'Updater\KAZip.pas',
  MD5 in 'Updater\MD5.pas',
  UpdaterUnit in 'Updater\UpdaterUnit.pas',
  Updater in 'Updater\Updater.pas' {frmUpdater},
  BZIP2 in 'Updater\bzip2\BZIP2.PAS',
  bass_fx in 'Bass\bass_fx.pas',
  BassPlayer in 'Bass\BassPlayer.pas' {frmBassPlayer},
  HotKeyManager in 'General\HotKeyManager.pas',
  Drawing in 'General\Drawing.pas',
  uToolTip in 'General\uToolTip.pas',
  uBase64 in 'General\uBase64.pas',
  uFileFolder in 'General\uFileFolder.pas',
  uLNG in 'General\uLNG.pas',
  uSuperReplace in 'General\uSuperReplace.pas',
  uImage in 'General\uImage.pas',
  uIcon in 'General\uIcon.pas',
  uComments in 'General\uComments.pas',
  uTime in 'General\uTime.pas',
  uColors in 'General\uColors.pas',
  uLinks in 'General\uLinks.pas',
  uINI in 'General\uINI.pas',
  dynamic_bass in 'Bass\dynamic_bass.pas',
  dynamic_basswma in 'Bass\dynamic_basswma.pas',
  ID3v2LibraryDefs in 'Plugins\ID3v2LibraryDefs.pas',
  LibXmlParser in 'XML\LibXmlParser.pas',
  XMLFiles in 'Units\XMLFiles.pas';

{***********************************************************}
function CreateInfiumPLUGIN(PluginService: IQIPPluginService): IQIPPlugin; stdcall;
begin
  Result := TQipPlugin.Create(PluginService);
end;

{$R *.res}

exports
  CreateInfiumPLUGIN name 'CreateInfiumPLUGIN';

end.

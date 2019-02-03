unit uEqualizer;

interface

uses
  SysUtils, Classes, Dialogs, Graphics, Windows, Forms, ExtCtrls, Controls,
  fQIPPlugin, u_common, IniFiles,
  About, Options, BassPlayer, Info, Volume, Recording, Equalizer, EditStations,
  FastAddStation,
  DownloadFile;

const
  EQ_REVERB = 19;

type
  { EqHz }
  TEqHz = class
  public
    Hz                  : WideString; //nepoø.
    dB                  : Real;
  end;

  { EqPreset }
  TEqPreset = class
  public
    Name                : WideString;
    Hz                  : TStringList;
  end;

  procedure LoadEqualizerSettings;
  procedure LoadPersonalEqualizerSettings(var sValues: WideString);
  procedure ActiveEqualizer(Preset: string);
  procedure DeactiveEqualizer;
  procedure SaveEqualizerSettings;

  procedure AddEqualizerPreset(sName, sValues: WideString);
  procedure UpdateEqualizerPreset(sName, sValues: WideString);
  procedure GetEqualizerPreset;

implementation

uses General, Convs, uSuperReplace, uLNG, uINI;

procedure LoadEqualizerSettings;
var
  INI: TINIFile;
  sFreqs: string;

begin
  INIGetProfileConfig(INI);
  EqualizerOption := INIReadStringUTF8(INI, 'Equalizer', 'Option', 'Flat');
  if EqualizerOption = '' then
    EqualizerOption := 'Flat';
  EqualizerToRadioGenre := INIReadBool(INI, 'Equalizer', 'ToRadioGenre', true) ;

  INI := TIniFile.Create(PluginDLLpath + 'equalizer.ini');

  sFreqs := INIReadStringUTF8(INI, 'Conf', 'Freqs', '');
  slFreqs := TStringList.Create;
  slFreqs.Clear;
  slFreqs.Delimiter := ',';
  slFreqs.DelimitedText := sFreqs;

  INIFree(INI);
end;

procedure LoadPersonalEqualizerSettings(var sValues: WideString);
var
  INI   : TINIFile;
  sText : String;
  idx   : Integer;

begin
  INIGetProfileConfig(INI);

  sText := '';
  for idx := 1 to FrequencyCount do
    sText := sText + '0, ';
  Delete(sText, Length(sText) - 1, 2); // smazání poslední mezery s èárkou

  sValues := INIReadStringUTF8(INI, 'Equalizer', 'Values', sText );
  if sValues = '' then sValues := sText;

  INIFree(INI);
end;

procedure ActiveEqualizer(Preset: string);
var
  idx: integer;
begin
  if EqualizerPreset.IndexOf(Preset) = -1 then
    Preset := 'Pop';

  for idx := 1 to FrequencyCount do
    begin
      FBassPlayer.BASSPlayer_SetEq(idx, Round(TEqHz(TEqPreset(EqualizerPreset.Objects[EqualizerPreset.IndexOf(Preset)]).Hz.Objects[idx-1]).dB));
    end;

  if not EqualizerToRadioGenre then
    FBassPlayer.BASSPlayer_SetReverb(EQ_REVERB, 20-EqualizerReverb)
  else
    FBassPlayer.BASSPlayer_SetReverb(EQ_REVERB, 20);

end;

procedure DeactiveEqualizer;
var
  idx: integer;
begin

  for idx := 1 to FrequencyCount do
    begin
      FBassPlayer.BASSPlayer_SetEq(idx, 0);
    end;

  FBassPlayer.BASSPlayer_SetReverb(EQ_REVERB,20);
end;

procedure SaveEqualizerSettings;
var
  INI : TIniFile;

begin
  INIGetProfileConfig(INI);
  INIWriteBool(INI, 'Equalizer', 'Enabled', EqualizerEnabled);
  INIWriteBool(INI, 'Equalizer', 'ToRadioGenre', EqualizerToRadioGenre);

  INIWriteInteger(INI, 'Equalizer', 'Reverb', EqualizerReverb);

  if EqualizerOption = 'Personal' then
  begin
    INIWriteStringUTF8(INI, 'Equalizer', 'Values', Eq);
  end;

  INIWriteStringUTF8(INI, 'Equalizer', 'Option', EqualizerOption );

  INIFree(INI);
end;

procedure AddEqualizerPreset(sName, sValues: WideString);
var
  idx, idx1: integer;
  slValues: TStringList;
  dB: real;
begin

  slValues := TStringList.Create;
  slValues.Clear;
  slValues.Delimiter := ',';
  slValues.DelimitedText := sValues;

  EqualizerPreset.Add(sName);
  idx1 := EqualizerPreset.Count - 1;
  EqualizerPreset.Objects[idx1] := TEqPreset.Create;
  TEqPreset(EqualizerPreset.Objects[idx1]).Name := sName;
  TEqPreset(EqualizerPreset.Objects[idx1]).Hz := TStringList.Create;

  for idx := 0 to slValues.Count - 1 do
    begin
      dB := ConvStrToInt( Trim( slValues.Strings[idx] ));
      TEqPreset(EqualizerPreset.Objects[idx1]).Hz.Add('');
      TEqPreset(EqualizerPreset.Objects[idx1]).Hz.Objects[idx] := TEqHz.Create;
      TEqHz(TEqPreset(EqualizerPreset.Objects[idx1]).Hz.Objects[idx]).dB := dB;
     end;
end;

procedure UpdateEqualizerPreset(sName, sValues: WideString);
var
  idx, idx1: integer;
  slValues: TStringList;
  dB: real;
begin

  slValues := TStringList.Create;
  slValues.Clear;
  slValues.Delimiter := ',';
  slValues.DelimitedText := sValues;

  idx1 := EqualizerPreset.IndexOf(sName);

  for idx := 0 to slValues.Count - 1 do
    begin
      dB := ConvStrToInt( Trim( slValues.Strings[idx] ));
      TEqPreset(EqualizerPreset.Objects[idx1]).Hz.Objects[idx] := TEqHz.Create;
      TEqHz(TEqPreset(EqualizerPreset.Objects[idx1]).Hz.Objects[idx]).dB := dB;
     end;
end;

procedure GetEqualizerPreset;
var INI        : TINIFILE;
    slSections : TStringList;
    idx, idx2  : Integer;
    sValues    : WideString;
    sText      : String;
begin
  LoadEqualizerSettings;
  LoadPersonalEqualizerSettings(sValues);
  AddEqualizerPreset('Personal', sValues);

  slSections := TStringList.Create;
  slSections.Clear;

  if FileExists(PluginDllPath + 'equalizer.ini') = False then
  begin
    ShowMessage( TagsReplace( StringReplace(LNG('Texts', 'ConfigNotFound', 'Config file %file% wasn''t found.[br]Plugin can be unstable.'), '%file%', 'equalizer.ini', [rfReplaceAll, rfIgnoreCase]) ) );
  end;

  INI := TiniFile.Create( PluginDllPath + 'equalizer.ini');

  INI.ReadSections(slSections);

  idx:=0;
  while ( idx <= slSections.Count - 1 ) do
  begin
    Application.ProcessMessages;

    sText := '';
    for idx2 := 1 to FrequencyCount do
      sText := sText + '0, ';
    Delete(sText, Length(sText) - 1, 2); // smazání poslední mezery s èárkou

    sValues := INIReadStringUTF8(INI, slSections.Strings[idx], 'Values', sText );
    if sValues = '' then sValues := sText;


    if slSections.Strings[idx] <> 'Conf' then
      AddEqualizerPreset(slSections.Strings[idx], sValues);


    Inc(idx);
  end;

  INIFree(INI);


end;

end.

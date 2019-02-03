unit Equalizer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, INIFiles;

type
  TfrmEqualizer = class(TForm)
    lblReverb: TLabel;
    tbReverb: TTrackBar;
    btnReset: TBitBtn;
    cbOptions: TComboBox;
    pnlEq: TPanel;
    chkEnableEqualizer: TCheckBox;
    lblPreset: TLabel;
    chkSetEqualizerToRadioGenre: TCheckBox;
    btnOk: TBitBtn;
    gbOptions: TGroupBox;
    Timer: TTimer;
    procedure btnResetClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure tbEq01Change(Sender: TObject);
    procedure tbReverbChange(Sender: TObject);
    procedure cbOptionsSelect(Sender: TObject);
    procedure chkEnableEqualizerClick(Sender: TObject);
    procedure chkSetEqualizerToRadioGenreClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure EqualizerControl;
    procedure EqualizerActiveAll(Truth: boolean);
    procedure EqPersonal;
    procedure TimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEqualizer: TfrmEqualizer;
  idx: integer;
  EqLista: TTrackBar;
  lblFreqs: TLabel;

implementation

uses General, uLNG, BassPlayer, u_qip_plugin, u_lang_ids, uComments, uEqualizer;

{$R *.dfm}

procedure TfrmEqualizer.btnOkClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmEqualizer.EqPersonal;
var
  idx: integer;
begin
      // Uložení hodnot vlastního nastavení do promìnné Eq
      Eq := '';
      for idx := 0 to (pnlEq.ComponentCount - 1) do
        begin
          if StrPos( PChar(pnlEq.Components[idx].Name), PChar('Bar') ) <> nil then
            Eq := Eq + IntToStr({15 - }TTrackBar(pnlEq.Components[idx]).Position) + ',';
        end;
      Delete(Eq,Length(Eq),1);
      //---
end;

procedure TfrmEqualizer.btnResetClick(Sender: TObject);
var
  idx: integer;
begin

  for idx := 0 to (pnlEq.ComponentCount - 1) do
    if StrPos( PChar(pnlEq.Components[idx].Name), PChar('Bar') ) <> nil then
      TTrackBar(pnlEq.Components[idx]).Position := 0;

  tbReverb.position := 20;
  SaveEqualizerSettings;
end;

procedure TfrmEqualizer.EqualizerActiveAll(Truth: Boolean);
var
  i: integer;
begin
  for i := 0 to (pnlEq.ComponentCount - 1) do
    begin
      if StrPos( PChar(pnlEq.Components[i].Name), PChar('Bar') ) <> nil then;
        begin
          TTrackBar(pnlEq.Components[i]).Enabled := Truth;
        end;
    end;
  cbOptions.Enabled := Truth;
  btnReset.Enabled := Truth;
  tbReverb.Enabled := Truth;
end;

procedure TfrmEqualizer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  EqPersonal;
  SaveEqualizerSettings;

  chkEnableEqualizer.Visible := True;
  EqualizerIsShow := False;
  FEqualizer.Destroy;
end;

procedure TfrmEqualizer.FormShow(Sender: TObject);
var
  idx, pom: Integer;

begin
  Color := frmBgColor;

  Icon := PluginSkin.Equalizer.Icon;

  LoadEqualizerSettings;

  for idx := 1  to FrequencyCount do
    begin
      EqLista := TTrackBar.Create(pnlEq);
      with EqLista do
        begin
          Parent := pnlEq;
          Name := Format('Bar%d', [idx]);
          TickMarks := tmBoth;
          TickStyle := tsNone;
          ShowHint := True;
          Position := 0;
          Hint := IntToStr( Position );
          Orientation := trVertical;
          ShowSelRange := False;
          Min := -11;  // v reálu chceme interval <11;-12>
          Max := 12;
          Frequency := 2;
          SelStart := 0;
          SelEnd := 0;
          ShowSelRange := True;
          ThumbLength := 15;
          Width := 23;
          Height := 145;
          Top := 8;
          Tag := 100 + idx;
          Left := Width * (idx - 1) + 8;
          OnChange := tbEq01Change;
        end;
      lblFreqs := TLabel.Create(pnlEq);
      with lblFreqs do
        begin
          Parent := pnlEq;
          Name := Format('Freq%d', [idx]);
          Caption := slFreqs.Strings[idx-1];
          pom := StrToInt( Caption ) div 1000;
          if pom <> 0 then
            Caption := FloatToStr( StrToInt( Caption ) / 1000 )+ 'k';
          Width := EqLista.Width;
          Height := 13;
          Top := EqLista.Top + EqLista.Height;
          Left := EqLista.Left;
          Alignment := taCenter;
          AutoSize := True;
          Visible := True;
        end;
    end;

  Caption                             := PLUGIN_NAME + ' | ' + LNG('FORM Equalizer', 'Caption', 'Equalizer');
  btnReset.Caption                    := LNG('FORM Equalizer', 'Reset', 'Reset');
  btnOk.Caption                       := QIPPlugin.GetLang(LI_OK);
  lblReverb.Caption                   := LNG('FORM Equalizer', 'Reverb', 'Reverb');
  chkEnableEqualizer.Caption          := LNG('FORM Options', 'Advanced.EnableEqualizer', 'Enable Equalizer');
  chkSetEqualizerToRadioGenre.Caption := LNG('FORM Equalizer', 'SetEqualizerToRadioGenre', 'Set Equalizer according to radio genre');
  lblPreset.Caption                   := LNG('FORM Equalizer', 'Preset', 'Preset') + ':';
  cbOptions.Left                      := lblPreset.Left + lblPreset.Width + 4;
  gbOptions.Caption                   := QIPPlugin.GetLang(LI_OPTIONS);
  pnlEq.Color := Color;

  cbOptions.Clear;

  idx:=0;

  while ( idx <= EqualizerPreset.Count - 1 ) do
  begin
    Application.ProcessMessages;

    cbOptions.Items.Add(LNG('FORM Equalizer', 'Option.' + TEqPreset(EqualizerPreset.Objects[idx]).Name, TEqPreset(EqualizerPreset.Objects[idx]).Name));

    Inc(idx);
  end;

  cbOptions.ItemIndex := EqualizerPreset.IndexOf(EqualizerOption);

  chkSetEqualizerToRadioGenre.Checked := EqualizerToRadioGenre;
  chkEnableEqualizer.Checked          := EqualizerEnabled;
  chkEnableEqualizerClick(Sender);

  tbReverb.Position := 20 - EqualizerReverb;

  AddComments(FEqualizer);
  EqualizerIsShow := True;
end;

procedure TfrmEqualizer.EqualizerControl;
var
  Truth: boolean;
  i: integer;
begin
  i := 0;
  Truth := True;
  if (cbOptions.ItemIndex <> 0) or EqualizerToRadioGenre then
    Truth := False;
  for idx := 0 to (pnlEq.ComponentCount - 1) do
    begin
      if StrPos( PChar(pnlEq.Components[idx].Name), PChar('Bar') ) <> nil then
        begin
          TTrackBar(pnlEq.Components[idx]).Position := 0 - Round(TEqHz(TEqPreset(EqualizerPreset.Objects[EqualizerPreset.IndexOf(EqualizerOption)]).Hz.Objects[i]).dB);
          TTrackBar(pnlEq.Components[idx]).Enabled := Truth;
          Inc(i);
        end;
    end;
  btnReset.Enabled  := Truth;
end;

procedure TfrmEqualizer.cbOptionsSelect(Sender: TObject);
var
  idx: integer;
  sValues: WideString;

begin
  if EqualizerPreset.IndexOf(EqualizerOption) = 0 then
    begin
      EqPersonal;
      SaveEqualizerSettings;
      LoadPersonalEqualizerSettings(sValues);
      UpdateEqualizerPreset(EqualizerOption, sValues);
    end;

  EqualizerOption := TEqPreset(EqualizerPreset.Objects[cbOptions.ItemIndex]).Name;

  EqualizerControl;
  ActiveEqualizer(EqualizerOption);
end;

procedure TfrmEqualizer.chkSetEqualizerToRadioGenreClick(Sender: TObject);
begin
  EqualizerToRadioGenre := chkSetEqualizerToRadioGenre.Checked;
  ReverbEnabled := not chkSetEqualizerToRadioGenre.Checked;

  EqualizerActiveAll(not EqualizerToRadioGenre);
  EqualizerControl;

  if EqualizerToRadioGenre then
  begin
    if Radio_StationID <= Stations.Count - 1 then
    begin
      ActiveEqualizer(TStation(Stations.Objects[Radio_StationID]).Genre);
    end;
  end
  else
  begin
    ActiveEqualizer(EqualizerOption);
  end;

  // Nastavení ozvìny
  if ReverbEnabled then
    tbReverbChange(nil)
  else
    FBassPlayer.BASSPlayer_SetReverb(EQ_REVERB, tbReverb.Max);
  // ----------------

  SaveEqualizerSettings;

end;

procedure TfrmEqualizer.chkEnableEqualizerClick(Sender: TObject);
begin
  EqualizerEnabled := chkEnableEqualizer.Checked;
  if OptionsIsShow then
    FOptions.chkEnableEqualizer.Checked := EqualizerEnabled;

  if EqualizerEnabled then
    begin
      if EqualizerToRadioGenre then
        begin
          EqualizerActiveAll(not EqualizerToRadioGenre);
          if Radio_StationID <= Stations.Count - 1 then
            ActiveEqualizer(TStation(Stations.Objects[Radio_StationID]).Genre);
        end
      else
        begin
          ActiveEqualizer(EqualizerOption);
          EqualizerActiveAll(EqualizerEnabled);
        end;
      EqualizerControl;
      chkSetEqualizerToRadioGenre.Enabled := EqualizerEnabled;
    end
  else
    begin
      DeactiveEqualizer;
      EqualizerActiveAll(EqualizerEnabled);
      //chkSetEqualizerToRadioGenre.Checked := EqualizerEnabled;
      chkSetEqualizerToRadioGenre.Enabled := EqualizerEnabled;
    end;

  SaveEqualizerSettings;
end;

procedure TfrmEqualizer.tbEq01Change(Sender: TObject);
var
  Bar: TTrackBar;
  BarID, BarPos: integer;
begin
  Bar := (Sender as TTrackBar);
  BarPos := 0 - Bar.Position;
  Bar.Hint := IntToStr(BarPos);
  BarID := StrToInt( StringReplace(Bar.Name, 'Bar', '', [rfReplaceAll]) );
  FBassPlayer.BASSPlayer_SetEq(BarID,BarPos);
end;

procedure TfrmEqualizer.tbReverbChange(Sender: TObject);
begin
  EqualizerReverb := 20-tbReverb.position;
  FBassPlayer.BASSPlayer_SetReverb(EQ_REVERB, tbReverb.position);
end;

procedure TfrmEqualizer.TimerTimer(Sender: TObject);
var
  I, iPosition: Integer;
begin
  // Zjištìní nastavení frekvencí EQ
  for I := 1 to FrequencyCount do
  begin
    FBassPlayer.BASSPlayer_GetEq(I, iPosition);
    with TTrackBar(pnlEq.FindComponent('Bar' + IntToStr(I))) do
    begin
      SelStart := 0 - iPosition;
      SelEnd := Max;
    end;
  end;

  // Zjištìní nastavení ozvìny
  FBassPlayer.BASSPlayer_GetReverb(EQ_REVERB, iPosition);
  tbReverb.SelStart := iPosition;
  tbReverb.SelEnd := tbReverb.Max;
end;

end.

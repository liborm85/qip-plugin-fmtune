unit Info;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmInfo = class(TForm)
    lbleBitrate: TLabeledEdit;
    lbleRadio: TLabeledEdit;
    lbleSong: TLabeledEdit;
    lbleStream: TLabeledEdit;
    lbleTime: TLabeledEdit;
    tmriTime: TTimer;
    imgCover: TImage;
    lblCover: TLabel;
    CoverRame: TShape;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmriTimeTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInfo: TfrmInfo;

implementation

uses General, uLNG, u_lang_ids, uComments, uTime;

{$R *.dfm}

procedure TfrmInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tmriTime.Enabled := False;
  InfoIsShow := False;
  FInfo.Destroy;
end;

procedure TfrmInfo.FormShow(Sender: TObject);
begin
  Color := frmBgColor;

  Icon := PluginSkin.Info.Icon;

  Caption           := QIPPlugin.GetLang(LI_INFORMATION);

  lbleStream.EditLabel.Caption  := LNG('FORM Info', 'Stream', 'Stream') + ':';
  lbleSong.EditLabel.Caption    := LNG('FORM Info', 'Song', 'Song') + ':';
  lbleRadio.EditLabel.Caption   := LNG('FORM Info', 'Radio', 'Radio') + ':';
  lbleBitrate.EditLabel.Caption := LNG('FORM Info', 'Bitrate', 'Bitrate') + ':';
  lbleTime.EditLabel.Caption    := LNG('FORM Info', 'Time', 'Time') + ':';
  lblCover.Caption              := LNG('FORM Info', 'Cover', 'Cover') + ':';

  lblCover.Left := 48 - lblCover.Width;

  AddComments(FInfo);
  tmriTimeTimer(nil);
  tmriTime.Enabled := True;

  InfoIsShow := True;
end;

procedure TfrmInfo.tmriTimeTimer(Sender: TObject);
var
  CoverShow: Boolean;
begin
  CoverShow := ShowCover and Radio_Playing and FileExists(CoverFile);
  lblCover.Visible  := CoverShow;
  CoverRame.Visible := CoverShow;
  imgCover.Visible  := CoverShow;

  lbleStream.Text  := PlayURL;
  lbleSong.Text    := iSong;
  lbleRadio.Text   := iRadio;

  try
    if FileExists(CoverFile) then
      imgCover.Picture.LoadFromFile(CoverFile);
  finally

  end;

  CoverRame.Width  := imgCover.Width + 2 * 4;
  CoverRame.Height := imgCover.Height + 2 * 4;
  if iBitrate <> '' then
    lbleBitrate.Text := iBitrate + ' kbps'
  else
    lbleBitrate.Text := iBitrate;
  lbleTime.Text := IntToTimeStr(Trunc(iTime), 'h:nn:ss');

  if CoverShow then
    Height := CoverRame.Top + CoverRame.Height + 32
  else
    Height := lbleBitrate.Top + lbleBitrate.Height + 32; // zde musí být ten nejspodnìjší objekt
end;

end.

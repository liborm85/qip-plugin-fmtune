unit Volume;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, INIFiles, ExtCtrls;

type
  TfrmVolume = class(TForm)
    chkMute: TCheckBox;
    lblVolume: TLabel;
    tbVolume: TTrackBar;
    imgMute: TImage;
    imgUnmute: TImage;
    line: TShape;
    Timer: TTimer;
    procedure tbVolumeKeyPress(Sender: TObject; var Key: Char);
    procedure chkMuteKeyPress(Sender: TObject; var Key: Char);
    procedure tbVolumeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkMuteClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure CreateParams (var Params: TCreateParams); override;
  end;

var
  frmVolume: TfrmVolume;

implementation

uses General, uLNG, uComments, uINI;

{$R *.dfm}

procedure TfrmVolume.CreateParams (var Params: TCreateParams);
begin
  inherited;
    with Params do begin
      ExStyle := (ExStyle or WS_EX_TOOLWINDOW or WS_EX_NOACTIVATE);
    end;
end;

procedure TfrmVolume.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  VolumeIsShow := False;
  FVolume.Destroy;
end;

procedure TfrmVolume.FormShow(Sender: TObject);
begin
  Color := frmBgColor;

  Icon := PluginSkin.Volume.Icon;
  imgMute.Picture.Icon   := PluginSkin.Mute.Icon;
  imgUnmute.Picture.Icon := PluginSkin.Unmute.Icon;

{ Width := 90;
  Height := 243;  }

  Caption           := LNG('FORM Volume', 'Caption', 'Volume');
  chkMute.Caption   := LNG('FORM Volume', 'Mute', 'Mute');

  SetWindowPos(Handle,
              HWND_TOPMOST,
              Left,Top, Width, Height,
              0{SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW});

  tbVolume.Position := 100 - Player_Volume;

  chkMute.Checked := Player_Mute;

  lblVolume.Caption := IntToStr(Player_Volume) + '%';

  AddComments(FVolume);

  tbVolume.SetFocus;
  VolumeIsShow := True;
end;

procedure TfrmVolume.tbVolumeChange(Sender: TObject);
var INI : TIniFile;
begin
  Timer.Enabled := False;

  Player_Volume := 100 - tbVolume.Position ;

  lblVolume.Caption := IntToStr(Player_Volume) + '%';


  INIGetProfileConfig(INI);

  INIWriteInteger(INI, 'Conf', 'Volume', Player_Volume );

  INIFree(INI);

  QIPPlugin.SetChangeVolume;

  Timer.Enabled := True;
end;

procedure TfrmVolume.tbVolumeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    Close;
end;

procedure TfrmVolume.TimerTimer(Sender: TObject);
begin
  Close;
end;

procedure TfrmVolume.chkMuteClick(Sender: TObject);
begin
  Player_Mute := chkMute.Checked;
  QIPPlugin.SetChangeVolume;
end;

procedure TfrmVolume.chkMuteKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    Close;
end;

end.

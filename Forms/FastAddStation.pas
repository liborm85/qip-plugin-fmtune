unit FastAddStation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmFastAddStation = class(TForm)
    edtStationName: TEdit;
    lblStationName: TLabel;
    lblStreamURL: TLabel;
    edtStreamURL: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure edtStreamURLKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtStationNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFastAddStation: TfrmFastAddStation;

implementation

uses General, uLNG, u_lang_ids, uComments;

{$R *.dfm}

procedure TfrmFastAddStation.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmFastAddStation.btnOKClick(Sender: TObject);
var
  hIndex, hIndex2 : Integer;
  sFormat : WideString;
begin

  if edtStationName.Text='' then
  begin
    ShowMessage( LNG('FORM FastAddStation', 'EnterStationName', 'Enter station name.') );
    edtStationName.SetFocus;
    Exit;
  end
  else if edtStreamURL.Text='' then
  begin
    ShowMessage( LNG('FORM FastAddStation', 'EnterStreamURL', 'Enter stream URL.') );
    edtStreamURL.SetFocus;
    Exit;
  end;


  Stations.Add('ITEM');
  hIndex:= Stations.Count - 1;
  Stations.Objects[hIndex] := TStation.Create;
  TStation(Stations.Objects[hIndex]).Name     := edtStationName.Text;
  TStation(Stations.Objects[hIndex]).Genre    := 'Pop';
  TStation(Stations.Objects[hIndex]).Language := '';
  TStation(Stations.Objects[hIndex]).URL      := '';

  TStation(Stations.Objects[hIndex]).Streams := TStringList.Create;
  TStation(Stations.Objects[hIndex]).Streams.Clear;

  sFormat := Copy(ExtractFileExt(edtStreamURL.Text),2);

  if sFormat = '' then
    sFormat := 'stream';

  TStation(Stations.Objects[hIndex]).Streams.Add('STREAM');
  hIndex2:= TStation(Stations.Objects[hIndex]).Streams.Count - 1;
  TStation(Stations.Objects[hIndex]).Streams.Objects[hIndex2] := TStream.Create;
  TStream(TStation(Stations.Objects[hIndex]).Streams.Objects[hIndex2]).Format := sFormat;
  TStream(TStation(Stations.Objects[hIndex]).Streams.Objects[hIndex2]).URL    := edtStreamURL.Text;

  SaveStations(Stations,'',False);

  Close;
end;

procedure TfrmFastAddStation.edtStationNameKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=13 then
  begin
    btnOKClick(Sender);
    Key := 0;
  end;
end;

procedure TfrmFastAddStation.edtStreamURLKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=13 then
  begin
    btnOKClick(Sender);
    Key := 0;
  end;
end;

procedure TfrmFastAddStation.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FastAddStationIsShow := False;
  FFastAddStation.Destroy;
end;

procedure TfrmFastAddStation.FormShow(Sender: TObject);
begin
  Color := frmBgColor;

  Icon := PluginSkin.FastAddStation.Icon;

  Caption             := LNG('FORM FastAddStation', 'Caption', 'Fast add station');


  lblStationName.Caption      := LNG('FORM EditStations', 'Station.Name', 'Name') + ':';
  lblStreamURL.Caption        := LNG('FORM EditStations', 'Station.Streams.Stream.URL', 'URL') + ':';

  btnOK.Caption            := QIPPlugin.GetLang(LI_OK);
  btnCancel.Caption        := QIPPlugin.GetLang(LI_CANCEL);

  AddComments(FFastAddStation);
  FastAddStationIsShow := True;
end;

end.

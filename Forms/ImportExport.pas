unit ImportExport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TfrmImportExport = class(TForm)
    lblFastSearch: TLabel;
    lvStations: TListView;
    btnSelectAll: TButton;
    btnUnselectAll: TButton;
    btnInvertSelection: TButton;
    edtFastSearch: TEdit;
    btnStart: TButton;
    procedure FormShow(Sender: TObject);
    procedure edtFastSearchChange(Sender: TObject);
    procedure btnUnselectAllClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure btnInvertSelectionClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImportExport: TfrmImportExport;

implementation

uses General, uLNG, u_qip_plugin;

{$R *.dfm}

procedure TfrmImportExport.btnInvertSelectionClick(Sender: TObject);
var i: Integer;
begin

  i:=0;
  while ( i <= lvStations.Items.Count - 1 ) do
  begin
    Application.ProcessMessages;

    if lvStations.Items.item[i].Checked = False then
      lvStations.Items.item[i].Checked := True
    else if lvStations.Items.item[i].Checked = True then
      lvStations.Items.item[i].Checked := False;

    Inc(i);
  end;

end;

procedure TfrmImportExport.btnSelectAllClick(Sender: TObject);
var i: Integer;
begin

  i:=0;
  while ( i <= lvStations.Items.Count - 1 ) do
  begin
    Application.ProcessMessages;

    lvStations.Items.item[i].Checked := True;

    Inc(i);
  end;

end;

procedure TfrmImportExport.btnStartClick(Sender: TObject);
var i: Integer;
begin


  i := lvStations.Items.Count - 1;
  while ( i >= 0 ) do
  begin
    Application.ProcessMessages;

    if lvStations.Items.item[i].Checked = False then
      DataImportExport.Delete(i);

    i := i - 1;
  end;


  ImportExport_Type := 10;
  Close;

end;

procedure TfrmImportExport.btnUnselectAllClick(Sender: TObject);
var i: Integer;
begin

  i:=0;
  while ( i <= lvStations.Items.Count - 1 ) do
  begin
    Application.ProcessMessages;

    lvStations.Items.item[i].Checked := False;

    Inc(i);
  end;

end;

procedure TfrmImportExport.edtFastSearchChange(Sender: TObject);
var i: Integer;
begin

  i:=0;
  while ( i <= lvStations.Items.Count - 1 ) do
  begin
    Application.ProcessMessages;

    if AnsiUpperCase(edtFastSearch.Text) = AnsiUpperCase(Copy(lvStations.Items.item[i].Caption,1,Length(edtFastSearch.Text))) then
    begin
      lvStations.ItemIndex := i;
      break;
    end;

    Inc(i);
  end;
end;

procedure TfrmImportExport.FormShow(Sender: TObject);
var i: Integer;
begin
  Color := frmBgColor;

  if ImportExport_Type = 1 then
    begin
      Caption := PLUGIN_NAME + ' | ' + LNG('FORM EditStations', 'Caption', 'Edit Radio stations') + ' | ' + LNG('FORM ImportExport', 'Caption.Import', 'Import');
      Icon := PluginSkin.Import.Icon;
    end
  else
    if ImportExport_Type = 2 then
      begin
        Caption  := PLUGIN_NAME + ' | ' + LNG('FORM EditStations', 'Caption', 'Edit Radio stations') + ' | ' + LNG('FORM ImportExport', 'Caption.Export', 'Export');
        Icon := PluginSkin.Export.Icon;
      end;

  lblFastSearch.Caption  := LNG('FORM ImportExport', 'FastSearch', 'Fast search') + ':';

  btnSelectAll.Caption        := LNG('FORM ImportExport', 'SelectAll', 'Select All');
  btnUnselectAll.Caption      := LNG('FORM ImportExport', 'UnselectAll', 'Unselect All');
  btnInvertSelection.Caption  := LNG('FORM ImportExport', 'InvertSelection', 'Invert selection');

  btnStart.Caption            := LNG('FORM ImportExport', 'Start', 'Start');


  i:=0;
  while ( i <= DataImportExport.Count - 1 ) do
    begin
      Application.ProcessMessages;

      lvStations.Items.Add;
      lvStations.Items.item[lvStations.Items.Count - 1].Caption := TStation(DataImportExport.Objects[i]).Name;

      Inc(i);
    end;

  btnSelectAllClick(Sender);
end;

end.

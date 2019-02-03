unit EditStations;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ImportExport, ImgList, Buttons;

type
  TfrmEditStations = class(TForm)
    lvStations: TListView;
    btnStationAdd: TBitBtn;
    btnStationRemove: TBitBtn;
    btnImport: TButton;
    btnExport: TButton;
    btnSave: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    btnStationUp: TBitBtn;
    btnStationDown: TBitBtn;
    gbStationsList: TGroupBox;
    imgStreams: TImageList;
    lblStationName: TLabel;
    lblStationGenre: TLabel;
    lblStationLanguage: TLabel;
    lblStationWeb: TLabel;
    edtStationName: TEdit;
    edtStationURL: TEdit;
    edtStationGenre: TComboBox;
    edtStationLanguage: TComboBox;
    gbStreams: TGroupBox;
    lblStreamFormat: TLabel;
    lblStreamURL: TLabel;
    edtStreamFormat: TComboBox;
    edtStreamURL: TEdit;
    btnSaveStream: TButton;
    btnDefaultStream: TButton;
    lvStreams: TListView;
    btnStreamUp: TBitBtn;
    btnStreamDown: TBitBtn;
    btnStreamAdd: TBitBtn;
    btnStreamRemove: TBitBtn;
    gbEditStation: TGroupBox;
    btnCancel: TButton;
    btnOK: TButton;
    lblStationGroup: TLabel;
    cmbStationGroup: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure lvStationsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);

    procedure ViewStationInfo(Index : Integer);
    procedure ViewStreamInfo(Index : Integer);

    procedure lvStreamsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btnStationApplyClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnStreamRemoveClick(Sender: TObject);
    procedure btnStationRemoveClick(Sender: TObject);
    procedure btnStreamAddClick(Sender: TObject);
    procedure btnStationAddClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);

    procedure ShowImportExport(Index : Integer);
    procedure btnExportClick(Sender: TObject);
    procedure btnDefaultStreamClick(Sender: TObject);
    procedure btnStationUpClick(Sender: TObject);
    procedure btnStationDownClick(Sender: TObject);
    procedure btnSaveStreamClick(Sender: TObject);
    procedure bntSaveOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnStreamUpClick(Sender: TObject);
    procedure btnStreamDownClick(Sender: TObject);
    procedure lvStreamsClick(Sender: TObject);
    procedure lvStationsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);


  private
    { Private declarations }
  public
    { Public declarations }


  end;

var
  frmEditStations: TfrmEditStations;
  FfrmImportExport: TfrmImportExport;

implementation

uses General, uLNG, u_qip_plugin, u_lang_ids, uIcon, uComments, uEqualizer;

{$R *.dfm}

function Repl1(sText: WideString; sStation: WideString): WideString;

begin

  Result := StringReplace(sText, '%STATION%', sStation, [rfReplaceAll]);

end;

function Repl2(sText: WideString; sStream: WideString): WideString;

begin

  Result := StringReplace(sText, '%STREAM%', sStream, [rfReplaceAll]);

end;

procedure TfrmEditStations.ShowImportExport(Index : Integer);
var i,ii,hIndex,hIndex2: Integer;
    r : Integer;

begin
  btnImport.Enabled := False;
  btnExport.Enabled := False;

  if ImportExportIsShow = False then
  begin
    DataImportExport.Clear;

    if Index = 1 then
      begin
        OpenDialog1.Title := LNG('FORM ImportExport', 'Caption.Import', 'Import');
        OpenDialog1.InitialDir := GetCurrentDir;
        OpenDialog1.Options := [ofFileMustExist];
        OpenDialog1.Filter :='*.ftx|*.ftx|*.*|*.*';
        //  openDialog.FilterIndex := 2;

        if OpenDialog1.Execute then
        begin

          LoadStations(DataImportExport, openDialog1.FileName);

          ImportExport_Type:= 1;
          FfrmImportExport := TfrmImportExport.Create(nil);
          FfrmImportExport.ShowModal;

          if ImportExport_Type = 10 then
            begin
              if DataImportExport.Count = 0 then
                ShowMessage('Není co importovat.')
              else
                begin

                  i:=0;
                  while ( i <= DataImportExport.Count - 1 ) do
                  begin
                    Application.ProcessMessages;

                    Stations.Add('ITEM');
                    hIndex:= Stations.Count - 1;
                    Stations.Objects[hIndex] := TStation.Create;
                    TStation(Stations.Objects[hIndex]).Name     := TStation(DataImportExport.Objects[i]).Name;
                    TStation(Stations.Objects[hIndex]).Genre    := TStation(DataImportExport.Objects[i]).Genre;
                    TStation(Stations.Objects[hIndex]).Language := TStation(DataImportExport.Objects[i]).Language;
                    TStation(Stations.Objects[hIndex]).URL      := TStation(DataImportExport.Objects[i]).URL;
                    TStation(Stations.Objects[hIndex]).Group    := TStation(DataImportExport.Objects[i]).Group;
                    TStation(Stations.Objects[hIndex]).DefaultStream      := TStation(DataImportExport.Objects[i]).DefaultStream;

                    lvStations.Items.Add;
                    lvStations.Items.item[lvStations.Items.Count - 1].Caption := TStation(DataImportExport.Objects[i]).Name;

                    TStation(Stations.Objects[hIndex]).Streams := TStringList.Create;
                    TStation(Stations.Objects[hIndex]).Streams.Clear;

                    ii:=0;
                    while ( ii <= TStation(DataImportExport.Objects[i]).Streams.Count - 1 ) do
                    begin
                      Application.ProcessMessages;

                      TStation(Stations.Objects[hIndex]).Streams.Add('STREAM');
                      hIndex2:= TStation(Stations.Objects[hIndex]).Streams.Count - 1;
                      TStation(Stations.Objects[hIndex]).Streams.Objects[hIndex2] := TStream.Create;
                      TStream(TStation(Stations.Objects[hIndex]).Streams.Objects[hIndex2]).Format := TStream(TStation(DataImportExport.Objects[i]).Streams.Objects[ii]).Format;
                      TStream(TStation(Stations.Objects[hIndex]).Streams.Objects[hIndex2]).URL    := TStream(TStation(DataImportExport.Objects[i]).Streams.Objects[ii]).URL;

                      Inc(ii);
                    end;

                    Inc(i);
                  end;

                end;

            end;

        end

      end
    else
      begin

        i:=0;
        while ( i <= Stations.Count - 1 ) do
        begin
          Application.ProcessMessages;

          DataImportExport.Add('ITEM');
          hIndex:= DataImportExport.Count - 1;
          DataImportExport.Objects[hIndex] := TStation.Create;
          TStation(DataImportExport.Objects[hIndex]).Name     := TStation(Stations.Objects[i]).Name;
          TStation(DataImportExport.Objects[hIndex]).Genre    := TStation(Stations.Objects[i]).Genre;
          TStation(DataImportExport.Objects[hIndex]).Language := TStation(Stations.Objects[i]).Language;
          TStation(DataImportExport.Objects[hIndex]).URL      := TStation(Stations.Objects[i]).URL;
          TStation(DataImportExport.Objects[hIndex]).Group    := TStation(Stations.Objects[i]).Group;
          TStation(DataImportExport.Objects[hIndex]).DefaultStream      := TStation(Stations.Objects[i]).DefaultStream;

          TStation(DataImportExport.Objects[hIndex]).Streams := TStringList.Create;
          TStation(DataImportExport.Objects[hIndex]).Streams.Clear;

          ii:=0;
          while ( ii <= TStation(Stations.Objects[i]).Streams.Count - 1 ) do
          begin
            Application.ProcessMessages;

            TStation(DataImportExport.Objects[hIndex]).Streams.Add('STREAM');
            hIndex2:= TStation(DataImportExport.Objects[hIndex]).Streams.Count - 1;
            TStation(DataImportExport.Objects[hIndex]).Streams.Objects[hIndex2] := TStream.Create;
            TStream(TStation(DataImportExport.Objects[hIndex]).Streams.Objects[hIndex2]).Format := TStream(TStation(Stations.Objects[i]).Streams.Objects[ii]).Format;
            TStream(TStation(DataImportExport.Objects[hIndex]).Streams.Objects[hIndex2]).URL    := TStream(TStation(Stations.Objects[i]).Streams.Objects[ii]).URL;

            Inc(ii);
          end;

          Inc(i);
        end;


        ImportExport_Type:= 2;
        FfrmImportExport := TfrmImportExport.Create(nil);
        FfrmImportExport.ShowModal;
          if ImportExport_Type = 10 then
          begin
            if DataImportExport.Count = 0 then
              ShowMessage('Není co exportovat.')
            else
            begin
              SaveDialog1.Title := LNG('FORM ImportExport', 'Caption.Export', 'Export');
              SaveDialog1.InitialDir := GetCurrentDir;
              SaveDialog1.Options := [ofFileMustExist];
              SaveDialog1.Filter :='*.ftx|*.ftx|*.*|*.*';
              SaveDialog1.DefaultExt := 'ftx';
              //  SaveDialog.FilterIndex := 2;

              if SaveDialog1.Execute then
              begin

                if FileExists(SaveDialog1.FileName) = True then
                  begin
                    r := MessageBoxW(0, PWideChar( LNG('FORM EditStations','MsgFileExists', 'File exists. Do you want add data in to file?' ) ) , 'FMtune', MB_YESNOCANCEL + MB_ICONQUESTION);
                    if r = IDYES then
                    begin
                      SaveStations(DataImportExport, SaveDialog1.FileName, True);
                    end
                    else if r = IDNO then
                    begin
                      SaveStations(DataImportExport, SaveDialog1.FileName, False);
                    end;

                  end
                else
                  begin
                      SaveStations(DataImportExport, SaveDialog1.FileName, False);
                  end
                

              end;


            end;

        end

      end;

  end;

  btnImport.Enabled := True;
  btnExport.Enabled := True;
end;

procedure TfrmEditStations.ViewStreamInfo(Index : Integer);

begin

  btnSaveStream.Enabled := True;
  btnDefaultStream.Enabled := True;
  edtStreamFormat.Enabled := True;
  edtStreamURL.Enabled := True;
  btnStreamRemove.Enabled := True;
  btnStreamUp.Enabled := True;
  btnStreamDown.Enabled := True;
  edtStreamFormat.Text := '';
  edtStreamURL.Text := '';  

  edtStreamFormat.Text := lvStreams.Items.item[Index].Caption;
  edtStreamURL.Text    := lvStreams.Items.item[Index].SubItems[0];

  if btnDefaultStream.Tag = Index then
    btnDefaultStream.Enabled := False
  else
    btnDefaultStream.Enabled := True;

end;

procedure TfrmEditStations.ViewStationInfo(Index : Integer);
var
  i, r, idx1 : Integer;
begin
  lvStreams.Items.Clear;

  btnSaveStream.Enabled := False;
  btnDefaultStream.Enabled := False;
  btnStationRemove.Enabled := True;
  edtStreamFormat.Enabled := False;
  edtStreamURL.Enabled := False;
  btnStreamRemove.Enabled := False;
  btnStreamUp.Enabled := False;
  btnStreamDown.Enabled := False;

  edtStationName.Text     := TStation(Stations.Objects[Index]).Name;
  //ShowMessage('_'+TStation(Stations.Objects[Index]).Genre+'_');
  edtStationGenre.ItemIndex := edtStationGenre.Items.IndexOf( LNG('FORM Equalizer', 'Option.' + TStation(Stations.Objects[Index]).Genre, TStation(Stations.Objects[Index]).Genre) );
//  edtStationGenre.Text    := LNG('FORM Equalizer', 'Option.' + TStation(Stations.Objects[Index]).Genre, TStation(Stations.Objects[Index]).Genre);

  r := Langs.IndexOf(TStation(Stations.Objects[Index]).Language);

  if r=-1 then
    edtStationLanguage.ItemIndex := 0
  else
    edtStationLanguage.ItemIndex := r;


  edtStationURL.Text      := TStation(Stations.Objects[Index]).URL;


  cmbStationGroup.Clear;
  idx1:=0;
  while ( idx1 <= Stations.Count - 1 ) do
  begin
    Application.ProcessMessages;

    if TStation(Stations.Objects[idx1]).Group<>'' then
      if cmbStationGroup.Items.IndexOf( TStation(Stations.Objects[idx1]).Group ) = -1 then
        cmbStationGroup.Items.Add( TStation(Stations.Objects[idx1]).Group );

    Inc(idx1);
  end;

  cmbStationGroup.Text     := TStation(Stations.Objects[Index]).Group;

  btnDefaultStream.Tag    := TStation(Stations.Objects[Index]).DefaultStream;

  i:=0;
  while ( i <= TStation(Stations.Objects[Index]).Streams.Count - 1 ) do
  begin
    Application.ProcessMessages;

    lvStreams.Items.Add;
    lvStreams.Items.item[lvStreams.Items.Count - 1].Caption := TStream(TStation(Stations.Objects[Index]).Streams.Objects[i]).Format;

    if btnDefaultStream.Tag = i then
      lvStreams.Items.item[lvStreams.Items.Count - 1].ImageIndex := 1
    else
      lvStreams.Items.item[lvStreams.Items.Count - 1].ImageIndex := 0;

    lvStreams.Items.item[lvStreams.Items.Count - 1].SubItems.Add( TStream(TStation(Stations.Objects[Index]).Streams.Objects[i]).URL );

    Inc(i);
  end;

end;

procedure TfrmEditStations.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmEditStations.bntSaveOKClick(Sender: TObject);
begin
  btnSaveClick(Sender);

  Close;
end;

procedure TfrmEditStations.btnDefaultStreamClick(Sender: TObject);
var i: Integer;
begin

  btnDefaultStream.Tag := lvStreams.ItemIndex;

  i:=0;
  while ( i <= lvStreams.Items.Count - 1 ) do
    begin
      Application.ProcessMessages;

      if btnDefaultStream.Tag = i then
        lvStreams.Items.item[i].ImageIndex := 1
      else
        lvStreams.Items.item[i].ImageIndex := 0;

      Inc(i);
    end;

end;

procedure TfrmEditStations.btnExportClick(Sender: TObject);
begin
  ShowImportExport(2);
end;

procedure TfrmEditStations.btnImportClick(Sender: TObject);

begin
  ShowImportExport(1);
end;

procedure TfrmEditStations.btnSaveStreamClick(Sender: TObject);
begin
  lvStreams.Items.item[lvStreams.ItemIndex].Caption     := edtStreamFormat.Text;
  lvStreams.Items.item[lvStreams.ItemIndex].SubItems[0] := edtStreamURL.Text;
end;

procedure TfrmEditStations.btnSaveClick(Sender: TObject);
begin
  if lvStations.ItemIndex <> -1 then
    btnStationApplyClick(Sender);

  btnSave.Enabled := False;

  SaveStations(Stations,'',False);

  btnSave.Enabled := True;
end;

procedure TfrmEditStations.btnStationAddClick(Sender: TObject);
var hIndex : Integer;
begin
  lvStations.Items.Add;
  lvStations.Items.item[lvStations.Items.Count - 1].Caption := 'unknown';

  Stations.Add('ITEM');
  hIndex:= Stations.Count - 1;
  Stations.Objects[hIndex] := TStation.Create;
  TStation(Stations.Objects[hIndex]).Name     := 'unknown';
  TStation(Stations.Objects[hIndex]).Genre    := 'Pop';
  TStation(Stations.Objects[hIndex]).Language := '';
  TStation(Stations.Objects[hIndex]).URL      := '';

  TStation(Stations.Objects[hIndex]).Streams := TStringList.Create;
  TStation(Stations.Objects[hIndex]).Streams.Clear;

  lvStations.ItemIndex := lvStations.Items.Count - 1;
  lvStations.Scroll(0, lvStations.Items.Count * 50);

  edtStationName.SetFocus;

end;

procedure TfrmEditStations.btnStationApplyClick(Sender: TObject);
var
  Index: Integer;
  i : Integer;
  hIndex2: Integer;
begin

  Index := lvStations.ItemIndex;

  TStation(Stations.Objects[Index]).Name     := edtStationName.Text;
  lvStations.Items.item[Index].Caption       := edtStationName.Text;

  if edtStationGenre.ItemIndex = -1 then
    TStation(Stations.Objects[Index]).Genre    := 'Pop'
  else
    TStation(Stations.Objects[Index]).Genre    := TEqPreset(EqualizerPreset.Objects[edtStationGenre.ItemIndex]).Name;

  TStation(Stations.Objects[Index]).Language := Langs[edtStationLanguage.ItemIndex];
//  TSLStation(Stations.Objects[Index]).Language := edtStationLanguage.Text;


  TStation(Stations.Objects[Index]).URL      := edtStationURL.Text;

  TStation(Stations.Objects[Index]).Group    := cmbStationGroup.Text;

  TStation(Stations.Objects[Index]).DefaultStream := btnDefaultStream.Tag;

  TStation(Stations.Objects[Index]).Streams.Clear;

//  TSLStation(Stations.Objects[Index]).Streams.Count - 1

  i:=0;
  while ( i <= lvStreams.Items.Count - 1 ) do
    begin
      Application.ProcessMessages;

      TStation(Stations.Objects[Index]).Streams.Add('STREAM');
      hIndex2:= TStation(Stations.Objects[Index]).Streams.Count - 1;
      TStation(Stations.Objects[Index]).Streams.Objects[hIndex2] := TStream.Create;
      TStream(TStation(Stations.Objects[Index]).Streams.Objects[hIndex2]).Format := lvStreams.Items.item[i].Caption;
      TStream(TStation(Stations.Objects[Index]).Streams.Objects[hIndex2]).URL    := lvStreams.Items.item[i].SubItems[0];

      Inc(i);
    end;

end;

procedure TfrmEditStations.btnStationDownClick(Sender: TObject);
var Stat1,Stat2 : TStation;
    idx : Integer;
begin
  idx := lvStations.ItemIndex;
  if (idx <> -1) then
    begin
      Stations.Exchange(idx, idx + 1);

      Stat1 := TStation(Stations.Objects[idx]);
      Stat2 := TStation(Stations.Objects[idx + 1]);

      if Radio_StationID = idx then
        Inc(Radio_StationID)
      else
        if Radio_StationID = idx + 1 then
          Dec(Radio_StationID);

      lvStations.Items.item[idx].Caption     :=  Stat1.Name;

      lvStations.Items.item[idx + 1].Caption :=  Stat2.Name;

      lvStations.ItemIndex := lvStations.ItemIndex + 1;
    end;
end;

procedure TfrmEditStations.btnStationRemoveClick(Sender: TObject);
var
  i: integer;
begin

  if lvStations.ItemIndex <> -1 then
  begin

    btnStationRemove.Enabled := False;

    if MessageBoxW(0, PWideChar( Repl1 ( LNG('FORM EditStations','MsgRemoveStation', 'Do you really want to remove station "%STATION%" from list?' ) , lvStations.Items[lvStations.ItemIndex].Caption ) ) , 'FMtune', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      if Radio_Playing = True then
        FBassPlayer.PlayStopRadio;

      i := lvStations.ItemIndex;
      Stations.Delete(i);
      lvStations.Items.Delete(i);
      if i = lvStations.Items.Count then
        lvStations.ItemIndex := i - 1
      else
        lvStations.ItemIndex := i;
      lvStationsSelectItem(Sender, lvStations.ItemFocused, True);
      lvStationsClick(Sender);
      //Radio_StationID := i;
    end
    else
    begin
      btnStationRemove.Enabled := True;
    end;

  end;

end;

procedure TfrmEditStations.btnStationUpClick(Sender: TObject);
var Stat1,Stat2 : TStation;
    idx : Integer;
begin
  idx := lvStations.ItemIndex;
  if (idx <> -1) then
    begin
      Stations.Exchange(idx, idx - 1);

      Stat1 := TStation(Stations.Objects[idx]);
      Stat2 := TStation(Stations.Objects[idx - 1]);

      if Radio_StationID = idx then
        Dec(Radio_StationID)
      else
        if Radio_StationID = idx - 1 then
          Inc(Radio_StationID);

      lvStations.Items.item[idx].Caption     := Stat1.Name;

      lvStations.Items.item[idx - 1].Caption := Stat2.Name;

      lvStations.ItemIndex := lvStations.ItemIndex - 1;
    end;
end;

procedure TfrmEditStations.btnStreamAddClick(Sender: TObject);
begin
  lvStreams.Items.Add;
  lvStreams.Items.item[lvStreams.Items.Count - 1].Caption := '-';
  lvStreams.Items.item[lvStreams.Items.Count - 1].SubItems.Add( '-' );
  ViewStreamInfo(lvStreams.Items.Count - 1);
  lvStreams.ItemIndex := lvStreams.Items.Count - 1;
  edtStreamURL.SetFocus;
end;

procedure TfrmEditStations.btnStreamUpClick(Sender: TObject);
var idx: Integer;
    Stream1Format, Stream1URL,
    Stream2Format, Stream2URL : WideString;
    Stream1ImgIndex,Stream2ImgIndex : Integer;
begin
  idx := lvStreams.ItemIndex;
  if (idx <> -1) then
    begin
      Stream1Format := lvStreams.Items.Item[idx].Caption;
      Stream1URL    := lvStreams.Items.Item[idx].SubItems[0];
      Stream1ImgIndex :=  lvStreams.Items.Item[idx].ImageIndex;

      Stream2Format := lvStreams.Items.Item[idx-1].Caption;
      Stream2URL    := lvStreams.Items.Item[idx-1].SubItems[0];
      Stream2ImgIndex :=  lvStreams.Items.Item[idx-1].ImageIndex;


      lvStreams.Items.Item[idx].Caption       := Stream2Format;
      lvStreams.Items.Item[idx].SubItems[0]   := Stream2URL;
      lvStreams.Items.Item[idx].ImageIndex    := Stream2ImgIndex;
      if lvStreams.Items.Item[idx].ImageIndex = 1 then
        btnDefaultStream.Tag := idx;

      lvStreams.Items.Item[idx-1].Caption     := Stream1Format;
      lvStreams.Items.Item[idx-1].SubItems[0] := Stream1URL;
      lvStreams.Items.Item[idx-1].ImageIndex  := Stream1ImgIndex;
      if lvStreams.Items.Item[idx-1].ImageIndex = 1 then
        btnDefaultStream.Tag := idx;

      lvStreams.ItemIndex := idx - 1;
    end;
end;

procedure TfrmEditStations.btnStreamDownClick(Sender: TObject);
var idx: Integer;
    Stream1Format, Stream1URL,
    Stream2Format, Stream2URL : WideString;
    Stream1ImgIndex,Stream2ImgIndex : Integer;
begin
  idx := lvStreams.ItemIndex;
  if (idx <> -1) then
    begin
      Stream1Format := lvStreams.Items.Item[idx].Caption;
      Stream1URL    := lvStreams.Items.Item[idx].SubItems[0];
      Stream1ImgIndex :=  lvStreams.Items.Item[idx].ImageIndex;

      Stream2Format := lvStreams.Items.Item[idx+1].Caption;
      Stream2URL    := lvStreams.Items.Item[idx+1].SubItems[0];
      Stream2ImgIndex :=  lvStreams.Items.Item[idx+1].ImageIndex;


      lvStreams.Items.Item[idx].Caption       := Stream2Format;
      lvStreams.Items.Item[idx].SubItems[0]   := Stream2URL;
      lvStreams.Items.Item[idx].ImageIndex    := Stream2ImgIndex;
      if lvStreams.Items.Item[idx].ImageIndex = 1 then
        btnDefaultStream.Tag := idx;

      lvStreams.Items.Item[idx+1].Caption     := Stream1Format;
      lvStreams.Items.Item[idx+1].SubItems[0] := Stream1URL;
      lvStreams.Items.Item[idx+1].ImageIndex  := Stream1ImgIndex;
      if lvStreams.Items.Item[idx+1].ImageIndex = 1 then
        btnDefaultStream.Tag := idx;

      lvStreams.ItemIndex := idx + 1;
    end;
end;


procedure TfrmEditStations.btnStreamRemoveClick(Sender: TObject);
var
  i: integer;
begin


  if lvStreams.ItemIndex <> -1 then
  begin

    btnStreamRemove.Enabled := False;

    if MessageBoxW(0, PWideChar( Repl2 ( LNG('FORM EditStations','MsgRemoveStream', 'Do you really want to remove format "%STREAM%" from list?' ) , lvStreams.Items[lvStreams.ItemIndex].Caption ) ) , 'FMtune', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      i := lvStreams.ItemIndex;
      lvStreams.Items.Delete(i);
      if i = lvStreams.Items.Count then
        lvStreams.ItemIndex := i - 1
      else
        lvStreams.ItemIndex := i;
      lvStreamsSelectItem(Sender, lvStreams.ItemFocused, True);
      lvStreamsClick(Sender);

      //Radio_StreamID := i;
    end
    else
    begin
      btnStreamRemove.Enabled := True;
    end;

  end;



//  btnDefaultStream.Enabled := False;
//  btnSaveStream.Enabled := False;
end;


procedure TfrmEditStations.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  EditStationsIsShow := False;
  FEditStations.Destroy;
end;

procedure TfrmEditStations.FormShow(Sender: TObject);
var
  i : Integer;
begin
  Icon := PluginSkin.EditStations.Icon;

  Color := frmBgColor;

  Caption := PLUGIN_NAME + ' | ' + LNG('FORM EditStations', 'Caption', 'Edit stations');

  gbStationsList.Caption     := LNG('FORM EditStations', 'Station.List', 'Stations List');
  btnStationAdd.Hint         := LNG('FORM EditStations', 'Station.Add', 'Add');
  btnStationRemove.Hint      := LNG('FORM EditStations', 'Station.Remove', 'Remove');
  btnImport.Caption          := LNG('FORM EditStations', 'Station.Import', 'Import...');
  btnExport.Caption          := LNG('FORM EditStations', 'Station.Export', 'Export...');

  lblStationName.Caption     := LNG('FORM EditStations', 'Station.Name', 'Name') + ':';
  lblStationGenre.Caption    := LNG('FORM EditStations', 'Station.Genre', 'Genre') + ':';
  lblStationLanguage.Caption := LNG('FORM EditStations', 'Station.Language', 'Language') + ':';
  lblStationWeb.Caption      := LNG('FORM EditStations', 'Station.Web', 'Web') + ':';
  lblStationGroup.Caption    := QIPPlugin.GetLang(LI_GROUP)+':';

  gbEditStation.Caption     := LNG('FORM EditStations', 'Caption', 'Edit stations');
  gbStreams.Caption         := LNG('FORM EditStations', 'Station.Streams', 'Streams');
  btnStreamAdd.Hint         := LNG('FORM EditStations', 'Station.Streams.Add', 'Add');
  btnStreamRemove.Hint      := LNG('FORM EditStations', 'Station.Streams.Remove', 'Remove');

  lvStreams.Column[0].Caption   := LNG('FORM EditStations', 'Station.Streams.Stream.LV.Format', 'Name');
  lvStreams.Column[1].Caption   := LNG('FORM EditStations', 'Station.Streams.Stream.LV.URL', 'URL');

  lblStreamFormat.Caption     := LNG('FORM EditStations', 'Station.Streams.Stream.Format', 'Format') + ':';
  lblStreamURL.Caption        := LNG('FORM EditStations', 'Station.Streams.Stream.URL', 'URL') + ':';

  btnSaveStream.Caption    := LNG('FORM EditStations', 'Station.Streams.Stream.Save', 'Save Stream');
  btnDefaultStream.Caption := LNG('FORM EditStations', 'Station.Streams.Stream.Default', 'Default');

  btnSave.Caption          := QIPPlugin.GetLang(LI_SAVE);
  btnOK.Caption            := QIPPlugin.GetLang(LI_OK);
  btnCancel.Caption        := QIPPlugin.GetLang(LI_CANCEL);


  btnStationAdd.Glyph        := ImageToBitmap(PluginSkin.ItemAdd.Image);
  btnStationRemove.Glyph     := ImageToBitmap(PluginSkin.ItemRemove.Image);
  btnStationUp.Glyph         := ImageToBitmap(PluginSkin.ItemUp.Image);
  btnStationDown.Glyph       := ImageToBitmap(PluginSkin.ItemDown.Image);

  btnStreamAdd.Glyph        := ImageToBitmap(PluginSkin.ItemAdd.Image);
  btnStreamRemove.Glyph     := ImageToBitmap(PluginSkin.ItemRemove.Image);
  btnStreamUp.Glyph         := ImageToBitmap(PluginSkin.ItemUp.Image);
  btnStreamDown.Glyph       := ImageToBitmap(PluginSkin.ItemDown.Image);

  LoadStations(Stations,'');

  i:=0;
  while ( i <= EqualizerPreset.Count - 1 ) do
  begin
    Application.ProcessMessages;

    //edtStationGenre.Items.Add(TEqPreset(EqualizerPreset.Objects[i]).Name);
    edtStationGenre.Items.Add(LNG('FORM Equalizer', 'Option.' + TEqPreset(EqualizerPreset.Objects[i]).Name, TEqPreset(EqualizerPreset.Objects[i]).Name));

    Inc(i);
  end;

  i:=0;
  while ( i <= Langs.Count - 1 ) do
  begin
    Application.ProcessMessages;

    edtStationLanguage.Items.Add( TLangs(Langs.Objects[i]).Trans );

    Inc(i);
  end;

  lvStations.ItemIndex := -1;

  if Stations.Count <> 0 then
    begin
      i:=0;
      while ( i <= Stations.Count - 1 ) do
        begin
          Application.ProcessMessages;

          lvStations.Items.Add;
          lvStations.Items.item[lvStations.Items.Count - 1].Caption := TStation(Stations.Objects[i]).Name;
          //            lvData.Items.item[lvData.Items.Count - 1].SubItems.Add( SQLTextToText( SQLtb.FieldAsString(SQLtb.FieldIndex['pubDate']) ) );

          Inc(i);
        end;

      lvStations.ItemIndex := 0;
    end;

  AddComments(FEditStations);
  EditStationsIsShow := True;
end;



procedure TfrmEditStations.lvStationsClick(Sender: TObject);
var
  Truth: boolean;
begin
  if (lvStations.ItemIndex = -1) then
    begin
      Truth := False;
      btnStationRemove.Enabled := Truth;
      btnStationUp.Enabled := Truth;
      btnStationDown.Enabled := Truth;
    end;
end;

procedure TfrmEditStations.lvStationsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if lvStations.ItemIndex <> -1 then
  begin
    gbEditStation.Enabled := True;
    ViewStationInfo(lvStations.ItemIndex);
    btnStationUp.Enabled := not (lvStations.ItemIndex = 0);
    btnStationDown.Enabled := not (lvStations.ItemIndex = lvStations.Items.Count - 1);
    lvStreams.Enabled := True;
  end
  else
  begin
    gbEditStation.Enabled := False;
  end;
end;


procedure TfrmEditStations.lvStreamsSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if lvStreams.ItemIndex <> -1 then
  begin
    ViewStreamInfo(lvStreams.ItemIndex);
    btnStreamUp.Enabled := not (lvStreams.ItemIndex = 0);
    btnStreamDown.Enabled := not (lvStreams.ItemIndex = lvStreams.Items.Count - 1);
  end;
end;


procedure TfrmEditStations.lvStreamsClick(Sender: TObject);
var
  Truth: boolean;
begin
  if (lvStreams.ItemIndex = -1) then
    begin
      Truth := False;
      btnSaveStream.Enabled := Truth;
      btnDefaultStream.Enabled := Truth;
      edtStreamFormat.Enabled := Truth;
      edtStreamURL.Enabled := Truth;
      btnStreamRemove.Enabled := Truth;
      btnStreamUp.Enabled := Truth;
      btnStreamDown.Enabled := Truth;
    end;
end;


end.

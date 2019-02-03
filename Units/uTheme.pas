unit uTheme;

interface

uses
  SysUtils, Classes, Dialogs, Graphics, Windows, Forms, ExtCtrls, Controls,
  fQIPPlugin, u_common, IniFiles;


type
  {Skin Pos }
  TSkin_Pos = record
    Left              : Integer;
    Top               : Integer;
    Right             : Integer;
    Bottom            : Integer;
  end;

  {Skin Font}
  TSkin_Font = record
    Name              : WideString;
    Size              : Integer;
    Style             : TFontStyles;
    Color             : WideString;//Integer;
  end;

  {Skin Text}
  TSkin_Text = record
    Show              : Boolean;
    Left              : Integer;
    Top               : Integer;
    Right             : Integer;
    Bottom            : Integer;
    Font              : TSkin_Font;
    TextAlign         : Integer;
  end;

  {Skin Icon}
  TSkin_Icon = record
    Left              : Integer;
    Top               : Integer;
    Picture           : TIcon;//TSkin_Picture;
  end;

  TImageIcon = record
  public
    Image             : TImage;
    Icon              : TIcon;
  end;

  {Skin State}
  TSkin_State = record
    First       : TSkin_Pos;
    Second      : TSkin_Pos;
    Third       : TSkin_Pos;
    PicturePlay     : TImageIcon;//TSkin_Picture;
    PictureStop     : TImageIcon;//TSkin_Picture;
    PicturePause    : TImageIcon;//TSkin_Picture;
    PictureRecord   : TImageIcon;//TSkin_Picture;
    PictureError    : TImageIcon;//TSkin_Picture;
  end;

  {Skin}
  TPluginTheme = record
    Name              : WideString;

    Height            : Integer;
    HeightInfo2       : Integer;

    Icon              : TSkin_Icon;
    Title             : TSkin_Text;

    Info              : TSkin_Text;
    Info2             : TSkin_Text;

    State             : TSkin_State;

  end;

  function SpecCntHeight : Integer;
  procedure OpenTheme;

var
  PluginTheme     : TPluginTheme;

implementation

uses General, Convs, uSuperReplace, uLNG, uIcon, uImage, TextSearch, uINI;


function SpecCntHeight : Integer;
begin
  if SpecCntShowLine2 = True then
    Result := PluginTheme.Height + PluginTheme.HeightInfo2
  else
    Result := PluginTheme.Height;
end;

procedure OpenTheme;

var
  INI : TIniFile;
  sString : AnsiString;
  hLibraryGraph : THandle;

begin

  if FileExists(PluginDllPath + 'Skins\' + PluginTheme.Name + '\skin.ini') = False then
    PluginTheme.Name := 'FMtune';


  INI := TiniFile.Create(PluginDllPath +
                         'Skins\' + PluginTheme.Name + '\skin.ini');

  PluginTheme.Height           := INIReadInteger(INI, 'Skin', 'Height', 19);
  PluginTheme.HeightInfo2      := INIReadInteger(INI, 'Skin', 'Height.Info2', 19);

  PluginTheme.Icon.Left        := INIReadInteger(INI, 'Skin', 'Icon.Left', 5);
  PluginTheme.Icon.Top         := INIReadInteger(INI, 'Skin', 'Icon.Top', 2);

  PluginTheme.Title.Show       := INIReadBool(INI, 'Skin', 'Title.Show', true);
  PluginTheme.Title.Left       := INIReadInteger(INI, 'Skin', 'Title.Left', 23);
  PluginTheme.Title.Top        := INIReadInteger(INI, 'Skin', 'Title.Top', 1);
  PluginTheme.Title.Right      := INIReadInteger(INI, 'Skin', 'Title.Right', -16);
  PluginTheme.Title.Bottom     := INIReadInteger(INI, 'Skin', 'Title.Bottom', -0);
  PluginTheme.Title.Font.Name  := INIReadStringUTF8(INI, 'Skin', 'Title.Font.Name', 'Tahoma');
  PluginTheme.Title.Font.Size  := INIReadInteger(INI, 'Skin', 'Title.Font.Size', 8);

  sString := INIReadStringUTF8(INI, 'Skin', 'Title.Font.Style', 'Bold;');
  PluginTheme.Title.Font.Style := [];
  if StrPosE(sString, 'Underline;', 1,False) <> 0 then
    PluginTheme.Title.Font.Style := PluginTheme.Title.Font.Style + [fsUnderline];
  if StrPosE(sString, 'Italic;', 1,False) <> 0 then
    PluginTheme.Title.Font.Style := PluginTheme.Title.Font.Style + [fsItalic];
  if StrPosE(sString, 'Bold;', 1,False) <> 0 then
    PluginTheme.Title.Font.Style := PluginTheme.Title.Font.Style + [fsBold];

  PluginTheme.Title.Font.Color :=            INIReadStringUTF8(INI, 'Skin', 'Title.Font.Color', 'NotInList');
  sString := AnsiUpperCase( INIReadStringUTF8(INI, 'Skin', 'Title.TextAlign', '') );
  if sString='LEFT' then
    PluginTheme.Title.TextAlign := DT_LEFT
  else if sString='RIGHT' then
    PluginTheme.Title.TextAlign := DT_RIGHT
  else if sString='CENTER' then
    PluginTheme.Title.TextAlign := DT_CENTER
  else
    PluginTheme.Title.TextAlign := DT_LEFT;


  PluginTheme.State.First.Right   := INIReadInteger(INI, 'Skin', 'State.First.Right', 16);
  //{}PluginTheme.State.First.Left    := INIReadInteger(INI, 'Skin', 'State.First.Left', -16);
  PluginTheme.State.First.Top     := INIReadInteger(INI, 'Skin', 'State.First.Top', 2);

  PluginTheme.State.Second.Right  := INIReadInteger(INI, 'Skin', 'State.Second.Right', 32);
  //{}PluginTheme.State.Second.Left   := INIReadInteger(INI, 'Skin', 'State.Second.Left', -32);
  PluginTheme.State.Second.Top    := INIReadInteger(INI, 'Skin', 'State.Second.Top', 2);

  PluginTheme.State.Third.Right    := INIReadInteger(INI, 'Skin', 'State.Third.Right', 48);
  //{}PluginTheme.State.Third.Left    := INIReadInteger(INI, 'Skin', 'State.Third.Left', -48);
  PluginTheme.State.Third.Top     := INIReadInteger(INI, 'Skin', 'State.Third.Top', 2);


  hLibraryGraph := LoadLibrary(PChar(PluginDllPath + 'Skins\' + PluginTheme.Name + '\graph.dll'));

  if hLibraryGraph = 0 then
  begin
    ShowMessage( TagsReplace( StringReplace(LNG('Texts', 'LibraryNotLoad', 'Can''t load library %file%.[br]Plugin can be unstable.'), '%file%', 'graph.dll', [rfReplaceAll, rfIgnoreCase]) ) );
    Exit;
  end;

  PluginTheme.Icon.Picture := LoadImageAsIconFromResource(10, hLibraryGraph);
  PluginTheme.State.PicturePlay.Image   := LoadImageFromResource(11, hLibraryGraph);
  PluginTheme.State.PicturePlay.Icon    := LoadImageAsIconFromResource(11, hLibraryGraph);

  PluginTheme.State.PictureStop.Image   := LoadImageFromResource(12, hLibraryGraph);
  PluginTheme.State.PictureStop.Icon    := LoadImageAsIconFromResource(12, hLibraryGraph);

  PluginTheme.State.PicturePause.Image  := LoadImageFromResource(13, hLibraryGraph);
  PluginTheme.State.PicturePause.Icon   := LoadImageAsIconFromResource(13, hLibraryGraph);

  PluginTheme.State.PictureRecord.Image := LoadImageFromResource(14, hLibraryGraph);
  PluginTheme.State.PictureRecord.Icon  := LoadImageAsIconFromResource(14, hLibraryGraph);

  PluginTheme.State.PictureError.Image  := LoadImageFromResource(15, hLibraryGraph);
  PluginTheme.State.PictureError.Icon   := LoadImageAsIconFromResource(15, hLibraryGraph);


  FreeLibrary(hLibraryGraph);


  PluginTheme.Info.Left       := INIReadInteger(INI, 'Skin', 'Info.Left', 75);
  PluginTheme.Info.Top        := INIReadInteger(INI, 'Skin', 'Info.Top', 0);
  PluginTheme.Info.Right      := INIReadInteger(INI, 'Skin', 'Info.Right', 0);
  PluginTheme.Info.Bottom     := INIReadInteger(INI, 'Skin', 'Info.Bottom', -0);
  PluginTheme.Info.Font.Name  := UTF82WideString( INIReadStringUTF8(INI, 'Skin', 'Info.Font.Name', 'Tahoma') );
  PluginTheme.Info.Font.Size  := INIReadInteger(INI, 'Skin', 'Info.Font.Size', 8);

  sString := INIReadStringUTF8(INI, 'Skin', 'Info.Font.Style', 'Italic;');
  PluginTheme.Info.Font.Style := [];
  if StrPosE(sString, 'Underline;', 1,False) <> 0 then
    PluginTheme.Info.Font.Style := PluginTheme.Info.Font.Style + [fsUnderline];
  if StrPosE(sString, 'Italic;', 1,False) <> 0 then
    PluginTheme.Info.Font.Style := PluginTheme.Info.Font.Style + [fsItalic];
  if StrPosE(sString, 'Bold;', 1,False) <> 0 then
    PluginTheme.Info.Font.Style := PluginTheme.Info.Font.Style + [fsBold];


  PluginTheme.Info.Font.Color :=            INIReadStringUTF8(INI, 'Skin', 'Info.Font.Color', 'NotInList');

  sString := AnsiUpperCase( INIReadStringUTF8(INI, 'Skin', 'Info.TextAlign', '') );
  if sString='LEFT' then
    PluginTheme.Info.TextAlign := DT_LEFT
  else if sString='RIGHT' then
    PluginTheme.Info.TextAlign := DT_RIGHT
  else if sString='CENTER' then
    PluginTheme.Info.TextAlign := DT_CENTER
  else
    PluginTheme.Info.TextAlign := DT_LEFT;


  PluginTheme.Info2.Left       := INIReadInteger(INI, 'Skin', 'Info2.Left', 0);
  PluginTheme.Info2.Top        := INIReadInteger(INI, 'Skin', 'Info2.Top', 20);
  PluginTheme.Info2.Right      := INIReadInteger(INI, 'Skin', 'Info2.Right', -0);
  PluginTheme.Info2.Bottom     := INIReadInteger(INI, 'Skin', 'Info2.Bottom', -0);
  PluginTheme.Info2.Font.Name  := INIReadStringUTF8(INI, 'Skin', 'Info2.Font.Name', 'Tahoma');
  PluginTheme.Info2.Font.Size  := INIReadInteger(INI, 'Skin', 'Info2.Font.Size', 8);

  sString := INIReadStringUTF8(INI, 'Skin', 'Info2.Font.Style', 'Italic;');
  PluginTheme.Info2.Font.Style := [];
  if StrPosE(sString, 'Underline;', 1,False) <> 0 then
    PluginTheme.Info2.Font.Style := PluginTheme.Info2.Font.Style + [fsUnderline];
  if StrPosE(sString, 'Italic;', 1,False) <> 0 then
    PluginTheme.Info2.Font.Style := PluginTheme.Info2.Font.Style + [fsItalic];
  if StrPosE(sString, 'Bold;', 1,False) <> 0 then
    PluginTheme.Info2.Font.Style := PluginTheme.Info2.Font.Style + [fsBold];

  PluginTheme.Info2.Font.Color :=            INIReadStringUTF8(INI, 'Skin', 'Info2.Font.Color', 'NotInList');
  sString := AnsiUpperCase( INIReadStringUTF8(INI, 'Skin', 'Info2.TextAlign', '') );
  if sString='LEFT' then
    PluginTheme.Info2.TextAlign := DT_LEFT
  else if sString='RIGHT' then
    PluginTheme.Info2.TextAlign := DT_RIGHT
  else if sString='CENTER' then
    PluginTheme.Info2.TextAlign := DT_CENTER
  else
    PluginTheme.Info2.TextAlign := DT_LEFT;

  INIFree(INI);

end;

end.

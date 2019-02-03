unit uNowPlaying;

interface

uses
  SysUtils, Classes, Dialogs, Graphics, Windows, Forms, ExtCtrls, Controls,
  fQIPPlugin, u_common, IniFiles,
  DownloadFile, TextSearch, Convs;

  function GetNowPlaying(sURL: WideString): WideString;
  function GetNP_playcz(sStation : WideString): WideString;
  function GetNP_abradiocz(sURL : WideString): WideString;
  function GetNP_other(sURL : WideString): WideString;

  function DownloadCover(URL, Cover: WideString): Boolean;

var
  LoadNowPlayingThread : DWORD = 0;

implementation

uses
  General, uFileFolder;

function If_IsURL(sURL : WideString; sKnownURL: WideString; var Radio: String) : Boolean;
var
  sText: String;
  I, PrvniCislo: Integer;
begin

  if AnsiUpperCase(Copy(sURL,1, length(sKnownURL)))= AnsiUpperCase(sKnownURL) then
    Result := True
  else
    Result := False;


  if Result then
  begin

    // Optimalizováno pro server play.cz
    PrvniCislo := 0;

    sText := FoundStr(sURL+'$', sKnownURL, '$', 1); // vrací soubor rádia (napø.: evropa2-128.asx)

    for I := 0 to Length(sText) - 1 do
    begin

      if (sText[I] in ['1'..'9']) and (PrvniCislo = 0) then
        PrvniCislo := I;

      if (sText[I] in ['-']) and (sText[I+1] in ['1'..'9']) then
      // po nalezní pomlèky smaž '-128.asx' z 'evropa2-128.asx'
      begin
        iBitrate := Copy(sText, I, Length(sText) - I + 1);
        iBitrate := FoundStr(iBitrate, '-', '.', 1);
        Delete(sText, I, Length(sText) - I + 1);
        Break;
      end;

      if (sText[I] in ['/']) and (sText[I+1] in ['1'..'9']) then
      // po nalezní lomítka smaž '/128.asx' z 'evropa2/128.asx'
      begin
        iBitrate := Copy(sText, I, Length(sText) - I + 1);
        iBitrate := FoundStr(iBitrate, '/', '.', 1);
        Delete(sText, I, Length(sText) - I + 1);
        Break;
      end;

      if sText[I] in ['.'] then
      // po nalezení teèky smaž '128.asx' z 'blanik128.asx'
      begin
        try
          iBitrate := IntToStr( StrToInt( Copy(sText, PrvniCislo, I - PrvniCislo) ) ); // test, zda se jedná o èíslo
        except
          iBitrate := '???';
        end;
        Delete(sText, PrvniCislo, Length(sText) - PrvniCislo + 1);
        Break;
      end;

    end;

    Radio := sText;
    // -

  end;

end;


function GetNowPlaying(sURL: WideString): WideString;
var
  Radio: String;
begin

  // ****************** \\
  //      PLAY.CZ       \\
  // ****************** \\
  // Výjimky
  if If_IsURL(sURL, 'http://www.play.cz/radio/bonart', Radio) then
    Result := GetNP_playcz('bonartmulti')
  else if If_IsURL(sURL, 'http://www.play.cz/radio/radiospin', Radio) then
    Result := GetNP_playcz('spin')
  else if If_IsURL(sURL, 'http://www.play.cz/radio/countryradio', Radio) then
    Result := GetNP_playcz('country')
  // -
    //songster:
  else if If_IsURL(sURL, 'http://www.play.cz/radio/frekvence1', Radio) then
    Result := GetNP_other('http://songster.rmc.fg.cz/xml/frekvence1.xml')
{  else if If_IsURL(sURL, 'http://www.play.cz/radio/evropa2', Radio) then
    Result := GetNP_other('http://songster.rmc.fg.cz/xml/evropa2.xml')}
  else if If_IsURL(sURL, 'http://www.play.cz/radio/evropa2heavy', Radio) then
    Result := GetNP_other('http://www.evropa2.cz/flash-heavy.xml')
  else if If_IsURL(sURL, 'http://www.play.cz/radio/evropa2movin', Radio) then
    Result := GetNP_other('http://www.evropa2.cz/flash-movin.xml')
  else if If_IsURL(sURL, 'http://www.play.cz/radio/evropa2retro', Radio) then
    Result := GetNP_other('http://www.evropa2.cz/flash-retro.xml')
  else if If_IsURL(sURL, 'http://www.play.cz/radio/evropa2top40', Radio) then
    Result := GetNP_other('http://www.evropa2.cz/flash-top40.xml')
  else if If_IsURL(sURL, 'http://www.play.cz/radio/evropa2lowrider', Radio) then
    Result := GetNP_other('http://www.evropa2.cz/flash-lowrider.xml')
  //- Vyjimky, ktere nenacita jako play.cz
  else if If_IsURL(sURL, 'http://www.play.cz/radio/evropa2', Radio) then
    //Result := GetNP_other('http://songster.rmc.fg.cz/xml/evropa2.xml')
    Result := GetNP_other('http://www.evropa2.cz/cs/_inc/songster.html')
    //Result := GetNP_other('http://panther7.ic.cz/songster.html')
  else if If_IsURL(sURL, 'http://www.play.cz/radio/expres', Radio) then
    Result := GetNP_other('http://servis.idnes.cz/js/xmltojson.asp?pthXml=data/xml/expresradio.xml')
  //-
  else if If_IsURL(sURL, 'http://www.play.cz/radio/', Radio) then
    Result := GetNP_playcz(Radio)

  // ****************** \\
  //    ABRADIO.CZ      \\
  // ****************** \\
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/atr', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.2:20000/MYRADIO5.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/myabradio5', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.2:20000/MYRADIO5.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/club', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.3:20000/clubbeat.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/cshity', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.5:20000/cshity.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/danceradio', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.9:20000/danceradio.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/dnbradio', Radio) then
    Result := GetNP_abradiocz('http://217.11.251.154:20000/NowOnAir.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/freestyle', Radio) then
    Result := GetNP_abradiocz('http://robot1.limemedia.cz:20000/8030.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/house', Radio) then
    Result := GetNP_abradiocz('http://robot1.limemedia.cz:20000/8130.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/heybrno', Radio) then
    Result := GetNP_abradiocz('http://www.radiohey.cz/pravehraje-brno/data.php')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/heyostrava', Radio) then
    Result := GetNP_abradiocz('http://www.radiohey.cz/pravehraje-brno/data.php')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/hiphopvibesradio', Radio) then
    Result := GetNP_abradiocz('http://robot1.limemedia.cz:20000/8260.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/myabradio17', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.4:20000/myabradio17.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/myabradio51', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.4:20000/myabradio51.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/myabradio10', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.2:20000/MYRADIO10.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/polishradiolondon', Radio) then
    Result := GetNP_abradiocz('http://www.prl24.net/rds/prl24.xml')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/myabradio25', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.2:20000/MYRADIO25.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/bestofrock', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.5:20000/bestofrock.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/bigbeat', Radio) then
    Result := GetNP_abradiocz('http://robot4.limemedia.cz:20000/8620.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/blues', Radio) then
    Result := GetNP_abradiocz('http://robot2.limemedia.cz:20000/8100.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/celtic', Radio) then
    Result := GetNP_abradiocz('http://robot4.limemedia.cz:20000/8260.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/clickandcountry', Radio) then
    Result := GetNP_abradiocz('http://90.183.101.199:20000/playingnow.html')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/country', Radio) then
    Result := GetNP_abradiocz('http://robot2.limemedia.cz:20000/8050.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/depechemode', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.3:20000/depeche.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/myabradio35', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.4:20000/myabradio35.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/domino', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.2:20000/MYRADIO14.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/downtempo', Radio) then
    Result := GetNP_abradiocz('http://82.208.28.35:20000/8140.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/drak', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.5:20000/drak.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/etno', Radio) then
    Result := GetNP_abradiocz('http://robot4.limemedia.cz:20000/8040.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/folk', Radio) then
    Result := GetNP_abradiocz('http://folk.limemedia.cz:20000/jozincz.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/hit', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.5:20000/hit.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/humor', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.3:20000/humor.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/chillout', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.5:20000/chillout.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/insane', Radio) then
    Result := GetNP_abradiocz('http://www.radioinsane.cz/NowPlaying/np.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/jazz', Radio) then
    Result := GetNP_abradiocz('http://robot4.limemedia.cz:20000/8540.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/myabradio42', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.4:20000/myabradio42.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/latino', Radio) then
    Result := GetNP_abradiocz('http://robot4.limemedia.cz:20000/8070.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/madonna', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.3:20000/madonna.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/metallica', Radio) then
    Result := GetNP_abradiocz('http://robot3.limemedia.cz:20000/8000.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/metal', Radio) then
    Result := GetNP_abradiocz('http://robot2.limemedia.cz:20000/8070.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/oldiespop', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.5:20000/oldiespop.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/oldiesrock', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.5:20000/oldiesrock.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/pohadka', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.3:20000/pohadka.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/pop90', Radio) then
    Result := GetNP_abradiocz('http://217.11.251.145:20000/8120.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/queen', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.3:20000/queen.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/rock80', Radio) then
    Result := GetNP_abradiocz('http://robot2.limemedia.cz:20000/8200.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/rock90', Radio) then
    Result := GetNP_abradiocz('http://217.11.251.145:20000/8220.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/energie', Radio) then
    Result := GetNP_abradiocz('http://robot4.limemedia.cz:20000/8300.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/roxette', Radio) then
    Result := GetNP_abradiocz('http://217.11.251.146:20000/8380.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/myabradio59', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.4:20000/myabradio59.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/soucasnyrock', Radio) then
    Result := GetNP_abradiocz('http://robot2.limemedia.cz:20000/8010.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/soundtrack', Radio) then
    Result := GetNP_abradiocz('http://robot4.limemedia.cz:20000/8330.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/pop80.asx', Radio) then
    Result := GetNP_abradiocz('http://robot2.limemedia.cz:20000/8220.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/balbinka', Radio) then
    Result := GetNP_abradiocz('http://robot4.limemedia.cz:20000/8320.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/swing', Radio) then
    Result := GetNP_abradiocz('http://robot4.limemedia.cz:20000/8250.txt')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/u2', Radio) then
    Result := GetNP_abradiocz('http://78.24.10.3:20000/u2.rds')
  else if If_IsURL(sURL, 'http://www.abradio.cz/asx/rnbstyle', Radio) then
    Result := GetNP_abradiocz('http://robot1.limemedia.cz:20000/8100.txt')
  ;


  // ****************** \\
  //      OSTATNÍ       \\
  // ****************** \\
  if If_IsURL(sURL, 'http://85.248.7.162', Radio) then // Rádio Expres SK
    Result := GetNP_other('http://www.expres.sk/now_playing.html')
  ;



  if (iSong <> Result) and ShowCover then // pokud se zmìnila písnièka a je povoleno zobrazování...
  begin

    if FoundStr(sURL,'evropa2','.',1) <> '' then
    begin
      DownloadCover('http://songster.rmc.fg.cz/data/sharedfiles/top40/covers/', iCover)
    end
    else
    begin
      DownloadCover('http://songster.rmc.fg.cz/img/u/', iCover) // ...aktualizuj i cover
    end;

  end;

end;


function DownloadCover(URL, Cover: WideString): Boolean;
const
  FileFormat : WideString = '.jpg';
  FileName   : WideString = 'cover';
  TempDir    : WideString = '[tmp]\';
var
  poshtml  : TPositionInfo;
  HTMLData : TResultData;
  F        : TextFile;
  FullPath : WideString;
label
  Stahuj;
begin

  if SaveCover then
    FullPath := PluginDllPath + TempDir + FileName + Cover + FileFormat
  else
  begin
    FullPath := PluginDllPath + TempDir + 'last_' + FileName + FileFormat;
    DeleteFileIfExists(FullPath);
  end;

  HTMLData.OK := False;

  if (not FileExists(FullPath)) and (Cover <> '') then
  begin
    Stahuj:
    try
      HTMLData := GetHTML(URL + Cover + FileFormat, '','', 5000, NO_CACHE, poshtml);
    except

    end;
  end;

  if HTMLData.OK = True then
  begin
    if CreateFolderIfNotExists(ExtractFilePath(FullPath)) then
    begin
      AssignFile(F, FullPath);
      Rewrite(F);
      Write(F,HTMLData.parString);
      if FileSize(F) = 0 then
      begin
        CloseFile(F);
        GoTo Stahuj;
      end;
      CloseFile(F);
    end;
  end;



  Result := FileExists(FullPath);

  CoverFile := FullPath;
end;


function GetNP_playcz(sStation : WideString): WideString;
var
  poshtml : TPositionInfo;
  HTMLData : TResultData;
  r : Integer;
begin
  Result := '';

  HTMLData := GetHTML('http://62.44.1.24/txt/'+sStation+'.txt' ,'', '', 1000, NO_CACHE, poshtml);

  if HTMLData.OK = True then
  begin
    if Copy(HTMLData.parString,1,length('<!DOCTYPE html PUBLIC'))<>'<!DOCTYPE html PUBLIC' then
    begin
      r := StrPosE(HTMLData.parString,'</strong>',1,false);
      Result := Trim(Copy(HTMLData.parString,r+9));
      Result := UTF82WideString(Result);
      // doèasné øešení:
      Result := StringReplace(Result, 'Â´', '''', [rfReplaceAll]);
      Result := StringReplace(Result, '&amp;', '&', [rfReplaceAll]);
      // -
    end;
  end;

end;


function GetNP_abradiocz(sURL : WideString): WideString;
var
  poshtml : TPositionInfo;
  HTMLData : TResultData;
  slLines : TStringList;
begin
  Result := '';

  HTMLData := GetHTML(sURL ,'', '', 2000, NO_CACHE, poshtml);

  if HTMLData.OK = True then
  begin
    if Copy(HTMLData.parString,1,length('<!DOCTYPE html PUBLIC'))<>'<!DOCTYPE html PUBLIC' then
    begin
      if AnsiUpperCase(Copy(sURL, Length(sURL)-Length('.rds')+1)) = '.RDS' then
        Result := HTMLData.parString
      else if AnsiUpperCase(Copy(sURL, Length(sURL)-Length('data.php')+1)) = 'DATA.PHP' then
      begin
        slLines := TStringList.Create;
        slLines.Text := HTMLData.parString;

        if slLines.Count-1 >= 2 then
          Result := slLines.Strings[2] + ' - ' + slLines.Strings[0];
      end
      else if AnsiUpperCase(Copy(sURL, Length(sURL)-Length('np.txt')+1)) = 'NP.TXT' then
      begin
        slLines := TStringList.Create;
        slLines.Text := HTMLData.parString;

        if slLines.Count-1 >= 1 then
          Result := slLines.Strings[0] + ' - ' + slLines.Strings[1];
      end
      else if AnsiUpperCase(Copy(sURL, Length(sURL)-Length('.txt')+1)) = '.TXT' then
      begin
        slLines := TStringList.Create;
        slLines.Delimiter := ';';
        slLines.DelimitedText := HTMLData.parString;

        if slLines.Count-1 >= 4 then
          Result := slLines.Strings[4] + ' - ' + slLines.Strings[3]

      end
      else if AnsiUpperCase(Copy(sURL, Length(sURL)-Length('.xml')+1)) = '.XML' then
      begin
        Result := FoundStr(HTMLData.parString,'<Artist name="','">',1);

        if Result <> '' then
          Result := Result + ' - ';

        Result := Result + FoundStr(HTMLData.parString,'<Song title="','">',1);
      end
      else
        Result := HTMLData.parString;

    end;
  end;

end;

function GetNP_other(sURL : WideString): WideString;
var
  poshtml : TPositionInfo;
  HTMLData : TResultData;
  slLines : TStringList;
  sTmpText : WideString;
begin
  Result := '';

  HTMLData := GetHTML(sURL ,'', '', 2000, NO_CACHE, poshtml);

  if HTMLData.OK = True then
  begin
    if Copy(HTMLData.parString,1,length('<!DOCTYPE html PUBLIC'))<>'<!DOCTYPE html PUBLIC' then
    begin
      // Rádio Expres SK
      if AnsiUpperCase(Copy(sURL, Length(sURL)-Length('www.expres.sk/now_playing.html')+1)) = 'WWW.EXPRES.SK/NOW_PLAYING.HTML' then
      begin
        Result := FoundStr(HTMLData.parString,'<message>','</message>',1);
      end

      // Evropa 2 CZ
      else if AnsiUpperCase(Copy(sURL, Length(sURL)-Length('songster.html')+1)) = 'SONGSTER.HTML' then
      begin
        Result := UTF82WideString( FoundStr(HTMLData.parString,'<!--JSTIT:','-->',1) );

        if Result <> '' then
          Result := ' - ' + Result;

        Result := UTF82WideString( FoundStr(HTMLData.parString,'<!--JS:','-->',1) ) + Result;

        iCover := UTF82WideString( FoundStr(HTMLData.parString,'<!--JSCO:','-->',1) );
      end

      //songster: Evropa 2 a další podrádia
      else if AnsiUpperCase(Copy(sURL, Length(sURL)-Length('.xml')+1)) = '.XML' then
      begin
        sTmpText := UTF82WideString( FoundStr(HTMLData.parString,'<playing>','</playing>',1) );

        iCover := FoundStr(sTmpText,'<cover>','</cover>',1);
        if iCover = 'NULL' then
          iCover := '';

        Result := FoundStr(sTmpText,'<title><![CDATA[',']]></title>',1);

        if Result <> '' then
          Result := ' - ' + Result;

        Result := FoundStr(sTmpText,'<artist><![CDATA[',']]></artist>',1) + Result;
      end

      // Expres Rádio CZ
      else if AnsiUpperCase(Copy(sURL, Length(sURL)-Length('expresradio.xml')+1)) = 'EXPRESRADIO.XML' then
      begin
        slLines := TStringList.Create;
        slLines.Text := HTMLData.parString;

        if slLines.Count-1 >= 8 then
          Result := FoundStr(slLines.Strings[7],'"','"',1) + ' - ' + FoundStr(slLines.Strings[8],'"','"',1);
      end

      else
        Result := HTMLData.parString;

    end;
  end;

end;


end.

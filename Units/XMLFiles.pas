unit XMLFiles;

interface

uses SysUtils, Classes, Windows, Forms, Dialogs;

type

  { XML Attrs }
  TXMLAttrs = class
  public
    dataWideString : WideString;
  end;

  function GetAttrs(Name: WideString; Attrs: TStringList): WideString;


  procedure LoadXMLStations(sFileName : String; DATA : TStringList);


implementation

uses LibXmlParser, General, Convs;

(*
===============================================================================================
TElementNode
===============================================================================================
*)

TYPE
  TElementNode = CLASS
                   Content : AnsiString;
                   Attr    : TStringList;
                   CONSTRUCTOR Create (TheContent : RawByteString; TheAttr : TNvpList);
                   DESTRUCTOR Destroy; OVERRIDE;
                 END;

CONSTRUCTOR TElementNode.Create (TheContent : RawByteString; TheAttr : TNvpList);
VAR
  I : INTEGER;
BEGIN
  INHERITED Create;
  Content := TheContent;
  Attr    := TStringList.Create;
  IF TheAttr <> NIL THEN
    FOR I := 0 TO TheAttr.Count-1 DO
      Attr.Add (TNvpNode (TheAttr [I]).Name + '=' + TNvpNode (TheAttr [I]).Value);
END;


DESTRUCTOR TElementNode.Destroy;
BEGIN
  Attr.Free;
  INHERITED Destroy;
END;

////////////////////////////////////////////////////////////////////////////////

function GetAttrs(Name: WideString; Attrs: TStringList): WideString;
var
  idx : Integer;
begin
  idx := Attrs.IndexOf(name);
  if idx <> -1 then
   Result := TXMLAttrs(Attrs.Objects[idx]).dataWideString;
end;

////////////////////////////////////////////////////////////////////////////////

procedure LoadXMLStations(sFileName : String; DATA : TStringList);
var
  XmlParser   : TXmlParser;
  sn          : RawByteString;
  EN          : TElementNode;

  idxItem, idxStream : Integer;
//  F, F2: TextFile;
  bNewFormat : Boolean;

  procedure CommandXML(sCommand: RawByteString; sValue: RawByteString; Attrs: TStringList; bAttrs: Boolean);
  var
    ix : Integer;
  begin
//showmessage(sCommand + #13 + sValue);
    application.ProcessMessages;
{
      writeln(F,sCommand + ' >>> ' + sValue);


      for ix := 0 to Attrs.Count - 1 do
      begin

        writeln(F, '>' + Attrs.Strings[ix] + ' >>> ' + TXMLAttrs(Attrs.Objects[ix]).dataWideString );

      end;
               }
    if (sCommand = 'CODEPAGE') and (sValue = 'UTF-8') then
    begin
      bNewFormat := True;
    end;

    if bNewFormat=True then
    begin
      if sCommand = '/stationslist/station' then
      begin
        DATA.Add('ITEM');
        idxItem:= DATA.Count - 1;
        DATA.Objects[idxItem] := TStation.Create;
        TStation(DATA.Objects[idxItem]).Name     := UTF82WideString({MIMEBase64Decode(}GetAttrs('name', Attrs){)});
        TStation(DATA.Objects[idxItem]).Genre    := UTF82WideString({MIMEBase64Decode(}GetAttrs('genre', Attrs){)});
        TStation(DATA.Objects[idxItem]).Language := UTF82WideString({MIMEBase64Decode(}GetAttrs('language', Attrs){)});
        TStation(DATA.Objects[idxItem]).URL      := UTF82WideString({MIMEBase64Decode(}GetAttrs('url', Attrs){)});
        TStation(DATA.Objects[idxItem]).Group    := UTF82WideString({MIMEBase64Decode(}GetAttrs('group', Attrs){)});

        TStation(DATA.Objects[idxItem]).Streams := TStringList.Create;
        TStation(DATA.Objects[idxItem]).Streams.Clear;

{        writeln(F2,'--- station ---');
        writeln(F2,UTF82WideString(GetAttrs('name', Attrs)));
        writeln(F2,UTF82WideString(GetAttrs('genre', Attrs)));
        writeln(F2,UTF82WideString(GetAttrs('language', Attrs)));
        writeln(F2,UTF82WideString(GetAttrs('url', Attrs)));
        writeln(F2,UTF82WideString(GetAttrs('group', Attrs))); }
      end;

      if sCommand = '/stationslist/station/streams' then
      begin
        TStation(DATA.Objects[idxItem]).DefaultStream := ConvStrToInt( GetAttrs('default', Attrs) );
{        writeln(F2,GetAttrs('default', Attrs));}
      end;

      if sCommand = '/stationslist/station/streams/stream' then
      begin
        TStation(DATA.Objects[idxItem]).Streams.Add('STREAM');
        idxStream:= TStation(DATA.Objects[idxItem]).Streams.Count - 1;
        TStation(DATA.Objects[idxItem]).Streams.Objects[idxStream] := TStream.Create;
        TStream(TStation(DATA.Objects[idxItem]).Streams.Objects[idxStream]).Format := UTF82WideString({MIMEBase64Decode(}GetAttrs('format', Attrs){)});
        TStream(TStation(DATA.Objects[idxItem]).Streams.Objects[idxStream]).URL    :=  UTF82WideString({MIMEBase64Decode(}GetAttrs('url', Attrs){)});

{        writeln(F2,'--- stream ---');
        writeln(F2,UTF82WideString(GetAttrs('format', Attrs)));
        writeln(F2,UTF82WideString( sValue ));}
      end;

    end
    else
    begin
      if (sCommand = 'BEGIN') and (sValue = '/Station') then
      begin
        DATA.Add('ITEM');
        idxItem:= DATA.Count - 1;
        DATA.Objects[idxItem] := TStation.Create;
        TStation(DATA.Objects[idxItem]).Name     := '';
        TStation(DATA.Objects[idxItem]).Genre    := '';
        TStation(DATA.Objects[idxItem]).Language := '';
        TStation(DATA.Objects[idxItem]).URL      := '';

        TStation(DATA.Objects[idxItem]).Streams := TStringList.Create;
        TStation(DATA.Objects[idxItem]).Streams.Clear;

//        writeln(F2,'--- station ---');
      end;

      if (sCommand = 'BEGIN') and (sValue = '/Station/Stream') then
      begin
        TStation(DATA.Objects[idxItem]).Streams.Add('STREAM');
        idxStream:= TStation(DATA.Objects[idxItem]).Streams.Count - 1;
        TStation(DATA.Objects[idxItem]).Streams.Objects[idxStream] := TStream.Create;
        TStream(TStation(DATA.Objects[idxItem]).Streams.Objects[idxStream]).Format := '';
        TStream(TStation(DATA.Objects[idxItem]).Streams.Objects[idxStream]).URL    := '';

//        writeln(F2,'--- stream ---');
      end;

      if sCommand = '/Station/Name' then
      begin
        TStation(DATA.Objects[idxItem]).Name         := UTF82WideString( sValue );
//        writeln(F2,UTF82WideString( sValue ));
      end
      else if sCommand = '/Station/Genre' then
      begin
        TStation(DATA.Objects[idxItem]).Genre         := UTF82WideString( sValue );
//        writeln(F2,UTF82WideString( sValue ));
      end
      else if sCommand = '/Station/Language' then
      begin
        TStation(DATA.Objects[idxItem]).Language         := UTF82WideString( sValue );
//        writeln(F2,UTF82WideString( sValue ));
      end
      else if sCommand = '/Station/URL' then
      begin
        TStation(DATA.Objects[idxItem]).URL         := UTF82WideString( sValue );
//        writeln(F2,UTF82WideString( sValue ));
      end
      else if sCommand = '/Station/Group' then
      begin
        TStation(DATA.Objects[idxItem]).Group         := UTF82WideString( sValue );
//        writeln(F2,UTF82WideString( sValue ));
      end
      else if sCommand = '/Station/DefaultStream' then
      begin
        TStation(DATA.Objects[idxItem]).DefaultStream := ConvStrToInt( UTF82WideString( sValue ) );
//        writeln(F2,UTF82WideString( sValue ));
      end

      else if sCommand = '/Station/Stream/Format' then
      begin
        TStream(TStation(DATA.Objects[idxItem]).Streams.Objects[idxStream]).Format := UTF82WideString( sValue );
//        writeln(F2,UTF82WideString( sValue ));
      end
      else if sCommand = '/Station/Stream/URL' then
      begin
        TStream(TStation(DATA.Objects[idxItem]).Streams.Objects[idxStream]).URL := UTF82WideString( sValue );
//        writeln(F2,UTF82WideString( sValue ));
      end;
    ;
    end;
    Attrs.Clear;
  end;

  procedure ReadItemXML(s: RawByteString);
  var ii: Integer;
      sAttrs : TStringList;
      hIndex1: Integer;
  begin

    sAttrs := TStringList.Create;
    sAttrs.Clear;

    while XmlParser.Scan do
    begin
      case XmlParser.CurPartType of
        ptXmlProlog : begin
                        CommandXML( 'CODEPAGE' ,XmlParser.CurEncoding, sAttrs, False);
                      end;
        ptDtdc      : begin
                      end;
        ptStartTag,
        ptEmptyTag  : begin
                        if XmlParser.CurAttr.Count > 0 then
                        begin
                          sn:= s + '/' + XmlParser.CurName ;

                          EN := TElementNode.Create ('', XmlParser.CurAttr);

                          sAttrs.Clear;

                          for Ii := 0 TO EN.Attr.Count-1 do
                          begin

                            sAttrs.Add( Trim( EN.Attr.Names [Ii] ) );
                            hIndex1:= sAttrs.Count - 1;
                            sAttrs.Objects[hIndex1] := TXMLAttrs.Create;
                            TXMLAttrs(sAttrs.Objects[hIndex1]).dataWideString := Trim( EN.Attr.Values [EN.Attr.Names [Ii]]);

                          end;

                          CommandXML( sn, '', sAttrs, True );

                          sAttrs.Clear;

                        end;

                        if XmlParser.CurPartType = ptStartTag then   // Recursion
                        begin
                          sn:= s + '/' + XmlParser.CurName ;

                          CommandXML('BEGIN' , sn, sAttrs, False );

                          ReadItemXML (sn);
                        end

                      end;
        ptEndTag    : begin
                        CommandXML('END' , s, sAttrs, False );
                        BREAK;
                      end;
        ptContent,
        ptCData     : begin
                        if Trim( XmlParser.CurContent)='' then

                        else
                        begin
                          CommandXML( s , Trim( XmlParser.CurContent ), sAttrs, False );
                        end;

                      end;
        ptComment   : begin
                      end;
        ptPI        : begin
                      end;

      end;

    end;

  end;

begin

(*
  if Copy(sXMLText,1,3) = 'ï»¿' then
    sXMLText := Copy(sXMLText,4);

  if (Copy(sXMLText,1,5) <> '<?xml') then  // neplatny XML soubor
  begin
    ShowMessage('Neplatný XML soubor');
    Exit;
  end;             *)

{ AssignFile(F2, ExtractFilePath( PluginDllPath) + '\stanice.txt');
  Rewrite(F2);}

{ AssignFile(F, ExtractFilePath( PluginDllPath) + '\xml.txt');
  Rewrite(F);}

  bNewFormat := False;

  XmlParser := TXmlParser.Create;

  XmlParser.LoadFromFile(sFileName);
//  XmlParser.LoadFromBuffer(  PAnsiChar( sXMLText )  );

  XmlParser.StartScan;
  XmlParser.Normalize := FALSE;

  ReadItemXML('');


  XmlParser.Free;
{
  CloseFile(F);}

{  CloseFile(F2);}

end;



end.


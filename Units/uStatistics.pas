unit uStatistics;

interface

uses
  SysUtils, Classes, Forms, Dialogs, fQIPPlugin;

  procedure Statistics_PlayCount_Add(sURL: WideString);
  procedure Statistics_PlayTime_Add(sURL: WideString; var iTime: Real);
  procedure GetStatistics;
  function SortStationsPlayCount( list: TStringList ): TStringList;
  function SortStationsPlayTime( list: TStringList ): TStringList;

var
  StatisticsRadioTime : Real;

implementation

uses General, Convs, IniFiles, uBase64, uTime, uINI;


procedure Statistics_PlayCount_Add(sURL: WideString);
var INI: TINIFile;
    sURLBase64: RawByteString;
    iPlayCount: Int64;
    idx1, idx2: Int64;
begin
  sURLBase64 := MIMEBase64Encode(WideString2UTF8(sURL));

  INIGetProfileStatistic(INI);
  iPlayCount := INIReadInteger(INI, sURLBase64, 'PlayCount', 0);
  INIWriteInteger(INI, sURLBase64, 'PlayCount', iPlayCount + 1);
  INIFree(INI);

  idx1:=0;
  while ( idx1 <= Stations.Count - 1 ) do
  begin
    Application.ProcessMessages;

    idx2:=0;
    while ( idx2 <= TStation(Stations.Objects[idx1]).Streams.Count - 1 ) do
    begin
      Application.ProcessMessages;

      if sURL = TStream(TStation(Stations.Objects[idx1]).Streams.Objects[idx2]).URL then
      begin
        Inc(TStream(TStation(Stations.Objects[idx1]).Streams.Objects[idx2]).PlayCount);
        Inc(TStation(Stations.Objects[idx1]).PlayCount);
      end;

      Inc(idx2);
    end;

    Inc(idx1);
  end;

end;

procedure Statistics_PlayTime_Add(sURL: WideString; var iTime: Real);
var INI: TINIFile;
    sURLBase64: RawByteString;
    iPlayTime: Int64;
    idx1, idx2: Int64;
begin

  sURLBase64 := MIMEBase64Encode(WideString2UTF8(sURL));
  INIGetProfileStatistic(INI);
  iPlayTime := INIReadInteger(INI, sURLBase64, 'PlayTime', 0);
  INIWriteInteger(INI, sURLBase64, 'PlayTime', iPlayTime + Trunc(iTime));
  INIFree(INI);

  idx1:=0;
  while ( idx1 <= Stations.Count - 1 ) do
  begin
    Application.ProcessMessages;

    idx2:=0;
    while ( idx2 <= TStation(Stations.Objects[idx1]).Streams.Count - 1 ) do
    begin
      Application.ProcessMessages;

      if sURL = TStream(TStation(Stations.Objects[idx1]).Streams.Objects[idx2]).URL then
      begin
        Inc(TStream(TStation(Stations.Objects[idx1]).Streams.Objects[idx2]).PlayTime, Trunc(iTime));
        Inc(TStation(Stations.Objects[idx1]).PlayTime, Trunc(iTime));
      end;

      Inc(idx2);
    end;

    Inc(idx1);
  end;

  iTime := 0;
end;

procedure GetStatistics;
var INI: TINIFile;
    sURLBase64: RawByteString;
    idx1, idx2: Int64;

begin

  INIGetProfileStatistic(INI);

  idx1:=0;
  while ( idx1 <= Stations.Count - 1 ) do
  begin
    Application.ProcessMessages;

    TStation(Stations.Objects[idx1]).PlayCount := 0;

    idx2:=0;
    while ( idx2 <= TStation(Stations.Objects[idx1]).Streams.Count - 1 ) do
    begin
      Application.ProcessMessages;

      sURLBase64 := MIMEBase64Encode(WideString2UTF8( TStream(TStation(Stations.Objects[idx1]).Streams.Objects[idx2]).URL ));
      TStream(TStation(Stations.Objects[idx1]).Streams.Objects[idx2]).PlayCount := INIReadInteger(INI, sURLBase64, 'PlayCount', 0);
      Inc(TStation(Stations.Objects[idx1]).PlayCount, TStream(TStation(Stations.Objects[idx1]).Streams.Objects[idx2]).PlayCount);

      TStream(TStation(Stations.Objects[idx1]).Streams.Objects[idx2]).PlayTime := INIReadInteger(INI, sURLBase64, 'PlayTime', 0);
      Inc(TStation(Stations.Objects[idx1]).PlayTime, TStream(TStation(Stations.Objects[idx1]).Streams.Objects[idx2]).PlayTime);


      Inc(idx2);
    end;

    Inc(idx1);
  end;

  INIFree(INI);

end;


(*function BubbleSort( list: TStringList ): TStringList;
var
  i, j: Integer;
  temp: string;
begin
  // bubble sort
  for i := 0 to list.Count - 1 do begin
    for j := 0 to ( list.Count - 1 ) - i do begin
      // Condition to handle i=0 & j = 9. j+1 tries to access x[10] which
      // is not there in zero based array
      if ( j + 1 = list.Count ) then
        continue;
      if ( list.Strings[j] > list.Strings[j+1] ) then begin
        temp              := list.Strings[j];
        list.Strings[j]   := list.Strings[j+1];
        list.Strings[j+1] := temp;
      end; // endif
    end; // endwhile
  end; // endwhile
  Result := list;
end;     *)



function SortStationsPlayCount( list: TStringList ): TStringList;
var
  i, j: Integer;
begin
  for i := 0 to list.Count - 1 do begin
    for j := 0 to ( list.Count - 1 ) - i do begin
      if ( j + 1 = list.Count ) then
        continue;
      if ( TStation(list.Objects[j]).PlayCount < TStation(list.Objects[j+1]).PlayCount ) then begin
        list.Move(j,j+1);
      end;
    end; // endwhile
  end; // endwhile
  Result := list;
end;


function SortStationsPlayTime( list: TStringList ): TStringList;
var
  i, j: Integer;
begin
  for i := 0 to list.Count - 1 do begin
    for j := 0 to ( list.Count - 1 ) - i do begin
      if ( j + 1 = list.Count ) then
        continue;
      if ( TStation(list.Objects[j]).PlayTime < TStation(list.Objects[j+1]).PlayTime ) then begin
        list.Move(j,j+1);
      end;
    end; // endwhile
  end; // endwhile
  Result := list;
end;

end.

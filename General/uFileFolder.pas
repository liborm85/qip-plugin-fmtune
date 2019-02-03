unit uFileFolder;

interface

uses
  SysUtils, Classes, Windows, Dialogs, uLNG, uSuperReplace;

  const
    { Parametry k funkci GetFileVersion }
    //GET_FILE_VER_ALL     = 9; // Vrací celou verzi souboru
    GET_FILE_VER_MAJOR   = 0; // Vrací pouze èíslo MAJOR verze
    GET_FILE_VER_MINOR   = 1; // Vrací pouze èíslo MINOR verze
    GET_FILE_VER_RELEASE = 2; // Vrací pouze èíslo RELEASE verze
    GET_FILE_VER_BUILD   = 3; // Vrací pouze èíslo BUILD verze


  procedure CheckFolder(Path: WideString; ErrorInfo: Boolean = False);
  function SetDateToFile(const FileName: WideString; Value: TDateTime): Boolean;

  // File
  function CreateFileIfNotExists(FileName: WideString): Boolean;
  function MoveFileIfExists(FileName, ExtPath: WideString; ReWrite: Boolean = False): Boolean;
  function CopyFileIfExists(ExistingFileName, NewFileName: WideString; Rewrite: Boolean = False): Boolean;
  function DeleteFileIfExists(FileName : WideString): Boolean;
  function GetFileVersionW(FileName: WideString): WideString; overload;
  function GetFileVersionW(FileName: WideString; Ver: DWORD): Byte; overload;

  // Folder
  function CreateFolderIfNotExists(FolderName: WideString): Boolean;
  function RemoveFolderIfExists(FolderName : WideString): Boolean;

implementation

procedure CheckFolder(Path: WideString; ErrorInfo: Boolean = False);
var rec: TSearchRec;
begin

  if FindFirst(Path, faDirectory, rec) = 0 then

  else
  begin
    try
      if ForceDirectories(Path)=False then
        if ErrorInfo=True then
          ShowMessage( TagsReplace( StringReplace(LNG('Texts', 'DirNotCreate', 'Can''t create directory: %path%') , '%path%', Path, [rfReplaceAll, rfIgnoreCase]) ) );
    except
      if ErrorInfo=True then
        ShowMessage( TagsReplace( StringReplace(LNG('Texts', 'DirNotCreate', 'Can''t create directory: %path%'), '%path%', Path, [rfReplaceAll, rfIgnoreCase]) ) );
    end;

  end;

end;

function SetDateToFile(const FileName: WideString; Value: TDateTime): Boolean;
var
  hFile: THandle;
begin
  Result := False;
  hFile := 0;
  try
    {open a file handle}
    hFile := FileOpen(FileName, fmOpenWrite or fmShareDenyNone);

    {if opened succesfully}
    if (hFile > 0) then
      {convert a datetime into DOS format and set a date}
      Result := (FileSetDate(hFile, DateTimeToFileDate(Value)) = 0)
  finally
    {close an opened file handle}
    FileClose(hFile);
  end;
end;


{  FILE  }

function CreateFileIfNotExists(FileName: WideString): Boolean;
var
  F: TextFile;
begin
  if not FileExists(FileName) then
  begin
    AssignFile(F, FileName);
    ReWrite(F);
    WriteLn(F,'; Code page: UTF-8');
    WriteLn(F);
    CloseFile(F);
  end;

  Result := FileExists(FileName);
end;


function MoveFileIfExists(FileName, ExtPath: WideString; ReWrite: Boolean = False): Boolean;
var
  Param: Cardinal;
begin
  CreateFolderIfNotExists( ExtractFileName(ExtPath) );                                                   // existuje cílový adresáø ?

  (*if ReWrite then
  begin
    Param := MOVEFILE_REPLACE_EXISTING;
  end
  else
    Param := 0;

  Result := True;   *)

  if MoveFileExW( PWideChar(FileName), PWideChar(ExtPath), MOVEFILE_REPLACE_EXISTING) = True then
  begin
    Result := False;
    //ShowMessage( 'Error: ' + IntToStr(GetLastError) );
  end;

  (*if CopyFileIfExists(FileName, ExtPath + ExtractFileName(FileName), ReWrite) then // byl zkopírováno ?
    DeleteFileW( PWideChar(FileName) );                                            // tak smaž pùvodní soubor      *)

  if not FileExists(FileName) then                                                 // byl smazán pùvodní soubor ?
    Result := FileExists(ExtPath + ExtractFileName(FileName))                      // byl pøesunut ?
  else
    Result := False;                                                               // nahlaš chybu
end;


function CopyFileIfExists(ExistingFileName, NewFileName: WideString; ReWrite: Boolean = False): Boolean;
begin
  if FileExists(ExistingFileName) then
    CopyFileW( PWideChar(ExistingFileName), PWideChar(NewFileName), not ReWrite); // not ReWrite = FALSE => Soubor bude pøepsán

  Result := FileExists(ExistingFileName);
end;


function DeleteFileIfExists(FileName : WideString): Boolean;
begin
  if FileExists(FileName) then
    DeleteFileW( PWideChar(FileName) );

  Result := not FileExists(FileName);
end;


function GetFileVersionW(FileName: WideString): WideString; overload;
begin
  Result := IntToStr( GetFileVersionW(FileName, GET_FILE_VER_MAJOR) );
  Result := Result + '.' + IntToStr( GetFileVersionW(FileName, GET_FILE_VER_MINOR) );
  Result := Result + '.' + IntToStr( GetFileVersionW(FileName, GET_FILE_VER_RELEASE) );
  Result := Result + '.' + IntToStr( GetFileVersionW(FileName, GET_FILE_VER_BUILD) );
end;


function GetFileVersionW(FileName: WideString; Ver: DWORD): Byte; overload;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
begin
  VerInfoSize := GetFileVersionInfoSizeW(PWideChar(FileName), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfoW(PWideChar(FileName), 0, VerInfoSize, VerInfo);
  VerQueryValueW(VerInfo, '\', Pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    case Ver of
      GET_FILE_VER_MAJOR:   Result := dwFileVersionMS shr 16;
      GET_FILE_VER_MINOR:   Result := dwFileVersionMS and $FFFF;
      GET_FILE_VER_RELEASE: Result := dwFileVersionLS shr 16;
      GET_FILE_VER_BUILD:   Result := dwFileVersionLS and $FFFF;
    end;
  end;
  FreeMem(VerInfo, VerInfoSize);
end;


{  FOLDER  }

function CreateFolderIfNotExists(FolderName: WideString): Boolean;
begin
  if not DirectoryExists(FolderName) then
    CheckFolder( FolderName );

  Result := DirectoryExists(FolderName);
end;

(*function MoveFolderIfNotExists(FolderName: WideString; ReWrite: Boolean = False): Boolean;
begin
  if not DirectoryExists(FolderName) then
    CheckFolder( FolderName );
  MoveFileExW()

  Result := DirectoryExists(FolderName);
end;*)


function RemoveFolderIfExists(FolderName : WideString): Boolean;
begin
  if DirectoryExists(FolderName) then
    RemoveDirectoryW( PChar(FolderName) );

  Result := not DirectoryExists(FolderName);
end;



end.

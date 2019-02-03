{
  BASSWMA 2.4 Delphi unit
  Copyright (c) 2002-2009 Un4seen Developments Ltd.

  See the BASSWMA.CHM file for more detailed documentation
}

unit dynamic_basswma;

interface

uses Windows,
     SysUtils,
     dynamic_bass;

const
  // Additional error codes returned by BASS_ErrorGetCode
  BASS_ERROR_WMA_LICENSE     = 1000; // the file is protected
  BASS_ERROR_WMA             = 1001; // Windows Media (9 or above) is not installed
  BASS_ERROR_WMA_WM9         = BASS_ERROR_WMA;
  BASS_ERROR_WMA_DENIED      = 1002; // access denied (user/pass is invalid)
  BASS_ERROR_WMA_INDIVIDUAL  = 1004; // individualization is needed

  // Additional BASS_SetConfig options
  BASS_CONFIG_WMA_PRECHECK   = $10100;
  BASS_CONFIG_WMA_PREBUF     = $10101;
  BASS_CONFIG_WMA_BASSFILE   = $10103;
  BASS_CONFIG_WMA_NETSEEK    = $10104;

  // additional WMA sync types
  BASS_SYNC_WMA_CHANGE       = $10100;
  BASS_SYNC_WMA_META         = $10101;

  // additional BASS_StreamGetFilePosition WMA mode
  BASS_FILEPOS_WMA_BUFFER    = 1000; // internet buffering progress (0-100%)

  // Additional flags for use with BASS_WMA_EncodeOpen/File/Network/Publish
  BASS_WMA_ENCODE_STANDARD   = $2000;  // standard WMA
  BASS_WMA_ENCODE_PRO        = $4000;  // WMA Pro
  BASS_WMA_ENCODE_24BIT      = $8000;  // 24-bit
  BASS_WMA_ENCODE_SCRIPT     = $20000; // set script (mid-stream tags) in the WMA encoding

  // Additional flag for use with BASS_WMA_EncodeGetRates
  BASS_WMA_ENCODE_RATES_VBR  = $10000; // get available VBR quality settings

  // WMENCODEPROC "type" values
  BASS_WMA_ENCODE_HEAD       = 0;
  BASS_WMA_ENCODE_DATA       = 1;
  BASS_WMA_ENCODE_DONE       = 2;

  // BASS_WMA_EncodeSetTag "type" values
  BASS_WMA_TAG_ANSI          = 0;
  BASS_WMA_TAG_UNICODE       = 1;
  BASS_WMA_TAG_UTF8          = 2;

  // BASS_CHANNELINFO type
  BASS_CTYPE_STREAM_WMA      = $10300;
  BASS_CTYPE_STREAM_WMA_MP3  = $10301;

  // Additional BASS_ChannelGetTags type
  BASS_TAG_WMA               = 8; // WMA header tags : series of null-terminated UTF-8 strings
  BASS_TAG_WMA_META          = 11; // WMA mid-stream tag : UTF-8 string


type
  HWMENCODE = DWORD;		// WMA encoding handle

  CLIENTCONNECTPROC = procedure(handle:HWMENCODE; connect:BOOL; ip:PAnsiChar; user:Pointer); stdcall;
  {
    Client connection notification callback function.
    handle : The encoder
    connect: TRUE=client is connecting, FALSE=disconnecting
    ip     : The client's IP (xxx.xxx.xxx.xxx:port)
    user   : The 'user' parameter value given when calling BASS_WMA_EncodeSetNotify
  }

  WMENCODEPROC = procedure(handle:HWMENCODE; dtype:DWORD; buffer:Pointer; length:DWORD; user:Pointer); stdcall;
  {
    Encoder callback function.
    handle : The encoder handle
    dtype  : The type of data, one of BASS_WMA_ENCODE_xxx values
    buffer : The encoded data
    length : Length of the data
    user   : The 'user' parameter value given when calling BASS_WMA_EncodeOpen
  }


// Vars that will hold our dynamically loaded functions...
var BASS_WMA_StreamCreateFile:function(mem:BOOL; fl:pointer; offset,length:QWORD; flags:DWORD): HSTREAM; stdcall;
var BASS_WMA_StreamCreateFileAuth:function(mem:BOOL; fl:pointer; offset,length:QWORD; flags:DWORD; user,pass:PChar): HSTREAM; stdcall;
var BASS_WMA_StreamCreateFileUser:function(system,flags:DWORD; var procs:BASS_FILEPROCS; user:Pointer): HSTREAM; stdcall;

var BASS_WMA_EncodeGetRates:function(freq,chans,flags:DWORD): PDWORD; stdcall;
var BASS_WMA_EncodeOpen:function(freq,chans,flags,bitrate:DWORD; proc:WMENCODEPROC; user:Pointer): HWMENCODE; stdcall;
var BASS_WMA_EncodeOpenFile:function(freq,chans,flags,bitrate:DWORD; fname:PChar): HWMENCODE; stdcall;
var BASS_WMA_EncodeOpenNetwork:function(freq,chans,flags,bitrate,port,clients:DWORD): HWMENCODE; stdcall;
var BASS_WMA_EncodeOpenNetworkMulti:function(freq,chans,flags:DWORD; bitrates:PDWORD; port,clients:DWORD): HWMENCODE; stdcall;
var BASS_WMA_EncodeOpenPublish:function(freq,chans,flags,bitrate:DWORD; url,user,pass:PChar): HWMENCODE; stdcall;
var BASS_WMA_EncodeOpenPublishMulti:function(freq,chans,flags:DWORD; bitrates:PDWORD; url,user,pass:PChar): HWMENCODE; stdcall;
var BASS_WMA_EncodeGetPort:function(handle:HWMENCODE): DWORD; stdcall;
var BASS_WMA_EncodeSetNotify:function(handle:HWMENCODE; proc:CLIENTCONNECTPROC; user:Pointer): BOOL; stdcall;
var BASS_WMA_EncodeGetClients:function(handle:HWMENCODE): DWORD; stdcall;
var BASS_WMA_EncodeSetTag:function(handle:HWMENCODE; tag,text:PChar; ttype:DWORD): BOOL; stdcall;
var BASS_WMA_EncodeWrite:function(handle:HWMENCODE; buffer:Pointer; length:DWORD): BOOL; stdcall;
var BASS_WMA_EncodeClose:function(handle:HWMENCODE): BOOL; stdcall;

var BASS_WMA_GetWMObject:function(handle:DWORD): Pointer; stdcall;

var BASS_Handle:Thandle=0; // this will hold our handle for the dll; it functions nicely as a mutli-dll prevention unit as well...

Function Load_BASSDLL (const dllfilename:string) :boolean; // well, this functions uses sub-space field harmonics to erase all your credit cards in a 30 meter area...look at it's name, what do you think it does ?

Procedure Unload_BASSDLL; // another mystery function ???
{
  This function frees the dynamically linked-in functions from memory...don't forget to call it once you're done !
  Best place to put this is probably the OnDestroy of your Main-Form;
  suggested use in OnDestroy :
  - Call BASS_Free to get rid of everything that's eating memory (automatically called, but just to be on the safe-side !),
  - Then call this function.
}

implementation

Function Load_BASSDLL (const dllfilename:string) :boolean;
const szBassDll = 'Plugins\basswma.dll' + #0;
var
  oldmode:integer;
  P: PChar;
  s: string;
  dllfile: array[0..MAX_PATH + 1] of Char;
begin
  Result := False;
  if BASS_Handle<>0 then result:=true {is it already there ?}
  else begin {go & load the dll}
    s := dllfilename;
    if Length(s) = 0 then begin
      P := nil;
      if SearchPath(nil, PChar(szBassDll), nil, MAX_PATH, dllfile, P) > 0 then
        s := StrPas(dllfile)
      else exit;
      end;
    oldmode:=SetErrorMode($8001);
    s := s + #0;
    BASS_Handle:=LoadLibrary(PChar(s)); // obtain the handle we want
    SetErrorMode(oldmode);
    if BASS_Handle<>0 then
       begin {now we tie the functions to the VARs from above}

@BASS_WMA_StreamCreateFile:=GetProcAddress(BASS_Handle,PChar('BASS_WMA_StreamCreateFile'));
@BASS_WMA_StreamCreateFileAuth:=GetProcAddress(BASS_Handle,PChar('BASS_WMA_StreamCreateFileAuth'));
@BASS_WMA_StreamCreateFileUser:=GetProcAddress(BASS_Handle,PChar('BASS_WMA_StreamCreateFileUser'));

@BASS_WMA_EncodeGetRates:=GetProcAddress(BASS_Handle,PChar('BASS_WMA_EncodeGetRates'));
@BASS_WMA_EncodeOpen:=GetProcAddress(BASS_Handle,PChar('BASS_WMA_EncodeOpen'));
@BASS_WMA_EncodeOpenFile:=GetProcAddress(BASS_Handle,PChar('BASS_WMA_EncodeOpenFile'));
@BASS_WMA_EncodeOpenNetwork:=GetProcAddress(BASS_Handle,PChar('BASS_WMA_EncodeOpenNetwork'));
@BASS_WMA_EncodeOpenNetworkMulti:=GetProcAddress(BASS_Handle,PChar('BASS_WMA_EncodeOpenNetworkMulti'));
@BASS_WMA_EncodeOpenPublish:=GetProcAddress(BASS_Handle,PChar('BASS_WMA_EncodeOpenPublish'));
@BASS_WMA_EncodeOpenPublishMulti:=GetProcAddress(BASS_Handle,PChar('BASS_WMA_EncodeOpenPublishMulti'));
@BASS_WMA_EncodeGetPort:=GetProcAddress(BASS_Handle,PChar('BASS_WMA_EncodeGetPort'));
@BASS_WMA_EncodeSetNotify:=GetProcAddress(BASS_Handle,PChar('BASS_WMA_EncodeSetNotify'));
@BASS_WMA_EncodeGetClients:=GetProcAddress(BASS_Handle,PChar('BASS_WMA_EncodeGetClients'));
@BASS_WMA_EncodeSetTag:=GetProcAddress(BASS_Handle,PChar('BASS_WMA_EncodeSetTag'));
@BASS_WMA_EncodeWrite:=GetProcAddress(BASS_Handle,PChar('BASS_WMA_EncodeWrite'));
@BASS_WMA_EncodeClose:=GetProcAddress(BASS_Handle,PChar('BASS_WMA_EncodeClose'));

@BASS_WMA_GetWMObject:=GetProcAddress(BASS_Handle,PChar('BASS_WMA_GetWMObject'));

      {now check if everything is linked in correctly}
      if
(@BASS_WMA_StreamCreateFile=nil)  or
(@BASS_WMA_StreamCreateFileAuth=nil)  or
(@BASS_WMA_StreamCreateFileUser=nil)  or

(@BASS_WMA_EncodeGetRates=nil)  or
(@BASS_WMA_EncodeOpen=nil)  or
(@BASS_WMA_EncodeOpenFile=nil)  or
(@BASS_WMA_EncodeOpenNetwork=nil)  or
(@BASS_WMA_EncodeOpenNetworkMulti=nil)  or
(@BASS_WMA_EncodeOpenPublish=nil)  or
(@BASS_WMA_EncodeOpenPublishMulti=nil)  or
(@BASS_WMA_EncodeGetPort=nil)  or
(@BASS_WMA_EncodeSetNotify=nil)  or
(@BASS_WMA_EncodeGetClients=nil)  or
(@BASS_WMA_EncodeSetTag=nil)  or
(@BASS_WMA_EncodeWrite=nil)  or
(@BASS_WMA_EncodeClose=nil)  or

(@BASS_WMA_GetWMObject=nil)

         then
          begin {if something went wrong during linking, free library & reset handle}
            FreeLibrary(BASS_Handle);
           BASS_Handle:=0;
         end;
       end;
    result:=(BASS_Handle<>0);
  end;
end;

Procedure Unload_BASSDLL;
begin
  if BASS_Handle<>0 then
     begin
       BASS_Free; // make sure we release everything
       FreeLibrary(BASS_Handle);
     end;
  BASS_Handle:=0;
end;


end.

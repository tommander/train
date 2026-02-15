unit uversionhelper;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, FileInfo, elfreader{, winpeimagereader, machoreader};

type
  TVersion = record
    strComments: string;
    strCompanyName: string;
    strFileDescription: string;
    strFileVersion: string;
    strInternalName: string;
    strLegalCopyright: string;
    strLegalTrademarks: string;
    strOriginalFilename: string;
    strProductName: string;
    strProductVersion: string;
  end;

function GetExecVersion(): TVersion;
function AppTitle(): string;

implementation

function GetExecVersion(): TVersion;
var fvi: TFileVersionInfo;
begin
  fvi := TFileVersionInfo.Create(nil);
  try
    fvi.ReadFileInfo();
    result.strComments := fvi.VersionStrings.Values['Comments'];
    result.strCompanyName := fvi.VersionStrings.Values['CompanyName'];
    result.strFileDescription := fvi.VersionStrings.Values['FileDescription'];
    result.strFileVersion := fvi.VersionStrings.Values['FileVersion'];
    result.strInternalName := fvi.VersionStrings.Values['InternalName'];
    result.strLegalCopyright := fvi.VersionStrings.Values['LegalCopyright'];
    result.strLegalTrademarks := fvi.VersionStrings.Values['LegalTrademarks'];
    result.strOriginalFilename := fvi.VersionStrings.Values['OriginalFilename'];
    result.strProductName := fvi.VersionStrings.Values['ProductName'];
    result.strProductVersion := fvi.VersionStrings.Values['ProductVersion'];
  finally
    FreeAndNil(fvi);
  end;
end;

function AppTitle(): string;
var ver: TVersion;
begin
  ver := GetExecVersion();
  result := ver.strProductName + ' v' + ver.strFileVersion;
end;

end.


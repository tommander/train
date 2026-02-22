unit uprofile;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ucommon;

type
  TProfile = class
    constructor Create();
    private
      var theGuid: TGUID;
      var strName: shortstring;
      var intStatus: TProfessionalStatus;
      var currAmount: Currency;
      var strTrains: string;
      var strCertificates: string;
      var strLog: string;
      var dtRegistered: TDateTime;
      var qwdStatPassengers: QWord;
      var qwdStatMeters: QWord;
      var qwdStatDrives: QWord;
    public
      property GUID: TGUID read theGuid;
      property Name: shortstring read strName;
      property Status: TProfessionalStatus read intStatus;
      property Amount: Currency read currAmount;
      property Trains: string read strTrains;
      property Certificates: string read strCertificates;
      property Log: string read strLog;
      property DateRegistered: TDateTime read dtRegistered;
      property StatPassengers: QWord read qwdStatPassengers;
      property StatMeters: QWord read qwdStatMeters;
      property StatDrives: QWord read qwdStatDrives;

      procedure Clear(AClearGUID: boolean);
      procedure LoadFromFile(AFile: string);
      procedure SaveToFile(AFile: string);

      function GUIDStr(): string;

      procedure GenerateGUID();
      procedure AddToLog(AName: string; ADate: boolean = true);

      procedure AddAmount(AName: Currency);
      procedure AddTrain(AName: string);
      procedure AddCertificate(AName: string);
      procedure RemoveAmount(AName: Currency);
      procedure RemoveTrain(AName: string);
      procedure RemoveCertificate(AName: string);

      procedure SetName(AName: shortstring);
      procedure SetStatus(AName: TProfessionalStatus);
      procedure SetAmount(AName: Currency);
      procedure SetTrains(AName: string);
      procedure SetCertificates(AName: string);
      procedure SetLog(AName: string);
  end;

var
  theProfile: TProfile;

implementation

constructor TProfile.Create();
begin
  Clear(true);
end;

procedure TProfile.Clear(AClearGUID: boolean);
begin
  if AClearGUID then
  begin
    theGuid := GUID_NULL;
  end;
  strName := '';
  intStatus := psNovice;
  currAmount := 0;
  strTrains := '';
  strCertificates := '';
  strLog := '';
end;

procedure TProfile.LoadFromFile(AFile: string);
var sl: TStringList;
    i: integer;
begin
  if not FileExists(AFile) then
  begin
    Exit;
  end;

  sl := TStringList.Create();
  try
    sl.LoadFromFile(AFile);
    case sl[0] of
      'PROFILEv1':
      begin
        Clear(true);
        theGuid := StringToGUID(sl[1]);
        strName := sl[2];
        intStatus := StrToProfessionalStatus(sl[3]);
        currAmount := StrToCurr(sl[4]);
        strTrains := sl[5];
        strCertificates := sl[6];
        strLog := '';
        for i := 7 to sl.Count-1 do
        begin
          strLog := strLog + sl[i] + LineEnding;
        end;
      end;
    end;
  finally
    FreeAndNil(sl);
  end;
end;

procedure TProfile.SaveToFile(AFile: string);
var sl: TStringList;
    i: integer;
begin
  sl := TStringList.Create();
  try
    sl.Add('PROFILEv1');
    sl.Add(GUIDToString(theGuid));
    sl.Add(StringReplace(strName, LineEnding, '', [rfReplaceAll]));
    sl.Add(ProfessionalStatusToStr(intStatus));
    sl.Add(CurrToStr(currAmount));
    sl.Add(StringReplace(strTrains, LineEnding, '', [rfReplaceAll]));
    sl.Add(StringReplace(strCertificates, LineEnding, '', [rfReplaceAll]));
    sl.Add(strLog);
    sl.SaveToFile(AFile);
  finally
    FreeAndNil(sl);
  end;
end;

function TProfile.GUIDStr(): string;
begin
  result := GUIDToString(theGuid);
end;

procedure TProfile.GenerateGUID();
var lRes: integer;
begin
  lRes := CreateGUID(theGuid);
  if lRes <> 0 then
  begin
    raise Exception.Create('Cannot create profile GUID');
  end;
end;

procedure TProfile.AddToLog(AName: string; ADate: boolean = true);
var lDate: string;
begin
  lDate := '';
  if ADate then
  begin
    lDate := Format('[%s]', []);
  end;
  strLog := strLog + lDate + AName + LineEnding;
end;

procedure TProfile.AddAmount(AName: Currency);
begin
  currAmount := currAmount + AName;
end;

procedure TProfile.AddTrain(AName: string);
begin
  strTrains := strTrains + '|' + AName;
end;

procedure TProfile.AddCertificate(AName: string);
begin
  strCertificates := strCertificates + '|' + AName;
end;

procedure TProfile.RemoveAmount(AName: Currency);
begin
  currAmount := currAmount - AName;
end;

procedure TProfile.RemoveTrain(AName: string);
begin
  strTrains := StringReplace(strTrains, '|' + AName, '', [rfReplaceAll, rfIgnoreCase]);
end;

procedure TProfile.RemoveCertificate(AName: string);
begin
  strCertificates := StringReplace(strCertificates, '|' + AName, '', [rfReplaceAll, rfIgnoreCase]);
end;

procedure TProfile.SetName(AName: shortstring);
begin
  strName := AName;
end;

procedure TProfile.SetStatus(AName: TProfessionalStatus);
begin
  intStatus := AName;
end;

procedure TProfile.SetAmount(AName: Currency);
begin
  currAmount := AName;
end;

procedure TProfile.SetTrains(AName: string);
begin
  strTrains := AName;
end;

procedure TProfile.SetCertificates(AName: string);
begin
  strCertificates := AName;
end;

procedure TProfile.SetLog(AName: string);
begin
  strLog := AName;
end;

end.


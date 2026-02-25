unit ucommon;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, Math, ExtCtrls, Graphics;

type
  //                   //novacek       junior        certifikovan     pokrocily       zkuseny            mentor        vlakmistr
  TProfessionalStatus = (psNovice = 1, psJunior = 2, psCertified = 3, psAdvanced = 4, psExperienced = 5, psMentor = 6, psMaster = 7);
  TLEDColor = (ledOff, ledWhite, ledSilver, ledGray, ledBlack, ledRed, ledYellow, ledGreen, ledAqua, ledBlue, ledViolet);
  TLEDPower = (ledLight, ledNormal, ledDark);
  TLED = record
    ledColor: TLEDColor;
    ledPower: TLEDPower;
    ledText: shortstring;
  end;
  TTrainSwitchControl = record
    arrMap: array of TLED;
  end;
  TDoorStatus = (doorClosed = 0, doorOpening = 1, doorOpen = 2, doorAlarm = 3, doorClosing = 4);
  TTrainLights = (tlOff,tlHeadDim,tlHead,tlHeadHigh,tlRearDim,tlRear);
  TInteriorLights = (ilOff, ilDim, ilNormal, ilEmergency);
  TTunnel = (tnNone,tnSingle,tnDouble);
  TTrainRangeControl = record
    intValue: shortint;
    intMax: shortint;
  end;
  //TTrainRangeControlType = (rctPower,rctBrakeDynamic,rctBrakeElmag,rctBrakeAir);
  TTrainDirection = (dirReverse = -1, dirNeutral = 0, dirForward = 1);

function BoolToStr(ABool: boolean; const ATrue, AFalse: string): string;
function HrMin(ADate: TDateTime; const AFormat: string = '%.2d:%.2d'): string;
function NiceNumber(ANum: double; const AUnit: shortstring; ADigits: byte = 1): string;
function timeint(ATime: TDateTime): double;
function gauss(ATime,AMaxPassengers,AStretchRushHours: double): double;
procedure LED(APanel: TPanel; AStatus: TLED);
function LEDStatus(AColor: TLEDColor; APower: TLEDPower = ledNormal; AText: shortstring = ''): TLED;
//function VirtualTime(AHour: word = 0; AMinute: word = 0; ASecond: word = 0; AMillsecond: word = 0): TDateTime;
//function VirtualizeTime(ATime: TDateTime): TDateTime;
//function VirtualNow(): TDateTime;
function sign(AValue: double): double;
function AppDir(const APath: string = ''): string;
function ProfessionalStatusLabel(AStatus: TProfessionalStatus): string;
function ProfessionalStatusToStr(AStatus: TProfessionalStatus): string;
function StrToProfessionalStatus(AStatus: string): TProfessionalStatus;
function CzechDate(ADT: TDateTime): string;
function CzechTime(ADT: TDateTime): string;
function CzechDateTime(ADT: TDateTime): string;
procedure Explode(const AString: string; var AArray: TStringArray; const ASeparator: string = ','; AAddEmpty: boolean = false);
procedure Implode(const AArray: TStringArray; var AString: string; const ASeparator: string = ',');
function SplitByChar(const AText: string; const ASeparator: string; var ALeft: string): string;

implementation

(**
lItem := '';
lStr := 'a,b,c,';
i := 0;
while Length(lStr) > 0 do
begin
  lOld := Length(lStr);
  lStr := SplitByChar(lStr, ',', lItem);
  if lOld = Length(lStr) then
  begin
    break;
  end;
  //do something with lItem
  Inc(i);
end;
*)
function SplitByChar(const AText: string; const ASeparator: string; var ALeft: string): string;
var lSep: integer;
begin
  lSep := Pos(ASeparator, AText);
  if lSep > 0 then
  begin
    ALeft := Copy(AText, 1, lSep - 1);
    result := Copy(AText, lSep + 1, Length(AText) - lSep);
    Exit;
  end;

  ALeft := AText;
  result := '';
end;

procedure Explode(const AString: string; var AArray: TStringArray; const ASeparator: string = ','; AAddEmpty: boolean = false);
var lSep,lOff,lLen: int64;
    lAdd: string;
begin
  SetLength(AArray, 0);
  lOff := 1;
  repeat
    lSep := Pos(ASeparator, AString, lOff);
    if lSep <= 0 then
    begin
      lSep := Length(AString)+1;
    end;
    lAdd := '';
    lLen := (lSep - lOff);
    if lLen > 0 then
    begin
      lAdd := Trim(Copy(AString, lOff, lLen));
    end;
    if (Length(lAdd) > 0) or AAddEmpty then
    begin
      SetLength(AArray, Length(AArray) + 1);
      AArray[High(AArray)] := lAdd;
    end;
    lOff := lSep + 1;
  until
    lOff > Length(AString);
end;

procedure Implode(const AArray: TStringArray; var AString: string; const ASeparator: string = ',');
var i: integer;
begin
  AString := '';
  if Length(AArray) <= 0 then
  begin
    Exit;
  end;
  AString := AArray[0];
  for i := 1 to High(AArray) do
  begin
    AString := AString + ASeparator + AArray[i];
  end;
end;

function CzechDate(ADT: TDateTime): string;
begin
  result := Format('%s.%s.%s', [DayOf(ADT), MonthOf(ADT), YearOf(ADT)]);
end;

function CzechTime(ADT: TDateTime): string;
begin
  result := Format('%s:%s:%s', [HourOf(ADT), MinuteOf(ADT), SecondOf(ADT)]);
end;

function CzechDateTime(ADT: TDateTime): string;
begin
  result := Format('%s.%s.%s %s:%s:%s', [DayOf(ADT), MonthOf(ADT), YearOf(ADT), HourOf(ADT), MinuteOf(ADT), SecondOf(ADT)]);
end;

function ProfessionalStatusLabel(AStatus: TProfessionalStatus): string;
begin
  result := '🕫 Chybička';
  case AStatus of
    psNovice: result := '👶 Nováček';
    psJunior: result := '🧒 Junior';
    psCertified: result := '🎓 Certifikovaný';
    psAdvanced: result := '🦸 Pokročilý';
    psExperienced: result := '🧙 Zkušený';
    psMentor: result := '🌟 Mentor';
    psMaster: result := '🎖️ Vlakmistr';
  end;
end;

function ProfessionalStatusToStr(AStatus: TProfessionalStatus): string;
begin
  result := 'novice';
  case AStatus of
    psJunior: result := 'junior';
    psCertified: result := 'certified';
    psAdvanced: result := 'advanced';
    psExperienced: result := 'experienced';
    psMentor: result := 'mentor';
    psMaster: result := 'master';
  end;
end;

function StrToProfessionalStatus(AStatus: string): TProfessionalStatus;
var lStatus: string;
begin
  result := psNovice;
  lStatus := LowerCase(Trim(AStatus));
  case lStatus of
    'junior': result := psJunior;
    'certified': result := psCertified;
    'advanced': result := psAdvanced;
    'experienced': result := psExperienced;
    'mentor': result := psMentor;
    'master': result := psMaster;
  end;
end;

function AppDir(const APath: string = ''): string;
begin
  result := ExtractFilePath(ParamStr(0));
  if APath <> '' then
  begin
    result := IncludeTrailingPathDelimiter(result) + ExcludeLeadingPathDelimiter(APath);
  end;
end;

function BoolToStr(ABool: boolean; const ATrue, AFalse: string): string;
begin
  result := AFalse;
  if ABool then
  begin
    result := ATrue;
  end;
end;

function HrMin(ADate: TDateTime; const AFormat: string = '%.2d:%.2d'): string;
begin
  result := Format(AFormat, [HourOf(ADate), MinuteOf(ADate)]);
end;

function NiceNumber(ANum: double; const AUnit: shortstring; ADigits: byte = 1): string;
var dblValue: double;
    strPrefix: string;
begin
  strPrefix := '';
  dblValue := 0;
  if (ANum > -1000) and (ANum < 1000) then
  begin
    dblValue := ANum;
  end
  else if (ANum > -1000*1000) and (ANum < 1000*1000) then
  begin
    dblValue := ANum / 1000;
    strPrefix := 'k';
  end
  else if (ANum > -1000*1000*1000) and (ANum < 1000*1000*1000) then
  begin
    dblValue := ANum / (1000*1000);
    strPrefix := 'M';
  end
  else if (ANum > -1000*1000*1000*1000) and (ANum < 1000*1000*1000*1000) then
  begin
    dblValue := ANum / (1000*1000*1000);
    strPrefix := 'G';
  end
  else
  begin
    dblValue := ANum / (1000*1000*1000*1000);
    strPrefix := 'T';
  end;
  result := Format('%.*f %s%s', [ADigits, dblValue, strPrefix, AUnit]);
end;

function timeint(ATime: TDateTime): double;
begin
  result := HourOf(ATime) + (MinuteOf(ATime) / 60);
end;

{
ATime ... Real number interval <0;24)
AMaxPassengers ... Real positive number
AStretchRushHours ... Real number, default is 2, 4 = medium, 8 = busy place
}
function gauss(ATime,AMaxPassengers,AStretchRushHours: double): double;
const e: double = 2.71828;
      u: double = 12;
begin
  result := Math.Power(AMaxPassengers * e, Power(ATime - u, 2)/(2*Power(AStretchRushHours, 2)));
end;

function LEDStatus(AColor: TLEDColor; APower: TLEDPower = ledNormal; AText: shortstring = ''): TLED;
begin
  result.ledColor := AColor;
  result.ledPower := APower;
  result.ledText := AText;
end;

procedure LED(APanel: TPanel; AStatus: TLED);
var intOff,intOn: integer;
begin
  APanel.Caption := AStatus.ledText;
  APanel.Color := clDefault;

  intOff := 0;
  if AStatus.ledPower = ledLight then
  begin
    intOff := 128;
  end;
  intOn := 255;
  if AStatus.ledPower = ledDark then
  begin
    intOn := 128;
  end;

  case AStatus.ledColor of
    ledWhite: APanel.Color :=  clWhite;
    ledSilver: APanel.Color := clSilver;
    ledGray: APanel.Color :=   clGray;
    ledBlack: APanel.Color :=  clBlack;
    ledRed: APanel.Color :=    RGBToColor(intOn, intOff, intOff);
    ledYellow: APanel.Color := RGBToColor(intOn, intOn, intOff);
    ledGreen: APanel.Color :=  RGBToColor(intOff, intOn, intOff);
    ledAqua: APanel.Color :=   RGBToColor(intOff, intOn, intOn);
    ledBlue: APanel.Color :=   RGBToColor(intOff, intOff, intOn);
    ledViolet: APanel.Color := RGBToColor(intOn, intOff, intOn);
  end;
end;

//function VirtualTime(AHour: word = 0; AMinute: word = 0; ASecond: word = 0; AMillsecond: word = 0): TDateTime;
//begin
//  result := EncodeDateTime(1996,01,01,AHour, AMinute, ASecond, AMillsecond);
//end;
//
//function VirtualizeTime(ATime: TDateTime): TDateTime;
//begin
//  result := VirtualTime(HourOf(ATime), MinuteOf(ATime), SecondOf(ATime), MilliSecondOf(ATime));
//end;
//
//function VirtualNow(): TDateTime;
//begin
//  result := VirtualizeTime(Now());
//end;

function sign(AValue: double): double;
begin
  result := 1;
  if AValue < 0 then
  begin
    result := -1;
  end;
end;

end.


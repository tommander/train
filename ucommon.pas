unit ucommon;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, Math, ExtCtrls, Graphics;

type
  TProfessionalStatus = (psNone = 0, psNovice = 1, psJunior = 2, psCertified = 3, psAdvanced = 4, psExperienced = 5, psMentor = 6, psMaster = 7);
  TStationID = longword;
  TStation = packed record
    strName: shortstring;
    dtArrival: TDateTime;
    dtDeparture: TDateTime;
    dblPosition: double;
    dtRealArrival: TDateTime;
    dtRealDeparture: TDateTime;
    dblRealPosition: double;
    dblMaxPassengers: double;
    dblStretchRushHours: double;
    intPassengersOut: word;
    intPassengersIn: word;
    boolVisited: boolean;
  end;
  TStationList = array of TStation;
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
  TTrainRangeControlType = (rctPower,rctBrakeDynamic,rctBrakeElmag,rctBrakeAir);
  TTrainDirection = (dirReverse = -1, dirNeutral = 0, dirForward = 1);
  TTrackSection = record
    boolValid: boolean;
    dblStartPosition: double;
    dblSpeed: double;
    dblSlope: double;
    dblArc: double;
    tnlTunnel: TTunnel;
    boolMain: boolean;
  end;
  TTrackDefinition = array of TTrackSection;

function BoolToStr(ABool: boolean; const ATrue, AFalse: string): string;
function HrMin(ADate: TDateTime; const AFormat: string = '%.2d:%.2d'): string;
function NiceNumber(ANum: double; const AUnit: shortstring; ADigits: byte = 1): string;
function SameSection(ASection1, ASection2: TTrackSection): boolean;
function IsNullSection(ASection: TTrackSection): boolean;
function NullSection(): TTrackSection;
function Section(AValid: boolean = false; AStartPosition: double = 0; ASpeed: double = 0; ASlope: double = 0; AArc: double = 0; ATunnel: TTunnel = tnNone; AMain: boolean = false): TTrackSection;
function SameStation(AStation1, AStation2: TStation): boolean;
function IsNullStation(AStation: TStation): boolean;
function NullStation(): TStation;
function Station(AName: shortstring = ''; AArrival: TDateTime = 0; ADeparture: TDateTime = 0; APosition: double = 0; AMaxPassengers: double = 1; AStretchRushHours: double = 2): TStation;
function CompareStations(const s1,s2): integer;
function timeint(ATime: TDateTime): double;
function gauss(ATime,AMaxPassengers,AStretchRushHours: double): double;
procedure LED(APanel: TPanel; AStatus: TLED);
function LEDStatus(AColor: TLEDColor; APower: TLEDPower = ledNormal; AText: shortstring = ''): TLED;
function VirtualTime(AHour: word = 0; AMinute: word = 0; ASecond: word = 0; AMillsecond: word = 0): TDateTime;
function VirtualizeTime(ATime: TDateTime): TDateTime;
function VirtualNow(): TDateTime;
function sign(AValue: double): double;

implementation

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

function SameSection(ASection1, ASection2: TTrackSection): boolean;
begin
  result :=
  (ASection1.boolValid = ASection2.boolValid) and
  (ASection1.dblStartPosition = ASection2.dblStartPosition) and
  (ASection1.dblSpeed = ASection2.dblSpeed) and
  (ASection1.dblSlope = ASection2.dblSlope) and
  (ASection1.dblArc = ASection2.dblArc) and
  (ASection1.tnlTunnel = ASection2.tnlTunnel) and
  (ASection1.boolMain = ASection2.boolMain);
end;

function IsNullSection(ASection: TTrackSection): boolean;
begin
  result := SameSection(ASection, NullSection);
end;

function NullSection(): TTrackSection;
begin
  result := Section();
end;

function Section(AValid: boolean = false; AStartPosition: double = 0; ASpeed: double = 0; ASlope: double = 0; AArc: double = 0; ATunnel: TTunnel = tnNone; AMain: boolean = false): TTrackSection;
begin
  result.boolValid := AValid;
  result.dblStartPosition := AStartPosition;
  result.dblSpeed := ASpeed;
  result.dblSlope := ASlope;
  result.dblArc := AArc;
  result.tnlTunnel := ATunnel;
  result.boolMain := AMain;
end;

function SameStation(AStation1, AStation2: TStation): boolean;
begin
  result :=
  (AStation1.strName = AStation2.strName) and
  (AStation1.dtArrival = AStation2.dtArrival) and
  (AStation1.dtDeparture = AStation2.dtDeparture) and
  (AStation1.dblPosition = AStation2.dblPosition) and
  (AStation1.dtRealArrival = AStation2.dtRealArrival) and
  (AStation1.dtRealDeparture = AStation2.dtRealDeparture) and
  (AStation1.dblRealPosition = AStation2.dblRealPosition) and
  (AStation1.dblMaxPassengers = AStation2.dblMaxPassengers) and
  (AStation1.dblStretchRushHours = AStation2.dblStretchRushHours) and
  (AStation1.intPassengersOut = AStation2.intPassengersOut) and
  (AStation1.intPassengersIn = AStation2.intPassengersIn) and
  (AStation1.boolVisited = AStation2.boolVisited);
end;

function IsNullStation(AStation: TStation): boolean;
begin
  result := SameStation(AStation, NullStation);
end;

function NullStation(): TStation;
begin
  result.strName := '';
  result.dtArrival := 0;
  result.dtDeparture := 0;
  result.dblPosition := 0;
  result.dtRealArrival := 0;
  result.dtRealDeparture := 0;
  result.dblRealPosition := 0;
  result.dblMaxPassengers := 1;
  result.dblStretchRushHours := 2;
  result.intPassengersOut := 0;
  result.intPassengersIn := 0;
  result.boolVisited := false;
end;

function Station(AName: shortstring = ''; AArrival: TDateTime = 0; ADeparture: TDateTime = 0; APosition: double = 0; AMaxPassengers: double = 1; AStretchRushHours: double = 2): TStation;
begin
  result := NullStation();
  result.strName := AName;
  result.dtArrival := AArrival;
  result.dtDeparture := ADeparture;
  result.dblPosition := APosition;
  result.dblMaxPassengers := AMaxPassengers;
  result.dblStretchRushHours := AStretchRushHours;
end;

function CompareStations(const s1,s2): integer;
var
  i1 : TStation absolute s1;
  i2 : TStation absolute s2;
begin
  if i1.dblPosition=i2.dblPosition then Result:=0
  else if i1.dblPosition<i2.dblPosition then Result:=-1
  else Result:=1;
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

function VirtualTime(AHour: word = 0; AMinute: word = 0; ASecond: word = 0; AMillsecond: word = 0): TDateTime;
begin
  result := EncodeDateTime(1996,01,01,AHour, AMinute, ASecond, AMillsecond);
end;

function VirtualizeTime(ATime: TDateTime): TDateTime;
begin
  result := VirtualTime(HourOf(ATime), MinuteOf(ATime), SecondOf(ATime), MilliSecondOf(ATime));
end;

function VirtualNow(): TDateTime;
begin
  result := VirtualizeTime(Now());
end;

function sign(AValue: double): double;
begin
  result := 1;
  if AValue < 0 then
  begin
    result := -1;
  end;
end;

end.


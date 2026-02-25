unit utrackmgr;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ucommon;

const
  DIR_TRACKS = 'tracks';

type
  TEventOnCurrentSectionChanged = procedure() of object;
  TEventAskForPosition = function(): double of object;
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
  TTrackSection = record
    boolValid: boolean;
    dblStartPosition: double;
    dblSpeed: double;
    dblSlope: double;
    dblArc: double;
    tnlTunnel: TTunnel;
    boolMain: boolean;
  end;
//  TTrackDefinition = array of TTrackSection;
  TTrackDefinition = record
    strName: string;
    wrdLength: word; // Max 65 536 km
    arrStations: array of TStation;
    arrSections: array of TTrackSection;
  end;

function SameStation(AStation1, AStation2: TStation): boolean;
function IsNullStation(AStation: TStation): boolean;
function NullStation(): TStation;
function Station(AName: shortstring = ''; AArrival: TDateTime = 0; ADeparture: TDateTime = 0; APosition: double = 0; AMaxPassengers: double = 0; AStretchRushHours: double = 0): TStation;
function CompareStations(const s1,s2): integer;
procedure BlockSort();
procedure UnblockSort();
function BlockedSort(): boolean;
function CurrentStationId(): TStationID;
function CurrentStation(): TStation;
procedure AdvanceStation(AValue: longint);
procedure QuickSort(var AI: TStationList; ALo, AHi: Integer);
procedure SortStations();
function AddStation(AStation: TStation): TStationID;
procedure UpdateStation(AID: TStationID; AStation: TStation);
procedure DeleteStation(AID: TStationID);
function ListStations(): TStationList;

function SameSection(ASection1, ASection2: TTrackSection): boolean;
function IsNullSection(ASection: TTrackSection): boolean;
function NullSection(): TTrackSection;
function Section(AValid: boolean = false; AStartPosition: double = 0; ASpeed: double = 0; ASlope: double = 0; AArc: double = 0; ATunnel: TTunnel = tnNone; AMain: boolean = false): TTrackSection;
procedure UpdateCurrentSection();
function CurrentSectionId(): longword;
function CurrentSection(): TTrackSection;
function AddSection(ASection: TTrackSection): longword;
procedure UpdateSection(AID: longword; ASection: TTrackSection);
procedure DeleteSection(AID: longword);
function GetSection(AID: longword): TTrackSection;

var
  arrTracks: array of TTrackDefinition;
  lwdCurrentSection: longword;
  lwdCurrentStation: longword;
  trcTrack: TTrackDefinition;
  boolBlockSort: boolean;
  evtOnCurrentSectionChanged: TEventOnCurrentSectionChanged;
  evtAskForPosition: TEventAskForPosition;

function StrToTunnel(const AString: string): TTunnel;
procedure InitTracks();
procedure FreeTracks();


implementation

function StrToTunnel(const AString: string): TTunnel;
var lString: string;
begin
  result := tnNone;
  lString := LowerCase(Trim(AString));
  case lString of
    'singe': result := tnSingle;
    'double': result := tnDouble;
  end;
end;

procedure InitTracks();
var sl: TStringList;
    sr: TSearchRec;
    intStart,intDivider,x,y,a: integer;
begin
  SetLength(arrTracks, 0);
  if not DirectoryExists(AppDir(DIR_TRACKS)) then
  begin
    Exit;
  end;

  if FindFirst(AppDir(IncludeTrailingPathDelimiter(DIR_TRACKS) + '*.dat'), faAnyFile, sr) <> 0 then
  begin
    Exit;
  end;

  sl := TStringList.Create();
  try
    repeat
      sl.LoadFromFile(AppDir(IncludeTrailingPathDelimiter(DIR_TRACKS) + sr.Name));
      SetLength(arrTracks, Length(arrTracks) + 1);
      x := High(arrTracks);
      y := 0;

      //          TStringHelper().Split([#10,#13], 7, [ExcludeEmpty]);

      case sl[0] of
        'TRACKv1':
        begin
          arrTracks[x].strName := sl[1];
          arrTracks[x].wrdLength := StrToInt(sl[2]);
          SetLength(arrTracks[x].arrSections, 0);
          SetLength(arrTracks[x].arrStations, 0);
          intStart := 3;
          intDivider := sl.IndexOf('---');

          if (intDivider < 3) or ((intDivider-intStart) mod 7 <> 0) or ((sl.Count - 1 - intDivider) mod 12 <> 0) then
          begin
            continue;
          end;

          for a := 0 to (intDivider-intStart) div 7 do
          begin
            arrTracks[x].arrSections[a].boolValid :=          StrToBool(  sl[intStart + (a*7)]);
            arrTracks[x].arrSections[a].dblStartPosition := StrToFloat( sl[intStart + (a*7 + 1)]);
            arrTracks[x].arrSections[a].dblSpeed :=         StrToFloat( sl[intStart + (a*7 + 2)]);
            arrTracks[x].arrSections[a].dblSlope :=         StrToFloat( sl[intStart + (a*7 + 3)]);
            arrTracks[x].arrSections[a].dblArc :=           StrToFloat( sl[intStart + (a*7 + 4)]);
            arrTracks[x].arrSections[a].tnlTunnel :=        StrToTunnel(sl[intStart + (a*7 + 5)]);
            arrTracks[x].arrSections[a].boolMain :=         StrToBool(  sl[intStart + (a*7 + 6)]);
          end;

          a := (intDivider + 1);
          while (a < sl.Count) do
          begin
            arrTracks[x].arrStations[a].strName := sl[a]; //shortstring;
            arrTracks[x].arrStations[a].dtArrival := StrToDateTime(sl[a+1]); //TDateTime;
            arrTracks[x].arrStations[a].dtDeparture := StrToDateTime(sl[a+2]); //TDateTime;
            arrTracks[x].arrStations[a].dblPosition := StrToFloat(sl[a+3]); //double;
            arrTracks[x].arrStations[a].dtRealArrival := StrToDateTime(sl[a+4]); //TDateTime;
            arrTracks[x].arrStations[a].dtRealDeparture := StrToDateTime(sl[a+5]); //TDateTime;
            arrTracks[x].arrStations[a].dblRealPosition := StrToFloat(sl[a+6]); //double;
            arrTracks[x].arrStations[a].dblMaxPassengers := StrToFloat(sl[a+7]); //double;
            arrTracks[x].arrStations[a].dblStretchRushHours := StrToFloat(sl[a+8]); //double;
            arrTracks[x].arrStations[a].intPassengersOut := StrToInt(sl[a+9]); //word;
            arrTracks[x].arrStations[a].intPassengersIn := StrToInt(sl[a+10]); //word;
            arrTracks[x].arrStations[a].boolVisited := StrToBool(sl[a+11]); //boolean;
            a := a + 12;
          end;
          for a := intDivider+1 to (sl.Count-1) div 7 do
          begin
            arrTracks[x].arrSections[a].boolValid :=          StrToBool(  sl[intStart + (a*7)]);
            arrTracks[x].arrSections[a+1].dblStartPosition := StrToFloat( sl[intStart + (a*7 + 1)]);
            arrTracks[x].arrSections[a+2].dblSpeed :=         StrToFloat( sl[intStart + (a*7 + 2)]);
            arrTracks[x].arrSections[a+3].dblSlope :=         StrToFloat( sl[intStart + (a*7 + 3)]);
            arrTracks[x].arrSections[a+4].dblArc :=           StrToFloat( sl[intStart + (a*7 + 4)]);
            arrTracks[x].arrSections[a+5].tnlTunnel :=        StrToTunnel(sl[intStart + (a*7 + 5)]);
            arrTracks[x].arrSections[a+6].boolMain :=         StrToBool(  sl[intStart + (a*7 + 6)]);
          end;
        end;
      end;
    until
      FindNext(sr) <> 0;
  finally
    FindClose(sr);
    FreeAndNil(sl);
  end;
end;

procedure FreeTracks();
var i: integer;
begin
  if (Assigned(arrTracks)) or (Length(arrTracks) > 0) then
  begin
    for i := Low(arrTracks) to High(arrTracks) do
    begin
      SetLength(arrTracks[i].arrSections, 0);
      SetLength(arrTracks[i].arrStations, 0);
    end;
    SetLength(arrTracks, 0);
  end;
  arrTracks := nil;
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

function Station(AName: shortstring = ''; AArrival: TDateTime = 0; ADeparture: TDateTime = 0; APosition: double = 0; AMaxPassengers: double = 0; AStretchRushHours: double = 0): TStation;
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

procedure BlockSort();
begin
  boolBlockSort := true;
end;

procedure UnblockSort();
begin
  boolBlockSort := false;
  SortStations();
end;

function BlockedSort(): boolean;
begin
  result := boolBlockSort;
end;

function CurrentStationId(): TStationID;
begin
  result := lwdCurrentStation;
end;

function CurrentStation(): TStation;
begin
  result := NullStation();
  if (lwdCurrentStation > High(trcTrack.arrStations)) then
  begin
    Exit;
  end;

  result := trcTrack.arrStations[lwdCurrentStation];
end;

procedure AdvanceStation(AValue: longint);
begin
  if AValue < (-1*lwdCurrentStation) then
  begin
    lwdCurrentStation := 0;
    Exit;
  end;
  if (lwdCurrentStation + AValue) > High(trcTrack.arrStations) then
  begin
    lwdCurrentStation := High(trcTrack.arrStations);
    Exit;
  end;
  lwdCurrentStation := lwdCurrentStation + AValue;
end;

procedure QuickSort(var AI: TStationList; ALo, AHi: Integer);
 var
  Lo, Hi: Integer;
  Pivot, T: TStation;
 begin
  Lo := ALo;
  Hi := AHi;
  Pivot := AI[(Lo + Hi) div 2];
  repeat
    while AI[Lo].dblPosition < Pivot.dblPosition do
      Inc(Lo);
    while AI[Hi].dblPosition > Pivot.dblPosition do
      Dec(Hi);
    if Lo <= Hi then
    begin
      T := AI[Lo];
      AI[Lo] := AI[Hi];
      AI[Hi] := T;
      Inc(Lo) ;
      Dec(Hi) ;
    end;
  until Lo > Hi;
  if Hi > ALo then
    QuickSort(AI, ALo, Hi) ;
  if Lo < AHi then
    QuickSort(AI, Lo, AHi) ;
end;

procedure SortStations();
begin
  if BlockedSort() then
  begin
    Exit;
  end;
  QuickSort(trcTrack.arrStations, Low(trcTrack.arrStations), High(trcTrack.arrStations));
end;

function AddStation(AStation: TStation): TStationID;
begin
  result := 0;
  SetLength(trcTrack.arrStations, Length(trcTrack.arrStations) + 1);
  result := High(trcTrack.arrStations);
  trcTrack.arrStations[result] := AStation;
  SortStations();
end;

procedure UpdateStation(AID: TStationID; AStation: TStation);
begin
  if (AID <= High(trcTrack.arrStations)) then
  begin
    trcTrack.arrStations[AID] := AStation;
    SortStations();
  end;
end;

procedure DeleteStation(AID: TStationID);
begin
  if (AID <= High(trcTrack.arrStations)) then
  begin
    trcTrack.arrStations[AID] := NullStation();
    SortStations();
  end;
end;

function ListStations(): TStationList;
begin
  result := trcTrack.arrStations;
end;

procedure UpdateCurrentSection();
var lSectionChanged: boolean;
    lPosition: double;
begin
 if (Length(trcTrack.arrSections) = 0) and (lwdCurrentSection > 0) then
 begin
   lwdCurrentSection := 0;
   if Assigned(evtOnCurrentSectionChanged) then
   begin
     evtOnCurrentSectionChanged();
   end;
   Exit;
 end;

 if not Assigned(evtAskForPosition) then
 begin
   Exit;
 end;

 lSectionChanged := false;
 lPosition := evtAskForPosition();
 while ((lwdCurrentSection+1) <= High(trcTrack.arrSections)) and (trcTrack.arrSections[lwdCurrentSection+1].dblStartPosition <= lPosition) do
 begin
   Inc(lwdCurrentSection);
   lSectionChanged := true;
 end;
  if lwdCurrentSection > High(trcTrack.arrSections) then
  begin
    lwdCurrentSection := High(trcTrack.arrSections);
    lSectionChanged := true;
  end;
 if lSectionChanged and Assigned(evtOnCurrentSectionChanged) then
 begin
   evtOnCurrentSectionChanged();
 end;
end;

function CurrentSectionId(): longword;
begin
  UpdateCurrentSection();
  result := lwdCurrentSection;
end;

function CurrentSection(): TTrackSection;
begin
  if Length(trcTrack.arrSections) = 0 then
  begin
    Exit;
  end;
  UpdateCurrentSection();
  result := trcTrack.arrSections[lwdCurrentSection];
end;

function AddSection(ASection: TTrackSection): longword;
begin
  result := 0;
  SetLength(trcTrack.arrSections, Length(trcTrack.arrSections) + 1);
  result := High(trcTrack.arrSections);
  trcTrack.arrSections[result] := ASection;
end;

procedure UpdateSection(AID: longword; ASection: TTrackSection);
begin
  if (AID <= High(trcTrack.arrSections)) then
  begin
    trcTrack.arrSections[AID] := ASection;
  end;
end;

procedure DeleteSection(AID: longword);
begin
  if (AID <= High(trcTrack.arrSections)) then
  begin
    trcTrack.arrSections[AID] := NullSection();
  end;
end;

function GetSection(AID: longword): TTrackSection;
begin
  result := NullSection();
  if (AID <= High(trcTrack.arrSections)) then
  begin
    result := trcTrack.arrSections[AID];
  end;
end;

end.


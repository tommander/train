unit utrainmgr;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ucommon;

const
  DIR_TRAINS = 'trains';

type
  TTrainCargoKind = (tckWeight, tckCountable, tckFluid);
  TTrainCargo = record
    tckKind: TTrainCargoKind;
    strType: shortstring;
    sglAmount: single; // weight [t], countable [-], fluid [m3]
    sglCapacity: single; // dtto
    sglLoaderSpeed: single; // loading of 1 unit/t/m3 takes n seconds
    sglUnloaderSpeed: single; // unloading of 1 unit/t/m3 takes n seconds
    sglLoaderAmount: word; // passengers = no. of get-on/mixed doors, rest = no. of loading machines/devices/whatever
    sglUnloaderAmount: word; // passengers = no. of get-off/mixed doors, rest = no. of unloading machines/devices/whatever
  end;
  TTrainDefinition = record
    strName: string;
    qwdOdometer: QWord; // [m]
    qwdTimer: QWord; // [min]
    dblMass: double; // [kg]
    dblMaxVelocity: double; // [m/s]
    dblMaxPower: double; // [W]
    dblMaxForce: double; // [N]
    dblMaxBrake: double; // [N]
    dblResistanceA: double; // [-]
    dblResistanceB: double; // [-] A + B*V + C*V^2 (V in km/h)
    dblResistanceC: double; // [-]
    arrCargo: array of TTrainCargo;
  end;

var
  arrTrains: array of TTrainDefinition;
  trnTrain: TTrainDefinition;

function StrToCargoKind(const AString: string): TTrainCargoKind;
procedure InitTrains();
procedure FreeTrains();

implementation

function StrToCargoKind(const AString: string): TTrainCargoKind;
var lString: string;
begin
  result := tckWeight;
  lString := LowerCase(Trim(AString));
  case lString of
    'countable': result := tckCountable;
    'fluid': result := tckFluid;
  end;
end;

procedure InitTrains();
var sl: TStringList;
    sr: TSearchRec;
    i,x,y: integer;
begin
  SetLength(arrTrains, 0);
  if not DirectoryExists(AppDir(DIR_TRAINS)) then
  begin
    Exit;
  end;

  if FindFirst(AppDir(IncludeTrailingPathDelimiter(DIR_TRAINS) + '*.dat'), faAnyFile, sr) <> 0 then
  begin
    Exit;
  end;

  sl := TStringList.Create();
  try
    repeat
      sl.LoadFromFile(AppDir(IncludeTrailingPathDelimiter(DIR_TRAINS) + sr.Name));
      SetLength(arrTrains, Length(arrTrains) + 1);
      x := High(arrTrains);
      y := 0;

      case sl.Values['type'] of
        'TRAINv1':
        begin
          arrTrains[x].strName := sl.Values['name'];
          arrTrains[x].qwdOdometer := StrToQWord(sl.Values['odo']);
          arrTrains[x].qwdTimer := StrToQWord(sl.Values['timer']);
          arrTrains[x].dblMass := StrToFloat(sl.Values['mass']);
          arrTrains[x].dblMaxVelocity := StrToFloat(sl.Values['maxvelo']);
          arrTrains[x].dblMaxPower := StrToFloat(sl.Values['maxpower']);
          arrTrains[x].dblMaxForce := StrToFloat(sl.Values['maxforce']);
          arrTrains[x].dblMaxBrake := StrToFloat(sl.Values['maxbrake']);
          arrTrains[x].dblResistanceA := StrToFloat(sl.Values['resa']);
          arrTrains[x].dblResistanceB := StrToFloat(sl.Values['resb']);
          arrTrains[x].dblResistanceC := StrToFloat(sl.Values['resc']);
           sl.Values['cargo'];
          SetLength(arrTrains[x].arrCargo, 0);
          i := 12;
          while i < sl.Count - 7 do
          begin
            SetLength(arrTrains[x].arrCargo, Length(arrTrains[x].arrCargo) + 1);
            y := High(arrTrains[High(arrTrains)].arrCargo);
            arrTrains[x].arrCargo[y].tckKind := StrToCargoKind(sl[i]);
            arrTrains[x].arrCargo[y].strType := sl[i+1];
            arrTrains[x].arrCargo[y].sglAmount := StrToFloat(sl[i+2]);
            arrTrains[x].arrCargo[y].sglCapacity := StrToFloat(sl[i+3]);
            arrTrains[x].arrCargo[y].sglLoaderSpeed := StrToFloat(sl[i+4]);
            arrTrains[x].arrCargo[y].sglUnloaderSpeed := StrToFloat(sl[i+5]);
            arrTrains[x].arrCargo[y].sglLoaderAmount := StrToInt(sl[i+6]);
            arrTrains[x].arrCargo[y].sglUnloaderAmount := StrToInt(sl[i+7]);
            i := i + 8;
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

procedure FreeTrains();
var i: integer;
begin
  if (Assigned(arrTrains)) or (Length(arrTrains) > 0) then
  begin
    for i := Low(arrTrains) to High(arrTrains) do
    begin
      SetLength(arrTrains[i].arrCargo, 0);
    end;
    SetLength(arrTrains, 0);
  end;
  arrTrains := nil;
end;

end.


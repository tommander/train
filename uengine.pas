unit uengine;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Controls, Buttons, ComCtrls, ExtCtrls, Graphics,
  DateUtils, ucommon;

type
  TEventBlockDoor = procedure() of object;
  TEventUnblockDoor = procedure() of object;
  TEventValueChangedDouble = procedure(AName: string; AValue, AOldValue: double) of object;
  TEventValueChangedString = procedure(AName: string; AValue, AOldValue: string) of object;
  TEventValueChangedInteger = procedure(AName: string; AValue, AOldValue: int64) of object;
  TEventValueChangedBoolean = procedure(AName: string; AValue, AOldValue: boolean) of object;
  TEventValueChangedDateTime = procedure(AName: string; AValue, AOldValue: TDateTime) of object;
  TEventValueChangedTunnel = procedure(AName: string; AValue, AOldValue: TTunnel) of object;
  TEventValueChangedInteriorLights = procedure(AName: string; AValue, AOldValue: TInteriorLights) of object;
  TEventValueChangedTrainLights = procedure(AName: string; AValue, AOldValue: TTrainLights) of object;
  TEventValueChangedDoorStatus = procedure(AName: string; AValue, AOldValue: TDoorStatus) of object;
  TEventValueChangedTrainRangeControl = procedure(AName: string; AValue, AOldValue: TTrainRangeControl) of object;
  TEventValueChangedTrainDirection = procedure(AName: string; AValue, AOldValue: TTrainDirection) of object;

  TSimulation = class
    private
      var dblPowerControl: double; //<0;1>
      var dblBrakeDynaControl: double; //<0;1>
      var dblBrakeElmagControl: double; //<0;1>
      var dblBrakeAirControl: double; //<0;1>
      var intDoor: TDoorStatus;
      var intTrainlights: TTrainLights;
      var intDriverlights: TInteriorLights;
      var intPassengerlights: TInteriorLights;
      var boolSander: boolean; // ...
      var boolEmergency: boolean; // ...
      var boolMainSwitch: boolean; // ...
      var boolLock: boolean; // ...
      var boolWakeUp: boolean; // ...
      var dblMaxV: double; // [m/s]
      var dblLastV: double; // [m/s]
      var dblLastX: double; // [m]
      var dblLastA: double; // [m/s^-2]
      var dblLastEk: double; // [J]
      var dblLastP: double; // [W]
      var dblForce: double; // [N]
      var dblForceNet: double; // [N]
      var dblTotalPullForce: double; // [N]
      var dblBrakeResistance: double; // [N]
      var dblGravityResistance: double; // [N]
      var boolTrainResistanceUseABC: boolean;
      var dblTrainResistance: double; // [N]
      var dblTrainResistanceA: double; // [-]
      var dblTrainResistanceB: double; // [-] A + B*V + C*V^2 (V in km/h)
      var dblTrainResistanceC: double; // [-]
      var dblTrainResistanceRoll: double; // [N]
      var dblTrainResistanceAero: double; // [N]
      var dblTrainResistanceAccel: double; // [N]
      var dblTrackResistance: double; // [N]
      var dblTrackResistanceArc: double; // [N]
      var dblTrackResistanceTunnel: double; // [N]
      var dirDirection: TTrainDirection; //
      var dblTrackArc: double; //radius [m]
      var tnlTrackTunnel: TTunnel;
      var dblTrackSlope: double; // slope [per mile, ‰]
      var boolTrackMain: boolean; // main track? for arc res computation
      var dblMass: double; // [kg]
      var dblMaxBrake: double; // [N]
      var dblMaxPower: double; // [W]
      var dblMaxForce: double; // [N]
      var dblAlsoMaxForce: double; // [N]
      var dtLastT: TDateTime; // [s]
      var boolBlockedDoor: boolean; // ...

    public
      constructor Create();

      procedure Tick2();
      function Export(): string;
      procedure Refresh();

      function PowerControl(): double;
      function BrakeDynaControl(): double;
      function BrakeElmagControl(): double;
      function BrakeAirControl(): double;
      function Door(): TDoorStatus;
      function Trainlights(): TTrainLights;
      function Passengerlights(): TInteriorLights;
      function Driverlights(): TInteriorLights;
      function Sander(): boolean;
      function Emergency(): boolean;
      function MainSwitch(): boolean;
      function Lock(): boolean;
      function WakeUp(): boolean;
      function Velocity(boolKmph: boolean = false): double;
      function Position(): double;
      function Acceleration(): double;
      function KineticEnergy(): double;
      function Power(): double;
      function Force(): double;
      function MaxVelocity(boolKmph: boolean = false): double;
      function TrainResistanceUseABC(): boolean;
      function Direction(): TTrainDirection;
      function TrackArc(): double;
      function TrackTunnel(): TTunnel;
      function TrackSlope(): double;
      function TrackMain(): boolean;
      function BrakeResistance(): double;
      function GravityResistance(): double;
      function TrainResistance(): double;
      function TrackResistance(): double;
      function Mass(): double;
      function MaxPower(): double;
      function MaxBrake(): double;
      function MaxForce(): double;
      function BlockedDoor(): boolean;
      function SimTime(): TDateTime;

      procedure SetPowerControl(AValue: double);
      procedure SetBrakeDynaControl(AValue: double);
      procedure SetBrakeElmagControl(AValue: double);
      procedure SetBrakeAirControl(AValue: double);
      procedure SwitchDoor(var ATimer: TTimer);
      procedure SwitchTrainlights();
      procedure SwitchPassengerlights();
      procedure SwitchDriverlights();
      procedure ToggleSander();
      procedure ToggleEmergency();
      procedure ToggleMainSwitch();
      procedure ToggleLock();
      procedure ToggleWakeup();
      procedure SetMaxVelocity(AValue: double; boolKmph: boolean = false);
      procedure SetTrainResistanceUseABC(AValue: boolean);
      procedure SetDirection(AValue: TTrainDirection);
      procedure SetTrackArc(AValue: double);
      procedure SetTrackTunnel(AValue: TTunnel);
      procedure SetTrackSlope(AValue: double);
      procedure SetTrackMain(AValue: boolean);
      procedure SetMass(AValue: double);
      procedure SetMaxPower(AValue: double);
      procedure SetMaxBrake(AValue: double);
      procedure SetMaxForce(AValue: double);
      procedure BlockDoor();
      procedure UnblockDoor();

      var EBlockDoor: TEventBlockDoor;
      var EUnblockDoor: TEventUnblockDoor;
      var EValueChangedDouble: TEventValueChangedDouble;
      var EValueChangedString: TEventValueChangedString;
      var EValueChangedInteger: TEventValueChangedInteger;
      var EValueChangedBoolean: TEventValueChangedBoolean;
      var EValueChangedDateTime: TEventValueChangedDateTime;
      var EValueChangedTunnel: TEventValueChangedTunnel;
      var EValueChangedInteriorLights: TEventValueChangedInteriorLights;
      var EValueChangedTrainLights: TEventValueChangedTrainLights;
      var EValueChangedDoorStatus: TEventValueChangedDoorStatus;
      var EValueChangedTrainRangeControl: TEventValueChangedTrainRangeControl;
      var EValueChangedTrainDirection: TEventValueChangedTrainDirection;
  end;

implementation

constructor TSimulation.Create();
begin
  EBlockDoor := nil;
  EUnblockDoor := nil;
  EValueChangedDouble := nil;
  EValueChangedString := nil;
  EValueChangedInteger := nil;
  EValueChangedBoolean := nil;
  EValueChangedDateTime := nil;
  EValueChangedTunnel := nil;
  EValueChangedInteriorLights := nil;
  EValueChangedTrainLights := nil;
  EValueChangedDoorStatus := nil;
  EValueChangedTrainRangeControl := nil;
  EValueChangedTrainDirection := nil;

  dblPowerControl := 0; //  [0;1]
  dblBrakeDynaControl := 0; // [0;1]
  dblBrakeElmagControl := 0; // [0;1]
  dblBrakeAirControl := 0; // [0;1]
  dblMaxBrake := 0; // [N]
  dblMaxPower := 0; // [W]
  dblMaxForce := 0; // [N]
  dblAlsoMaxForce := 0; // [N]
  dblMass := 0; // [kg]

  intDoor := doorClosed;
  intTrainlights := tlOff;
  intDriverlights := ilOff;
  intPassengerlights := ilOff;

  boolSander := false;
  boolEmergency := false;
  boolMainSwitch := false;
  boolLock := false;
  boolWakeUp := false;

  dtLastT := 0;
  dblLastV := 0;
  dblMaxV := 0;
  dblLastX := 0;
  dblLastA := 0;
  dblLastEk := 0;
  dblLastP := 0;
  dblForce := 0;
  dblForceNet := 0;
  dblTotalPullForce := 0;
  dblBrakeResistance := 0;
  dblGravityResistance := 0;
  dblTrainResistance := 0;
  dblTrackResistance := 0;
  boolTrainResistanceUseABC := true;
  dblTrainResistanceA := 1.35;
  dblTrainResistanceB := 0.0008;
  dblTrainResistanceC := 0.00033;
  dblTrainResistanceRoll := 0;
  dblTrainResistanceAero := 0;
  dblTrainResistanceAccel := 0;
  dblTrackResistanceArc := 0;
  dblTrackResistanceTunnel := 0;
  dblTrackArc := 0;
  tnlTrackTunnel := tnNone;
  dblTrackSlope := 0;
  boolTrackMain := false;
  dirDirection := dirForward;
end;

procedure TSimulation.Tick2();
var dtInt: int64;
    dt,lRealMaxForce: double;
    dtNow: TDateTime;
begin
  // Kein "mass", kein Spaß
  if dblMass = 0 then
  begin
    Exit;
  end;

  // Time
  dtNow := Now();
  dtInt := MilliSecondsBetween(dtNow, dtLastT);
  dt := (dtInt / 1000);
  dtLastT := dtNow;
  if (dtInt <= 0) or (dtInt > 10000) then
  begin
    Exit;
  end;

  dblGravityResistance := (dblMass/1000) * 9.81 * dblTrackSlope;
  dblBrakeResistance := dblMaxBrake * dblBrakeElmagControl;
  dblTrainResistance := 0;
  dblTrackResistance := 0;
  dblTrackResistanceArc := 0;
  dblTrackResistanceTunnel := 0;
  dblTrainResistance := (dblTrainResistanceA + dblTrainResistanceB * (dblLastV * 3.6) + dblTrainResistanceC * (dblLastV * 3.6) * (dblLastV * 3.6));
  if (dblTrackArc > 55) and boolTrackMain then
  begin
    dblTrackResistanceArc := (dblMass/1000) * 9.81 * (650 / (dblTrackArc - 55));
  end
  else if (dblTrackArc > 30) and (not boolTrackMain) then
  begin
    dblTrackResistanceArc := (dblMass/1000) * 9.81 * (500 / (dblTrackArc - 30));
  end;
  case tnlTrackTunnel of
    tnSingle: dblTrackResistanceTunnel := (dblMass/1000) * 9.81 * 2;
    tnDouble: dblTrackResistanceTunnel := (dblMass/1000) * 9.81;
  end;
  dblTrackResistance := dblTrackResistanceArc + dblTrackResistanceTunnel;
  lRealMaxForce := dblMaxForce;
  dblAlsoMaxForce := 0;
  if (abs(dblLastV) >= 0.1) then
  begin
    dblAlsoMaxForce := dblMaxPower / dblLastV;
    if (dblAlsoMaxForce < lRealMaxForce) then
    begin
      lRealMaxForce := dblAlsoMaxForce;
    end;
  end;
  dblForce := lRealMaxForce * dblPowerControl;
  if dirDirection = dirNeutral then
  begin
    dblForce := 0;
  end;
  dblTotalPullForce := dblForce - dblTrainResistance - dblTrackResistance;
  if (abs(dblLastV) < 0.1) and (abs(dblTotalPullForce) <= dblBrakeResistance) then
  begin
    dblForceNet := 0;
    dblLastV := 0;
    dblLastA := 0;
  end
  else
  begin
    if abs(dblLastV) < 0.1 then
    begin
      dblForceNet := dblTotalPullForce - sign(dblTotalPullForce) * dblBrakeResistance;
    end
    else
    begin
      dblForceNet := dblTotalPullForce - sign(dblLastV) * dblBrakeResistance;
    end;
    dblForceNet := dblForceNet - dblGravityResistance;
    dblLastA := dblForceNet / dblMass;
    dblLastV := dblLastV + (dblLastA * dt);
  end;

  if dirDirection = dirForward then
  begin
    dblLastX := dblLastX + (dblLastV * dt);
  end
  else if dirDirection = dirReverse then
  begin
    dblLastX := dblLastX - (dblLastV * dt);
  end;
  dblLastP := dblForce * dblLastV;
  dblLastEk := (dblMass/2)*dblLastV*dblLastV;
end;

function TSimulation.Export(): string;
var strTunnel: string;
begin
  strTunnel := 'none';
  case tnlTrackTunnel of
    tnSingle: strTunnel := 'single';
    tnDouble: strTunnel := 'double';
  end;
  result :=
  Format('"PwrCtrl": "%.3f",'#10, [dblPowerControl]) +
  Format('"BrkDyna": "%.3f",'#10, [dblBrakeDynaControl]) +
  Format('"BrkElmag": "%.3f",'#10, [dblBrakeElmagControl]) +
  Format('"BrkAir": "%.3f",'#10, [dblBrakeAirControl]) +
  Format('"Door": "%d",'#10, [intDoor]) +
  Format('"LgtTrain": "%d",'#10, [intTrainlights]) +
  Format('"LgtDrivr": "%d",'#10, [intDriverlights]) +
  Format('"LgtPasng": "%d",'#10, [intPassengerlights]) +
  Format('"Sander": "%d",'#10, [Integer(boolSander)]) +
  Format('"Emergncy": "%d",'#10, [Integer(boolEmergency)]) +
  Format('"MainSwtc": "%d",'#10, [Integer(boolMainSwitch)]) +
  Format('"Lock": "%d",'#10, [Integer(boolLock)]) +
  Format('"WakeUp": "%d",'#10, [Integer(boolWakeUp)]) +
  Format('"Vmax": "%.1f m/s": "%.1f km/h",'#10, [dblMaxV, dblMaxV*3.6]) +
  Format('"V": "%.1f m/s": "%.1f km/h",'#10, [dblLastV, dblLastV*3.6]) +
  Format('"X": "%.1f m",'#10, [dblLastX]) +
  Format('"A": "%.1f m/s2",'#10, [dblLastA]) +
  Format('"Ek": "%.1f J",'#10, [dblLastEk]) +
  Format('"Pmax": "%.1f w",'#10, [dblMaxPower]) +
  Format('"P": "%.1f W",'#10, [dblLastP]) +
  Format('"Fmax": "%.1f N",'#10, [dblMaxForce]) +
  Format('"Famx": "%.1f N",'#10, [dblAlsoMaxForce]) +
  Format('"F": "%.1f N",'#10, [dblForce]) +
  Format('"Ftpf": "%.1f N",'#10, [dblTotalPullForce]) +
  Format('"Fn": "%.1f N",'#10, [dblForceNet]) +
  Format('"Rbmx": "%.1f N",'#10, [dblMaxBrake]) +
  Format('"Rb": "%.1f N",'#10, [dblBrakeResistance]) +
  Format('"Rg": "%.1f N",'#10, [dblGravityResistance]) +
  Format('"Rabc": "%.1d N",'#10, [Integer(boolTrainResistanceUseABC)]) +
  Format('"Rva": "%.1f N",'#10, [dblTrainResistanceA]) +
  Format('"Rvb": "%.1f N",'#10, [dblTrainResistanceB]) +
  Format('"Rvc": "%.1f N",'#10, [dblTrainResistanceC]) +
  Format('"Rvd": "%.1f N",'#10, [dblTrainResistanceAccel]) +
  Format('"Rve": "%.1f N",'#10, [dblTrainResistanceAero]) +
  Format('"Rvf": "%.1f N",'#10, [dblTrainResistanceRoll]) +
  Format('"Rv": "%.1f N",'#10, [dblTrainResistance]) +
  Format('"Rt": "%.1f N",'#10, [dblTrackResistance]) +
  Format('"Rtra": "%.1f N",'#10, [dblTrackResistanceArc]) +
  Format('"Rtrt": "%.1f N",'#10, [dblTrackResistanceTunnel]) +
  Format('"Rta": "%.1f m",'#10, [dblTrackArc]) +
  Format('"Rts": "%.1f ‰",'#10, [dblTrackSlope]) +
  Format('"Rabc": "%.1d",'#10, [Integer(boolTrackMain)]) +
  Format('"Rtt": "%s",'#10, [strTunnel]) +
  Format('"M": "%.1f kg",'#10, [dblMass]) +
  Format('"T": "%s",'#10, [FormatDateTime('dd.mm.yyyy hh.mm.ss.zzz', dtLastT)]);
end;

procedure TSimulation.Refresh();
begin
  if Assigned(EValueChangedDouble) then
  begin
    EValueChangedDouble('BrakeAirControl', dblBrakeAirControl, dblBrakeAirControl);
    EValueChangedDouble('BrakeElmagControl', dblBrakeElmagControl, dblBrakeElmagControl);
    EValueChangedDouble('BrakeDynaControl', dblBrakeDynaControl, dblBrakeDynaControl);
    EValueChangedDouble('PowerControl', dblPowerControl, dblPowerControl);
    EValueChangedDouble('MaxVelocity', dblMaxV, dblMaxV);
    EValueChangedDouble('MaxForce', dblMaxForce, dblMaxForce);
    EValueChangedDouble('MaxBrake', dblMaxBrake, dblMaxBrake);
    EValueChangedDouble('MaxPower', dblMaxPower, dblMaxPower);
    EValueChangedDouble('Mass', dblMass, dblMass);
    EValueChangedDouble('TrackSlope', dblTrackSlope, dblTrackSlope);
    EValueChangedDouble('TrackArc', dblTrackArc, dblTrackArc);
  end;

  if Assigned(EValueChangedBoolean) then
  begin
    EValueChangedBoolean('Sander', boolSander, boolSander);
    EValueChangedBoolean('Emergency', boolEmergency, boolEmergency);
    EValueChangedBoolean('MainSwitch', boolMainSwitch, boolMainSwitch);
    EValueChangedBoolean('Lock', boolLock, boolLock);
    EValueChangedBoolean('Wakeup', boolWakeUp, boolWakeUp);
    EValueChangedBoolean('TrainResistanceUseABC', boolTrainResistanceUseABC, boolTrainResistanceUseABC);
    EValueChangedBoolean('BlockedDoor', boolBlockedDoor, boolBlockedDoor);
    EValueChangedBoolean('TrackMain', boolTrackMain, boolTrackMain);
  end;

  if Assigned(EValueChangedInteriorLights) then
  begin
    EValueChangedInteriorLights('DriverLights', intDriverlights, intDriverlights);
    EValueChangedInteriorLights('PassengerLights', intPassengerlights, intPassengerlights);
  end;

  if Assigned(EValueChangedDoorStatus) then
  begin
    EValueChangedDoorStatus('Door', intDoor, intDoor);
  end;
  if Assigned(EValueChangedTrainLights) then
  begin
    EValueChangedTrainLights('TrainLights', intTrainlights, intTrainlights);
  end;
  if Assigned(EValueChangedTrainDirection) then
  begin
    EValueChangedTrainDirection('Direction', dirDirection, dirDirection);
  end;
  if Assigned(EValueChangedTunnel) then
  begin
    EValueChangedTunnel('TrackTunnel', tnlTrackTunnel, tnlTrackTunnel);
  end;
end;

function TSimulation.PowerControl(): double;
begin
  result := dblPowerControl;
end;

function TSimulation.BrakeDynaControl(): double;
begin
  result := dblBrakeDynaControl;
end;

function TSimulation.BrakeElmagControl(): double;
begin
  result := dblBrakeElmagControl;
end;

function TSimulation.BrakeAirControl(): double;
begin
  result := dblBrakeAirControl;
end;

function TSimulation.Door(): TDoorStatus;
begin
  result := intDoor;
end;

function TSimulation.Trainlights(): TTrainLights;
begin
  result := intTrainlights;
end;

function TSimulation.Passengerlights(): TInteriorLights;
begin
  result := intPassengerlights;
end;

function TSimulation.Driverlights(): TInteriorLights;
begin
  result := intDriverlights;
end;

function TSimulation.Sander(): boolean;
begin
  result := boolSander;
end;

function TSimulation.Emergency(): boolean;
begin
  result := boolEmergency;
end;

function TSimulation.MainSwitch(): boolean;
begin
  result := boolMainSwitch;
end;

function TSimulation.Lock(): boolean;
begin
  result := boolLock;
end;

function TSimulation.WakeUp(): boolean;
begin
  result := boolWakeUp;
end;

function TSimulation.Velocity(boolKmph: boolean = false): double;
begin
  result := dblLastV;
  if boolKmph then
  begin
    result := dblLastV * 3.6;
  end;
end;

function TSimulation.Position(): double;
begin
  result := dblLastX;
end;

function TSimulation.Acceleration(): double;
begin
  result := dblLastA;
end;

function TSimulation.KineticEnergy(): double;
begin
  result := dblLastEk;
end;

function TSimulation.Power(): double;
begin
  result := dblLastP;
end;

function TSimulation.Force(): double;
begin
  result := dblForce;
end;

function TSimulation.MaxVelocity(boolKmph: boolean = false): double;
begin
  result := dblMaxV;
  if boolKmph then
  begin
    result := dblMaxV * 3.6;
  end;
end;

function TSimulation.TrainResistanceUseABC(): boolean;
begin
  result := boolTrainResistanceUseABC;
end;

function TSimulation.Direction(): TTrainDirection;
begin
  result := dirDirection;
end;

function TSimulation.TrackArc(): double;
begin
  result := dblTrackArc;
end;

function TSimulation.TrackTunnel(): TTunnel;
begin
  result := tnlTrackTunnel;
end;

function TSimulation.TrackSlope(): double;
begin
  result := dblTrackSlope;
end;

function TSimulation.TrackMain(): boolean;
begin
  result := boolTrackMain;
end;

function TSimulation.BrakeResistance(): double;
begin
  result := dblBrakeResistance;
end;

function TSimulation.GravityResistance(): double;
begin
  result := dblGravityResistance;
end;

function TSimulation.TrainResistance(): double;
begin
  result := dblTrainResistance;
end;

function TSimulation.TrackResistance(): double;
begin
  result := dblTrackResistance;
end;

function TSimulation.Mass(): double;
begin
  result := dblMass;
end;

function TSimulation.MaxPower(): double;
begin
  result := dblMaxPower;
end;

function TSimulation.MaxBrake(): double;
begin
  result := dblMaxBrake;
end;

function TSimulation.MaxForce(): double;
begin
  result := dblMaxForce;
end;

function TSimulation.SimTime(): TDateTime;
begin
  result := dtLastT;
end;

function TSimulation.BlockedDoor(): boolean;
begin
  result := boolBlockedDoor;
end;

/////////////////////////////////////////////////////////////////

procedure TSimulation.SetPowerControl(AValue: double);
var dblOld: double;
begin
  if (AValue < 0) then
  begin
    AValue := 0;
  end;
  if (AValue > 1) then
  begin
    AValue := 1;
  end;
  dblOld := dblPowerControl;
  dblPowerControl := AValue;
  if Assigned(EValueChangedDouble) then
  begin
    EValueChangedDouble('PowerControl', dblOld, dblPowerControl);
  end;
end;

procedure TSimulation.SetBrakeDynaControl(AValue: double);
var dblOld: double;
begin
  if (AValue < 0) then
  begin
    AValue := 0;
  end;
  if (AValue > 1) then
  begin
    AValue := 1;
  end;
  dblOld := dblBrakeDynaControl;
  dblBrakeDynaControl := AValue;
  if Assigned(EValueChangedDouble) then
  begin
    EValueChangedDouble('BrakeDynaControl', dblOld, dblBrakeDynaControl);
  end;
end;

procedure TSimulation.SetBrakeElmagControl(AValue: double);
var dblOld: double;
begin
  if (AValue < 0) then
  begin
    AValue := 0;
  end;
  if (AValue > 1) then
  begin
    AValue := 1;
  end;
  dblOld := dblBrakeElmagControl;
  dblBrakeElmagControl := AValue;
  if Assigned(EValueChangedDouble) then
  begin
    EValueChangedDouble('BrakeElmagControl', dblOld, dblBrakeElmagControl);
  end;
end;

procedure TSimulation.SetBrakeAirControl(AValue: double);
var dblOld: double;
begin
  if (AValue < 0) then
  begin
    AValue := 0;
  end;
  if (AValue > 1) then
  begin
    AValue := 1;
  end;
  dblOld := dblBrakeAirControl;
  dblBrakeAirControl := AValue;
  if Assigned(EValueChangedDouble) then
  begin
    EValueChangedDouble('BrakeAirControl', dblOld, dblBrakeAirControl);
  end;
end;

procedure TSimulation.SwitchDoor(var ATimer: TTimer);
var doorOld: TDoorStatus;
begin
  if (dblLastV >= 0.1) or (abs(dblLastA) >= 0.1) or (dblPowerControl <> 0) then
  begin
    Exit;
  end;
  doorOld := intDoor;
  if (intDoor >= High(TDoorStatus)) or (intDoor < Low(TDoorStatus)) then
  begin
    intDoor := Low(TDoorStatus);
  end
  else
  begin
    intDoor := Succ(intDoor);
  end;
  if (intDoor = doorOpening) or (intDoor = doorClosing) then
  begin
    ATimer.Enabled := true;
  end;
  if Assigned(EValueChangedDoorStatus) then
  begin
    EValueChangedDoorStatus('Door', doorOld, intDoor);
  end;
end;

procedure TSimulation.SwitchTrainlights();
var tlOld: TTrainLights;
begin
  if (intTrainlights >= High(TTrainLights)) or (intTrainlights < Low(TTrainLights)) then
  begin
    intTrainlights := Low(TTrainLights);
    Exit;
  end;
  tlOld := intTrainlights;
  intTrainlights := Succ(intTrainlights);
  if Assigned(EValueChangedTrainLights) then
  begin
    EValueChangedTrainLights('TrainLights', tlOld, intTrainlights);
  end;
end;

procedure TSimulation.SwitchPassengerlights();
var ilOld: TInteriorLights;
begin
  if (intPassengerlights >= High(TInteriorLights)) or (intPassengerlights < Low(TInteriorLights)) then
  begin
    intPassengerlights := Low(TInteriorLights);
    Exit;
  end;
  ilOld := intPassengerlights;
  intPassengerlights := Succ(intPassengerlights);
  if Assigned(EValueChangedInteriorLights) then
  begin
    EValueChangedInteriorLights('PassengerLights', ilOld, intPassengerlights);
  end;
end;

procedure TSimulation.SwitchDriverlights();
var ilOld: TInteriorLights;
begin
  if (intDriverlights >= High(TInteriorLights)) or (intDriverlights < Low(TInteriorLights)) then
  begin
    intDriverlights := Low(TInteriorLights);
    Exit;
  end;
  ilOld := intDriverlights;
  intDriverlights := Succ(intDriverlights);
  if Assigned(EValueChangedInteriorLights) then
  begin
    EValueChangedInteriorLights('DriverLights', ilOld, intDriverlights);
  end;
end;

procedure TSimulation.ToggleSander();
var boolOld: boolean;
begin
  boolOld := boolSander;
  boolSander := not boolSander;
  if Assigned(EValueChangedBoolean) then
  begin
    EValueChangedBoolean('Sander', boolOld, boolSander);
  end;
end;

procedure TSimulation.ToggleEmergency();
var boolOld: boolean;
begin
  boolOld := boolEmergency;
  boolEmergency := not boolEmergency;
  if Assigned(EValueChangedBoolean) then
  begin
    EValueChangedBoolean('Emergency', boolOld, boolEmergency);
  end;
end;

procedure TSimulation.ToggleMainSwitch();
var boolOld: boolean;
begin
  boolOld := boolMainSwitch;
  boolMainSwitch := not boolMainSwitch;
  if Assigned(EValueChangedBoolean) then
  begin
    EValueChangedBoolean('MainSwitch', boolOld, boolMainSwitch);
  end;
end;

procedure TSimulation.ToggleLock();
var boolOld: boolean;
begin
  boolOld := boolLock;
  boolLock := not boolLock;
  if Assigned(EValueChangedBoolean) then
  begin
    EValueChangedBoolean('Lock', boolOld, boolLock);
  end;
end;

procedure TSimulation.ToggleWakeup();
var boolOld: boolean;
begin
  boolOld := boolWakeup;
  boolWakeUp := not boolWakeUp;
  if Assigned(EValueChangedBoolean) then
  begin
    EValueChangedBoolean('Wakeup', boolOld, boolWakeUp);
  end;
end;

procedure TSimulation.SetMaxVelocity(AValue: double; boolKmph: boolean = false);
var dblOld: double;
begin
  if boolKmph then
  begin
    dblMaxV := AValue / 3.6;
    Exit;
  end;
  dblOld := dblMaxV;
  dblMaxV := AValue;
  if Assigned(EValueChangedDouble) then
  begin
    EValueChangedDouble('MaxVelocity', dblOld, dblMaxV);
  end;
end;

procedure TSimulation.SetTrainResistanceUseABC(AValue: boolean);
var boolOld: boolean;
begin
  boolOld := boolTrainResistanceUseABC;
  boolTrainResistanceUseABC := AValue;
  if Assigned(EValueChangedBoolean) then
  begin
    EValueChangedBoolean('TrainResistanceUseABC', boolOld, boolTrainResistanceUseABC);
  end;
end;

procedure TSimulation.SetDirection(AValue: TTrainDirection);
var dirOld: TTrainDirection;
begin
  dirOld := dirDirection;
  dirDirection := AValue;
  if Assigned(EValueChangedTrainDirection) then
  begin
    EValueChangedTrainDirection('Direction', dirOld, dirDirection);
  end;
end;

procedure TSimulation.SetTrackArc(AValue: double);
var dblOld: double;
begin
  if (AValue < 0) then
  begin
    AValue := 0;
  end;
  dblOld := dblTrackArc;
  dblTrackArc := AValue;
  if Assigned(EValueChangedDouble) then
  begin
    EValueChangedDouble('TrackArc', dblOld, dblTrackArc);
  end;
end;

procedure TSimulation.SetTrackTunnel(AValue: TTunnel);
var tnlOld: TTunnel;
begin
  tnlOld := tnlTrackTunnel;
  tnlTrackTunnel := AValue;
  if Assigned(EValueChangedTunnel) then
  begin
    EValueChangedTunnel('TrackTunnel', tnlOld, tnlTrackTunnel);
  end;
end;

procedure TSimulation.SetTrackSlope(AValue: double);
var dblOld: double;
begin
  dblOld := dblTrackSlope;
  dblTrackSlope := AValue;
  if Assigned(EValueChangedDouble) then
  begin
    EValueChangedDouble('TrackSlope', dblOld, dblTrackSlope);
  end;
end;

procedure TSimulation.SetTrackMain(AValue: boolean);
var boolOld: boolean;
begin
  boolOld := boolTrackMain;
  boolTrackMain := AValue;
  if Assigned(EValueChangedBoolean) then
  begin
    EValueChangedBoolean('TrackMain', boolOld, boolTrackMain);
  end;
end;

procedure TSimulation.SetMass(AValue: double);
var dblOld: double;
begin
  if (AValue < 0) then
  begin
    Exit;
  end;
  dblOld := dblMass;
  dblMass := AValue;
  if Assigned(EValueChangedDouble) then
  begin
    EValueChangedDouble('Mass', dblOld, dblMass);
  end;
end;

procedure TSimulation.SetMaxPower(AValue: double);
var dblOld: double;
begin
  if (AValue < 0) then
  begin
    Exit;
  end;
  dblOld := dblMaxPower;
  dblMaxPower := AValue;
  if Assigned(EValueChangedDouble) then
  begin
    EValueChangedDouble('MaxPower', dblOld, dblMaxPower);
  end;
end;

procedure TSimulation.SetMaxBrake(AValue: double);
var dblOld: double;
begin
  if (AValue < 0) then
  begin
    Exit;
  end;
  dblOld := dblMaxBrake;
  dblMaxBrake := AValue;
  if Assigned(EValueChangedDouble) then
  begin
    EValueChangedDouble('MaxBrake', dblOld, dblMaxBrake);
  end;
end;

procedure TSimulation.SetMaxForce(AValue: double);
var dblOld: double;
begin
  if (AValue < 0) then
  begin
    Exit;
  end;
  dblOld := dblMaxForce;
  dblMaxForce := AValue;
  if Assigned(EValueChangedDouble) then
  begin
    EValueChangedDouble('MaxForce', dblOld, dblMaxForce);
  end;
end;

procedure TSimulation.BlockDoor();
var boolOld: boolean;
begin
  boolOld := boolBlockedDoor;
  boolBlockedDoor := true;
  if Assigned(EValueChangedBoolean) then
  begin
    EValueChangedBoolean('BlockedDoor', boolOld, boolBlockedDoor);
  end;
end;

procedure TSimulation.UnblockDoor();
var boolOld: boolean;
begin
  boolOld := boolBlockedDoor;
  boolBlockedDoor := false;
  if Assigned(EValueChangedBoolean) then
  begin
    EValueChangedBoolean('BlockedDoor', boolOld, boolBlockedDoor);
  end;
end;

end.


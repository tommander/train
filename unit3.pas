unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Controls, Buttons, StdCtrls, ComCtrls, ExtCtrls, Graphics,
  DateUtils;

type
  //TStation = record
  //  strName: string;
  //  intPosition: qword;
  //  intAvgIn: word;
  //  intAvgOut: word;
  //end;
  //TTimeSheetItem = record
  //  sta: TStation;
  //  timeArrival: TTime;
  //  timeDeparture: TTime;
  //end;
  //TTimeSheet = array of TTimeSheetItem;

  TEventCanBoard = procedure() of object;

  TDoorStatus = (doorClosed = 0, doorOpening = 1, doorOpen = 2, doorAlarm = 3, doorClosing = 4);
  TTrainLights = (tlOff,tlHeadDim,tlHead,tlHeadHigh,tlRearDim,tlRear);
  TInteriorLights = (ilOff, ilDim, ilNormal, ilEmergency);
  TTunnel = (tnNone,tnSingle,tnDouble);

  TTrainRangeControl = record
    intValue: shortint;
    intMax: shortint;
  end;
  TTrainRangeControlType = (rctPower,rctBrakeDynamic,rctBrakeElmag,rctBrakeAir);
//  TTrainToggleControlValue = (tcvDec=-1,tcvZero=0,tcvInc=1);

  TTrainDirection = (dirForward = 1, dirNeutral = 0, dirReverse = -1);

  TSimulation = class
    private var slLog: TStringList;

    private var dblPowerControl: double; //<0;1>
    private var dblBrakeDynaControl: double; //<0;1>
    private var dblBrakeElmagControl: double; //<0;1>
    private var dblBrakeAirControl: double; //<0;1>
    public function PowerControl(): double;
    public function BrakeDynaControl(): double;
    public function BrakeElmagControl(): double;
    public function BrakeAirControl(): double;
    public procedure SetPowerControl(AValue: double);
    public procedure SetBrakeDynaControl(AValue: double);
    public procedure SetBrakeElmagControl(AValue: double);
    public procedure SetBrakeAirControl(AValue: double);

    private var intDoor: TDoorStatus;
    private var intTrainlights: TTrainLights;
    private var intDriverlights: TInteriorLights;
    private var intPassengerlights: TInteriorLights;
    public function Door(): TDoorStatus;
    public function Trainlights(): TTrainLights;
    public function Passengerlights(): TInteriorLights;
    public function Driverlights(): TInteriorLights;
    public procedure SwitchDoor();
    public procedure SwitchTrainlights();
    public procedure SwitchPassengerlights();
    public procedure SwitchDriverlights();

    private var boolSander: boolean; // ...
    private var boolEmergency: boolean; // ...
    private var boolMainSwitch: boolean; // ...
    private var boolLock: boolean; // ...
    private var boolWakeUp: boolean; // ...
    public function Sander(): boolean;
    public function Emergency(): boolean;
    public function MainSwitch(): boolean;
    public function Lock(): boolean;
    public function WakeUp(): boolean;
    public procedure ToggleSander();
    public procedure ToggleEmergency();
    public procedure ToggleMainSwitch();
    public procedure ToggleLock();
    public procedure ToggleWakeup();

    private var dblMaxV: double; // [m/s]
    private var dblLastV: double; // [m/s]
    private var dblLastX: double; // [m]
    private var dblLastA: double; // [m/s^-2]
    private var dblLastEk: double; // [J]
    private var dblLastP: double; // [W]
    private var dblForce: double; // [N]
    private var dblForceNet: double; // [N]
    private var dblTotalPullForce: double; // [N]
    private var dblBrakeResistance: double; // [N]
    private var dblGravityResistance: double; // [N]
    private var boolTrainResistanceUseABC: boolean;
    private var dblTrainResistance: double; // [N]
    private var dblTrainResistanceA: double; // [-]
    private var dblTrainResistanceB: double; // [-] A + B*V + C*V^2 (V in km/h)
    private var dblTrainResistanceC: double; // [-]
    private var dblTrainResistanceRoll: double; // [N]
    private var dblTrainResistanceAero: double; // [N]
    private var dblTrainResistanceAccel: double; // [N]
    private var dblTrackResistance: double; // [N]
    private var dblTrackResistanceArc: double; // [N]
    private var dblTrackResistanceTunnel: double; // [N]
//    private var dblTrackResistanceSlope: double; // [N]
    private var dirDirection: TTrainDirection; //
    public function Velocity(boolKmph: boolean = false): double;
    public function Position(): double;
    public function Acceleration(): double;
    public function KineticEnergy(): double;
    public function Power(): double;
    public function Force(): double;
    public function MaxVelocity(boolKmph: boolean = false): double;
    public procedure SetMaxVelocity(AValue: double; boolKmph: boolean = false);
    public function TrainResistanceUseABC(): boolean;
    public procedure SetTrainResistanceUseABC(AValue: boolean);
    public function Direction(): TTrainDirection;
    public procedure SetDirection(AValue: TTrainDirection);

    private var dblTrackArc: double; //radius [m]
    private var tnlTrackTunnel: TTunnel;
    private var dblTrackSlope: double; // slope [per mile, ‰]
    private var boolTrackMain: boolean; // main track? for arc res computation
    public function TrackArc(): double;
    public function TrackTunnel(): TTunnel;
    public function TrackSlope(): double;
    public function TrackMain(): boolean;
    public procedure SetTrackArc(AValue: double);
    public procedure SetTrackTunnel(AValue: TTunnel);
    public procedure SetTrackSlope(AValue: double);
    public procedure SetTrackMain(AValue: boolean);

    public function BrakeResistance(): double;
    public function GravityResistance(): double;
    public function TrainResistance(): double;
    public function TrackResistance(): double;

    private var dblMass: double; // [kg]
    private var dblMaxBrake: double; // [N]
    private var dblMaxPower: double; // [W]
    private var dblMaxForce: double; // [N]
    private var dblAlsoMaxForce: double; // [N]
    public function Mass(): double;
    public function MaxPower(): double;
    public function MaxBrake(): double;
    public function MaxForce(): double;
    public procedure SetMass(AValue: double);
    public procedure SetMaxPower(AValue: double);
    public procedure SetMaxBrake(AValue: double);
    public procedure SetMaxForce(AValue: double);

    private dtLastT: TDateTime; // [s]
    public function SimTime(): TDateTime;

    public constructor Create();
    public destructor Destroy(); override;
    public procedure Tick2();
    public function Export(): string;

    // Events

    public var ECanBoard: TEventCanBoard;
  end;

function VirtualTime(AHour: word = 0; AMinute: word = 0; ASecond: word = 0; AMillsecond: word = 0): TDateTime;
function VirtualizeTime(ATime: TDateTime): TDateTime;
function VirtualNow(): TDateTime;

implementation

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

destructor TSimulation.Destroy();
begin
  slLog.SaveToFile('/home/tommander/Desktop/fujuh/log.txt');
  FreeAndNil(slLog);
  inherited;
end;

constructor TSimulation.Create();
begin
  ECanBoard := nil;

  slLog := TStringList.Create;
  slLog.Add('[');

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
//  dblTrackResistanceSlope := 0;
  dblTrackArc := 0;
  tnlTrackTunnel := tnNone;
  dblTrackSlope := 0;
  boolTrackMain := false;
  dirDirection := dirForward;

  //slLog.Add('{');
  //slLog.Add('"title": "Initial status",');
  //slLog.Add(Export());
  //slLog.Add('}');
end;

function sign(AValue: double): double;
begin
  result := 1;
  if AValue < 0 then
  begin
    result := -1;
  end;
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

  dblGravityResistance := dblMass * 9.81 * dblTrackSlope;
  dblBrakeResistance := dblMaxBrake * dblBrakeElmagControl;
  dblTrainResistance := 0;
  dblTrackResistance := 0;
  dblTrackResistanceArc := 0;
  dblTrackResistanceTunnel := 0;
  dblTrainResistance := (dblTrainResistanceA + dblTrainResistanceB * (dblLastV * 3.6) + dblTrainResistanceC * (dblLastV * 3.6) * (dblLastV * 3.6));
  if (dblTrackArc > 0) and boolTrackMain then
  begin
    dblTrackResistanceArc := 650 / (dblTrackArc - 55);
  end
  else if (dblTrackArc > 0) and (not boolTrackMain) then
  begin
    dblTrackResistanceArc := 500 / (dblTrackArc - 30);
  end;
  case tnlTrackTunnel of
    tnSingle: dblTrackResistanceTunnel := dblMass * 9.81 * 2;
    tnDouble: dblTrackResistanceTunnel := dblMass * 9.81;
  end;
  dblTrackResistance := dblTrackResistanceArc + dblTrackResistanceTunnel;
  lRealMaxForce := dblMaxForce;
  dblAlsoMaxForce := 0;
  if (abs(dblLastV) > 0.1) then
  begin
    dblAlsoMaxForce := dblMaxPower / dblLastV;
    if (dblAlsoMaxForce < lRealMaxForce) then
    begin
      lRealMaxForce := dblAlsoMaxForce;
    end;
  end;
  dblForce := lRealMaxForce * dblPowerControl;
  dblTotalPullForce := dblForce - dblTrainResistance - dblTrackResistance;
  if (abs(dblLastV) < 0.01) and (abs(dblTotalPullForce) <= dblBrakeResistance) then
  begin
    dblForceNet := 0;
  end
  else if abs(dblLastV) < 0.01 then
  begin
    dblForceNet := dblTotalPullForce - sign(dblTotalPullForce) * dblBrakeResistance;
  end
  else
  begin
    dblForceNet := dblTotalPullForce - sign(dblLastV) * dblBrakeResistance;
  end;
  dblForceNet := dblForceNet - dblGravityResistance;
  dblLastA := dblForceNet / dblMass;
  dblLastV := dblLastV + dblLastA * dt;

  if abs(dblLastV) < 0.001 then
    dblLastV := 0;
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

  //slLog.Add('Tick');
  //slLog.Add(Export());
  //slLog.Add('End of tick');
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

procedure TSimulation.SetPowerControl(AValue: double);
begin
  if (AValue < 0) then
  begin
    AValue := 0;
  end;
  if (AValue > 1) then
  begin
    AValue := 1;
  end;
  dblPowerControl := AValue;
end;

procedure TSimulation.SetBrakeDynaControl(AValue: double);
begin
  if (AValue < 0) then
  begin
    AValue := 0;
  end;
  if (AValue > 1) then
  begin
    AValue := 1;
  end;
  dblBrakeDynaControl := AValue;
end;

procedure TSimulation.SetBrakeElmagControl(AValue: double);
begin
  if (AValue < 0) then
  begin
    AValue := 0;
  end;
  if (AValue > 1) then
  begin
    AValue := 1;
  end;
  dblBrakeElmagControl := AValue;
end;

procedure TSimulation.SetBrakeAirControl(AValue: double);
begin
  if (AValue < 0) then
  begin
    AValue := 0;
  end;
  if (AValue > 1) then
  begin
    AValue := 1;
  end;
  dblBrakeAirControl := AValue;
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

procedure TSimulation.SwitchDoor();
begin
  if (intDoor >= High(TDoorStatus)) or (intDoor < Low(TDoorStatus)) then
  begin
    intDoor := Low(TDoorStatus);
  end
  else
  begin
    intDoor := Succ(intDoor);
  end;
  if (intDoor = doorOpen) and Assigned(ECanBoard) then
  begin
    ECanBoard();
  end;
end;

procedure TSimulation.SwitchTrainlights();
begin
  if (intTrainlights >= High(TTrainLights)) or (intTrainlights < Low(TTrainLights)) then
  begin
    intTrainlights := Low(TTrainLights);
    Exit;
  end;
  intTrainlights := Succ(intTrainlights);
end;

procedure TSimulation.SwitchPassengerlights();
begin
  if (intPassengerlights >= High(TInteriorLights)) or (intPassengerlights < Low(TInteriorLights)) then
  begin
    intPassengerlights := Low(TInteriorLights);
    Exit;
  end;
  intPassengerlights := Succ(intPassengerlights);
end;

procedure TSimulation.SwitchDriverlights();
begin
  if (intDriverlights >= High(TInteriorLights)) or (intDriverlights < Low(TInteriorLights)) then
  begin
    intDriverlights := Low(TInteriorLights);
    Exit;
  end;
  intDriverlights := Succ(intDriverlights);
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

procedure TSimulation.ToggleSander();
begin
  boolSander := not boolSander;
end;
procedure TSimulation.ToggleEmergency();
begin
  boolEmergency := not boolEmergency;
end;

procedure TSimulation.ToggleMainSwitch();
begin
  boolMainSwitch := not boolMainSwitch;
end;

procedure TSimulation.ToggleLock();
begin
  boolLock := not boolLock;
end;

procedure TSimulation.ToggleWakeup();
begin
  boolWakeUp := not boolWakeUp;
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

procedure TSimulation.SetMaxVelocity(AValue: double; boolKmph: boolean = false);
begin
  if boolKmph then
  begin
    dblMaxV := AValue / 3.6;
    Exit;
  end;
  dblMaxV := AValue;
end;

function TSimulation.TrainResistanceUseABC(): boolean;
begin
  result := boolTrainResistanceUseABC;
end;

procedure TSimulation.SetTrainResistanceUseABC(AValue: boolean);
begin
  boolTrainResistanceUseABC := AValue;
end;

function TSimulation.Direction(): TTrainDirection;
begin
  result := dirDirection;
end;

procedure TSimulation.SetDirection(AValue: TTrainDirection);
begin
  dirDirection := AValue;
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

procedure TSimulation.SetTrackArc(AValue: double);
begin
  if (AValue < 0) then
  begin
    AValue := 0;
  end;
  dblTrackArc := AValue;
end;

procedure TSimulation.SetTrackTunnel(AValue: TTunnel);
begin
  tnlTrackTunnel := AValue;
end;

procedure TSimulation.SetTrackSlope(AValue: double);
begin
  dblTrackSlope := AValue;
end;

procedure TSimulation.SetTrackMain(AValue: boolean);
begin
  boolTrackMain := AValue;
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

procedure TSimulation.SetMass(AValue: double);
begin
  if (AValue < 0) then
  begin
    Exit;
  end;
  dblMass := AValue;
end;

procedure TSimulation.SetMaxPower(AValue: double);
begin
  if (AValue < 0) then
  begin
    Exit;
  end;
  dblMaxPower := AValue;
end;

procedure TSimulation.SetMaxBrake(AValue: double);
begin
  if (AValue < 0) then
  begin
    Exit;
  end;
  dblMaxBrake := AValue;
end;

procedure TSimulation.SetMaxForce(AValue: double);
begin
  if (AValue < 0) then
  begin
    Exit;
  end;
  dblMaxForce := AValue;
end;

function TSimulation.SimTime(): TDateTime;
begin
  result := dtLastT;
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

end.


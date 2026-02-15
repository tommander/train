unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  StdCtrls, Buttons, DateUtils, Math{, anysort}, uengine;

type
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

  { TfMain }

  TfMain = class(TForm)
      BitBtn1: TBitBtn;
      BitBtn2: TBitBtn;
      BitBtn3: TBitBtn;
      Button1: TButton;
      Label1: TLabel;
      Label10: TLabel;
      Label11: TLabel;
      Label12: TLabel;
      Label13: TLabel;
      Label14: TLabel;
      Label15: TLabel;
      Label16: TLabel;
      Label2: TLabel;
      Label3: TLabel;
      Label4: TLabel;
      Label5: TLabel;
      Label6: TLabel;
      Label7: TLabel;
      Label8: TLabel;
      Label9: TLabel;
      lblAirBrake1: TLabel;
      lblAirBrake2: TLabel;
      lblAirBrake1Max: TLabel;
      lblAirBrake2Max: TLabel;
      lblVelocity: TLabel;
      lblForce: TLabel;
      lblAccel: TLabel;
      lblAccelMax: TLabel;
      lblForceMax: TLabel;
      lblPowerMax: TLabel;
      lblVelocityMax: TLabel;
      lblPower: TLabel;
      Panel10: TPanel;
      Panel11: TPanel;
      Panel12: TPanel;
      Panel13: TPanel;
      Panel14: TPanel;
      Panel15: TPanel;
      Panel16: TPanel;
      Panel17: TPanel;
      Panel18: TPanel;
      Panel19: TPanel;
      Panel2: TPanel;
      Panel20: TPanel;
      Panel21: TPanel;
      Panel22: TPanel;
      Panel23: TPanel;
      Panel24: TPanel;
      Panel25: TPanel;
      Panel8: TPanel;
      Panel9: TPanel;
      Panel5: TPanel;
      Panel6: TPanel;
      btnMinusDynBrake: TBitBtn;
      btnMinusPower: TBitBtn;
      btnMinuxAirBrake: TBitBtn;
      btnMinuxElmagBrake: TBitBtn;
      btnPlusAirBrake: TBitBtn;
      btnPlusDynBrake: TBitBtn;
      btnPlusElmagBrake: TBitBtn;
      btnPlusPower: TBitBtn;
      lblControlAirBrake: TLabel;
      lblControlDynBrake: TLabel;
      lblControlElmagBrake: TLabel;
      lblControlPower: TLabel;
      Memo1: TMemo;
      Panel3: TPanel;
      Panel4: TPanel;
      pbAirBrake1: TProgressBar;
      pbAirBrake2: TProgressBar;
      pbForce: TProgressBar;
      pbAccel: TProgressBar;
      pbVelocity: TProgressBar;
      pbPower: TProgressBar;
      pnlControlAirBrake: TPanel;
      pnlControlDynBrake: TPanel;
      pnlControlElmagBrake: TPanel;
      pnlControlXYZ: TPanel;
    btnDoor: TBitBtn;
    btnLock: TBitBtn;
    btnWakeUp: TBitBtn;
    btnHeadlights: TBitBtn;
    btnSander: TBitBtn;
    btnEmergency: TBitBtn;
    btnMainSwitch: TBitBtn;
    btnCabinlights: TBitBtn;
    btnPilotlights: TBitBtn;
    il32: TImageList;
    il64: TImageList;
    Image1: TImage;
    Panel1: TPanel;
    pnlSanderLight: TPanel;
    pnlEmergencyLight: TPanel;
    pnlMainSwitchLight: TPanel;
    pnlLockLight: TPanel;
    pnlWakeupLight: TPanel;
    pnlCabinlights: TPanel;
    pnlPilotlights: TPanel;
    pnlLock: TPanel;
    pnlWakeUp: TPanel;
    pnlHeadlightsLight: TPanel;
    Panel7: TPanel;
    pnlBottom1: TPanel;
    pnlBottom2: TPanel;
    pnlDoor: TPanel;
    pnlHeadlights: TPanel;
    pnlCabinlightsLight: TPanel;
    pnlPilotlightsLight: TPanel;
    pnlSander: TPanel;
    pnlEmergency: TPanel;
    pnlMainSwitch: TPanel;
    pnlMiddle: TPanel;
    Splitter1: TSplitter;
    tbControlAirBrake: TTrackBar;
    tbControlDynBrake: TTrackBar;
    tbControlElmagBrake: TTrackBar;
    tbControlPower: TTrackBar;
    Timer1: TTimer;
    tmrDoor: TTimer;
    tbDirection: TTrackBar;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure btnCabinlightsClick(Sender: TObject);
    procedure btnEmergencyClick(Sender: TObject);
    procedure btnDoorClick(Sender: TObject);
    procedure btnHeadlightsClick(Sender: TObject);
    procedure btnLockClick(Sender: TObject);
    procedure btnMainSwitchClick(Sender: TObject);
    procedure btnMinusPowerClick(Sender: TObject);
    procedure btnMinuxElmagBrakeClick(Sender: TObject);
    procedure btnPilotlightsClick(Sender: TObject);
    procedure btnPlusElmagBrakeClick(Sender: TObject);
    procedure btnPlusPowerClick(Sender: TObject);
    procedure btnSanderClick(Sender: TObject);
    procedure btnWakeUpClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure IdleTimer1Timer(Sender: TObject);
    // ---
    function DirectionChangeBlocked(): boolean;
    procedure RefreshStations();
    procedure RefreshUI();
    private
      var intPowerControl: shortint;
      var intBrakeDynaControl: shortint;
      var intBrakeElmagControl: shortint;
      var intBrakeAirControl: shortint;
      var intPowerControlMax: shortint;
      var intBrakeDynaControlMax: shortint;
      var intBrakeElmagControlMax: shortint;
      var intBrakeAirControlMax: shortint;
    private
      var sim: TSimulation;
      var boolTickBlocker: boolean;
    // Stations - props
    private intCurrentStation: TStationID;
    private arrStations: array of TStation;
    private boolBlockSort: boolean;
    // Stations - methods
    public procedure BlockSort();
    public procedure UnblockSort();
    public function BlockedSort(): boolean;
    public function CurrentStationId(): TStationID;
    public function CurrentStation(): TStation;
    public procedure AdvanceStation(AValue: longint);
    public procedure BoardCurrentStation(ADate: TDateTime; APosition: double);
    public procedure QuickSort(var AI: TStationList; ALo, AHi: Integer);
    public procedure SortStations();
    public function AddStation(AStation: TStation): TStationID;
    public procedure UpdateStation(AID: TStationID; AStation: TStation);
    public procedure DeleteStation(AID: TStationID);
    public function ListStations(): TStationList;
    public procedure TrainCanBoard();
  end;
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

function BoolToStr(ABool: boolean; const ATrue, AFalse: string): string;
function HrMin(ADate: TDateTime; const AFormat: string = '%.2d:%.2d'): string;
function NiceNumber(ANum: double; const AUnit: shortstring; ADigits: byte = 1): string;
procedure LED(APanel: TPanel; AStatus: TLED);
function LEDStatus(AColor: TLEDColor; APower: TLEDPower = ledNormal; AText: shortstring = ''): TLED;

// STATIONS - GLOBAL
function SameStation(AStation1, AStation2: TStation): boolean;
function IsNullStation(AStation: TStation): boolean;
function NullStation(): TStation;
function Station(AName: shortstring = ''; AArrival: TDateTime = 0; ADeparture: TDateTime = 0; APosition: double = 0; AMaxPassengers: double = 1; AStretchRushHours: double = 2): TStation;
function CompareStations(const s1,s2): integer;
function timeint(ATime: TDateTime): double;
function gauss(ATime,AMaxPassengers,AStretchRushHours: double): double;
var
  fMain: TfMain;


implementation

{$R *.lfm}

{ Global }

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

{ TfMain }

procedure TfMain.TrainCanBoard();
begin
  BoardCurrentStation(VirtualNow(), sim.Position());
end;

procedure TfMain.FormCreate(Sender: TObject);
var LNow: TDateTime;
begin
    intCurrentStation := 0;
    SetLength(arrStations, 0);
    boolBlockSort := false;

    sim := TSimulation.Create();
  sim.SetMass(20000);
  sim.SetMaxPower(155000);
  sim.SetMaxBrake(20000);
  sim.SetMaxForce(28000);
  sim.SetMaxVelocity(80, true);
  sim.SetBrakeElmagControl(1);
  sim.ECanBoard := @TrainCanBoard;

  intPowerControl := 0;
  intBrakeAirControl := 0;
  intBrakeElmagControl := 0;
  intBrakeDynaControl := 0;
  intPowerControlMax := 7;
  intBrakeAirControlMax := 7;
  intBrakeElmagControlMax := 7;
  intBrakeDynaControlMax := 7;

  LNow := VirtualNow();
  BlockSort();
  AddStation(Station('Stanice A 000-80-2', LNow,                IncMinute(LNow,  5), 0,   80, 2));
  AddStation(Station('Stanice B 200-40-3', IncMinute(LNow, 15), IncMinute(LNow, 20), 200, 40, 3));
  AddStation(Station('Stanice C 500-01-1', IncMinute(LNow, 30), IncMinute(LNow, 35), 500,  1, 1));
  AddStation(Station('Stanice D 765-50-8', IncMinute(LNow, 50), IncMinute(LNow, 55), 765, 50, 8));
  UnblockSort();

  RefreshUI();
  RefreshStations();
end;

procedure TfMain.RefreshStations();



  //procedure RenderStation(AIndex: integer; AStation: TStation);
  //var lComp: TComponent;
  //    lPanel: TPanel;
  //    lTitle: TLabel;
  //    lTimes: TPanel;
  //    lReal: TPanel;
  //    lArr: TLabel;
  //    lDep: TLabel;
  //    lRealArr: TLabel;
  //    lRealDep: TLabel;
  //    lDist: TLabel;
  //begin
  //  lComp := pnlStationList.FindComponent(Format('pnlStation%d', [AIndex]));
  //  if Assigned(lComp) and (lComp is TPanel) then
  //  begin
  //    lPanel := (lComp as TPanel);
  //  end
  //  else
  //  begin
  //    lPanel := TPanel.Create(pnlStationList);
  //    lPanel.Parent := pnlStationList;
  //    lPanel.Name := Format('pnlStation%d', [AIndex]);
  //    lPanel.AutoSize := true;
  //    lPanel.Align := alTop;
  //    lPanel.BevelInner := bvRaised;
  //    lPanel.BevelOuter := bvLowered;
  //    lPanel.BorderSpacing.Around := 6;
  //    lPanel.Caption := '';
  //  end;
  //  if (AIndex = intCurrentStation) then
  //  begin
  //    lPanel.Color := clMoneyGreen;
  //  end
  //  else if (AStation.boolVisited) then
  //  begin
  //    lPanel.Color := clGray;
  //  end;
  //
  //  lComp := pnlStationList.FindComponent(Format('lblStationDist%d', [AIndex]));
  //  if Assigned(lComp) and (lComp is TLabel) then
  //  begin
  //    lDist := (lComp as TLabel);
  //  end
  //  else
  //  begin
  //    lDist := TLabel.Create(lPanel);
  //    lDist.Parent := lPanel;
  //    lDist.Name := Format('lblStationDist%d', [AIndex]);
  //    lDist.Align := alTop;
  //    lDist.BorderSpacing.Bottom := 6;
  //    lDist.BorderSpacing.Left := 6;
  //    lDist.BorderSpacing.Right := 6;
  //  end;
  //  lDist.Caption := '🛤️ ' + NiceNumber(AStation.dblPosition - sim.Position(), 'm', 1);
  //
  //  lComp := pnlStationList.FindComponent(Format('pnlStationReal%d', [AIndex]));
  //  if Assigned(lComp) and (lComp is TPanel) then
  //  begin
  //    lReal := (lComp as TPanel);
  //  end
  //  else
  //  begin
  //    lReal := TPanel.Create(lPanel);
  //    lReal.Parent := lPanel;
  //    lReal.Name := Format('pnlStationReal%d', [AIndex]);
  //    lReal.Align := alTop;
  //    lReal.AutoSize := true;
  //    lReal.BorderSpacing.Left := 6;
  //    lReal.BorderSpacing.Right := 6;
  //    lReal.BevelOuter := bvNone;
  //    lReal.Caption := '';
  //  end;
  //
  //  lComp := pnlStationList.FindComponent(Format('lblStationArrivalReal%d', [AIndex]));
  //  if Assigned(lComp) and (lComp is TLabel) then
  //  begin
  //    lRealArr := (lComp as TLabel);
  //  end
  //  else
  //  begin
  //    lRealArr := TLabel.Create(lReal);
  //    lRealArr.Parent := lReal;
  //    lRealArr.Name := Format('lblStationArrivalReal%d', [AIndex]);
  //    lRealArr.Align := alLeft;
  //  end;
  //  lRealArr.Caption := Format('⬇️ %.2d:%.2d', [HourOf(Astation.dtRealArrival), MinuteOf(Astation.dtRealArrival)]);
  //
  //  lComp := pnlStationList.FindComponent(Format('lblStationDepartureReal%d', [AIndex]));
  //  if Assigned(lComp) and (lComp is TLabel) then
  //  begin
  //    lRealDep := (lComp as TLabel);
  //  end
  //  else
  //  begin
  //    lRealDep := TLabel.Create(lReal);
  //    lRealDep.Parent := lReal;
  //    lRealDep.Name := Format('lblStationDepartureReal%d', [AIndex]);
  //    lRealDep.Align := alRight;
  //    lRealDep.Alignment := taRightJustify;
  //  end;
  //  lRealDep.Caption := Format('%.2d:%.2d ⬆️', [HourOf(Astation.dtRealDeparture), MinuteOf(Astation.dtRealDeparture)]);
  //
  //  lComp := pnlStationList.FindComponent(Format('pnlStationPlan%d', [AIndex]));
  //  if Assigned(lComp) and (lComp is TPanel) then
  //  begin
  //    lTimes := (lComp as TPanel);
  //  end
  //  else
  //  begin
  //    lTimes := TPanel.Create(lPanel);
  //    lTimes.Parent := lPanel;
  //    lTimes.Name := Format('pnlStationPlan%d', [AIndex]);
  //    lTimes.Align := alTop;
  //    lTimes.AutoSize := true;
  //    lTimes.BorderSpacing.Left := 6;
  //    lTimes.BorderSpacing.Right := 6;
  //    lTimes.BevelOuter := bvNone;
  //    lTimes.Caption := '';
  //  end;
  //
  //  lComp := pnlStationList.FindComponent(Format('lblStationArrival%d', [AIndex]));
  //  if Assigned(lComp) and (lComp is TLabel) then
  //  begin
  //    lArr := (lComp as TLabel);
  //  end
  //  else
  //  begin
  //    lArr := TLabel.Create(lTimes);
  //    lArr.Parent := lTimes;
  //    lArr.Name := Format('lblStationArrival%d', [AIndex]);
  //    lArr.Align := alLeft;
  //  end;
  //  lArr.Caption := Format('⬇️ %.2d:%.2d', [HourOf(Astation.dtArrival), MinuteOf(Astation.dtArrival)]);
  //
  //  lComp := pnlStationList.FindComponent(Format('lblStationDeparture%d', [AIndex]));
  //  if Assigned(lComp) and (lComp is TLabel) then
  //  begin
  //    lDep := (lComp as TLabel);
  //  end
  //  else
  //  begin
  //    lDep := TLabel.Create(lTimes);
  //    lDep.Parent := lTimes;
  //    lDep.Name := Format('lblStationDeparture%d', [AIndex]);
  //    lDep.Align := alRight;
  //    lDep.Alignment := taRightJustify;
  //  end;
  //  lDep.Caption := Format('%.2d:%.2d ⬆️', [HourOf(Astation.dtDeparture), MinuteOf(Astation.dtDeparture)]);
  //
  //  lComp := pnlStationList.FindComponent(Format('pnlStation%d', [AIndex]));
  //  if Assigned(lComp) and (lComp is TLabel) then
  //  begin
  //    lTitle := (lComp as TLabel);
  //  end
  //  else
  //  begin
  //    lTitle := TLabel.Create(lPanel);
  //    lTitle.Parent := lPanel;
  //    lTitle.Name := Format('pnlStation%d', [AIndex]);
  //    lTitle.Align := alTop;
  //    lTitle.BorderSpacing.Top := 3;
  //    lTitle.BorderSpacing.Left := 6;
  //    lTitle.BorderSpacing.Right := 6;
  //  end;
  //  lTitle.Caption := '🚉 ' + AStation.strName;
  //end;


  //procedure RenderStation(AIndex: integer; AStation: TStation);
  //var rn,tn: TTreeNode;
  //begin
  //  rn := tvStations.Items.Add(nil, BoolToStr(AStation.boolVisited, '✅ ', '✖️ ') + AStation.strName);
  //  rn.Expanded := (AIndex = intCurrentStation);
  //  tn := tvStations.Items.AddChild(rn, 'Arrival Plan: ' + HrMin(AStation.dtArrival));
  //  tn := tvStations.Items.AddChild(rn, 'Departure Plan: ' + HrMin(AStation.dtDeparture));
  //  tn := tvStations.Items.AddChild(rn, 'Position: ' + NiceNumber(AStation.dblPosition, 'm', 2));
  //  tn := tvStations.Items.AddChild(rn, 'Arrival Real: ' + HrMin(AStation.dtRealArrival));
  //  tn := tvStations.Items.AddChild(rn, 'Departure Real: ' + HrMin(AStation.dtRealDeparture));
  //  tn := tvStations.Items.AddChild(rn, 'Position Real: ' + NiceNumber(AStation.dblRealPosition, 'm', 2));
  //  tn := tvStations.Items.AddChild(rn, 'Max Passengers: ' + Format('%.0f', [AStation.dblMaxPassengers]));
  //  tn := tvStations.Items.AddChild(rn, 'SRH Index: ' + Format('%.1f', [AStation.dblStretchRushHours]));
  //  tn := tvStations.Items.AddChild(rn, 'Passengers Out: ' + IntToStr(AStation.intPassengersOut));
  //  tn := tvStations.Items.AddChild(rn, 'Passengers In: ' + IntToStr(AStation.intPassengersIn));
  //end;

var i: integer;
begin
  //tvStations.Items.Clear;
  //for i := Low(arrStations) to High(arrStations) do
  //begin
  //  RenderStation(i, arrStations[i]);
  //end;
end;

procedure TfMain.RefreshUI();
var intVelocity: int64;
    lAccel: double;
begin
  pbVelocity.Min := 0;
  pbVelocity.Max := 160;
  intVelocity := Round(sim.Velocity(true));
  if intVelocity > 160 then
  begin
    intVelocity := 160
  end
  else if intVelocity < -160 then
  begin
    intVelocity := 160
  end
  else if intVelocity < 0 then
  begin
    intVelocity := -1 * intVelocity;
  end;

  pbVelocity.Position := intVelocity;
  lblVelocity.Caption := IntToStr(pbVelocity.Position);
  lblVelocityMax.Caption := IntToStr(pbVelocity.Max);


  pbPower.Min := 0;
  pbPower.Max := Round(sim.MaxPower()/1000);
  pbPower.Position := Round(sim.Power()/1000);
  lblPower.Caption := IntToStr(pbPower.Position);
  lblPowerMax.Caption := IntToStr(pbPower.Max);

  pbForce.Min := 0;
  pbForce.Max := Round(sim.MaxForce()/1000);
  pbForce.Position := Round(sim.Force()/1000);
  lblForce.Caption := IntToStr(pbForce.Position);
  lblForceMax.Caption := IntToStr(pbForce.Max);

  pbAccel.Min := 0;
  pbAccel.Max := 30;

  lAccel := abs(sim.Acceleration());
  if lAccel > 3 then
  begin
    lAccel := 3;
  end;
  pbAccel.Position := Round(lAccel*10);
  lblAccel.Caption := IntToStr(pbAccel.Position);
  lblAccelMax.Caption := IntToStr(pbAccel.Max);
  lblAccel.Font.Color := clBlue;
  if lAccel <= 0.05 then
  begin
    lblAccel.Font.Color := clBlack;
  end
  else if lAccel <= 1 then
  begin
    lblAccel.Font.Color := clGreen;
  end
  else if lAccel <= 2 then
  begin
    lblAccel.Font.Color := clOlive;
  end
  else
  begin
    lblAccel.Font.Color := clMaroon;
  end;

  pbAirBrake1.Min := 0;
  pbAirBrake1.Max := 1;
  pbAirBrake1.Position := 0;
  lblAirBrake1.Caption := IntToStr(pbAirBrake1.Position);
  lblAirBrake1Max.Caption := IntToStr(pbAirBrake1.Max);

  pbAirBrake2.Min := 0;
  pbAirBrake2.Max := 1;
  pbAirBrake2.Position := 1;
  lblAirBrake2.Caption := IntToStr(pbAirBrake2.Position);
  lblAirBrake2Max.Caption := IntToStr(pbAirBrake2.Max);

  tbDirection.Min := -1;
  tbDirection.Max := 1;
  tbDirection.Position := Integer(sim.Direction());

  tbControlPower.Min := 0;
  tbControlPower.Max := intPowerControlMax;
  tbControlPower.Position := intPowerControl;
  tbControlDynBrake.Min := 0;
  tbControlDynBrake.Max := intBrakeDynaControlMax;
  tbControlDynBrake.Position := intBrakeDynaControl;
  tbControlElmagBrake.Min := 0;
  tbControlElmagBrake.Max := intBrakeElmagControlMax;
  tbControlElmagBrake.Position := intBrakeElmagControl;
  tbControlAirBrake.Min := 0;
  tbControlAirBrake.Max := intBrakeAirControlMax;
  tbControlAirBrake.Position := intBrakeAirControl;

  LED(Panel7, LEDStatus(ledOff));
  case sim.Door() of
    doorClosed: LED(Panel7, LEDStatus(ledGreen, ledNormal, '||'));
    doorOpening: LED(Panel7, LEDStatus(ledYellow, ledNormal, '< >'));
    doorOpen: LED(Panel7, LEDStatus(ledRed, ledNormal, '|🏃|'));
    doorAlarm: LED(Panel7, LEDStatus(ledRed, ledLight, '***'));
    doorClosing: LED(Panel7, LEDStatus(ledYellow, ledLight, '> <'));
  end;

  LED(pnlHeadlightsLight, LEDStatus(ledOff));
  case sim.Trainlights() of
    tlOff: LED(pnlHeadlightsLight, LEDStatus(ledOff, ledNormal, 'x x'));
    tlHeadDim: LED(pnlHeadlightsLight, LEDStatus(ledYellow, ledNormal, 'O x'));
    tlHead: LED(pnlHeadlightsLight, LEDStatus(ledYellow, ledNormal, 'O O'));
    tlHeadHigh: LED(pnlHeadlightsLight, LEDStatus(ledWhite, ledNormal, 'H H'));
    tlRearDim: LED(pnlHeadlightsLight, LEDStatus(ledRed, ledNormal, 'O x'));
    tlRear: LED(pnlHeadlightsLight, LEDStatus(ledRed, ledNormal, 'O O'));
  end;

  LED(pnlCabinlightsLight, LEDStatus(ledOff));
  case sim.Passengerlights() of
    ilOff: LED(pnlCabinlightsLight, LEDStatus(ledOff));
    ilDim: LED(pnlCabinlightsLight, LEDStatus(ledYellow));
    ilNormal: LED(pnlCabinlightsLight, LEDStatus(ledGreen));
    ilEmergency: LED(pnlCabinlightsLight, LEDStatus(ledRed));
  end;

  LED(pnlPilotlightsLight, LEDStatus(ledOff));
  case sim.Driverlights() of
    ilOff: LED(pnlPilotlightsLight, LEDStatus(ledOff));
    ilDim: LED(pnlPilotlightsLight, LEDStatus(ledYellow));
    ilNormal: LED(pnlPilotlightsLight, LEDStatus(ledGreen));
    ilEmergency: LED(pnlPilotlightsLight, LEDStatus(ledRed));
  end;

  LED(pnlSanderLight, LEDStatus(ledOff));
  case sim.Sander() of
    true: LED(pnlSanderLight, LEDStatus(ledRed, ledNormal, 'SAND'));
    false: LED(pnlSanderLight, LEDStatus(ledOff));
  end;

  LED(pnlEmergencyLight, LEDStatus(ledOff));
  case sim.Emergency() of
    true: LED(pnlEmergencyLight, LEDStatus(ledRed, ledNormal, '!!!'));
    false: LED(pnlEmergencyLight, LEDStatus(ledOff));
  end;

  LED(pnlMainSwitchLight, LEDStatus(ledOff));
  case sim.MainSwitch() of
    true: LED(pnlMainSwitchLight, LEDStatus(ledRed, ledNormal, '!!!'));
    false: LED(pnlMainSwitchLight, LEDStatus(ledOff));
  end;

  LED(pnlLockLight, LEDStatus(ledOff));
  case sim.Lock() of
    true: LED(pnlLockLight, LEDStatus(ledRed, ledNormal, '!!!'));
    false: LED(pnlLockLight, LEDStatus(ledOff));
  end;

  LED(pnlWakeupLight, LEDStatus(ledOff));
  case sim.WakeUp() of
    true: LED(pnlWakeupLight, LEDStatus(ledRed, ledNormal, '!!!'));
    false: LED(pnlWakeupLight, LEDStatus(ledOff));
  end;

  Label2.Caption := TimeToStr(VirtualNow());
  Label3.Caption := DateToStr(VirtualNow());
  Label4.Caption := NiceNumber(sim.Position(), 'm', 1);

  Memo1.Lines.Text := sim.Export();
end;

procedure TfMain.btnDoorClick(Sender: TObject);
begin
  sim.SwitchDoor();
end;

procedure TfMain.btnCabinlightsClick(Sender: TObject);
begin
  sim.SwitchPassengerlights();
end;

function TfMain.DirectionChangeBlocked(): boolean;
begin
  result := (abs(sim.Velocity()) > 0.01);
end;

procedure TfMain.BitBtn1Click(Sender: TObject);
begin
  if DirectionChangeBlocked then
  begin
    showmessage('Cannot change direction when moving.');
    Exit;
  end;
  sim.SetDirection(dirForward);
end;

procedure TfMain.BitBtn2Click(Sender: TObject);
begin
  if DirectionChangeBlocked then
  begin
    showmessage('Cannot change direction when moving.');
    Exit;
  end;
  sim.SetDirection(dirNeutral);
end;

procedure TfMain.BitBtn3Click(Sender: TObject);
begin
  if DirectionChangeBlocked then
  begin
    showmessage('Cannot change direction when moving.');
    Exit;
  end;
  sim.SetDirection(dirReverse);
end;

procedure TfMain.btnEmergencyClick(Sender: TObject);
begin
  sim.ToggleEmergency();
end;

procedure TfMain.btnHeadlightsClick(Sender: TObject);
begin
  sim.SwitchTrainlights();
end;

procedure TfMain.btnLockClick(Sender: TObject);
begin
  sim.ToggleLock();
end;

procedure TfMain.btnMainSwitchClick(Sender: TObject);
begin
  sim.ToggleMainSwitch();
end;

procedure TfMain.btnMinusPowerClick(Sender: TObject);
begin
  Dec(intPowerControl);
  if intPowerControl < 0 then
  begin
    intPowerControl := 0;
  end;
  sim.SetPowerControl(intPowerControl/7);
end;

procedure TfMain.btnMinuxElmagBrakeClick(Sender: TObject);
begin
  Dec(intBrakeElmagControl);
  if intBrakeElmagControl < 0 then
  begin
    intBrakeElmagControl := 0;
  end;
  sim.SetBrakeElmagControl(intBrakeElmagControl/intBrakeElmagControlMax);
end;

procedure TfMain.btnPilotlightsClick(Sender: TObject);
begin
  sim.SwitchDriverlights();
end;

procedure TfMain.btnPlusElmagBrakeClick(Sender: TObject);
begin
  Inc(intBrakeElmagControl);
  if intBrakeElmagControl > intBrakeElmagControlMax then
  begin
    intBrakeElmagControl := intBrakeElmagControlMax;
  end;
  sim.SetBrakeElmagControl(intBrakeElmagControl/intBrakeElmagControlMax);
end;

procedure TfMain.btnPlusPowerClick(Sender: TObject);
begin
  Inc(intPowerControl);
  if intPowerControl > intPowerControlMax then
  begin
    intPowerControl := intPowerControlMax;
  end;
  sim.SetPowerControl(intPowerControl/intPowerControlMax);
end;

procedure TfMain.btnSanderClick(Sender: TObject);
begin
  sim.ToggleSander();
end;

procedure TfMain.btnWakeUpClick(Sender: TObject);
begin
  sim.ToggleWakeup();
end;

procedure TfMain.Button1Click(Sender: TObject);
begin
  Timer1.Enabled := not Timer1.Enabled;
  if Timer1.Enabled then
  begin
    Button1.Caption := '⏳ Timer is ON';
  end
  else
  begin
    Button1.Caption := '⏳ Timer is OFF';
  end;
end;

procedure TfMain.Button2Click(Sender: TObject);
begin
  RefreshStations();
end;

procedure TfMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var i: integer;
begin
  CanClose := false;
  if Assigned(Timer1) and Timer1.Enabled then
  begin
    Timer1.Enabled := false;
  end;
  if Assigned(tmrDoor) and tmrDoor.Enabled then
  begin
    tmrDoor.Enabled := false;
  end;
  try
    intCurrentStation := 0;
    boolBlockSort := false;
      delete(arrStations, Low(arrStations), Length(arrStations));
      arrStations := nil;
    if Assigned(sim) then
    begin
      FreeAndNil(sim);
    end;
  finally
    CanClose := true;
  end;
end;

procedure TfMain.IdleTimer1Timer(Sender: TObject);
begin
  if boolTickBlocker then
  begin
    Exit;
  end;
  boolTickBlocker := true;
  try
    sim.Tick2();
    RefreshUI();
  finally
    boolTickBlocker := false;
  end;
end;

// STATIONS

//constructor TfMain.Create();
//begin
//  intCurrentStation := 0;
//  SetLength(arrStations, 0);
//  boolBlockSort := false;
//end;
//
//destructor TfMain.Destroy();
//var i: integer;
//begin
//  intCurrentStation := 0;
//  boolBlockSort := false;
//  //delete(arrStations, Low(arrStations), Length(arrStations));
//  //arrStations := nil;
//  //inherited Destroy();
//end;

procedure TfMain.BlockSort();
begin
  boolBlockSort := true;
end;

procedure TfMain.UnblockSort();
begin
  boolBlockSort := false;
  SortStations();
end;

function TfMain.BlockedSort(): boolean;
begin
  result := boolBlockSort;
end;

function TfMain.CurrentStationId(): TStationID;
begin
  result := intCurrentStation;
end;

function TfMain.CurrentStation(): TStation;
begin
  if (intCurrentStation > High(arrStations)) then
  begin
    result := NullStation();
    Exit;
  end;

  result := arrStations[intCurrentStation];
end;

procedure TfMain.AdvanceStation(AValue: longint);
begin
  if AValue < (-1*intCurrentStation) then
  begin
    intCurrentStation := 0;
    Exit;
  end;
  if (intCurrentStation + AValue) > High(arrStations) then
  begin
    intCurrentStation := High(arrStations);
    Exit;
  end;
  intCurrentStation := intCurrentStation + AValue;
end;

procedure TfMain.BoardCurrentStation(ADate: TDateTime; APosition: double);
var st: TStation;
    id: TStationID;
begin
  id := CurrentStationId();
  st := CurrentStation();
  if IsNullStation(st) or st.boolVisited then
  begin
    Exit;
  end;

  st.dblRealPosition := APosition;
  st.dtRealArrival := ADate;
  st.intPassengersIn := Round(Random()*st.dblMaxPassengers);
  st.intPassengersOut := Round(Random()*st.dblMaxPassengers);
  st.boolVisited := true;
  st.dtRealDeparture := Now();

  UpdateStation(id, st);
  if id = High(arrStations) then
  begin

  end;
  AdvanceStation(1);
end;

procedure TfMain.QuickSort(var AI: TStationList; ALo, AHi: Integer);
 var
  Lo, Hi: Integer;
  Pivot, T: TStation;
 begin
  Lo := ALo;
  Hi := AHi;
  Pivot := AI[(Lo + Hi) div 2];
  repeat
    while AI[Lo].dblPosition < Pivot.dblPosition do
      Inc(Lo) ;
    while AI[Hi].dblPosition > Pivot.dblPosition do
      Dec(Hi) ;
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

//procedure TfMain.QuickSort(var arr: TStationList);
//var
//  Lo, Hi: Integer;
//  Pivot, T: TStation;
//begin
//  Lo := Low(arr);
//  Hi := High(arr);
//  Pivot := arr[(Lo + Hi) div 2];
//  repeat
//    while arr[Lo].dblPosition < Pivot.dblPosition do
//      Inc(Lo);
//    while arr[Hi].dblPosition > Pivot.dblPosition do
//      Dec(Hi);
//    if Lo <= Hi then
//    begin
//      T := arr[Lo];
//      arr[Lo] := arr[Hi];
//      arr[Hi] := T;
//      Inc(Lo);
//      Dec(Hi);
//    end;
//  until Lo > Hi;
//  if Hi > Low(arr) then
//    QuickSort(arr[Low(arr)..Hi]);
//  if Lo < High(arr) then
//    QuickSort(arr[Lo..High(arr)]);
//end;
//
procedure TfMain.SortStations();
begin
  if BlockedSort() then
  begin
    Exit;
  end;
  QuickSort(arrStations, Low(arrStations), High(arrStations));
//  anysort.AnySort(arrStations, Length(arrStations), SizeOf(TStation), @CompareStations);
end;

function TfMain.AddStation(AStation: TStation): TStationID;
begin
  result := 0;
  SetLength(arrStations, Length(arrStations) + 1);
  result := High(arrStations);
  arrStations[result] := AStation;
  SortStations();
end;

procedure TfMain.UpdateStation(AID: TStationID; AStation: TStation);
begin
  if (AID <= High(arrStations)) then
  begin
    arrStations[AID] := AStation;
    SortStations();
  end;
end;

procedure TfMain.DeleteStation(AID: TStationID);
begin
  if (AID <= High(arrStations)) then
  begin
    arrStations[AID] := NullStation();
    SortStations();
  end;
end;

function TfMain.ListStations(): TStationList;
begin
  result := arrStations;
end;

// STATIONS - GLOBAL

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

end.


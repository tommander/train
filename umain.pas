unit umain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  StdCtrls, Buttons, DateUtils, uengine, ucommon, utrackfinish, udebug, LCLType,
  uprofile, utrainmgr, utrackmgr;

const
  PASSENGER_BOARDING: single = 1.01;

type
  TUISection = set of (uisDebug, uisCanvas, uisStations,
                       uisProgressBars, uisTrackbars, uisMap,
                       uisSwitchesToggles, uisAdmin, uisProfile);

  { TfMain }

  TfMain = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Image2: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lblTrackArcNext: TLabel;
    lblTrackDistNext: TLabel;
    lblTrackMainNext: TLabel;
    lblTrackSlopeNext: TLabel;
    lblTrackSlopeLabel1: TLabel;
    lblTrackSpeedNext: TLabel;
    lblTrackTunnel: TLabel;
    Label11: TLabel;
    lblTrackSlope: TLabel;
    Label13: TLabel;
    lblTrackMain: TLabel;
    lblTrackArc: TLabel;
    lblTrackSlopeLabel: TLabel;
    lblTrackSpeed: TLabel;
    Label9: TLabel;
    lblPassengersWaitOut: TLabel;
    lblPassengersWaitIn: TLabel;
    Label6: TLabel;
    lblStationNowDistance: TLabel;
    lblStationNowDistanceLabel: TLabel;
    lblStationLastName: TLabel;
    Label2: TLabel;
    lblStationNowName: TLabel;
    lblStationNextName: TLabel;
    lblStationNowPlan: TLabel;
    lblStationNextPlan: TLabel;
    lblStationLastPlanArrival: TLabel;
    lblStationNowPlanArrival: TLabel;
    lblStationNextPlanArrival: TLabel;
    lblStationLastPlanDeparture: TLabel;
    lblStationLastPlan: TLabel;
    lblStationNowPlanDeparture: TLabel;
    lblStationNextPlanDeparture: TLabel;
    lblStationNowEtaLabel: TLabel;
    lblStationLastRealArrival: TLabel;
    lblStationNowEta: TLabel;
    lblStationLastRealDeparture: TLabel;
    lblStationLastReal: TLabel;
    lblStationLastPassengersIn: TLabel;
    lblStationLastPassengersOut: TLabel;
    lblStationLastPassengers: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblAirBrake1: TLabel;
    lblAirBrake2: TLabel;
    lblAirBrake1Max: TLabel;
    lblAirBrake2Max: TLabel;
    lblStationNowPlanDeparture1: TLabel;
    lblStationNowPlanDeparture2: TLabel;
    lblTrackTunnelNext: TLabel;
    lblVelocity: TLabel;
    lblForce: TLabel;
    lblAccel: TLabel;
    lblAccelMax: TLabel;
    lblForceMax: TLabel;
    lblPowerMax: TLabel;
    lblVelocityMax: TLabel;
    lblPower: TLabel;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel18: TPanel;
    Panel20: TPanel;
    pnlPenalty: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel2: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    pnlPassengersWait: TPanel;
    pnlRight: TPanel;
    Panel24: TPanel;
    pnlStationLast: TPanel;
    pnlStationNow: TPanel;
    pnlStationNext: TPanel;
    pnlStationNowDistance: TPanel;
    pnlStationNextDistance: TPanel;
    pnlStationLastPlan: TPanel;
    pnlStationNowPlan: TPanel;
    pnlStationNextPlan: TPanel;
    pnlStationLastReal: TPanel;
    pnlStationLastPassengers: TPanel;
    pnlStationLastDistance: TPanel;
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
    pnlSanderLight: TPanel;
    pnlEmergencyLight: TPanel;
    pnlMainSwitchLight: TPanel;
    pnlLockLight: TPanel;
    pnlStationNowEta: TPanel;
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
    pbPassengersWait: TProgressBar;
    Splitter1: TSplitter;
    tbControlAirBrake: TTrackBar;
    tbControlDynBrake: TTrackBar;
    tbControlElmagBrake: TTrackBar;
    tbControlPower: TTrackBar;
    Timer1: TTimer;
    tmrDoor: TTimer;
    tmrPassengersWait: TTimer;
    tmrPassengers: TTimer;
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
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure IdleTimer1Timer(Sender: TObject);
    procedure tmrDoorTimer(Sender: TObject);
    procedure tmrPassengersTimer(Sender: TObject);
    procedure tmrPassengersWaitTimer(Sender: TObject);
    // ---
    public procedure InitProps();
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
      var boolTickBlocker: boolean;
    public function DirectionChangeBlocked(): boolean;
    // Passengers
    //private var bytNoOfDoors: byte;
    //private var wrdPassengers: word;
    //private var wrdCapacity: word;
    private var intLoadingStationID: TStationID;
    private var stLoadingStation: TStation;
    private var dtLoadingEnd: TDateTime;
    //
    public procedure BoardCurrentStation(ADate: TDateTime; APosition: double);
//    public procedure UpdateCurrentSection();
    // Events from simulation
    public
    procedure SimOnValueChangedDouble(AName: string; AValue, AOldValue: double);
    procedure SimOnValueChangedString(AName: string; AValue, AOldValue: string);
    procedure SimOnValueChangedInteger(AName: string; AValue, AOldValue: int64);
    procedure SimOnValueChangedBoolean(AName: string; AValue, AOldValue: boolean);
    procedure SimOnValueChangedDateTime(AName: string; AValue, AOldValue: TDateTime);
    procedure SimOnValueChangedTunnel(AName: string; AValue, AOldValue: TTunnel);
    procedure SimOnValueChangedInteriorLights(AName: string; AValue, AOldValue: TInteriorLights);
    procedure SimOnValueChangedTrainLights(AName: string; AValue, AOldValue: TTrainLights);
    procedure SimOnValueChangedDoorStatus(AName: string; AValue, AOldValue: TDoorStatus);
    procedure SimOnValueChangedTrainRangeControl(AName: string; AValue, AOldValue: TTrainRangeControl);
    procedure SimOnValueChangedTrainDirection(AName: string; AValue, AOldValue: TTrainDirection);
    // Our events
    procedure OnTrackSectionChange();
    procedure OnStationChange();
    // REFRESH UI
    procedure RefreshUI();

  end;


var
  fMain: TfMain;
  sim: TSimulation;

implementation

{$R *.lfm}

procedure TfMain.InitProps();
begin
 //lwdCurrentStation := 0;
 //SetLength(trcTrack.arrStations, 0);
 //boolBlockSort := false;

 intPowerControl := 0;
 intBrakeAirControl := 0;
 intBrakeElmagControl := 0;
 intBrakeDynaControl := 0;
 intPowerControlMax := 7;
 intBrakeAirControlMax := 7;
 intBrakeElmagControlMax := 7;
 intBrakeDynaControlMax := 7;

 //wrdPassengers := 0;
 //wrdCapacity := 512;
 //lwdCurrentSection := 0;

 pbVelocity.Min := 0;
 pbVelocity.Max := 160;
 pbPower.Min := 0;
 pbForce.Min := 0;
 pbAccel.Min := 0;
 pbAccel.Max := 30;
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
end;

procedure TfMain.RefreshUI();
var intVelocity: int64;
    lAccel: double;
    lNow: TDateTime;
    lPosition: double;
    //lSectionChanged: boolean;
    lSection,lNextSection: TTrackSection;
    lPenaltyValid: boolean;
begin
 lNow := Now();
 lPosition := sim.Position();

 Label2.Caption := Format('%.2d:%.2d:%.2d', [HourOf(lNow), MinuteOf(lNow), SecondOf(lNow)]);
 Label3.Caption := Format('%.2d.%.2d.%.4d', [DayOf(lNow), MonthOf(lNow), YearOf(lNow)]);
 Label4.Caption := NiceNumber(lPosition, 'm', 3);

 lblStationNowDistance.Caption := '🛤️' + NiceNumber(trcTrack.arrStations[lwdCurrentStation].dblPosition - lPosition, 'm', 3);

 lSection := GetSection(CurrentSectionId());
 lNextSection := GetSection(CurrentSectionId()+1);
 lblTrackDistNext.Caption := NiceNumber(lNextSection.dblStartPosition - lPosition, 'm', 3);

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

  // Check penalties

  lPenaltyValid := (intVelocity > (lSection.dblSpeed * 3.6));
  if lPenaltyValid and (not pnlPenalty.Showing) then
  begin
    pnlPenalty.Show;
  end;
  if (not lPenaltyValid) and pnlPenalty.Showing then
  begin
    pnlPenalty.Hide;
  end;

  // Update progress bar section

  pbVelocity.Position := intVelocity;
  lblVelocity.Caption := IntToStr(pbVelocity.Position);

  pbPower.Position := Round(sim.Power()/1000);
  lblPower.Caption := IntToStr(pbPower.Position);

  pbForce.Position := Round(sim.Force()/1000);
  lblForce.Caption := IntToStr(pbForce.Position);

  lAccel := abs(sim.Acceleration());
  if lAccel > 3 then
  begin
    lAccel := 3;
  end;
  pbAccel.Position := Round(lAccel*10);
  lblAccel.Caption := Format('%.1f', [pbAccel.Position/10]);
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

  if Assigned(fDebug) and fDebug.Showing then
  begin
    fDebug.Memo1.Lines.Text := sim.Export();
  end;
end;

procedure TfMain.tmrDoorTimer(Sender: TObject);
begin
  sim.SwitchDoor(tmrDoor);
  tmrDoor.Enabled := false;
end;

procedure TfMain.tmrPassengersTimer(Sender: TObject);
begin
  tmrPassengers.Enabled := false;
  tmrPassengersWait.Enabled := false;
  pnlPassengersWait.Hide;
  sim.ToggleLock();
  stLoadingStation.boolVisited := true;
  stLoadingStation.dtRealDeparture := Now();
  UpdateStation(intLoadingStationID, stLoadingStation);
  if intLoadingStationID = High(trcTrack.arrStations) then
  begin
    fTrackFinish.SetRating(2);
    fTrackFinish.Show;
    Exit;
  end;
  AdvanceStation(1);
  ShowMessage('Můžete vyrazit.');
end;

procedure TfMain.tmrPassengersWaitTimer(Sender: TObject);
begin
  pbPassengersWait.Position := SecondsBetween(dtLoadingEnd, Now);
end;

procedure TfMain.btnDoorClick(Sender: TObject);
begin
  if (sim.Lock()) or (sim.BlockedDoor) or (sim.Door() = doorOpening) or (sim.Door() = doorClosing) then
  begin
    Exit;
  end;
  if (sim.Door() = doorClosed) and (Abs(CurrentStation().dblPosition - sim.Position()) > 10) then
  begin
    showmessage('Dveře lze otevřít nejvíce 10 metrů od staničního bodu.');
    Exit;
  end;
  sim.SwitchDoor(tmrDoor);
end;

procedure TfMain.btnCabinlightsClick(Sender: TObject);
begin
  if sim.Lock() then
  begin
    showmessage('🔒 Zamčeno');
    Exit;
  end;
  sim.SwitchPassengerlights();
end;

function TfMain.DirectionChangeBlocked(): boolean;
begin
  result := (abs(sim.Velocity()) >= 0.1);
end;

procedure TfMain.BitBtn1Click(Sender: TObject);
begin
  if DirectionChangeBlocked then
  begin
    showmessage('Nelze přepínat směr jízdy za jízdy.');
    Exit;
  end;
  sim.SetDirection(dirForward);
end;

procedure TfMain.BitBtn2Click(Sender: TObject);
begin
  if DirectionChangeBlocked then
  begin
    showmessage('Nelze přepínat směr jízdy za jízdy.');
    Exit;
  end;
  sim.SetDirection(dirNeutral);
end;

procedure TfMain.BitBtn3Click(Sender: TObject);
begin
  if DirectionChangeBlocked then
  begin
    showmessage('Nelze přepínat směr jízdy za jízdy.');
    Exit;
  end;
  sim.SetDirection(dirReverse);
end;

procedure TfMain.btnEmergencyClick(Sender: TObject);
begin
  if sim.Lock() then
  begin
    showmessage('🔒 Zamčeno');
    Exit;
  end;
  sim.ToggleEmergency();
end;

procedure TfMain.btnHeadlightsClick(Sender: TObject);
begin
  if sim.Lock() then
  begin
    showmessage('🔒 Zamčeno');
    Exit;
  end;
  sim.SwitchTrainlights();
end;

procedure TfMain.btnLockClick(Sender: TObject);
begin
  sim.ToggleLock();
end;

procedure TfMain.btnMainSwitchClick(Sender: TObject);
begin
  if sim.Lock() then
  begin
    showmessage('🔒 Zamčeno');
    Exit;
  end;
  sim.ToggleMainSwitch();
end;

procedure TfMain.btnMinusPowerClick(Sender: TObject);
begin
  if sim.Lock() then
  begin
    showmessage('🔒 Zamčeno');
    Exit;
  end;
  if not sim.MainSwitch() then
  begin
    showmessage('Main switch off');
    Exit;
  end;
  //if (intBrakeAirControl > 0) or (intBrakeElmagControl > 0) or (intBrakeDynaControl > 0) then
  //begin
  //  showmessage('Brake is on');
  //  Exit;
  //end;
  Dec(intPowerControl);
  if intPowerControl < 0 then
  begin
    intPowerControl := 0;
  end;
  sim.SetPowerControl(intPowerControl/7);
end;

procedure TfMain.btnMinuxElmagBrakeClick(Sender: TObject);
begin
  if sim.Lock() then
  begin
    showmessage('🔒 Zamčeno');
    Exit;
  end;
  if not sim.MainSwitch() then
  begin
    showmessage('Main switch off');
    Exit;
  end;
  if (sim.Door() <> doorClosed) then
  begin
    showmessage('Door is not closed');
    Exit;
  end;
  if intPowerControl > 0 then
  begin
    intPowerControl := 0;
    sim.SetPowerControl(0);
  end;
  Dec(intBrakeElmagControl);
  if intBrakeElmagControl < 0 then
  begin
    intBrakeElmagControl := 0;
  end;
  sim.SetBrakeElmagControl(intBrakeElmagControl/intBrakeElmagControlMax);
end;

procedure TfMain.btnPilotlightsClick(Sender: TObject);
begin
  if sim.Lock() then
  begin
    showmessage('🔒 Zamčeno');
    Exit;
  end;
  sim.SwitchDriverlights();
end;

procedure TfMain.btnPlusElmagBrakeClick(Sender: TObject);
begin
  if sim.Lock() then
  begin
    showmessage('🔒 Zamčeno');
    Exit;
  end;
  if not sim.MainSwitch() then
  begin
    showmessage('🚅 Zapněte hlavní jistič');
    Exit;
  end;
  if (sim.Door() <> doorClosed) then
  begin
    showmessage('🚪 Dveře nejsou zavřené');
    Exit;
  end;
  if intPowerControl > 0 then
  begin
    intPowerControl := 0;
    sim.SetPowerControl(0);
  end;
  Inc(intBrakeElmagControl);
  if intBrakeElmagControl > intBrakeElmagControlMax then
  begin
    intBrakeElmagControl := intBrakeElmagControlMax;
  end;
  sim.SetBrakeElmagControl(intBrakeElmagControl/intBrakeElmagControlMax);
end;

procedure TfMain.btnPlusPowerClick(Sender: TObject);
begin
  if sim.Lock() then
  begin
    showmessage('🔒 Zamčeno');
    Exit;
  end;
  if not sim.MainSwitch() then
  begin
    showmessage('🚅 Zapněte hlavní jistič');
    Exit;
  end;
  //if (intBrakeAirControl > 0) or (intBrakeElmagControl > 0) or (intBrakeDynaControl > 0) then
  //begin
  //  showmessage('Brzdy nejsou ');
  //  Exit;
  //end;
  if (sim.Door() <> doorClosed) then
  begin
    showmessage('🚪 Dveře nejsou zavřené');
    Exit;
  end;
  Inc(intPowerControl);
  if intPowerControl > intPowerControlMax then
  begin
    intPowerControl := intPowerControlMax;
  end;
  sim.SetPowerControl(intPowerControl/intPowerControlMax);
end;

procedure TfMain.btnSanderClick(Sender: TObject);
begin
  if sim.Lock() then
  begin
    showmessage('🔒 Zamčeno');
    Exit;
  end;
  sim.ToggleSander();
end;

procedure TfMain.btnWakeUpClick(Sender: TObject);
begin
  if sim.Lock() then
  begin
    showmessage('🔒 Zamčeno');
    Exit;
  end;
  sim.ToggleWakeup();
end;

procedure TfMain.Button1Click(Sender: TObject);
begin
  Timer1.Enabled := not Timer1.Enabled;
  if Timer1.Enabled then
  begin
    Button1.Caption := '⏳ Zastavit čas';
  end
  else
  begin
    Button1.Caption := '⏳ Spustit čas';
  end;
end;

procedure TfMain.Button2Click(Sender: TObject);
begin
  fDebug.Show();
end;

procedure TfMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := false;
  if Assigned(Timer1) and Timer1.Enabled then
  begin
    Timer1.Enabled := false;
  end;
  if Assigned(tmrPassengers) and tmrPassengers.Enabled then
  begin
    tmrPassengers.Enabled := false;
  end;
  try
    lwdCurrentStation := 0;
    boolBlockSort := false;
    delete(trcTrack.arrStations, Low(trcTrack.arrStations), Length(trcTrack.arrStations));
    trcTrack.arrStations := nil;
  finally
    CanClose := true;
  end;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  fMain.Caption := Application.Title;
  InitProps();
  evtAskForPosition := @sim.Position;
  evtOnCurrentSectionChanged := @OnTrackSectionChange;
end;

procedure TfMain.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Shift = []) and (Key = VK_W) then
  begin
    BitBtn1.Click();
    Exit;
  end;
  if (Shift = []) and (Key = VK_W) then
  begin
    btnPlusPower.Click();
    Exit;
  end;
  if (Shift = []) and (Key = VK_W) then
  begin
    btnPlusPower.Click();
    Exit;
  end;
  if (Shift = []) and (Key = VK_W) then
  begin
    btnPlusPower.Click();
    Exit;
  end;
end;

procedure TfMain.FormShow(Sender: TObject);
begin
  Timer1.Enabled := true;
  sim.Refresh();
  OnStationChange();
  OnTrackSectionChange();
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



procedure TfMain.BoardCurrentStation(ADate: TDateTime; APosition: double);
var st: TStation;
    id: TStationID;
    lIncrease: longint;
begin
  id := CurrentStationId();
  st := CurrentStation();
  if IsNullStation(st) or st.boolVisited then
  begin
    Exit;
  end;

  st.dblRealPosition := APosition;
  st.dtRealArrival := ADate;

  st.intPassengersOut := Round(Random()*st.dblMaxPassengers);
  if (st.intPassengersOut > trnTrain.arrCargo[0].sglAmount) then
  begin
    st.intPassengersOut := Round(trnTrain.arrCargo[0].sglAmount);
  end;
  trnTrain.arrCargo[0].sglAmount := trnTrain.arrCargo[0].sglAmount - st.intPassengersOut;

  st.intPassengersIn := Round(Random()*st.dblMaxPassengers);
  if st.intPassengersIn > (trnTrain.arrCargo[0].sglCapacity - trnTrain.arrCargo[0].sglAmount) then
  begin
    st.intPassengersIn := Round((trnTrain.arrCargo[0].sglCapacity - trnTrain.arrCargo[0].sglAmount));
  end;
  trnTrain.arrCargo[0].sglAmount := trnTrain.arrCargo[0].sglAmount + st.intPassengersIn;

  lIncrease :=
    Round((st.intPassengersIn * trnTrain.arrCargo[0].sglLoaderSpeed) / trnTrain.arrCargo[0].sglLoaderAmount)
    +
    Round((st.intPassengersOut * trnTrain.arrCargo[0].sglUnloaderSpeed) / trnTrain.arrCargo[0].sglUnloaderAmount)
  ;
  intLoadingStationID := id;
  stLoadingStation := st;
  dtLoadingEnd := IncSecond(Now, lIncrease);
  pbPassengersWait.Min := 0;
  pbPassengersWait.Position := lIncrease;
  pbPassengersWait.Max := lIncrease;
  lblPassengersWaitIn.Caption := '⬇️ ' + IntToStr(st.intPassengersIn);
  lblPassengersWaitOut.Caption := '⬆️ ' + IntToStr(st.intPassengersOut);
  sim.ToggleLock();
  pnlPassengersWait.Show;
  tmrPassengers.Interval := (st.intPassengersIn + st.intPassengersOut) * 1000;
  if tmrPassengers.Interval < 1000 then
  begin
    tmrPassengers.Interval := 1000;
  end;
  tmrPassengers.Enabled := true;
  tmrPassengersWait.Enabled := true;
end;







procedure TfMain.SimOnValueChangedDouble(AName: string; AValue, AOldValue: double);
begin
  case AName of
    'BrakeAirControl':
    begin
      tbControlAirBrake.Min := 0;
      tbControlAirBrake.Max := intBrakeAirControlMax;
      tbControlAirBrake.Position := Round(sim.BrakeAirControl() * intBrakeAirControlMax);
    end;
    'BrakeElmagControl':
    begin
      tbControlElmagBrake.Min := 0;
      tbControlElmagBrake.Max := intBrakeElmagControlMax;
      tbControlElmagBrake.Position := Round(sim.BrakeElmagControl() * intBrakeElmagControlMax);
    end;
    'BrakeDynaControl':
    begin
      tbControlDynBrake.Min := 0;
      tbControlDynBrake.Max := intBrakeDynaControlMax;
      tbControlDynBrake.Position := Round(sim.BrakeDynaControl() * intBrakeDynaControlMax);
    end;
    'PowerControl':
    begin
      tbControlPower.Min := 0;
      tbControlPower.Max := intPowerControlMax;
      tbControlPower.Position := Round(sim.PowerControl() * intPowerControlMax);
    end;
    'MaxVelocity':
    begin
      pbVelocity.Max := Round(sim.MaxVelocity()*3.6);
    end;
    'MaxForce':
    begin
      pbForce.Max := Round(sim.MaxForce()/1000);
    end;
    'MaxBrake':
    begin

    end;
    'MaxPower':
    begin
      pbPower.Max := Round(sim.MaxPower()/1000);
    end;
    'Mass':
    begin

    end;
    'TrackSlope':
    begin

    end;
    'TrackArc':
    begin

    end;
  end;
end;

procedure TfMain.SimOnValueChangedString(AName: string; AValue, AOldValue: string);
begin

end;

procedure TfMain.SimOnValueChangedInteger(AName: string; AValue, AOldValue: int64);
begin

end;

procedure TfMain.SimOnValueChangedBoolean(AName: string; AValue, AOldValue: boolean);
begin
 case AName of
   'Sander':
   begin
     LED(pnlSanderLight, LEDStatus(ledOff));
     case sim.Sander() of
       true: LED(pnlSanderLight, LEDStatus(ledRed));
       false: LED(pnlSanderLight, LEDStatus(ledOff));
     end;
   end;
   'Emergency':
   begin
     LED(pnlEmergencyLight, LEDStatus(ledOff));
     case sim.Emergency() of
       true: LED(pnlEmergencyLight, LEDStatus(ledRed));
       false: LED(pnlEmergencyLight, LEDStatus(ledGreen));
     end;
   end;
   'MainSwitch':
   begin
     LED(pnlMainSwitchLight, LEDStatus(ledOff));
     case sim.MainSwitch() of
       true: LED(pnlMainSwitchLight, LEDStatus(ledGreen));
       false: LED(pnlMainSwitchLight, LEDStatus(ledRed));
     end;
   end;
   'Lock':
   begin
     LED(pnlLockLight, LEDStatus(ledOff));
     case sim.Lock() of
       true: begin LED(pnlLockLight, LEDStatus(ledRed)); btnLock.Caption := '🔓'; end;
       false: begin LED(pnlLockLight, LEDStatus(ledGreen)); btnLock.Caption := '🔒'; end;
     end;
   end;
   'Wakeup':
   begin
     LED(pnlWakeupLight, LEDStatus(ledOff));
     case sim.WakeUp() of
       true: LED(pnlWakeupLight, LEDStatus(ledRed, ledNormal, '!!!'));
       false: LED(pnlWakeupLight, LEDStatus(ledGreen));
     end;
   end;
   'TrainResistanceUseABC':
   begin

   end;
   'BlockedDoor':
   begin

   end;
   'TrackMain':
   begin

   end;
 end;
end;

procedure TfMain.SimOnValueChangedDateTime(AName: string; AValue, AOldValue: TDateTime);
begin

end;

procedure TfMain.SimOnValueChangedTunnel(AName: string; AValue, AOldValue: TTunnel);
begin

end;

procedure TfMain.SimOnValueChangedInteriorLights(AName: string; AValue, AOldValue: TInteriorLights);
begin
  case AName of
    'PassengerLights':
    begin
      LED(pnlCabinlightsLight, LEDStatus(ledOff));
      case sim.Passengerlights() of
        ilOff: LED(pnlCabinlightsLight, LEDStatus(ledOff));
        ilDim: LED(pnlCabinlightsLight, LEDStatus(ledYellow));
        ilNormal: LED(pnlCabinlightsLight, LEDStatus(ledGreen));
        ilEmergency: LED(pnlCabinlightsLight, LEDStatus(ledRed));
      end;
    end;
    'DriverLights':
    begin
      LED(pnlPilotlightsLight, LEDStatus(ledOff));
      case sim.Driverlights() of
        ilOff: LED(pnlPilotlightsLight, LEDStatus(ledOff));
        ilDim: LED(pnlPilotlightsLight, LEDStatus(ledYellow));
        ilNormal: LED(pnlPilotlightsLight, LEDStatus(ledGreen));
        ilEmergency: LED(pnlPilotlightsLight, LEDStatus(ledRed));
      end;
    end;
  end;
end;

procedure TfMain.SimOnValueChangedTrainLights(AName: string; AValue, AOldValue: TTrainLights);
begin
 LED(pnlHeadlightsLight, LEDStatus(ledOff));
 case sim.Trainlights() of
   tlOff: LED(pnlHeadlightsLight, LEDStatus(ledOff, ledNormal, 'x x'));
   tlHeadDim: LED(pnlHeadlightsLight, LEDStatus(ledYellow, ledNormal, 'O x'));
   tlHead: LED(pnlHeadlightsLight, LEDStatus(ledYellow, ledNormal, 'O O'));
   tlHeadHigh: LED(pnlHeadlightsLight, LEDStatus(ledWhite, ledNormal, 'H H'));
   tlRearDim: LED(pnlHeadlightsLight, LEDStatus(ledRed, ledNormal, 'O x'));
   tlRear: LED(pnlHeadlightsLight, LEDStatus(ledRed, ledNormal, 'O O'));
 end;
end;

procedure TfMain.SimOnValueChangedDoorStatus(AName: string; AValue, AOldValue: TDoorStatus);
begin
 LED(Panel7, LEDStatus(ledOff));
  case sim.Door() of
    doorClosed: LED(Panel7, LEDStatus(ledGreen, ledNormal, '||'));
    doorOpening: LED(Panel7, LEDStatus(ledYellow, ledNormal, '< >'));
    doorOpen:
    begin
      LED(Panel7, LEDStatus(ledRed, ledNormal, '| |'));
      BoardCurrentStation(Now(), sim.Position());
      OnStationChange();
    end;
    doorAlarm: LED(Panel7, LEDStatus(ledRed, ledLight, '*'));
    doorClosing: LED(Panel7, LEDStatus(ledYellow, ledLight, '> <'));
  end;
end;

procedure TfMain.SimOnValueChangedTrainRangeControl(AName: string; AValue, AOldValue: TTrainRangeControl);
begin

end;

procedure TfMain.SimOnValueChangedTrainDirection(AName: string; AValue, AOldValue: TTrainDirection);
begin
 tbDirection.Min := -1;
 tbDirection.Max := 1;
 tbDirection.Position := Integer(sim.Direction());
end;

procedure TfMain.OnTrackSectionChange();
var lSec,lNext: TTrackSection;
begin
 sim.SetTrackArc(trcTrack.arrSections[lwdCurrentSection].dblArc);
 sim.SetTrackSlope(trcTrack.arrSections[lwdCurrentSection].dblSlope);
 sim.SetTrackTunnel(trcTrack.arrSections[lwdCurrentSection].tnlTunnel);
 sim.SetTrackMain(trcTrack.arrSections[lwdCurrentSection].boolMain);

 lblTrackSpeed.Caption := '';
 lblTrackSlope.Caption := '';
 lblTrackArc.Caption := '';
 lblTrackTunnel.Caption := '';
 lblTrackMain.Caption := '';
 lblTrackSpeedNext.Caption := '';
 lblTrackSlopeNext.Caption := '';
 lblTrackArcNext.Caption := '';
 lblTrackTunnelNext.Caption := '';
 lblTrackMainNext.Caption := '';

 if lwdCurrentSection > High(trcTrack.arrSections) then
 begin
   Exit;
 end;
 lSec := trcTrack.arrSections[lwdCurrentSection];

 lblTrackSpeed.Caption := Format('%.0f km/h', [lSec.dblSpeed*3.6]);
 lblTrackSlope.Caption := Format('%.0f ‰', [lSec.dblSlope]);
 lblTrackArc.Caption := Format('%.0f m', [lSec.dblArc]);
 lblTrackTunnel.Caption := 'ne';
 if lSec.tnlTunnel = tnSingle then
 begin
   lblTrackTunnel.Caption := '1kolej';
 end;
 if lSec.tnlTunnel = tnDouble then
 begin
   lblTrackTunnel.Caption := '2kolej';
 end;
 lblTrackMain.Caption := 'vedlejsi';
 if lSec.boolMain then
 begin
   lblTrackMain.Caption := 'hlavni';
 end;

 if ((lwdCurrentSection+1) < Low(trcTrack.arrSections)) or ((lwdCurrentSection+1) > High(trcTrack.arrSections)) then
 begin
   Exit;
 end;
 lNext := trcTrack.arrSections[lwdCurrentSection+1];
 lblTrackSpeedNext.Caption := Format('%.0f km/h', [lNext.dblSpeed*3.6]);
 lblTrackSlopeNext.Caption := Format('%.0f ‰', [lNext.dblSlope]);
 lblTrackArcNext.Caption := Format('%.0f m', [lNext.dblArc]);
 lblTrackTunnelNext.Caption := 'ne';
 if lNext.tnlTunnel = tnSingle then
 begin
   lblTrackTunnelNext.Caption := '1kolej';
 end;
 if lNext.tnlTunnel = tnDouble then
 begin
   lblTrackTunnelNext.Caption := '2kolej';
 end;
 lblTrackMainNext.Caption := 'vedlejsi';
 if lNext.boolMain then
 begin
   lblTrackMainNext.Caption := 'hlavni';
 end;
end;

procedure TfMain.OnStationChange();
var stLast,stNow,stNext: TStation;
begin
 lblStationLastName.Caption := '';
 lblStationLastPlanArrival.Caption := '';
 lblStationLastPlanDeparture.Caption := '';
 lblStationLastRealArrival.Caption := '';
 lblStationLastRealDeparture.Caption := '';
 lblStationLastPassengersIn.Caption := '';
 lblStationLastPassengersOut.Caption := '';
 lblStationNowName.Caption := '';
 lblStationNowPlanArrival.Caption := '';
 lblStationNowPlanDeparture.Caption := '';
 lblStationNowEta.Caption := '';
 lblStationNowDistance.Caption := '';
 lblStationNextName.Caption := '';
 lblStationNextPlanArrival.Caption := '';
 lblStationNextPlanDeparture.Caption := '';

 if lwdCurrentStation > Low(trcTrack.arrStations) then
 begin
   stLast := trcTrack.arrStations[lwdCurrentStation-1];
   lblStationLastName.Caption := '🚉  ' + stLast.strName;
   lblStationLastPlanArrival.Caption := '⬇️ ' + HrMin(stLast.dtArrival);
   lblStationLastPlanDeparture.Caption := '⬆️ ' + HrMin(stLast.dtDeparture);
   lblStationLastRealArrival.Caption := '⬇️ ' + HrMin(stLast.dtRealArrival);
   lblStationLastRealDeparture.Caption := '⬆️ ' + HrMin(stLast.dtRealDeparture);
   lblStationLastPassengersIn.Caption := '➕ ' + IntToStr(stLast.intPassengersIn);
   lblStationLastPassengersOut.Caption := '➖ ' + IntToStr(stLast.intPassengersOut);
 end;

 stNow := trcTrack.arrStations[lwdCurrentStation];
 lblStationNowName.Caption := '🚉  ' + stNow.strName;
 lblStationNowPlanArrival.Caption := '⬇️ ' + HrMin(stNow.dtArrival);
 lblStationNowPlanDeparture.Caption := '⬆️ ' + HrMin(stNow.dtDeparture);
 lblStationNowEta.Caption := '⌚ ' + HrMin(stNow.dtRealArrival);
 lblStationNowDistance.Caption := NiceNumber(stNow.dblPosition - sim.Position(), 'm', 2);

 if lwdCurrentStation < High(trcTrack.arrStations) then
 begin
   stNext := trcTrack.arrStations[lwdCurrentStation+1];
   lblStationNextName.Caption := '🚉  ' + stNext.strName;
   lblStationNextPlanArrival.Caption := '⬇️ ' + HrMin(stNext.dtArrival);
   lblStationNextPlanDeparture.Caption := '⬆️ ' + HrMin(stNext.dtDeparture);
 end;
end;

end.


unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  StdCtrls, Buttons, DateUtils, Unit3, DTAnalogGauge, BCLeaRingSlider,
  BCFluentSlider;

type

  { TfMain }

  TfMain = class(TForm)
      BitBtn1: TBitBtn;
      BitBtn2: TBitBtn;
      BitBtn3: TBitBtn;
      sldForce: TBCLeaRingSlider;
      tbDirection: TBCFluentSlider;
      btnMinusDynBrake: TBitBtn;
      btnMinusPower: TBitBtn;
      btnMinuxAirBrake: TBitBtn;
      btnMinuxElmagBrake: TBitBtn;
      btnPlusAirBrake: TBitBtn;
      btnPlusDynBrake: TBitBtn;
      btnPlusElmagBrake: TBitBtn;
      btnPlusPower: TBitBtn;
      Button1: TButton;
      Label11: TLabel;
      Label2: TLabel;
      Label3: TLabel;
      Label4: TLabel;
      lblControlAirBrake: TLabel;
      lblControlDynBrake: TLabel;
      lblControlElmagBrake: TLabel;
      lblControlPower: TLabel;
      Memo1: TMemo;
      Panel10: TPanel;
      Panel3: TPanel;
      Panel4: TPanel;
      pbAirBrake1: TProgressBar;
      pbAirBrake2: TProgressBar;
      pnlControlAirBrake: TPanel;
      pnlControlDynBrake: TPanel;
      pnlControlElmagBrake: TPanel;
      pnlControlXYZ: TPanel;
    sldVelocity: TBCLeaRingSlider;
    sldAcceleration: TBCLeaRingSlider;
    sldPower: TBCLeaRingSlider;
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
    Label10: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel11: TPanel;
    pnlSanderLight: TPanel;
    pnlEmergencyLight: TPanel;
    pnlMainSwitchLight: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    Panel20: TPanel;
    Panel21: TPanel;
    Panel22: TPanel;
    Panel23: TPanel;
    pnlLockLight: TPanel;
    pnlWakeupLight: TPanel;
    pnlCabinlights: TPanel;
    pnlPilotlights: TPanel;
    pnlLock: TPanel;
    pnlWakeUp: TPanel;
    pnlHeadlightsLight: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
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
    ScrollBox1: TScrollBox;
    Splitter1: TSplitter;
    tbControlAirBrake: TTrackBar;
    tbControlDynBrake: TTrackBar;
    tbControlElmagBrake: TTrackBar;
    tbControlPower: TTrackBar;
    Timer1: TTimer;
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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure IdleTimer1Timer(Sender: TObject);
    // ---
    function DirectionChangeBlocked(): boolean;
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

function NiceNumber(ANum: double; const AUnit: shortstring; ADigits: byte = 1): string;
procedure LED(APanel: TPanel; AStatus: TLED);
function LEDStatus(AColor: TLEDColor; APower: TLEDPower = ledNormal; AText: shortstring = ''): TLED;

var
  fMain: TfMain;
  sim: TSimulation;


implementation

{$R *.lfm}

{ Global }

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

procedure TfMain.FormCreate(Sender: TObject);
begin
  sim := TSimulation.Create();
  sim.SetMass(20000);
  sim.SetMaxPower(155000);
  sim.SetMaxBrake(20000);
  sim.SetMaxForce(28000);
  sim.SetMaxVelocity(80, true);
  sim.SetBrakeElmagControl(1);

  intPowerControl := 0;
  intBrakeAirControl := 0;
  intBrakeElmagControl := 0;
  intBrakeDynaControl := 0;
  intPowerControlMax := 7;
  intBrakeAirControlMax := 7;
  intBrakeElmagControlMax := 7;
  intBrakeDynaControlMax := 7;
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(sim);
end;

procedure TfMain.RefreshUI();
var intVelocity: int64;
    lAccel: double;
begin
  sldVelocity.MinValue := 0;
  sldVelocity.MaxValue := 160;
  intVelocity := Round(sim.Velocity(true));
  if intVelocity > 160 then
    intVelocity := 160;
  if intVelocity < -160 then
    intVelocity := -160;

  sldVelocity.Value := intVelocity;

  sldPower.MinValue := 0;
  sldPower.MaxValue := Round(sim.MaxPower()/1000);
  sldPower.Value := Round(sim.Power()/1000);

  sldForce.MinValue := 0;
  sldForce.MaxValue := Round(sim.MaxForce()/1000);
  sldForce.Value := Round(sim.Force()/1000);

  sldAcceleration.MinValue := 0;
  sldAcceleration.MaxValue := 30;

  lAccel := abs(sim.Acceleration());
  if lAccel > 3 then
  begin
    lAccel := 3;
  end;
  sldAcceleration.Value := Round(lAccel*10);
  sldAcceleration.LineColor := clWhite;
  if lAccel <= 0.05 then
  begin
    sldAcceleration.LineColor := clSilver;
  end
  else if lAccel <= 1 then
  begin
    sldAcceleration.LineColor := clGreen;
  end
  else if lAccel <= 2 then
  begin
    sldAcceleration.LineColor := clOlive;
  end
  else
  begin
    sldAcceleration.LineColor := clRed;
  end;

  pbAirBrake1.Min := 0;
  pbAirBrake1.Max := 1;
  pbAirBrake1.Position := 0;
  pbAirBrake2.Min := 0;
  pbAirBrake2.Max := 1;
  pbAirBrake2.Position := 1;

  tbDirection.MinValue := -1;
  tbDirection.MaxValue := 1;
  tbDirection.Value := Integer(sim.Direction());

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

  Label2.Caption := TimeToStr(sim.SimTime());
  Label3.Caption := DateToStr(sim.SimTime());
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

procedure TfMain.IdleTimer1Timer(Sender: TObject);
begin
  sim.Tick2();
  RefreshUI();
end;

end.


unit udrivestart;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, utrackmgr, utrainmgr, umain, uengine;

type

  { TfDriveStart }

  TfDriveStart = class(TForm)
    Button1: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    ListView1: TListView;
    ListView2: TListView;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  fDriveStart: TfDriveStart;

implementation

{$R *.lfm}

{ TfDriveStart }

procedure TfDriveStart.Button1Click(Sender: TObject);
begin
  //LNow := Now();
  //BlockSort();
  //AddStation(Station('Stanice A 000-80-2', LNow,                IncMinute(LNow,  5), 0,   80, 2));
  //AddStation(Station('Stanice B 200-40-3', IncMinute(LNow, 15), IncMinute(LNow, 20), 200, 40, 3));
  //AddStation(Station('Stanice C 500-01-1', IncMinute(LNow, 30), IncMinute(LNow, 35), 500,  1, 1));
  //AddStation(Station('Stanice D 765-50-8', IncMinute(LNow, 50), IncMinute(LNow, 55), 765, 50, 8));
  //UnblockSort();
  //
  //AddSection(Section(true,   0, 30/3.6,    0,    0, tnNone,   false));
  //AddSection(Section(true, 100, 50/3.6,  0.1,  321, tnNone,   false));
  //AddSection(Section(true, 200, 40/3.6, -0.1,  234, tnNone,   false));
  //AddSection(Section(true, 300, 40/3.6,    0,    0, tnSingle, false));
  //AddSection(Section(true, 400, 30/3.6,    0,    0, tnNone,   false));
  //
  trnTrain := arrTrains[0];
  trcTrack := arrTracks[0];

  sim := TSimulation.Create();
  sim.SetMass(20000);
  sim.SetMaxPower(155000);
  sim.SetMaxBrake(20000);
  sim.SetMaxForce(28000);
  sim.SetMaxVelocity(80, true);
  sim.SetBrakeElmagControl(1);
  sim.EValueChangedDouble := @fMain.SimOnValueChangedDouble;
  sim.EValueChangedString := @fMain.SimOnValueChangedString;
  sim.EValueChangedInteger := @fMain.SimOnValueChangedInteger;
  sim.EValueChangedBoolean := @fMain.SimOnValueChangedBoolean;
  sim.EValueChangedDateTime := @fMain.SimOnValueChangedDateTime;
  sim.EValueChangedTunnel := @fMain.SimOnValueChangedTunnel;
  sim.EValueChangedInteriorLights := @fMain.SimOnValueChangedInteriorLights;
  sim.EValueChangedTrainLights := @fMain.SimOnValueChangedTrainLights;
  sim.EValueChangedDoorStatus := @fMain.SimOnValueChangedDoorStatus;
  sim.EValueChangedTrainRangeControl := @fMain.SimOnValueChangedTrainRangeControl;
  sim.EValueChangedTrainDirection := @fMain.SimOnValueChangedTrainDirection;

  Close();
end;

end.

